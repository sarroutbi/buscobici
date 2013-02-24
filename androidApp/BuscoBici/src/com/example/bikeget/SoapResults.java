package com.example.bikeget;

import com.google.analytics.tracking.android.GoogleAnalytics;
import com.google.analytics.tracking.android.Tracker;

import android.os.Bundle;

import android.content.Intent;
import android.text.Html;
import android.text.method.LinkMovementMethod;
import android.view.View;
import android.app.Activity;
import android.view.Menu;
import android.widget.LinearLayout;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TableRow.LayoutParams;
import android.widget.TextView;

public class SoapResults extends Activity  {
	BikeList resultList;
    TableLayout soapTable;
	GoogleAnalytics gAnalyzer;
	private Tracker gTracker;
    
    private void setAsLink(TextView view, String url, String urlText)
    {
    	String urlTextTrimmed = urlText;
    	if(urlText.length() > Constants.MAX_URL_TEXT)
    	{
    		 urlTextTrimmed = urlText.substring(0, 
    				 	Constants.MAX_URL_TEXT - 3);
    		 urlTextTrimmed += "...";
    	}
        view.setText(Html.fromHtml("<a charset=" + 
        		Constants.DEFAULT_CHARSET + " + href='" + url + 
        			"'>" + urlTextTrimmed + "</a>"));
        view.setMovementMethod(LinkMovementMethod.getInstance());
    }

	private void fillList(BikeList list) {
      // Get the TableLayout		
	  // Go through each item in the array

	  try 
	  {
        for (int current = 0; current < list.bikeList.size(); current++)
        {
            TableRow tr = new TableRow(this);
            TableLayout.LayoutParams tableRowParams =
            		  new TableLayout.LayoutParams
            		  (TableLayout.LayoutParams.WRAP_CONTENT,
            				  TableLayout.LayoutParams.WRAP_CONTENT);

            int leftMargin=2;
            int topMargin=2;
            int rightMargin=2;
            int bottomMargin=2;

            tableRowParams.setMargins(leftMargin, topMargin, rightMargin, 
            		bottomMargin);
            
            tr.setLayoutParams(tableRowParams);
            
            tr.setId(Constants.MAX_BIKES + current);
            tr.setLayoutParams(new LayoutParams(
                    LayoutParams.MATCH_PARENT,
                    LayoutParams.WRAP_CONTENT));   

            TextView urlText = new TextView(this);
            urlText.setId(2 * Constants.MAX_BIKES + current);
            urlText.setLayoutParams(new LayoutParams(
                    LayoutParams.MATCH_PARENT,
                    LayoutParams.WRAP_CONTENT));
            
            byte[] utf16le = list.bikeList.get(current).urlText.
            		getBytes(Constants.DEFAULT_CHARSET);
            String urlString = new String(utf16le, 
            		Constants.DEFAULT_CHARSET);
            String urlTextFormat = urlString.replaceAll("ñ", "�");
            urlTextFormat = urlTextFormat.replaceAll("á", "�");
            urlTextFormat = urlTextFormat.replaceAll("é", "�");
            urlTextFormat = urlTextFormat.replaceAll("í",  "�");
            urlTextFormat = urlTextFormat.replaceAll("ó", "�");
            urlTextFormat = urlTextFormat.replaceAll("ú", "�");

            setAsLink(urlText, list.bikeList.get(current).url,
            		urlTextFormat);
            urlText.setTextSize(Constants.RESULTS_URL_TEXT_SIZE);
            tr.addView(urlText);
            
            TextView price = new TextView(this);
            price.setId(3 * Constants.MAX_BIKES + current);
            price.setText(String.format("%.2f", 
            			list.bikeList.get(current).price));
            price.setLayoutParams(new LayoutParams(
                    LayoutParams.MATCH_PARENT,
                    LayoutParams.WRAP_CONTENT));
            LinearLayout.LayoutParams margins = (LinearLayout.LayoutParams)
            		price.getLayoutParams();
            margins.leftMargin  = Constants.SOAP_RESULTS_TABLE_MARGIN;
            margins.rightMargin = Constants.SOAP_RESULTS_TABLE_MARGIN;
            price.setTextSize(Constants.RESULTS_PRICE_TEXT_SIZE);
            tr.addView(price);

            TextView store = new TextView(this);
            store.setId(4 * Constants.MAX_BIKES + current);
            store.setText(list.bikeList.get(current).store);
            store.setLayoutParams(new LayoutParams(
                    LayoutParams.MATCH_PARENT,
                    LayoutParams.WRAP_CONTENT));
            store.setTextSize(Constants.RESULTS_STORE_TEXT_SIZE);
            
            LinearLayout.LayoutParams margins2 = (LinearLayout.LayoutParams)
            		store.getLayoutParams();
            margins2.rightMargin=Constants.SOAP_RESULTS_TABLE_MARGIN;

            tr.addView(store);
            
            TextView type = new TextView(this);
            type.setId(5 * Constants.MAX_BIKES + current);
            type.setText(list.bikeList.get(current).type);
            type.setLayoutParams(new LayoutParams(
                    LayoutParams.MATCH_PARENT,
                    LayoutParams.WRAP_CONTENT));
            type.setTextSize(Constants.RESULTS_TYPE_TEXT_SIZE);
            tr.addView(type);
            
            soapTable.addView(tr, new TableLayout.LayoutParams(
            		LayoutParams.MATCH_PARENT,
            		LayoutParams.WRAP_CONTENT));
        }
	  }
	  catch (Exception e) {
          e.printStackTrace();  
	  }
	}
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.soap_results);
        soapTable = (TableLayout)findViewById(R.id.resultsTable00);
        resultList = ((BikeList)getApplicationContext());;
        if(resultList != null)
          fillList(resultList);
	    gAnalyzer = GoogleAnalytics.getInstance(this);
        if(Constants.GOOGLE_ANALYTICS_DEBUG)
        	gAnalyzer.setDebug(true);
	    gTracker = gAnalyzer.getTracker(Constants.GOOGLE_TRACKER);
	}
	
	@Override
	protected void onStart() {
		 super.onStart();
		 gTracker.sendView("/Android/SoapResults");
	}
	
	@Override
	protected void onStop() {
		super.onStop();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.activity_main, menu);
		return true;
	}
	
	 public void byPriceSearch(View view) {
	        Intent intentExercise = new Intent(view.getContext(), 
	        		ByPriceSearch.class);	        
	        startActivityForResult(intentExercise, 0);
	 } 
	 
	 public void simpleSearch(View view) {
	        Intent intentExercise = new Intent(view.getContext(), 
	        		SimpleSearch.class);
	        startActivityForResult(intentExercise, 0);
	 } 
	 
	 public void advancedSearch(View view) {
	        //Intent intentExercise = new Intent(view.getContext(), 
	        //		AdvancedSearch.class);
	        //startActivityForResult(intentExercise, 0);
	 }
}
