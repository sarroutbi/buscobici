APP=bikeGet
SRC=$(APP).h
SOAPCC=soapcpp2
CC=g++

SOAP_OUT=$(APP).nsmap $(APP).wsdl ns.xsd soap$(APP)Object.h soap$(APP)Proxy.h soapC.cpp soapClient.cpp soapClientLib.cpp soapH.h soapServer.cpp soapServerLib.cpp soapStub.h soapObject.h ns2.nsmap ns2.wsdl ns2.xsd

INC_DIR=/usr/include/gsoap/import

all: soapServer build

clean: soapclean cleanall cleancgi cleanxml

soapServer: $(SRC)
	$(SOAPCC) -S $(SRC) -I$(INC_DIR)

soapclean:
	rm -f $(SOAP_OUT)

cleancgi:
	rm -f *.cgi

cleanall:
	rm -f *~

cleanxml:
	rm -f *.xml

build:
	$(CC) -o $(APP).cgi $(APP)Cgi.cpp soapC.cpp soapServer.cpp -lgsoap++
