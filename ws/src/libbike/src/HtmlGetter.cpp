/**
 * Copyright © 2012-2013 Sergio Arroutbi Braojos <sarroutbi@gmail.com>
 * 
 * Permission to use, copy, modify, and/or distribute this software 
 * for any purpose with or without fee is hereby granted, provided that 
 * the above copyright notice and this permission notice appear in all copies.
 * 
 * THE SOFTWARE IS PROVIDED âAS ISâ AND THE AUTHOR DISCLAIMS ALL WARRANTIES 
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY 
 * AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, 
 * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM 
 * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, 
 * NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE 
 * OR PERFORMANCE OF THIS SOFTWARE.
 **/
#include <stdint.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>

#ifdef __cplusplus
extern "C"
{
#endif
#include <curl/curl.h>
#ifdef __cplusplus
}
#endif

#include "HtmlGetter.h"

size_t writeCallback(void *ptr, size_t size, size_t nmemb, char* user)
{
  char* file = user;
  size_t written = 0;

  //fprintf(stderr, "Callback executed!\n");
  //fprintf(stderr, "Writing [%d] elements of size [%d] to file [%s]\n\n",
  //        nmemb, size, file);

  FILE* f = fopen(user, "a");
  if( !f || !file)
  {
    fprintf(stderr, "Error when writting to file\n");
  }
  else
  {
    written = fwrite(ptr, size, nmemb, f);    
    fclose(f);
    return written;
  }
  return -1;
}

HtmlGetter::HtmlGetter ()
{
  memset(_url,  0, MAX_CURL_URL);
  memset(_post, 0, MAX_CURL_URL);
}

HtmlGetter::HtmlGetter (char* url)
{
  strncpy(_url, url, MAX_CURL_URL);
  memset (_post,  0, MAX_CURL_URL);
}

HtmlGetter::HtmlGetter (char* url, char* post)
{
  strncpy(_url,  url,  MAX_CURL_URL);
  strncpy(_post, post, MAX_CURL_URL);
}

HtmlGetter::~HtmlGetter ()
{
  ;
}
  
uint8_t HtmlGetter::DumpHtml (char* outFile)
{
  CURL *curl;
  CURLcode ret;

  unlink(outFile);

  curl_global_init(CURL_GLOBAL_ALL);

  curl = curl_easy_init();

  if(curl) 
  {
    /* URL set */ 
    curl_easy_setopt(curl, CURLOPT_URL, _url);

    /*  POST data */ 
    curl_easy_setopt(curl, CURLOPT_POSTFIELDS, _post);

    /* Set write callback */
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writeCallback);

    /* Set write callback */
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, outFile);

    /* Perform the request, ret is the return code */ 
    ret = curl_easy_perform(curl);
    
    /* Check for errors */ 
    if(ret != CURLE_OK)
    {
      fprintf(stderr, "curl_easy_perform() failed: %s\n", 
              curl_easy_strerror(ret));
    }
    /* always cleanup */ 
    curl_easy_cleanup(curl);
  }
  curl_global_cleanup();

  return ret;
}
