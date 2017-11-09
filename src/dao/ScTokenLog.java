package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;

import bean.BcTransactionLogBean;
import bean.ScTokenLogBean;
import net.vavasoft.util.DBConnector;

public class ScTokenLog {
	
	public int addNewTransactionLog(ScTokenLogBean token_data) {
		
		Date date				= new Date();
		Connection con 			= null;
		PreparedStatement pstmt = null;
		int result 				= 0;
		String query 			= "INSERT INTO sc_token_log "
				+ "(token, expire_date) "
				+ "VALUES (?, ?)";
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    
		    pstmt   			= con.prepareStatement(query);
            pstmt.setString(1, token_data.getToken());
            pstmt.setString(2, token_data.getExpireDate());
			
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
	
	public ScTokenLogBean getLatestToken()
	{
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		String  query 			= "SELECT TOP 1 * FROM sc_token_log ORDER BY sc_token_id DESC" ;
		
		ScTokenLogBean token_data	= new ScTokenLogBean();
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    
		    pstmt   			= con.prepareStatement(query);
			
            rs 					= pstmt.executeQuery();
            
            if (rs.next()) {
            	token_data.setToken(rs.getString("token"));
            	token_data.setExpireDate(rs.getString("expire_date"));
            }
            
            rs.close();
	        pstmt.close();
	        con.close();
		}
		catch(Exception e) {
			
		}
		
		return token_data;
	}
}
