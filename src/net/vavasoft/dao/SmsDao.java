package net.vavasoft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.log4j.Logger;

import net.vavasoft.bean.GameBean;
import net.vavasoft.bean.UserBean;
import net.vavasoft.bean.SmsAuthBean;
import test.BetConManager_Test2;
public class SmsDao {
	
	private static final DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static Logger logger = Logger.getLogger(SmsDao.class);
	
	public boolean addSmsAuth(String userid,String tel, String authcode,String ip) throws SQLException{
		boolean result = false;
		Connection con = null;
		Statement stmt = null;
		PreparedStatement pstmt = null;
		int row = 0;
		
		try{
		
			Context initContext = new InitialContext();
		 	Context envContext = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/vava");
		    con = ds.getConnection();
		    Date date = new Date();
		
		    String  query = "INSERT INTO RT01.dbo.sms_auth (tel,authcode,siteid,regdate,state,ip,viewtype) "+
					" VALUES (?,?,1,?,'WAIT',?,'Y')";
								
		    pstmt = con.prepareStatement(query);
		    pstmt.setString(1,tel);
		    pstmt.setString(2,authcode);
		    pstmt.setString(3,sdf.format(date));
		    pstmt.setString(4,ip);
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
	
	public String checkNumberStatus(String tel) throws SQLException{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String result = null;
		
		try {
			Context initContext = new InitialContext();
		 	Context envContext = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/vava");
			
		    con = ds.getConnection();
			      		
		    String  query = "SELECT * FROM RT01.dbo.sms_auth WHERE tel = ? AND state = 'WAIT'";
		    con = ds.getConnection();			 	
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,tel.toString());
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
	
	public boolean checkAuthCode(SmsAuthBean sab) throws SQLException{
		System.out.println("checkAuthCode");
		System.out.println(sab.getTel().toString());
		System.out.println(sab.getAuthcode().toString());
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;
		
		try {
			Context initContext = new InitialContext();
		 	Context envContext = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/vava");
			
		    con = ds.getConnection();
			      		
		    String  query = "SELECT * FROM RT01.dbo.sms_auth WHERE tel = ? AND authcode= ? AND state = 'WAIT'";
		    con = ds.getConnection();			 	
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,sab.getTel().toString());
			pstmt.setString(2,sab.getAuthcode().toString());
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
		try{	      
			
		 	Context initContext = new InitialContext();
		 	Context envContext = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/vava");
						 	
			con = ds.getConnection();			 	
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,sab.getUserid());
			pstmt.setString(2,sdf.format(date));
			pstmt.setString(3,sab.getTel());
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
	
	public boolean checkActiveNumber(SmsAuthBean sab) throws SQLException{

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;
		
		try {
			Context initContext = new InitialContext();
		 	Context envContext = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/vava");
			
		    con = ds.getConnection();
			      		
		    String  query = "SELECT * FROM RT01.dbo.sms_auth WHERE tel = ? AND  state = 'USE'";
		    con = ds.getConnection();			 	
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,sab.getTel());
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
}
