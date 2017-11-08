package net.vavasoft.bean;

//import java.text.*;
//import java.util.*;

public class DepositListBean {      			
	
	private String CD;
	private String UD;
	private String CT;
	private String MN;
	
  	public void setChid(String CD){
    	this.CD = CD;
  	}	  	  	
  	
  	public void setUid(String UD){
    	this.UD = UD;
  	}	  	
  
  	public void setChdt(String CT){
    	this.CT = CT;
  	}	 
  	
  	public void setMoney(String MN){
    	this.MN = MN;
  	}	
  	
	 
  	public String getChid(){
    	return this.CD;
  	}	  	  	
  	
  	public String getUid(){
  		return this.UD;
  	}	  	
  
  	public String getChdt(){
  		return this.CT;
  	}	 
  	
  	public String getMoney(){
  		return this.MN;
  	}	
  	
}