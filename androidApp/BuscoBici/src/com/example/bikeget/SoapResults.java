package com.example.bikeget;

import java.util.regex.Pattern;

import android.os.Bundle;

import android.content.Intent;
import android.text.Html;
import android.text.method.LinkMovementMethod;
import android.text.util.Linkify;
import android.view.View;
import android.app.Activity;
import android.view.Menu;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TableRow.LayoutParams;
import android.widget.TextView;

public class SoapResults extends Activity  {
	BikeList resultList;
    TableLayout soapTable;
    
    private void setAsLink(TextView view, String url, String urlText){
        view.setText(Html.fromHtml("<a href='"+url+"'>"+urlText+"</a>"));
        view.setMovementMethod(LinkMovementMethod.getInstance());
    }

	private void fillList(BikeList list) {
      // Get the TableLayout		
	  // Go through each item in the array

	  try 
	  {
        for (int current = 0; current < list.bikeList.size(); current++)
        {
            // Create a TableRow and give it an ID
            TableRow tr = new TableRow(this);
            tr.setId(Constants.MAX_BIKES+current);
            tr.setLayoutParams(new LayoutParams(
                    LayoutParams.MATCH_PARENT,
                    LayoutParams.WRAP_CONTENT));   

            // Create a TextView to house the link
            TextView urlText = new TextView(this);
            urlText.setId(Constants.MAX_BIKES+current);
            urlText.setLayoutParams(new LayoutParams(
                    LayoutParams.MATCH_PARENT,
                    LayoutParams.WRAP_CONTENT));
            setAsLink(urlText, list.bikeList.get(current).url,
            		list.bikeList.get(current).urlText);

            tr.addView(urlText);
            
            // Create a TextView to house the price
            TextView price = new TextView(this);
            price.setId(Constants.MAX_BIKES+current);
            price.setText(Float.toString(list.bikeList.get(current).price));
            price.setLayoutParams(new LayoutParams(
                    LayoutParams.MATCH_PARENT,
                    LayoutParams.WRAP_CONTENT));
            tr.addView(price);


            // Create a TextView to house the value of the after-tax income
            TextView store = new TextView(this);
            store.setId(current);
            store.setText(list.bikeList.get(current).store);
            store.setLayoutParams(new LayoutParams(
                    LayoutParams.MATCH_PARENT,
                    LayoutParams.WRAP_CONTENT));
            tr.addView(store);

            // Add the TableRow to the TableLayout
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
