package bean;

//import java.text.*;
//import java.util.*;

public class SelectionBean {      			
	
	private String MKD;
	private String SN;
	private String SO;
	private String OC;

	public void setMkid(String MKD){
	this.MKD = MKD;
	}	  	

	public void setSelName(String SN){
	this.SN = SN;
	}	 
	
	public void setSelOrder(String SO){
	this.SO = SO;
	}	
	
	public void setOutcome(String OC){
		this.OC = OC;
	}	
	
	public String getMkid(){
		return this.MKD;
	}	  	

	public String getSelName(){
		return this.SN;
	}	 
	
	public String getSelOrder(){
		return this.SO;
	}	
	
	public String getOutcome(){
		return this.OC;
	}
	
	  	
}