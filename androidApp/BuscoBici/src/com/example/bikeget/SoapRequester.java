package com.example.bikeget;

import java.util.ArrayList;
import java.util.List;

import org.ksoap2.SoapEnvelope;
import org.ksoap2.serialization.SoapObject;
import org.ksoap2.serialization.SoapSerializationEnvelope;
import org.ksoap2.transport.HttpTransportSE;

public class SoapRequester {

	private List<Bike> bikeList;
 
	public SoapRequester(String searchText, 
			int priceFrom, int priceTo, String type) {
		bikeList = null;
		try {
		    //Initialize soap request + add parameters
		 	SoapObject request = new SoapObject(Constants.NAMESPACE, 
		 			Constants.METHOD_NAME);
		 	//Use this to add parameters
		    request.addProperty("search",    searchText);
		    request.addProperty("priceFrom", priceFrom);
		    request.addProperty("priceTo",   priceTo);
		    request.addProperty("type",      type);
		    //Declare the version of the SOAP request
            SoapSerializationEnvelope envelope = 
            	new SoapSerializationEnvelope(SoapEnvelope.VER11);
            envelope.setOutputSoapObject(request);
            envelope.dotNet = false;
            HttpTransportSE androidHttpTransport = 
            		new HttpTransportSE(Constants.URL);
            //this is the actual part that will call the web service
            androidHttpTransport.call(Constants.SOAP_ACTION, envelope);
            // Get the SoapResult from the envelope body.
            SoapObject result = (SoapObject)envelope.bodyIn;
            Thread.yield();
            if(result != null)
            {
          	  bikeList = SoapRequester.parseList(result);  	    
            }
      } 
      catch (Exception e) {
            e.printStackTrace();
      }
	}
	
	public List<Bike> getList()
	{
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return bikeList;
	}
	
	public static List<Bike> parseList(SoapObject response) {
	    SoapObject soap_list = (SoapObject)response.getProperty(0);
	 	Thread.yield();
	    List<Bike> list = soapToList(soap_list);
	    try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return list;
    } 
	
	public static List<Bike> soapToList(SoapObject soapList) {
	    List<Bike> list = new ArrayList<Bike>();
	    for(int i=0; i<soapList.getPropertyCount(); i++)
	    {
	       Bike aBike = new Bike();
	       SoapObject bike = (SoapObject) soapList.getProperty(i);
	       aBike.trademark = bike.getProperty(0).toString();
	       aBike.store     = bike.getProperty(1).toString();
	       aBike.model     = bike.getProperty(2).toString();
	       aBike.url       = bike.getProperty(3).toString();
	       aBike.urlText   = bike.getProperty(4).toString();
	       aBike.type      = bike.getProperty(5).toString();
           aBike.price = Float.valueOf(bike.getProperty(6).toString());
	       list.add(aBike);
	       Thread.yield();
		}
	    return list;
	}
}
