//File: bikeGet.h
//gsoap ns2 service name: bikeGet
//gsoap ns2 service namespace: urn:bikeGet
//gsoap ns2 service location: http://www.buscobici.com/bikesearch/bikeGet.cgi
#import "stlvector.h"

class ns2Bike
{
  char*  trademark;
  char*  store;
  char*  model;
  char*  url;
  char*  urlContent;
  char*  type;
  double price;
};

class ns2BikeList
{
  std::vector<ns2Bike> bikeList;
};

int ns2__bikeGet(char* search, char* type, int priceFrom, int priceTo, ns2BikeList & bikeList);
