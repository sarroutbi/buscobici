package com.example.bikeget;

import java.util.List;

import android.app.Application;

public class BikeList extends Application {

	public List<Bike> bikeList = null; 
	SoapSearchData globalSearchData = null;
	
	public BikeList() {
		bikeList = null;
		globalSearchData = null;
	}
	
	public BikeList(BikeList input, SoapSearchData soapData) {
		bikeList = input.bikeList;
		globalSearchData = soapData;
	}
}
