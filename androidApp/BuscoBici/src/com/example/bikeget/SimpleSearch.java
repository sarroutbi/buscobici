package com.example.bikeget;

import android.os.AsyncTask;
import android.os.Bundle;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.widget.EditText;
import android.widget.ProgressBar;

import java.util.List;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

public class SimpleSearch extends Activity {

	EditText editText00;
	ProgressBar progressBar00;
	private BikeList bList = null;
	private final String TAG = "SimpleSearch";
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.search_simple);
        editText00=(EditText)findViewById(R.id.editText1);
        progressBar00=(ProgressBar)findViewById(R.id.progressBar00);
        progressBar00.setVisibility(View.INVISIBLE);
	}
	
	@Override
	protected void onResume() {
		super.onResume();
        progressBar00=(ProgressBar)findViewById(R.id.progressBar00);
	    progressBar00.setVisibility(View.INVISIBLE);
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
	 
	 public void advancedSearch(View view) {
	        //Intent intentExercise = new Intent(view.getContext(), 
	        //		AdvancedSearch.class);
	        //startActivityForResult(intentExercise, 0);
	 } 
	 
	 public void soapSearch(View view) {
		 if(Constants.MULTI_THREAD == 0)
			 soapSearchMonothread(view);
		 else if(Constants.MULTI_THREAD == 1)
			 soapSearchMultithread(view);
		 else
			 soapSearchAsynctask(view);
	 }
	 
	// Asynchronously posts to twitter
	class SoapSearch extends AsyncTask<String, Integer, List<Bike>> { //
	// Called to initiate the background activity
		@Override
	 	protected List<Bike> doInBackground(String... search) { //
			Log.d(TAG, "doInBackground");
			SoapRequester soapRequester = new 
    	    		SoapRequester(search[0], 0, 0, "");
       	    return soapRequester.getList();		 	
	 	}
	 	// Called when there's a status to be updated
	 	@Override
	 	protected void onProgressUpdate(Integer... values) { //
	 		// Not used in this case
	 		super.onProgressUpdate(values);
	 	}
	 	// Called once the background activity has completed
	 	@Override
	 	protected void onPostExecute(List<Bike> list) { //
    	    bList = ((BikeList)getApplicationContext());
	 		bList.bikeList = list;
	 		Log.d(TAG, "postExecute");
	 	}
	 }
	
	 protected void onProgressUpdate(Integer... values) { //
 		// Not used in this case
 	 }

	 public void soapSearchAsynctask(View view) {

		 AsyncTask<String, Integer, List<Bike>> task = 
				 new SoapSearch().execute(editText00.getText().toString());

  		 progressBar00.setVisibility(View.VISIBLE); 

		 try {
			task.get(Constants.SOAP_RESPONSE_TIMEOUT, TimeUnit.MILLISECONDS);
	  	 } catch (InterruptedException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		 } catch (ExecutionException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		 } catch (TimeoutException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		 }
		 
	     Intent intentExercise = new Intent(view.getContext(), 
	        		SoapResults.class);
         startActivityForResult(intentExercise, 0);
	 }
	 
	 public void soapSearchMultithread(View view) { 
	     progressBar00.setVisibility(View.VISIBLE);
		 Thread runner = new Thread(new Runnable() {
			    public void run() {
			    	SoapRequester soapRequester = new 
		    	    		SoapRequester(
		    	    				editText00.getText().toString(), 
		    	    					0, 0, "");		       	    
		    	    bList = ((BikeList)getApplicationContext());
		    	    bList.bikeList = soapRequester.getList();			        
			    }
			  });
		 runner.setPriority(Thread.MIN_PRIORITY);
		 runner.start();
		 try {
			runner.join(Constants.SOAP_RESPONSE_TIMEOUT);
		 } catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		 }
		 Intent intentExercise = new Intent(view.getContext(), 
	        		SoapResults.class);
         startActivityForResult(intentExercise, 0);
	 }
	 
	 public void soapSearchMonothread(View view) { 
    	    SoapRequester soapRequester = new 
    	    		SoapRequester(editText00.getText().toString(), 0, 0, "");
    	    bList = ((BikeList)getApplicationContext());
    	    bList.bikeList = soapRequester.getList();
	        Intent intentExercise = new Intent(view.getContext(), 
	        		SoapResults.class);
            startActivityForResult(intentExercise, 0);
	 }
}
