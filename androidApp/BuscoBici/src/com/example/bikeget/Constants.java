package com.example.bikeget;

public class Constants {
	// Generic
	//public final static String  CUSTOM_BIKELIST = "BikeList";
	public final static int     MAX_BIKES = 10000;
	public final static int     MAX_URL_TEXT = 25;
	// SOAP specific
	public static final String  NAMESPACE = "urn:bikeGet";
	public static final String  URL = "http://buscobici.com/bikesearch/bikeGet.cgi";
	public static final String  METHOD_NAME = "bikeGet";
	public static final String  SOAP_ACTION = "http://buscobici.com/bikeGet";
	// Type specific
	public static final String  TYPE_MTB    = "MTB";
	public static final String  TYPE_ROAD   = "ROAD";
	public static final String  TYPE_URBAN  = "URBAN";
	public static final String  TYPE_BMX    = "BMX";
	public static final String  TYPE_KIDS   = "KIDS";
	// Table Margins
	public static final int     SOAP_RESULTS_TABLE_MARGIN = 10;
	// Default Char set
	public static final String   DEFAULT_CHARSET = "ISO-8859-1";
	// Multi thread mode (0=monothread, 1=multithread, 2=asynctask)
	public static int MULTI_THREAD = 2;
	// Response timeout (milliseconds)
	public static final int      SOAP_RESPONSE_TIMEOUT = 30000;
	// Results text size
	public static final int      RESULTS_URL_TEXT_SIZE   = 18;
	public static final int      RESULTS_TYPE_TEXT_SIZE  = 15;
	public static final int      RESULTS_PRICE_TEXT_SIZE = 15;
	public static final int      RESULTS_STORE_TEXT_SIZE = 15;

	// Google Tracker
	public static final String    GOOGLE_TRACKER = "UA-35382693-4";
	public static final boolean  GOOGLE_ANALYTICS_DEBUG = true; 

}
