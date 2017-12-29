package dao;

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
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.log4j.Logger;

import com.google.gson.Gson;

import bean.GameBean;
import bean.SmsAuthBean;
import bean.UserBean;
import infobip.api.client.SendSingleTextualSms;
import infobip.api.config.BasicAuthConfiguration;
import infobip.api.model.sms.mt.send.SMSResponse;
import infobip.api.model.sms.mt.send.SMSResponseDetails;
import infobip.api.model.sms.mt.send.textual.SMSTextualRequest;
import util.DBConnector;
import bc4.*;

public class SmsDao {
	private String BASE_URL = "https://api.infobip.com/";
    private String USERNAME = "vavasoft";
    private String PASSWORD = "qwer1234";
    private String FROM = "VaVa";
    
	private static final DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static Logger logger = Logger.getLogger(SmsDao.class);
	
	/*
	public boolean sendSms(String userid, String cell_prefix, String cell,String ip, int site_id,boolean rSend){
		
		
	   boolean result = false;
	   try {
		   	String authcode = "";
		   	String mobile_no = formatCellNumber(cell_prefix,cell);
			String numberExistsAuthcode = checkNumberStatus(mobile_no);
			HashMap hsm;
			
	    	if(numberExistsAuthcode != null){
	    		authcode = numberExistsAuthcode;	
	    	}else{
	    		authcode = generateRandomNumber();
	    	}
	
	    	
	    	hsm = sendTextInfoBIP(userid, mobile_no, authcode);
	    	int responseGroupId = (int) hsm.get("group_id");
	    	
	    	String message_id =  (String) hsm.get("message_id");
	    	int status_id = (int) hsm.get("status_id");
	    	String status_name = (String) hsm.get("status_name");
	    		    	
	    	if(responseGroupId == 1 || responseGroupId == 3){
	    			    		
	    		if(numberExistsAuthcode == null){
	    			
	    			SmsAuthBean sab = new SmsAuthBean();
		    		sab.setUserid(userid);
		    		sab.setTel(mobile_no);
		    		sab.setIp(ip);
		    		sab.setAuthcode(authcode);
		    		result = addSmsAuth(sab);

	    		}else{	    			
	    			result = true;				
	    		}
	    		
	 
	    		if(result && rSend){	    			
	    			updateResendSmsDeliveryLog(mobile_no);
	    			
	    		}else if(result && !rSend){	    			
	    			saveSmsDeliveryLog(site_id, mobile_no,message_id,status_id,status_name);	    			
	    		}
	    		
	    	}
	    		    	
		} catch (SQLException e) {
			e.printStackTrace();
		}
	   	
	   return result;
   }
	*/
	
