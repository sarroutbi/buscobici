package com.example.bikeget;

import android.os.Bundle;

import org.ksoap2.SoapEnvelope;
import org.ksoap2.serialization.SoapObject;
import org.ksoap2.serialization.SoapSerializationEnvelope;
import org.ksoap2.transport.HttpTransportSE;

import android.app.Activity;
import android.content.Intent;
import android.view.Menu;
import android.view.View;
import android.widget.EditText;

import java.util.List;
import java.util.ArrayList;


public class SimpleSearch extends Activity {
	private static final String NAMESPACE = "urn:bikeGet";
	private static String URL="http://buscobici.com/bikesearch/bikeGet.cgi";
	private static final String METHOD_NAME = "bikeGet";
	private static final String SOAP_ACTION = "http://buscobici.com/bikeGet";

	EditText editText00;
	List<Bike> bikeList;
	BikeList bList;
 
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.search_simple);
        editText00=(EditText)findViewById(R.id.editText1);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.activity_main, menu);
		return true;
	}
	
	 public void simpleSearch(View view) {
	        //Intent intentExercise = new Intent(view.getContext(), SimpleSearch.class);
	        //startActivityForResult(intentExercise, 0);
	 } 
	 
	 public void byPriceSearch(View view) {
	        Intent intentExercise = new Intent(view.getContext(), ByPriceSearch.class);
	        startActivityForResult(intentExercise, 0);
	 }
	 
	 public void soapSearch(View view) { 
            try {
            	  // Get text to include in the SOAP search
    		 	  String searchText = editText00.getText().toString();
    		      //Initialize soap request + add parameters
    		 	  SoapObject request = new SoapObject(NAMESPACE, METHOD_NAME);                 
    		 	  //Use this to add parameters
    		      request.addProperty("search", searchText);
    		      //Declare the version of the SOAP request
                  SoapSerializationEnvelope envelope = new SoapSerializationEnvelope(SoapEnvelope.VER11);
                  envelope.setOutputSoapObject(request);
                  envelope.dotNet = true;
                  HttpTransportSE androidHttpTransport = new HttpTransportSE(URL);
                 
                  //this is the actual part that will call the webservice
                  androidHttpTransport.call(SOAP_ACTION, envelope);
               
                  // Get the SoapResult from the envelope body.
                  SoapObject result = (SoapObject)envelope.bodyIn;

                  if(result != null)
                  {
                	  bikeList = parseList(result);
                	  BikeList bList = ((BikeList)getApplicationContext());                	    
                	  bList.bikeList = bikeList;
                  }
            } 
            catch (Exception e) {
                  e.printStackTrace();
            }
	        Intent intentExercise = new Intent(view.getContext(), SoapResults.class);
            startActivityForResult(intentExercise, 0);
	}
	 
	private List<Bike> parseList(SoapObject response) {
	    SoapObject soap_list = (SoapObject)response.getProperty(0);
	    List<Bike> list = soapToList(soap_list);
	    return list;
    } 
	
	private List<Bike> soapToList(SoapObject soapList) {
	    List<Bike> list = new ArrayList<Bike>();
	    for(int i=0; i<soapList.getPropertyCount(); i++)
	    {
	       Bike aBike = new Bike();
	       SoapObject bike =(SoapObject) soapList.getProperty(i);
	       aBike.trademark = bike.getProperty(0).toString();
	       aBike.store     = bike.getProperty(1).toString();
	       aBike.model     = bike.getProperty(2).toString();
	       aBike.url       = bike.getProperty(3).toString();
	       aBike.urlText   = bike.getProperty(4).toString();
	       aBike.type      = bike.getProperty(5).toString();
           aBike.price     = Float.valueOf(bike.getProperty(6).toString());
	       list.add(aBike);
	    }
	    return list;
	}
}
