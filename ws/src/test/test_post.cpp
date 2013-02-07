#include <stdio.h>

#ifdef __cplusplus
extern "C"
{
#endif
#include <curl/curl.h>
#ifdef __cplusplus
}
#endif

int parse_response(CURL *curl)
{
  fprintf(stderr, "========================== Performing analysis ");
  fprintf(stderr, " ==========================\n");
  fprintf(stderr, "===============================================");
  fprintf(stderr, "===========================\n");
}

int main(int argc, char* argv[])
{
  CURL *curl;
  CURLcode ret;

  curl_global_init(CURL_GLOBAL_ALL);

  if ((argc < 2) || (!argv[1]))
  {
    fprintf(stderr, "Please provide a URL \n");
    goto error_url;
  }
  else if((argc<3) || (!argv[2]))
  {
    fprintf(stderr, "Please provide the data to post\n");
    goto error_post;
  }
  /* get a curl handle */ 
  curl = curl_easy_init();
  if(curl) 
  {
    /* URL set */ 
    curl_easy_setopt(curl, CURLOPT_URL, argv[1]);

    /*  POST data */ 
    curl_easy_setopt(curl, CURLOPT_POSTFIELDS, argv[2]);

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
  return 0;
error_url:
  return 1;
error_post:
  return 2;
}
