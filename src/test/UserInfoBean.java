package test;

public class UserInfoBean {

  	private String name;                  
   	private String id;   
   	private String regdate;
   	private int level;
   	private int balance;
    
  	public void setName(String name){
    	this.name = name;
  	}
  	
  	public void setId(String id){
    	this.id = id;
  	}
  	
  	public void setRegdate(String regdate){
    	this.regdate = regdate;
  	}
  	
  	public void setLevel(int level){
    	this.level = level;
  	}
  	
  	public void setBalance(int balance){
  		this.balance = balance;
  	}

  	
  	public String getName(){
  		return this.name;
  	}
  	
  	public String getId(){
  		return this.id;
  	}
  	
  	public String getRegdate(){
  		return this.regdate;
  	}
  	
  	public int getLevel(){
  		return this.level;
  	}
  	
  	public int getBalance(){
  		return this.balance;
  	}
  	
  
}