	public boolean sendSms(String cell_prefix, String cell,String ip, String site_id,String rSend){
		
    	Debug.out("cell_prefix:" + cell_prefix);
    	Debug.out("cell:" + cell);
    	Debug.out("ip:" + ip);
    	Debug.out("site_id:" + site_id);
    	Debug.out("rSend:" + rSend);
    	
		   boolean result = false;
		
		   try {
			   	String authcode = "";
			   	String mobile_no = formatCellNumber(cell_prefix,cell);
				String numberExistsAuthcode = checkNumberStatus(site_id,mobile_no);
				//HashMap hsm;
				
		    	if(numberExistsAuthcode != null){
		    		authcode = numberExistsAuthcode;	
		    	}else{
		    		authcode = generateRandomNumber();
		    	}
				    	
		    	HashMap hsm = sendTextInfoBIP(mobile_no, authcode);
		    	int responseGroupId = (int) hsm.get("group_id");		    	
		    	String message_id =  (String) hsm.get("message_id");
		    	int status_id = (int) hsm.get("status_id");
		    	String status_name = (String) hsm.get("status_name");
		    	
		    	/*
		    	 * responseGroupId 
		    	 * 1 - pending
		    	 * 2 - sent 
		    	 * 
		    	 * reference  https://dev.infobip.com/v1/docs/response-codes
		    	 * 
		    	 * */
		    	
		    	if(responseGroupId == 1 || responseGroupId == 3){
		    			    		
		    		if(numberExistsAuthcode == null){
		    			
		    			SmsAuthBean sab = new SmsAuthBean();
			    		//sab.setUserid(userid);
			    		sab.setTel(mobile_no);
			    		sab.setIp(ip);
			    		sab.setAuthcode(authcode);
			    		result = addSmsAuth(sab);

		    		}else{	    			
		    			result = true;				
		    		}
		    		
		 
		    		if(result && rSend.equals("true")){	    			
		    			updateResendSmsDeliveryLog(mobile_no);
		    			
		    		}else if(result && !rSend.equals("true")){	    			
		    			saveSmsDeliveryLog(site_id, mobile_no,message_id,status_id,status_name);	    			
		    		}
		    		
		    	}
		    		    	
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

	public HashMap sendTextInfoBIP(String cell, String authcode){
    	int groupId = 0;
    	boolean savelog = false;
    	
    	HashMap<String,Object> hsm = new HashMap<String,Object>();
    	
    	SendSingleTextualSms client = new SendSingleTextualSms(new BasicAuthConfiguration(BASE_URL,USERNAME, PASSWORD));
        String MESSAGE_TEXT = "귀하의 인증 번호는  : " + authcode + " 입니다.";
        	
		SMSTextualRequest requestBody = new SMSTextualRequest();
		requestBody.setFrom(FROM);
		requestBody.setTo(Arrays.asList("+"+cell));
		requestBody.setText(MESSAGE_TEXT);
		
		SMSResponse response = client.execute(requestBody);
		SMSResponseDetails sentMessageInfo = response.getMessages().get(0);
    	
		String message_id = sentMessageInfo.getMessageId();
		int status_id = sentMessageInfo.getStatus().getId();
		String status_name = sentMessageInfo.getStatus().getName();
		groupId = sentMessageInfo.getStatus().getGroupId();

//      Sample Response
//		String message_id = "2093640665371631338";
//		int status_id = 7;
//		String status_name = "PENDING_ENROUTE";
//        groupId = 1;
    	
    	hsm.put("message_id",message_id);
    	hsm.put("status_id",status_id);
    	hsm.put("status_name",status_name);
    	hsm.put("group_id",groupId);
    
    	return hsm;
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
	
	public String checkNumberStatus(String SITEID,String cell) throws SQLException{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String result = null;
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
			      		
		    String  query = "SELECT * FROM sms_auth WHERE tel = ? AND siteid = "+SITEID+" AND state = 'WAIT'";
		    	 	
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,cell);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				result = rs.getString("authcode");
			}
			
		} catch(Exception e){
			//logger.debug(e);
			
		}finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
	  		if(con!=null) con.close();
		}
		
