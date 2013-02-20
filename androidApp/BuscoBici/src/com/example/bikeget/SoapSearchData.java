package com.example.bikeget;

import java.util.List;

public class SoapSearchData {
		private BikeList bList = null;
		private String search = null;
		private int priceFrom = 0;
		private int priceTo = 0;
		private String type = null;
		private List<Bike> soapList = null;
				
		public SoapSearchData(BikeList bList, String search, 
				int priceFrom, int priceTo, String type) {
			this.bList = bList;
			this.search = search;
			this.priceFrom = priceFrom;
			this.priceTo = priceTo;
			this.type = type;
		}

		public void SetSoapBikeList(List<Bike> blist)
		{
			soapList = blist;
		}
		public void SetBikeList(List<Bike> blist)
		{
			bList.bikeList = blist;
		}
		public List<Bike> GetSoapBikeList()
		{
			return soapList;
		}
		public BikeList GetBikeList()
		{
			return bList;
		}
		public String GetSearch()
		{
			return search;
		}
		public int GetPriceFrom()
		{
			return priceFrom; 
		}
		public int GetPriceTo()
		{
			return priceTo; 
		}
		public String GetType()
		{
			return type;
		}	
}
