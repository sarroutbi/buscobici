package com.example.bikeget;

import android.os.Bundle;

import android.content.Intent;
import android.view.View;
import android.app.Activity;
import android.view.Menu;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.SeekBar;
import android.widget.TextView;

public class ByPriceSearch extends Activity implements 
	SeekBar.OnSeekBarChangeListener {

	// Visual elements
	EditText    search00;
    SeekBar     seekBar1;
    SeekBar     seekBar2;
    TextView    textView00;
    TextView    textView01;
    RadioButton radioMtb;
    RadioButton radioRoad;
    RadioButton radioUrban;
    RadioButton radioBmx;
    RadioButton radioKids;
	private BikeList bList = null;
	SoapThreadHandler soapThread = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.search_by_price);
        seekBar1   = (SeekBar)findViewById(R.id.seekBar00);
        seekBar2   = (SeekBar)findViewById(R.id.seekBar01);
        textView00 = (TextView)findViewById(R.id.textView00);
        textView01 = (TextView)findViewById(R.id.textView01);
        search00   = (EditText)findViewById(R.id.editText00);
        radioMtb   = (RadioButton)findViewById(R.id.RadioMtb);
        radioRoad  = (RadioButton)findViewById(R.id.RadioRoad);
        radioBmx   = (RadioButton)findViewById(R.id.RadioBmx);
        radioUrban = (RadioButton)findViewById(R.id.RadioUrban);
        radioKids  = (RadioButton)findViewById(R.id.RadioKids);

        seekBar1.setOnSeekBarChangeListener(this);
        seekBar2.setOnSeekBarChangeListener(this);
    	textView00.setText(" " + "0" + "€");
    	textView01.setText(" " + "0" + "€");
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.activity_main, menu);
		return true;
	}
	
	private String getType() {
		String type = "";
	    if(radioMtb.isChecked())
	    	type = Constants.TYPE_MTB;
	    else if (radioRoad.isChecked())
	    	type = Constants.TYPE_ROAD;
	    else if (radioUrban.isChecked())
	    	type = Constants.TYPE_URBAN;
	    else if (radioBmx.isChecked())
	    	type = Constants.TYPE_BMX;
	    else if (radioKids.isChecked())
	    	type = Constants.TYPE_KIDS;
		return type;
	}
	
	public void soapSearch(View view) {
 	     String search        = search00.getText().toString();
 	     String sFromCurrency = textView00.getText().toString().trim();
 	     String sToCurrency   = textView01.getText().toString().trim();
 	     String sPriceFrom = sFromCurrency.substring(0, 
 	    		 sFromCurrency.length()-1);
 	     String sPriceTo   = sToCurrency.substring(0, 
 	    		 sToCurrency.length()-1);
 	     int priceFrom = Integer.valueOf(sPriceFrom);
 	     int priceTo   = Integer.valueOf(sPriceTo);
 	     String type   = getType();
 	     
	     bList = ((BikeList)getApplicationContext());
	     if(bList.bikeList != null)
	      	bList.bikeList.clear();

	     SoapSearchData soapSearchData = new SoapSearchData(bList, 
	       		search, priceFrom, priceTo, type);
	     bList.globalSearchData = soapSearchData;
	     soapThread = new SoapThreadHandler(getApplicationContext());
	 } 
	 
	 public void simpleSearch(View view) {
		 if(soapThread != null)
		    	soapThread.cancelDownload();
	     Intent intentExercise = new Intent(view.getContext(), 
	    		SimpleSearch.class);
	     startActivityForResult(intentExercise, 0);
	 } 
	 
	 public void byPriceSearch(View view) {
	        //Intent intentExercise = new Intent(view.getContext(), 
	        //		ByPriceSearch.class);
	        //startActivityForResult(intentExercise, 0);
		 if(soapThread != null)
		    	soapThread.cancelDownload();
	 } 
	 
	 public void advancedSearch(View view) {
	        //Intent intentExercise = new Intent(view.getContext(), 
	        //		AdvancedSearch.class);
	        //startActivityForResult(intentExercise, 0);
		 if(soapThread != null)
		    	soapThread.cancelDownload();
	 } 
	 
	 @Override
	 public void onProgressChanged(SeekBar seekBar, int progress,
	     boolean fromUser) {
	     //  Notify that the progress level has changed.
		 if(seekBar == seekBar1)
		 {
			 int minPrice = seekBar1.getProgress();
			 int maxPrice = seekBar2.getProgress();     
             textView00.setText(" " + ((progress*progress*9) + 100 - 
            		 ((progress*progress*9)%100)) + "€");
            
		     if(minPrice > maxPrice)
		     {
		    	 textView01.setText(" " + ((progress*progress*9) + 100 - 
				    	 ((progress*progress*9)%100)) + "€");
		    	 seekBar2.setProgress(progress);
		     }
		 }
		 else if(seekBar == seekBar2)
		 {
			 int minPrice = seekBar1.getProgress();
			 int maxPrice = seekBar2.getProgress();             
             textView01.setText(" " + ((progress*progress*9) + 100 - 
            		 ((progress*progress*9)%100)) + "€");
             if(maxPrice < minPrice)
		     {
		    	 textView00.setText(" " + ((progress*progress*9) + 100 - 
	            		 ((progress*progress*9)%100)) + "€");
		    	 seekBar1.setProgress(progress);
		     }
		 }
	 }

	 @Override
	 public void onStartTrackingTouch(SeekBar arg0) {
		 // TODO Auto-generated method stub
	 }

	 @Override
	 public void onStopTrackingTouch(SeekBar arg0) {
		 // TODO Auto-generated method stub
	 }
}
