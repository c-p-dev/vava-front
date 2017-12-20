package bc4;

import java.io.*;

	public class Debug{
	
   public static void out(String msg) {

    java.text.SimpleDateFormat ymd = new java.text.SimpleDateFormat("HH:mm:ss");
    java.text.SimpleDateFormat ymd2 = new java.text.SimpleDateFormat("yyyyMMdd");
    
    String now = ymd.format(new java.util.Date());
    String now2 = ymd2.format(new java.util.Date());
		
     try{
  	FileWriter fw = new FileWriter("C:\\Java\\apache-tomcat-7.0.55\\weblog\\"+now2+".log",true);
	
  	
	fw.write("["+now+"] "+ msg  +" \n ");
	fw.flush();
	fw.close();
      
      }catch (Exception e){
	System.out.println("IO Error from DBDebug");
       }
	}
   
	
  public static void out(String path,String msg) {
   	
    
    java.text.SimpleDateFormat ymd = new java.text.SimpleDateFormat("HH:mm:ss");
    java.text.SimpleDateFormat ymd2 = new java.text.SimpleDateFormat("yyyyMMdd");
    
    String now = ymd.format(new java.util.Date());
    String now2 = ymd2.format(new java.util.Date());
		
     try{
  	FileWriter fw = new FileWriter("/var/log/mainlog/"+path+now2+".log",true);
	
	fw.write("["+now+"] "+ msg  +" \n ");
	fw.flush();
	fw.close();
      
      }catch (Exception e){
	System.out.println("IO Error from DBDebug");
       }
	}
	
public static String fillZero(int total,String msg) {
	String r_msg = "";
	for (int i=0; i< total - String.valueOf(msg).length();i++){
 		r_msg +="0";
	}
	r_msg += msg;
 	r_msg = r_msg.trim();
 	
 	return r_msg;
 	}
}