package net.vavasoft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.log4j.Logger;

import infobip.api.client.SendSingleTextualSms;
import infobip.api.config.BasicAuthConfiguration;
import infobip.api.model.sms.mt.send.SMSResponse;
import infobip.api.model.sms.mt.send.SMSResponseDetails;
import infobip.api.model.sms.mt.send.textual.SMSTextualRequest;
import net.vavasoft.bean.GameBean;
import net.vavasoft.bean.UserBean;
import net.vavasoft.util.DBConnector;
import net.vavasoft.bean.SmsAuthBean;

import test.BetConManager_Test2;
public class SmsDao {
	private String BASE_URL = "https://api.infobip.com/";
    private String USERNAME = "vavasoft";
    private String PASSWORD = "qwer1234";
    private String FROM = "VaVa";
    
	private static final DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static Logger logger = Logger.getLogger(SmsDao.class);
	
	public boolean sendSms(String userid, String cell_prefix, String cell,String ip){

	   boolean result = false;
	   try {
		   	String authcode = "";
		   	String mobile_no = formatCellNumber(cell_prefix,cell);
			String numberExistsAuthcode = checkNumberStatus(mobile_no);
	    	if(numberExistsAuthcode != null){
	    		authcode = numberExistsAuthcode;	
	    	}else{
	    		authcode = generateRandomNumber();
	    	}
	
	    	int responseGroupId = sendTextInfoBIP(userid, mobile_no, authcode);
	    	
	    	/*
	    	 * responseGroupId 
	    	 * 1 - pending
	    	 * 2 - sent 
	    	 * 
	    	 * reference  https://dev.infobip.com/v1/docs/response-codes
	    	 * 
	    	 * */
	    	
	    	if((responseGroupId == 1 || responseGroupId == 3) && numberExistsAuthcode == null){
	    		SmsAuthBean sab = new SmsAuthBean();
	    		sab.setUserid(userid);
	    		sab.setTel(mobile_no);
	    		sab.setIp(ip);
	    		sab.setAuthcode(authcode);
	    		addSmsAuth(sab);
	    		
	    	}
	    	
	    	result = true;
	  
	    	
		} catch (SQLException e) {
			e.printStackTrace();
		}
 
	   return result;
   }
	
	public String generateRandomNumber(){
    	String code ="";
    	for(int i = 0; i <=5; i++){
    		int randomNum = ThreadLocalRandom.current().nextInt(0, 9 + 1);
    		code = code + Integer.toString(randomNum);
    	}
    	return code;
    }

	public int sendTextInfoBIP(String userid,String cell, String authcode){
    	int groupId = 0;
 
    	SendSingleTextualSms client = new SendSingleTextualSms(new BasicAuthConfiguration(BASE_URL,USERNAME, PASSWORD));
        String MESSAGE_TEXT = " 회원가입을 하시면 보다 폭넓은 서비스 이용이 가능합니다. Your Certification Number is : " + authcode;
        	
		SMSTextualRequest requestBody = new SMSTextualRequest();
		requestBody.setFrom(FROM);
		requestBody.setTo(Arrays.asList("+"+cell));
		requestBody.setText(MESSAGE_TEXT);
		
		SMSResponse response = client.execute(requestBody);
		SMSResponseDetails sentMessageInfo = response.getMessages().get(0);
		System.out.println(response);
		System.out.println(sentMessageInfo);
		
		groupId = sentMessageInfo.getStatus().getGroupId();
         
    	return groupId;
    }
	
	public boolean addSmsAuth(SmsAuthBean smsBean) throws SQLException{
		boolean result = false;
		Connection con = null;
		Statement stmt = null;
		PreparedStatement pstmt = null;
		int row = 0;
		
		try{
		
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    Date date = new Date();
		
		    String  query = "INSERT INTO RT01.dbo.sms_auth (tel,authcode,siteid,regdate,state,ip,viewtype) "+
					" VALUES (?,?,1,?,'WAIT',?,'Y')";
								
		    pstmt = con.prepareStatement(query);
		    pstmt.setString(1,smsBean.getTel());
		    pstmt.setString(2,smsBean.getAuthcode());
		    pstmt.setString(3,sdf.format(date));
		    pstmt.setString(4,smsBean.getIp());
			row = pstmt.executeUpdate(); 
			pstmt.close();
			con.close();
		
			if(row > 0) result = true;
		
		    	
		}catch(Exception e){
			e.printStackTrace();
			logger.debug(e);
		
		}finally{
			if(stmt!=null) stmt.close();
			if(con!=null) con.close();
		}
			
		return result;
	}
	
	public String checkNumberStatus(String cell) throws SQLException{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String result = null;
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
			      		
		    String  query = "SELECT * FROM RT01.dbo.sms_auth WHERE tel = ? AND state = 'WAIT'";
		    	 	
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,cell);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				result = rs.getString("authcode");
			}
			
		} catch(Exception e){
			logger.debug(e);
			
		}finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
	  		if(con!=null) con.close();
		}
		
		return result;
	}
	
	public boolean checkAuthCode(String cell_prefix, String cell, String authcode) throws SQLException{
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;
		String mobile_no = formatCellNumber(cell_prefix,cell);
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
			      		
		    String  query = "SELECT * FROM RT01.dbo.sms_auth WHERE tel = ? AND authcode= ? AND state = 'WAIT'";
		    
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,mobile_no);
			pstmt.setString(2,authcode);
			rs = pstmt.executeQuery();
			System.out.println(pstmt);
			if(rs.next()){
				result = true;
			}
			
			
		} catch(Exception e){
			logger.debug(e);
			
		}finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
	  		if(con!=null) con.close();
		}
		
		return result;
	}
	
	public boolean updateUserAuthSms(SmsAuthBean sab) throws SQLException{
		boolean result = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int sts = 0;
		String query = "UPDATE sms_auth SET userid = ?, usedate = ? , state = 'USE'  WHERE tel = ? AND authcode = ? AND state = 'WAIT'";
		Date date = new Date();
		String mobile_no = formatCellNumber(sab.getCell_prefix(),sab.getCell());
		try{	      
			
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();		 	
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,sab.getUserid());
			pstmt.setString(2,sdf.format(date));
			pstmt.setString(3,mobile_no);
			pstmt.setString(4,sab.getAuthcode());

			sts = pstmt.executeUpdate();					   
			if(sts > 0 ) result = true;
			
	        pstmt.close();
	        con.close();
	        
		} catch(Exception e){
			logger.debug(e);
	       	e.printStackTrace();
		}finally{
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(con!=null) con.close();
		}
  	
		
		return result;
		
	}
	
	public boolean checkActiveNumber(String cell_prefix,String cell) throws SQLException{

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;
		String mobile_no = formatCellNumber(cell_prefix,cell);
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
			      		
		    String  query = "SELECT * FROM RT01.dbo.sms_auth WHERE tel = ? AND  state = 'USE'";
		    	 	
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,mobile_no);
			rs = pstmt.executeQuery();
			System.out.println(pstmt);
			if(rs.next()){
				result = true;
			}
			
			
		} catch(Exception e){
			logger.debug(e);
			
		}finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
	  		if(con!=null) con.close();
		}
		
		return result;
	}

	public String formatCellNumber(String cell_prefix, String cell){
		String mobile_no = "";
		if(cell_prefix.equals("+63")){ 
			if(cell.substring(1).length() == 10 && cell.substring(0,1).equals("0")){
				cell = cell.substring(1);
			}
			
			mobile_no = cell_prefix.substring(1) + cell;
		}
		 
		System.out.println(mobile_no);
		return mobile_no;
	}
}
