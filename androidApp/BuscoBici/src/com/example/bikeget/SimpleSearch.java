package com.example.bikeget;

import android.os.Bundle;

import android.app.Activity;
import android.content.Intent;
import android.view.Menu;
import android.view.View;
import android.widget.EditText;

public class SimpleSearch extends Activity {

	EditText editText00;
	private BikeList bList = null;

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
	        Intent intentExercise = new Intent(view.getContext(), 
	        		ByPriceSearch.class);
	        startActivityForResult(intentExercise, 0);
	 }
	 
	 public void soapSearch(View view) { 
    	    bList = ((BikeList)getApplicationContext());   
    	    SoapRequester soapRequester = new 
    	    		SoapRequester(editText00.getText().toString(), 0, 0, "");
    	    bList.bikeList = soapRequester.getList();
	        Intent intentExercise = new Intent(view.getContext(), 
	        		SoapResults.class);
            startActivityForResult(intentExercise, 0);
	}
}
