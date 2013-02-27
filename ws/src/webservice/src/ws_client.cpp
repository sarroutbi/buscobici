#include "soapH.h"
#include "bikeGet.nsmap"

const uint8_t MAX_POST_FIELD=255;

void logList(const ns2BikeList & ns2bl)
{
  std::vector<ns2Bike>::iterator i;
  std::vector<ns2Bike> bl = ns2bl.bikeList;
  for(i = bl.begin(); i != bl.end(); ++i)
  {
    std::cout << "===================================================="
              << "====================================================" 
              << std::endl;
    std::cout << "Trademark:" << i->trademark << std::endl;
    std::cout << "Model    :" << i->model<< std::endl;
    std::cout << "Store    :" << i->store<< std::endl;
    std::cout << "Url      :" << i->url<< std::endl;
    std::cout << "Url Text :" << i->urlContent<< std::endl;
    std::cout << "Type     :" << i->type << std::endl;
    std::cout << "Price    :" << i->price<< std::endl;
    std::cout << "===================================================="
              << "====================================================" 
              << std::endl;
  }
    std::cout << "===================================================="
              << "====================================================" 
              << std::endl;
    std::cout << "=>" << bl.size() << "<= elements obtained" << std::endl;
    std::cout << "===================================================="
              << "====================================================" 
              << std::endl;
}

void usage(char* argv, uint8_t err)
{
  if(argv)
  {
    fprintf(stderr, "\n");
    fprintf(stderr, "%s: ", argv);
    fprintf(stderr, "	%s [-s\"search\"] -k[\"bike_kind\"] -f\
[\"price_from\"] -t[\"price_to\"]\n", argv);
    fprintf(stderr, "\n");
  }
  exit(err);
}

void parseArgs(int argc, char* argv[], char* search, uint8_t search_max,
               char* type, uint8_t type_max, uint32_t* priceFrom, 
               uint32_t* priceTo)
{
  int8_t  c = 0;
  uint8_t opterr = 0;
     
  while ((c = getopt (argc, argv, "s:k:f:t:h")) != -1)
  {
    switch (c)
    {
      case 's':
        strncpy(search, optarg, search_max);
        break;
      case 'k':
        strncpy(type, optarg, type_max);
        break;
      case 'f':
        *priceFrom = strtoul(optarg, 0, 10);
        break;
      case 't':
        *priceTo = strtoul(optarg, 0, 10);
        break;
      default:
        usage (argv[0], 1);
    }
  }
  return;
}

int main(int argc, char* argv[])
{
  ns2BikeList bl;
  struct soap *soap = soap_new();
  char search[MAX_POST_FIELD] = "";
  char type  [MAX_POST_FIELD] = "";
  uint32_t priceFrom = 0;
  uint32_t priceTo   = 0;
 
  parseArgs(argc, argv, search, MAX_POST_FIELD, type, MAX_POST_FIELD, 
            &priceFrom, &priceTo);

  if(soap_call_ns2__bikeGet(soap, NULL, NULL, search, type, priceFrom, 
                            priceTo, bl) == SOAP_OK)
  {
    logList(bl);
  }
  else
  {
    soap_print_fault(soap, stderr);
  }
  soap_end(soap);
  soap_free(soap);
  return 0;
}

