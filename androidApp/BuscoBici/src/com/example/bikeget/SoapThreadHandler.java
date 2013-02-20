package com.example.bikeget;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;

public class SoapThreadHandler {
	Context context = null;
	AsyncTask<SoapSearchData, Integer, SoapSearchData> taskSoapSearch = null;
	SoapSearchData soapSearchData = null;
	
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
			SoapRequester soapRequester = new 
    	    		SoapRequester(searchData[0].GetSearch(), 
    	    				searchData[0].GetPriceFrom(), 
    	    				searchData[0].GetPriceTo(),	
    	    				searchData[0].GetType());
			searchData[0].SetSoapBikeList(soapRequester.getList());
			return searchData[0];
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
    	    searchData.SetBikeList(searchData.GetSoapBikeList());
	 		if(!isCancelled())
	 		{
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
		if(taskSoapSearch!=null)
	    	taskSoapSearch.cancel(true);
	}
}
