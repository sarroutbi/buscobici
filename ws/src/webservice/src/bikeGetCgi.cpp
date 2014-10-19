#include <stdlib.h>
#include <stdint.h>

#include "soapH.h"
#include "bikeGet.nsmap"

// libbike include files
#include "Bike.h"
#include "HtmlGetter.h"
#include "HtmlParser.h"

const char*    URL             = "http://buscobici.com/bikesearch/search.php";
const char*    POST_FORMAT     = "search=%s&priceFrom=%s&priceTo=%s&type=%s&numResults=%d";
const uint32_t MAX_POST_FIELD  = 255;
const uint32_t MAX_POST        = 1024;
const uint32_t MAX_RESULTS     = 2000;
const uint32_t MAX_SRV_RESULTS = 10000;

#define BACKLOG (100)

int main(int argc, char* argv[])
{
   struct soap soap;
   soap_init(&soap);
   if (argc < 3) // no args: assume this is a CGI application
   {
      // create soap context and serve one CGI-based request:
      soap_serve(&soap);
      soap_destroy(&soap); // dealloc C++ data
      soap_end(&soap); // dealloc data and clean up
   }
   else
   {
      soap.send_timeout = 60; // 60 seconds
      soap.recv_timeout = 60; // 60 seconds
      soap.accept_timeout = 3600; // server stops after 1 hour of inactivity
      soap.max_keep_alive = 100; // max keep-alive sequence
      void *process_request(void*);
      struct soap *tsoap;
      pthread_t tid;
      int port = atoi(argv[2]); // first command-line arg is port
      SOAP_SOCKET m, s;
      m = soap_bind(&soap, argv[1], port, BACKLOG);
      if (!soap_valid_socket(m)) {
         fprintf(stderr, "Unable to bind socket\n");
         soap_print_fault(&soap, stderr);
         exit(1);
      }
      fprintf(stderr, "Socket connection successful %d\n", m);
      for (;;)
      {
         s = soap_accept(&soap);
         if (!soap_valid_socket(s))
         {
            if (soap.errnum)
            {
               soap_print_fault(&soap, stderr);
               exit(1);
            }
            fprintf(stderr, "server timed out\n");
            break;
         }
         fprintf(stderr, "Thread accepts socket %d connection from IP %d.%d.%d.%d\n", s, (soap.ip >> 24)&0xFF, (soap.ip >> 16)&0xFF, (soap.ip >> 8)&0xFF, soap.ip&0xFF);
         tsoap = soap_copy(&soap); // make a safe copy
         if (!tsoap)
            break;
         pthread_create(&tid, NULL, (void*(*)(void*))process_request, (void*)tsoap);
      }
   }
   soap_done(&soap); // detach soap struct
}

void *process_request(void *soap)
{
   pthread_detach(pthread_self());
   soap_serve((struct soap*)soap);
   soap_destroy((struct soap*)soap); // dealloc C++ data
   soap_end((struct soap*)soap); // dealloc data and clean up
   soap_done((struct soap*)soap); // detach soap struct
   free(soap);
   return NULL;
}

void composePostInfo(const char* search, const char* type,
                     uint32_t priceFrom, uint32_t priceTo,
                     char* postString, const uint32_t maxPost)
{
   char  s[MAX_POST_FIELD] = "";
   char  t[MAX_POST_FIELD] = "";
   char pF[MAX_POST_FIELD] = "0";
   char pT[MAX_POST_FIELD] = "0";

   if(search)
     strncpy(s, search, MAX_POST_FIELD);
   if(type)
     strncpy(t, type, MAX_POST_FIELD);
   if(priceFrom)
     snprintf(pF, MAX_POST_FIELD, "%d", priceFrom);
   if(priceTo)
     snprintf(pT, MAX_POST_FIELD, "%d", priceTo);

   snprintf(postString, maxPost, POST_FORMAT, s, pF, pT, t, MAX_SRV_RESULTS);
}

void copyList(ns2BikeList* ns2bl, BikeList & bl)
{
  BikeList::iterator i;
  uint32_t counter = 0;
  fprintf(stderr, "Detected =>%d<= elements\n", bl.size());
  for(i = bl.begin(); (i != bl.end()) && counter<MAX_RESULTS; ++i, counter++)
  {
    ns2Bike nsb;
    nsb.trademark  = i->_trademark;
    nsb.model      = i->_model;
    nsb.store      = i->_store;
    nsb.url        = i->_url;
    nsb.urlContent = i->_url_text;
    nsb.type       = i->_type;
    nsb.price      = i->_price;
    ns2bl->bikeList.push_back(nsb);
  }
  fprintf(stderr, "Returning =>%d<= elements\n", ns2bl->bikeList.size());
}

int ns2__bikeGet(struct soap *soap, char* search, char* type,
                 int priceFrom, int priceTo, ns2BikeList & response)
{
  char post[MAX_POST];
  char file[FILENAME_MAX] = "/tmp/bikeGet.XXXXXX";
  if(mkstemp(file)==-1)
  {
    fprintf(stderr, "Error when calling mkstemp\n");
    return SOAP_SVR_FAULT;
  }
  else
  {
    fprintf(stderr, "cgi search to url:=>%s<=\n", URL);
    soap_set_omode(soap, SOAP_ENC_ZLIB);
    soap->z_level = 9; // best compression
    composePostInfo(search, type, priceFrom, priceTo, post, MAX_POST);
    HtmlGetter hg(const_cast<char*>(URL), post);
    fprintf(stderr, "POST=>%s<=\n", post);
    hg.DumpHtml(file);
    HtmlParser hp(file);
    hp.parse();
    fprintf(stderr, "File=>%s<= parsed\n", file);
    BikeList bl = hp.getList();
    copyList(&response, bl);
    fprintf(stderr, "List copied\n", file);
    unlink(file);
    fprintf(stderr, "File =>%s<= correctly deleted\n", file);
    return SOAP_OK;
  }
}
