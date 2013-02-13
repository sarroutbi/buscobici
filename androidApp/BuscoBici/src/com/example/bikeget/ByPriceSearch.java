package com.example.bikeget;

import android.os.Bundle;
import android.content.Intent;
import android.view.View;
import android.app.Activity;
import android.view.Menu;
import android.widget.SeekBar;
import android.widget.TextView;

public class ByPriceSearch extends Activity implements SeekBar.OnSeekBarChangeListener {

    SeekBar seekBar1;
    SeekBar seekBar2;
    TextView textView00;
    TextView textView01;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.search_by_price);
        seekBar1=(SeekBar)findViewById(R.id.seekBar1);
        seekBar2=(SeekBar)findViewById(R.id.seekBar2);
        textView00=(TextView)findViewById(R.id.textView00);
        textView01=(TextView)findViewById(R.id.textView01);
        seekBar1.setOnSeekBarChangeListener(this);
        seekBar2.setOnSeekBarChangeListener(this);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.activity_main, menu);
		return true;
	}
	
	 public void byPriceSearch(View view) {
	        //Intent intentExercise = new Intent(view.getContext(), ByPriceSearch.class);
	        //startActivityForResult(intentExercise, 0);
	 } 
	 
	 public void simpleSearch(View view) {
	        Intent intentExercise = new Intent(view.getContext(), SimpleSearch.class);
	        startActivityForResult(intentExercise, 0);
	 } 
	 
	 @Override
	 public void onProgressChanged(SeekBar seekBar, int progress,
	     boolean fromUser) {
	     //  Notify that the progress level has changed.
		 if(seekBar == seekBar1)
		 {
			 int minPrice = seekBar1.getProgress();
			 int maxPrice = seekBar2.getProgress();     
             textView00.setText(" "+progress + "€");
		     if(minPrice > maxPrice)
		     {
		    	 textView01.setText(" "+progress + "€");
		    	 seekBar2.setProgress(progress);
		     }
		 }
		 else if(seekBar == seekBar2)
		 {
			 //int minPrice = Integer.parseInt((String) textView00.getText());
			 int minPrice = seekBar1.getProgress();
			 int maxPrice = seekBar2.getProgress();             
             textView01.setText(" "+progress + "€");
             if(maxPrice < minPrice)
		     {
		    	 textView00.setText(" "+progress + "€");
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
