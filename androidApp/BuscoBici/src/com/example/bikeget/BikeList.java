package com.example.bikeget;

import java.util.List;

import android.app.Application;

public class BikeList extends Application {

	public List<Bike> bikeList;
	
	public BikeList() {
		bikeList = null;
	}
	
	public BikeList(BikeList input) {
		bikeList = input.bikeList;
	}
}
