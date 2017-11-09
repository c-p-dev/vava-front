package admin;

public class AdminInfoBean {

  	private String aname;                  
   	private String aid;   
   	private int result;   
    
  	public void setAname(String aname){
    	this.aname = aname;
  	}

  	public void setAid(String aid){
    	this.aid= aid;
  	}
 
   	public void setResult(int result){
    	this.result= result;
  	}
  	
  	public String getAname(){
    	return this.aname;
  	}

  	public String getAid(){
    	return this.aid;
  	}
 
   	public int getResult(){
    	return this.result;
  	}
  	
  
}