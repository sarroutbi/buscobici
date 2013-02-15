package com.example.bikeget;

import android.os.Bundle;

import android.content.Intent;
import android.view.View;
import android.app.Activity;
import android.view.Menu;

import java.util.List;

public class SoapResults extends Activity  {
	List<Bike> results;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.soap_results);
		Bundle b = this.getIntent().getExtras();
		if(b!=null)
		    results = b.getParcelable("bikeList");
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.activity_main, menu);
		return true;
	}
	
	 public void byPriceSearch(View view) {
	        Intent intentExercise = new Intent(view.getContext(), ByPriceSearch.class);	        
	        startActivityForResult(intentExercise, 0);
	 } 
	 
	 public void simpleSearch(View view) {
	        Intent intentExercise = new Intent(view.getContext(), SimpleSearch.class);
	        startActivityForResult(intentExercise, 0);
	 } 

}
