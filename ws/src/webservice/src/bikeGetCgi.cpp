#include "soapH.h" 
#include "bikeGet.nsmap"

int main(int argc, char* argv[])
{
  // create soap context and serve one CGI-based request:
  soap_serve(soap_new());
}

int ns2__bikeGet(struct soap *soap, char* search, char* type, 
                 int priceFrom, int priceTo, BikeList & response)
{
  return SOAP_OK;
}
