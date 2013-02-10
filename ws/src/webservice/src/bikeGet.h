// File: bikeGet.h
//gsoap ns2 service name: bikeGet
//gsoap ns2 service namespace: urn:bikeGet
//gsoap ns2 service location: http://www.buscobici.com/bikesearch/bikeGet.cgi
#import "stlvector.h"

class Bike
{
       char* trademark;
};

class BikeList
{
   int size;
   std::vector<Bike*> bikeList;
};

int ns2__bikeGet(BikeList & bikeList);
