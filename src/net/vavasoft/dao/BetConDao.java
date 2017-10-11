package net.vavasoft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import net.vavasoft.bean.BcTransactionLogBean;
import net.vavasoft.bean.BetConUserBean;
import net.vavasoft.bean.GameBean;
import net.vavasoft.bean.UserBean;
import net.vavasoft.betconstruct.GetBalanceOutput;

public class BetConDao {
	
	private static final DateFormat dfrmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	public UserBean getUserByPlayerId(int player_id)
	{
		UserBean user_data		= new UserBean();
		
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		String  query 			= "SELECT TOP 1 * FROM betcon_user_lst JOIN user_mst ON betcon_user_lst.username = user_mst.userid WHERE player_id = ?" ;
		
		try {
			Context initContext = new InitialContext();
		 	Context envContext 	= (Context)initContext.lookup("java:/comp/env");
			DataSource ds 		= (DataSource)envContext.lookup("jdbc/vava");
			
		    con 				= ds.getConnection();
		    
		    pstmt   			= con.prepareStatement(query);
            pstmt.setInt(1, player_id);
			
			rs 					= pstmt.executeQuery();
            
            if (rs.next()) {
            	user_data.setUserid(rs.getString("userid"));
            	user_data.setMoney(rs.getInt("money"));
            	user_data.setNick(rs.getString("nick"));
            	user_data.setIp(rs.getString("ip"));
            }
            
            rs.close();
	        pstmt.close();
	        con.close();
		}
		catch(Exception e) {
			
		}
		
		return user_data;
	}
	
	public BetConUserBean getUserBySessionToken(String token)
	{
		BetConUserBean user_data	= new BetConUserBean();
		
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		String  query 			= "SELECT TOP 1 * FROM betcon_user_lst  WHERE session_token = ?" ;
		
		try {
			Context initContext = new InitialContext();
		 	Context envContext 	= (Context)initContext.lookup("java:/comp/env");
			DataSource ds 		= (DataSource)envContext.lookup("jdbc/vava");
			
		    con 				= ds.getConnection();
		    
		    pstmt   			= con.prepareStatement(query);
            pstmt.setString(1, token);
			
			rs 					= pstmt.executeQuery();
            
            if (rs.next()) {
            	user_data.setPlayerId(rs.getInt("player_id"));
            	user_data.setSession_token(rs.getString("session_token"));
            	user_data.setUsername(rs.getString("username"));
            }
            
            rs.close();
	        pstmt.close();
	        con.close();
		}
		catch(Exception e) {
			
		}
		
		return user_data;
	}
	
	public BetConUserBean getUserByUsername(String username)
	{
		BetConUserBean user_data	= new BetConUserBean();
		
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		String  query 			= "SELECT TOP 1 * FROM betcon_user_lst WHERE username = ?" ;
		
		try {
			Context initContext = new InitialContext();
		 	Context envContext 	= (Context)initContext.lookup("java:/comp/env");
			DataSource ds 		= (DataSource)envContext.lookup("jdbc/vava");
			
		    con 				= ds.getConnection();
		    
		    pstmt   			= con.prepareStatement(query);
            pstmt.setString(1, username);
			
			rs 					= pstmt.executeQuery();
            
            if (rs.next()) {
            	user_data.setPlayerId(rs.getInt("player_id"));
            	user_data.setSession_token(rs.getString("session_token"));
            	user_data.setUsername(rs.getString("username"));
            }
            
            rs.close();
	        pstmt.close();
	        con.close();
		}
		catch(Exception e) {
			
		}
		
		return user_data;
	}
	
	public int updateBcSessionByUsername(String username, String token) 
	{
		
		Connection con 			= null;
		PreparedStatement pstmt = null;
		int result 				= 0;
		String query 			= "UPDATE betcon_user_lst SET "
				+ "session_token = ? "
				+ "WHERE username = ?";
		
		try {
			Context initContext = new InitialContext();
		 	Context envContext 	= (Context)initContext.lookup("java:/comp/env");
			DataSource ds 		= (DataSource)envContext.lookup("jdbc/vava");
			
		    con 				= ds.getConnection();
		    
		    pstmt   			= con.prepareStatement(query);
            pstmt.setString(1, token);
            pstmt.setString(2, username);
			
            result	= pstmt.executeUpdate();
            
	        pstmt.close();
	        con.close();
		}
		catch(Exception e) {
			e.printStackTrace();
	  		return 0;
		}
		
		return result;
	}
	
	public int addNewBcUser(BetConUserBean user_data) {
		
		Date date				= new Date();
		Connection con 			= null;
		PreparedStatement pstmt = null;
		int result 				= 0;
		String query 			= "INSERT INTO betcon_user_lst "
				+ "(username, session_token, date_added) "
				+ "VALUES (?, ?, ?)";
		
		try {
			Context initContext = new InitialContext();
		 	Context envContext 	= (Context)initContext.lookup("java:/comp/env");
			DataSource ds 		= (DataSource)envContext.lookup("jdbc/vava");
			
		    con 				= ds.getConnection();
		    
		    pstmt   			= con.prepareStatement(query);
            pstmt.setString(1, user_data.getUsername());
            pstmt.setString(2, user_data.getSession_token());
            pstmt.setString(3, dfrmt.format(date));
            result	= pstmt.executeUpdate();
            
	        pstmt.close();
	        con.close();
		}
		catch(Exception e) {
			e.printStackTrace();
	  		return 0;
		}
		
		return result;
	}
}
