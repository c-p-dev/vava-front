package bean;

//import java.text.*;
//import java.util.*;

public class MatchSearchResultBean {      			
	
	private String MID;
	private String MDT;
	private String SID;
	private String LSTAT;
	private String HT;
	private String AT;
	private String SN;
	private String RN;
	private String CN;
	
	
  	public void setMdate(String MDT){
    	this.MDT = MDT;
  	}	  	
  	  	
  	
  	public void setMid(String MID){
    	this.MID = MID;
  	}	  	
  
  	public void setSid(String SID){
    	this.SID = SID;
  	}	 
  	
  	public void setSname(String SN){
    	this.SN = SN;
  	}	

  	public void setRname(String RN){
    	this.RN = RN;
  	}

  	public void setCname(String CN){
    	this.CN = CN;
  	}
  	
  	public void setHteam(String HT){
    	this.HT = HT;
  	}	  	
  	
  	public void setAteam(String AT){
    	this.AT = AT;
  	}	  	
  
  	public void setLstat(String LSTAT){
    	this.LSTAT = LSTAT;
  	}	  	
  	
	 
  	public String getMdate(){
    	return this.MDT;
  	}	  	
  	  	
  	public String getMid(){
  		return this.MID;
  	}	  	
  
  	public String getSid(){
  		return this.SID;
  	}	 
  	
  	public String getSname(){
  		return this.SN;
  	}	

  	public String getRname(){
  		return this.RN;
  	}

  	public String getCname(){
  		return this.CN;
  	}
  	
  	public String getHteam(){
  		return this.HT;
  	}	  	
  	
  	public String getAteam(){
  		return this.AT;
  	}	  	
  
  	public String getLstat(){
  		return this.LSTAT;
  	}	
  	
	  	
	  	
}
