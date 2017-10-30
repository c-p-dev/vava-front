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

import org.apache.log4j.Logger;

import net.vavasoft.bean.BcTransactionLogBean;
import net.vavasoft.bean.GameBean;
import net.vavasoft.util.DBConnector;
import test.BetConManager_Test2;

public class BcTransactionLogDao {
	
	private static final DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	public BcTransactionLogBean getActiveTransactionByPlayerId(int player_id)
	{
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		String  query 			= "SELECT TOP 1 * FROM bc_transaction_log WHERE player_id = ?" ;
		
		BcTransactionLogBean trans_data	= new BcTransactionLogBean();
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    
		    pstmt   			= con.prepareStatement(query);
            pstmt.setInt(1, player_id);
			
            rs 					= pstmt.executeQuery();
            
            if (rs.next()) {
            	
            	trans_data.setTransaction_id(rs.getInt("transaction_id"));
            	trans_data.setWithdraw_amount(rs.getDouble("withdraw_amount"));
            	trans_data.setDeposit_amount(rs.getDouble("deposit_amount"));
            	trans_data.setStatus(rs.getInt("status"));
            }
            
            rs.close();
	        pstmt.close();
	        con.close();
		}
		catch(Exception e) {
			
		}
		
		return trans_data;
	}
	
	public BcTransactionLogBean getActiveTransactionByRgsId(int rgs_id)
	{
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		String  query 			= "SELECT TOP 1 * FROM bc_transaction_log WHERE rgs_id = ?" ;
		
		BcTransactionLogBean trans_data	= new BcTransactionLogBean();
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    
		    pstmt   			= con.prepareStatement(query);
            pstmt.setInt(1, rgs_id);
			
            rs 					= pstmt.executeQuery();
            
            if (rs.next()) {
            	
            	trans_data.setTransaction_id(rs.getInt("transaction_id"));
            	trans_data.setPlayerId(rs.getInt("player_id"));
            	trans_data.setRgs_id(rs.getInt("rgs_id"));
            	trans_data.setRgs_related_id(rs.getInt("rgs_related_id"));
            	trans_data.setToken(rs.getString("token"));
            	trans_data.setWithdraw_amount(rs.getDouble("withdraw_amount"));
            	trans_data.setDeposit_amount(rs.getDouble("deposit_amount"));
            	trans_data.setTransaction_type(rs.getInt("transaction_type"));
            	trans_data.setCurrency(rs.getString("currency"));
            	trans_data.setTransaction_type(rs.getInt("transaction_type"));
            	trans_data.setStatus(rs.getInt("status"));
            }
            
            rs.close();
	        pstmt.close();
	        con.close();
		}
		catch(Exception e) {
			
		}
		
		return trans_data;
	}
	
	public int addNewTransactionLog(BcTransactionLogBean trans_data) {
		
		Date date				= new Date();
		Connection con 			= null;
		PreparedStatement pstmt = null;
		int result 				= 0;
		String query 			= "INSERT INTO bc_transaction_log "
				+ "(player_id, rgs_id, rgs_related_id, token, currency, withdraw_amount, deposit_amount, transaction_type, date_added, status) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    
		    pstmt   			= con.prepareStatement(query);
            pstmt.setInt(1, trans_data.getPlayerId());
            pstmt.setInt(2, trans_data.getRgs_id());
            pstmt.setInt(3, trans_data.getRgs_related_id());
            pstmt.setString(4, trans_data.getToken());
            pstmt.setString(5, trans_data.getCurrency());
            pstmt.setDouble(6, trans_data.getWithdraw_amount());
            pstmt.setDouble(7, trans_data.getDeposit_amount());
            pstmt.setInt(8, trans_data.getTransaction_type());
            pstmt.setString(9, sdf.format(date));
            pstmt.setInt(10, trans_data.getStatus());
			
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
	
	public int updateNewTransactionLog(BcTransactionLogBean trans_data) {
		
		Date date				= new Date();
		Connection con 			= null;
		PreparedStatement pstmt = null;
		int result 				= 0;
		String query 			= "UPDATE bc_transaction_log SET "
				+ "player_id = ?, rgs_id = ?, rgs_related_id = ?, token = ?, currency = ?, "
				+ "withdraw_amount = ?, deposit_amount = ?, transaction_type = ?, date_added = ?, status = ? "
				+ "WHERE transaction_id = ?";
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    
		    pstmt   			= con.prepareStatement(query);
            pstmt.setInt(1, trans_data.getPlayerId());
            pstmt.setInt(2, trans_data.getRgs_id());
            pstmt.setInt(3, trans_data.getRgs_related_id());
            pstmt.setString(4, trans_data.getToken());
            pstmt.setString(5, trans_data.getCurrency());
            pstmt.setDouble(6, trans_data.getWithdraw_amount());
            pstmt.setDouble(7, trans_data.getDeposit_amount());
            pstmt.setInt(8, trans_data.getTransaction_type());
            pstmt.setString(9, sdf.format(date));
            pstmt.setInt(10, trans_data.getStatus());
            pstmt.setInt(11, trans_data.getTransaction_id());
			
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
	
	public BcTransactionLogBean getLogByUserToken(int player_id, String token)
	{
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		String  query 			= "SELECT TOP 1 * FROM bc_transaction_log WHERE player_id = ? AND token = ?" ;
		
		BcTransactionLogBean trans_data	= new BcTransactionLogBean();
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    
		    pstmt   			= con.prepareStatement(query);
            pstmt.setInt(1, player_id);
            pstmt.setString(2, token);
			
            rs 					= pstmt.executeQuery();
            
            if (rs.next()) {
            	
            	trans_data.setTransaction_id(rs.getInt("transaction_id"));
            	trans_data.setPlayerId(rs.getInt("player_id"));
            	trans_data.setRgs_id(rs.getInt("rgs_id"));
            	trans_data.setRgs_related_id(rs.getInt("rgs_related_id"));
            	trans_data.setToken(rs.getString("token"));
            	trans_data.setWithdraw_amount(rs.getDouble("withdraw_amount"));
            	trans_data.setDeposit_amount(rs.getDouble("deposit_amount"));
            	trans_data.setTransaction_type(rs.getInt("transaction_type"));
            	trans_data.setCurrency(rs.getString("currency"));
            	trans_data.setTransaction_type(rs.getInt("transaction_type"));
            	trans_data.setStatus(rs.getInt("status"));
            }
            
            rs.close();
	        pstmt.close();
	        con.close();
		}
		catch(Exception e) {
			
		}
		
		return trans_data;
	}
}
