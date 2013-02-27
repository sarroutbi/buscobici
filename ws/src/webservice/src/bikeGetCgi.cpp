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

int main(int argc, char* argv[])
{
  // create soap context and serve one CGI-based request:
  soap_serve(soap_new());
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
