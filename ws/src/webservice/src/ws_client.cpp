#include "soapH.h"
#include "bikeGet.nsmap"
#include "Bike.h"

void logList(const ns2BikeList & ns2bl)
{
  std::vector<ns2Bike>::iterator i;
  std::vector<ns2Bike> bl = ns2bl.bikeList;
  for(i = bl.begin(); i != bl.end(); ++i)
  {
    std::cout << "Trademark:" << i->trademark << std::endl;
    std::cout << "Model    :" << i->trademark << std::endl;
  }
}

int main()
{
  ns2BikeList bl;
  struct soap *soap = soap_new();
  if(soap_call_ns2__bikeGet(soap, NULL, NULL, "Trek", "MTB", 0, 1000, bl) == SOAP_OK)
  {
    fprintf(stderr, "Logging ...");
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