		return result;
	}
		
	public boolean checkAuthCode(String SITEID, String cell_prefix, String cell, String authcode, boolean rSend) throws SQLException{
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;
		boolean saveLog = false;
		
		
		try {
			
			String mobile_no = formatCellNumber(cell_prefix,cell);
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
			      		
		    String  query = "SELECT * FROM sms_auth WHERE siteid="+SITEID+" and tel = ? AND authcode= ? AND state = 'WAIT'";
		    
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,mobile_no);
			pstmt.setString(2,authcode);
			rs = pstmt.executeQuery();

			if(rs.next()){
				result = true;
			}
			
			if(result){
				updateValidSmsDeliveryLog(SITEID,mobile_no,"Y");
			}else{
				saveSmsAuthLog(mobile_no,authcode,SITEID);
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
	
	public boolean updateUserAuthSms(UserBean sab) throws SQLException{
		boolean result = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		//ResultSet rs = null;
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
			//logger.debug(e);
	       	e.printStackTrace();
		}finally{
			//if(rs!=null) rs.close();
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
			if(rs.next()){
				result = true;
			}
			
			
		} catch(Exception e){
			//logger.debug(e);
			
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
		}else{
			mobile_no = cell_prefix + cell;
		}
		 
		return mobile_no;
	}
	
	public String getUserAuthCodeByTel(String cell) throws SQLException{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String result = null;
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
			      		
		    String  query = "SELECT * FROM RT01.dbo.sms_auth WHERE tel = ? AND state = 'USE'";
		    	 	
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,cell);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				result = rs.getString("authcode");
			}
			
		} catch(Exception e){
			//logger.debug(e);
			
		}finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
	  		if(con!=null) con.close();
		}
		
		return result;
	}
	
	public boolean sendSmsByNickname(String nick, String cell_prefix, String cell, String site_id,boolean rSend){
		boolean result = false;
	
		try {
		   	
		   	String mobile_no = formatCellNumber(cell_prefix,cell);
			String authcode = getUserAuthCodeByTel(mobile_no);
			//HashMap hsm;
	    	if(authcode != null || !authcode.equals(null)){
	    		
	    		//hsm = sendTextInfoBIP(nick, mobile_no, authcode);
	    		HashMap hsm = sendTextInfoBIP(mobile_no, authcode);
		    	int responseGroupId = (int) hsm.get("group_id");		    	
		    	String message_id =  (String) hsm.get("message_id");
		    	int status_id = (int) hsm.get("status_id");
		    	String status_name = (String) hsm.get("status_name");		    	
		    	
		    	/*
		    	 * responseGroupId 
		    	 * 1 - pending
		    	 * 2 - sent 
		    	 * 
		    	 * reference  https://dev.infobip.com/v1/docs/response-codes
		    	 * 
		    	 * */
		    	if((responseGroupId == 1 || responseGroupId == 3)){
		    		result = true;		    	
		    	}		    	
		    	
		    	if(result && rSend){
		    		updateResendSmsDeliveryLog(mobile_no);
		    	}else if(result && !rSend){
		    		saveSmsDeliveryLog(site_id, mobile_no,message_id,status_id,status_name);
		    	}
	    	}
	    	
	  
		} catch (SQLException e) {
			e.printStackTrace();
			return result;
		}
 
		return result;
		
	}
	
	public String checkAuthCodeByNickname(String nick,String cell_prefix, String cell,String authcode) throws SQLException{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String result = null;
		String mobile_no = formatCellNumber(cell_prefix,cell); 
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
			      		
		    String query = "SELECT u.userid from sms_auth  s   " +
		    		"LEFT JOIN user_mst  u ON  s.userid = u.userid  " + 
		    		"WHERE u.nick = ? " + 
		    		"AND s.tel = ? " + 
		    		"AND s.authcode = ?";
		    
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,nick);
			pstmt.setString(2,mobile_no);
			pstmt.setString(3,authcode);
			rs = pstmt.executeQuery();
			if(rs.next()){
				result = rs.getString("userid");
			}
			
			return result;
			
		} catch(Exception e){
			logger.debug(e);
			return null;	
		}
	}
	
	public boolean checkAuthCodeByUseridNick(String userid, String nick,String cell_prefix, String cell,String authcode) throws SQLException{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;

		String mobile_no = formatCellNumber(cell_prefix,cell);
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    
		    String query = "SELECT u.userid,u.passwd FROM sms_auth s " + 
		    		"LEFT JOIN user_mst u ON s.userid = u.userid " + 
		    		"WHERE u.nick = ? " + 
		    		"AND u.userid =  ? " + 
		    		"AND s.tel = ? " + 
		    		"AND s.authcode = ?";
		    
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,nick);
			pstmt.setString(2,userid);
			pstmt.setString(3,mobile_no);
			pstmt.setString(4,authcode);
			rs = pstmt.executeQuery();
			if(rs.next()){
				result = true;
			}
			
			return result;
			
		} catch(Exception e){
			logger.debug(e);
			return false;	
		}
	}
	
	public boolean saveSmsDeliveryLog(String site_id,String mobile_no,String message_id,int status_id,String status_name) throws SQLException {

		boolean result = false;
		Connection con = null;
		Statement stmt = null;
		PreparedStatement pstmt = null;
		int row = 0;
		
		try{
			
			DBConnector.getInstance();
			con = DBConnector.getConnection();
		    Date date = new Date();
		   
	    	String  query = "INSERT INTO RT01.dbo.sms_delivery_log (site_id,tel,state,message_id,status_id,status_name,regdate,valid) "+
					" VALUES (?,?,?,?,?,?,?,?)";
	    	
	    	pstmt = con.prepareStatement(query);
		    pstmt.setInt(1,Integer.parseInt(site_id));
		    pstmt.setString(2,mobile_no);
		    pstmt.setString(3,"FIRST");
		    pstmt.setString(4,message_id);
		    pstmt.setInt(5,status_id);
		    pstmt.setString(6,status_name);
		    pstmt.setString(7,sdf.format(date));
		    pstmt.setString(8,"N");
		    
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

	public boolean updateResendSmsDeliveryLog(String mobile_no){
		
		boolean result = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		int row = 0;
		
		try{
			
			DBConnector.getInstance();
			con = DBConnector.getConnection();
		    Date date = new Date();
		   
		    String query = "UPDATE RT01.dbo.sms_delivery_log SET state = 'RESEND' WHERE sms_delivery_log_id = (SELECT MAX(sms_delivery_log_id) FROM RT01.dbo.sms_delivery_log WHERE tel = ?)";
		    
	    	pstmt = con.prepareStatement(query);
		    pstmt.setString(1,mobile_no);		    
			row = pstmt.executeUpdate(); 

			pstmt.close();
			con.close();
		
			if(row > 0) result = true;
		
		    	
		}catch(Exception e){
			e.printStackTrace();
			logger.debug(e);
		
		}
			
		return result;
	}
	
	public boolean updateValidSmsDeliveryLog(String SITEID, String mobile_no, String valid) throws SQLException{
		
		boolean result = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		int row = 0;
		
		try{
			
			DBConnector.getInstance();
			con = DBConnector.getConnection();
		    Date date = new Date();
		   
		    String query = "UPDATE sms_delivery_log SET valid = ? WHERE sms_delivery_log_id = (SELECT MAX(sms_delivery_log_id) FROM sms_delivery_log WHERE siteid="+SITEID+" and tel = ?)";
		    
	    	pstmt = con.prepareStatement(query);
	    	pstmt.setString(1,valid);
	    	pstmt.setString(2,mobile_no);		    
			row = pstmt.executeUpdate(); 

			pstmt.close();
			con.close();
		
			if(row > 0) result = true;
		
		    	
		}catch(Exception e){
			e.printStackTrace();
			//logger.debug(e);
		
		}finally{
			if(pstmt!=null) pstmt.close();
			if(con!=null) con.close();
		}
			
		return result;
	}
	
	public boolean saveSmsAuthLog(String mobile_no,String authcode,String site_id) throws SQLException{
		boolean result = false;
		Connection con = null;
		Statement stmt = null;
		PreparedStatement pstmt = null;
		int row = 0;
		String state = "INCORRECT CODE";
		try{
			
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    //Date date = new Date();
		    
		    String  query = "INSERT INTO sms_auth_log (site_id,tel,authcode,state,regdate) "+
					" VALUES ("+site_id+",?,?,?,GETDATE())";
								
		    pstmt = con.prepareStatement(query);
		    pstmt.setString(1,mobile_no);
		    pstmt.setString(2,authcode);
		    pstmt.setString(3,state);
		    //pstmt.setString(5,sdf.format(date));
			row = pstmt.executeUpdate(); 
			pstmt.close();
			con.close();
		
			if(row > 0) result = true;
		
		    	
		}catch(Exception e){
			e.printStackTrace();
			//logger.debug(e);
		
		}finally{
			if(stmt!=null) stmt.close();
			if(con!=null) con.close();
		}
			
		return result;
	}
	
}
