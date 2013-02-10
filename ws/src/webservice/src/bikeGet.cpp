#include "soapH.h" 
#include "bikeGet.nsmap"

int main()
{
  // create soap context and serve one CGI-based request:
  soap_serve(soap_new());
}

int ns2__bikeGet(struct soap *soap, BikeList & response)
{
  return SOAP_OK;
}
