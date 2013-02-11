#include "soapH.h"
#include "bikeGet.nsmap"
#include "Bike.h"

void logList(const ns2BikeList & ns2bl)
{
  std::vector<ns2Bike>::iterator i;
  std::vector<ns2Bike> bl = ns2bl.bikeList;
  for(i = bl.begin(); i != bl.end(); ++i)
  {
    std::cout << "===================================================="
              << "====================================================" << std::endl;
    std::cout << "Trademark:" << i->trademark << std::endl;
    std::cout << "Model    :" << i->model<< std::endl;
    std::cout << "Store    :" << i->store<< std::endl;
    std::cout << "Url      :" << i->url<< std::endl;
    std::cout << "Url Text :" << i->urlContent<< std::endl;
    std::cout << "Price    :" << i->price<< std::endl;
    std::cout << "===================================================="
              << "====================================================" << std::endl;
  }
}

int main()
{
  ns2BikeList bl;
  struct soap *soap = soap_new();
  if(soap_call_ns2__bikeGet(soap, NULL, NULL, const_cast<char*>("Trek"), 
                            const_cast<char*>("MTB"), 0, 1000, bl) == SOAP_OK)
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

