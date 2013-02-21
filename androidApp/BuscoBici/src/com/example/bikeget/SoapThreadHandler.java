package com.example.bikeget;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;

public class SoapThreadHandler {
	Context context = null;
	AsyncTask<SoapSearchData, Integer, SoapSearchData> taskSoapSearch = null;
	SoapSearchData soapSearchData = null;
	boolean cancelled = false;
	
	//@Override
	//protected void onCreate(Bundle savedInstanceState) {
	//	super.onCreate(savedInstanceState);
	//	soapSearchData = ((BikeList)getApplicationContext()).globalSearchData;
	//	taskSoapSearch = new SoapSearch().execute(soapSearchData);
	//}
	
	public SoapThreadHandler(Context context) {
		this.context = context;
		soapSearchData = ((BikeList)this.context).globalSearchData;
		taskSoapSearch = new SoapSearch().execute(soapSearchData);
	}
	
	// Asynchronously posts to twitter
	class SoapSearch extends AsyncTask<SoapSearchData, Integer, 
		SoapSearchData> { //
		// Called to initiate the background activity
		@Override
	 	protected SoapSearchData doInBackground(SoapSearchData... searchData)	{
			cancelled = false;
			SoapRequester soapRequester = new 
    	    		SoapRequester(searchData[0].GetSearch(), 
    	    				searchData[0].GetPriceFrom(), 
    	    				searchData[0].GetPriceTo(),	
    	    				searchData[0].GetType());
			searchData[0].SetSoapBikeList(soapRequester.getList());
			if(!isCancelled())
				return searchData[0];
			else
				return null;
			}
			// Called when there's a status to be updated
			@Override
			protected void onProgressUpdate(Integer... values) { //
				// Not used in this case
				super.onProgressUpdate(values);
			}
			// Called once the background activity has completed
			@Override
			protected void onPostExecute(SoapSearchData searchData) { //
				if(!cancelled && !isCancelled() && searchData != null)
				{
					searchData.SetBikeList(searchData.GetSoapBikeList());
				loadResults();
			}
		}
	}
	
	protected void loadResults()
	{
		Intent res = new Intent();
		res.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
		String mPackage = "com.example.bikeget";
		String mClass = ".SoapResults";
		res.setComponent(new ComponentName(mPackage,mPackage+mClass));
		//Intent res = new Intent(context, SoapResults.class);
		context.startActivity(res);
	}
	
	public void cancelDownload() {
		cancelled = true;
		if(taskSoapSearch!=null)
			taskSoapSearch.cancel(true);
	}
}
