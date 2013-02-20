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

public class SimpleSearch extends Activity {

	EditText editText00;
	ProgressBar progressBar00;
	private BikeList bList = null;
	private final String TAG = "SimpleSearch";
	AsyncTask<String, Integer, List<Bike>> taskSoapSearch = null;
	
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
	    if(taskSoapSearch!=null)
	    	taskSoapSearch.cancel(true);
	}
	
	@Override
	protected void onDestroy() {
		super.onDestroy();
        progressBar00=(ProgressBar)findViewById(R.id.progressBar00);
	    progressBar00.setVisibility(View.INVISIBLE);
	    if(taskSoapSearch!=null)
	    	taskSoapSearch.cancel(true);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.activity_main, menu);
		return true;
	}
	
	 public void simpleSearch(View view) {
		 if(taskSoapSearch!=null) {
			 taskSoapSearch.cancel(true);
		 }
	     progressBar00.setVisibility(View.INVISIBLE);
	 } 
	 
	 public void byPriceSearch(View view) {
		 if(taskSoapSearch!=null) {
			 taskSoapSearch.cancel(true);
		 }
	     Intent intentExercise = new Intent(view.getContext(), 
	    		 ByPriceSearch.class);
	     startActivityForResult(intentExercise, 0);
	 }
	 
	 public void advancedSearch(View view) {
		 if(taskSoapSearch!=null) {
			 taskSoapSearch.cancel(true);
		 }
	     progressBar00.setVisibility(View.INVISIBLE);
	 } 
	 
	 public void soapSearch(View view) {
	     progressBar00.setVisibility(View.VISIBLE);

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
	 		if(!isCancelled())
	 		{
	 			loadResults();
	 			bList = ((BikeList)getApplicationContext());
	 			bList.bikeList = list;
	 		}
	 	}
	 }
	
	 protected void loadResults()
	 {
	     Intent intentExercise = new Intent(this, 
	        		SoapResults.class);
	     startActivityForResult(intentExercise, 0);
	 }
	 
	 protected void onProgressUpdate(Integer... values) { //
 		// Not used in this case
 	 }

	 public void soapSearchAsynctask(View view) {
		 taskSoapSearch = new SoapSearch().execute(editText00.getText().toString());
	 }
	 
	 public void soapSearchMultithread(View view) { 
	     
		 Thread runner = new Thread(new Runnable() {
			    public void run() {
			    	Thread.yield();
			    	SoapRequester soapRequester = new 
		    	    		SoapRequester(
		    	    				editText00.getText().toString(), 
		    	    					0, 0, "");			
		    	    bList = ((BikeList)getApplicationContext());
		    	    bList.bikeList = soapRequester.getList();
		    	    loadResults();
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
