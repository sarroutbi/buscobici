package com.example.bikeget;

import android.os.Bundle;

import android.app.Activity;
import android.content.Intent;
import android.view.Menu;
import android.view.View;
import android.widget.EditText;
import android.widget.ProgressBar;

public class SimpleSearch extends Activity {

	EditText editText00;
	ProgressBar progressBar00;
	private BikeList bList = null;
	SoapThreadHandler soapThread = null;
	
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
	    if(soapThread!=null) {
	    	soapThread.cancelDownload();
	    }
	}
	
	@Override
	protected void onDestroy() {
		super.onDestroy();
        progressBar00=(ProgressBar)findViewById(R.id.progressBar00);
	    progressBar00.setVisibility(View.INVISIBLE);
	    if(soapThread!=null) 
	    	soapThread.cancelDownload();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.activity_main, menu);
		return true;
	}
	
	 public void simpleSearch(View view) {
		 if(soapThread!=null)
		    	soapThread.cancelDownload();
	     progressBar00.setVisibility(View.INVISIBLE);
	 } 
	 
	 public void byPriceSearch(View view) {
		 if(soapThread!=null)
		    	soapThread.cancelDownload();
	     Intent intentExercise = new Intent(view.getContext(), 
	    		 ByPriceSearch.class);
	     startActivityForResult(intentExercise, 0);
	 }
	 
	 public void advancedSearch(View view) {
		 if(soapThread!=null)
		    	soapThread.cancelDownload();
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
	 
	 protected void onProgressUpdate(Integer... values) { //
 		// Not used in this case
 	 }

	 public void soapSearchAsynctask(View view) {
	        bList = ((BikeList)getApplicationContext());
	        if(bList.bikeList != null)
	        	bList.bikeList.clear();

	        SoapSearchData soapSearchData = new SoapSearchData(bList, 
	        		editText00.getText().toString(), 0, 0, "");
 	        bList.globalSearchData = soapSearchData;
	        soapThread = new SoapThreadHandler(getApplicationContext());
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
    	    		SoapRequester(editText00.getText().toString(), 0, 0, 
    	    				"");
    	    bList = ((BikeList)getApplicationContext());
    	    bList.bikeList = soapRequester.getList();
	        Intent intentExercise = new Intent(view.getContext(), 
	        		SoapResults.class);
            startActivityForResult(intentExercise, 0);
	 }
}
