APP=bikeGet
SRC=$(APP).h
SOAPCC=soapcpp2
CC=g++
CLI=ws_client
CLI_SRC=$(CLI).cpp
LIBBIKE_PATH=../../libbike/o
LIBBIKE_INC_PATH=../../libbike/src
LIBBIKE=bike $(shell curl-config --libs)

SOAP_OUT=$(APP).nsmap $(APP).wsdl ns.xsd soap$(APP)Object.h soap$(APP)Proxy.h soapC.cpp soapClient.cpp soapClientLib.cpp soapH.h soapServer.cpp soapServerLib.cpp soapStub.h soapObject.h ns2.nsmap ns2.wsdl ns2.xsd soap$(APP)Service.cpp soap$(APP)Service.h

INC_DIR=/usr/include/gsoap/import

all: soap build buildcli

clean: soapclean cleanall cleancgi cleanxml cleancli

soap: $(SRC)
	$(SOAPCC) $(SRC) -I$(INC_DIR)

soapclean:
	rm -f $(SOAP_OUT)

cleancgi:
	rm -f *.cgi

cleanall:
	rm -f *~

cleanxml:
	rm -f *.xml

cleancli:
	rm -f $(CLI)

build: $(APP)Cgi.cpp
	$(CC) -o $(APP).cgi $(APP)Cgi.cpp soapC.cpp soapServer.cpp -lgsoap++ -L$(LIBBIKE_PATH) -l$(LIBBIKE) -I$(LIBBIKE_INC_PATH)

buildcli:
	$(CC) -o $(CLI) soapC.cpp soapClient.cpp $(CLI_SRC) -I$(LIBBIKE_INC_PATH) -lgsoap++
