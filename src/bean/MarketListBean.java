package bean;

//import java.text.*;
//import java.util.*;

public class MarketListBean {      			
	
	private String MTD;
	private String MKD;
	private String MD;
	private String MN;

	
  	public void setMarketType(String MTD){
    	this.MTD = MTD;
  	}	  	
  	
  	public void setMkid(String MKD){
    	this.MKD = MKD;
  	}	  	
  
  	public void setMid(String MD){
    	this.MD = MD;
  	}	 
  	
  	public void setMkname(String MN){
    	this.MN = MN;
  	}	
  	
  	public String getMarketType(){
    	return this.MTD;
  	}	  	
  	
  	public String getMkid(){
  		return this.MKD;
  	}	  	
  
  	public String getMid(){
  		return this.MD;
  	}	 
  	
  	public String getMkname(){
  		return this.MN;
  	}	
  	
  	
  	
	  	
	  	
}