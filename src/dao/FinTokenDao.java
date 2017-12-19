package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import bean.FinTokenBean;
import util.DBConnector;

public class FinTokenDao {
	
	private static final DateFormat dfrmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	public int addNewFinToken(FinTokenBean token_data) 
	{
		
		Date date				= new Date();
		Connection con 			= null;
		PreparedStatement pstmt = null;
		int result 				= 0;
		String query 			= "INSERT INTO fin_token_lst"
				+ " (username, site_id, fin_token, status, date_added)"
				+ " VALUES (?, ?, ?, ?, ?)";
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
			
		    pstmt   			= con.prepareStatement(query);
            pstmt.setString(1, token_data.getUsername());
            pstmt.setInt(2, token_data.getSiteId());
            pstmt.setString(3, token_data.getFinToken());
            pstmt.setInt(4, token_data.getStatus());
            pstmt.setString(5, dfrmt.format(date));
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
	
	public int updateFinTokenSts(String fin_token, int sts) 
	{
		
		Connection con 			= null;
		PreparedStatement pstmt = null;
		int result 				= 0;
		String query 			= "UPDATE fin_token_lst SET"
				+ " status = ? "
				+ " WHERE fin_token = ?";
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    
		    pstmt   			= con.prepareStatement(query);
            pstmt.setInt(1, sts);
            pstmt.setString(2, fin_token);
			
            result	= pstmt.executeUpdate();
            
	        pstmt.close();
	        con.close();
		}
		catch (Exception e) {
			e.printStackTrace();
	  		return 0;
		}
		
		return result;
	}
	
	public FinTokenBean getLatestFinToken(String username, int site_id)
	{
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		String  query 			= "SELECT TOP 1 * FROM fin_token_lst"
				+ " WHERE username = ?"
				+ " AND site_id	= ?"
				+ " AND status = 0"
				+ " ORDER BY date_added DESC" ;
		
		FinTokenBean token_data	= new FinTokenBean();
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    
		    pstmt   			= con.prepareStatement(query);
		    pstmt.setString(1, username);
		    pstmt.setInt(2, site_id);
		    
            rs 					= pstmt.executeQuery();
            
            if (rs.next()) {
            	token_data.setUsername(rs.getString("username"));
            	token_data.setSiteId(rs.getInt("site_id"));
            	token_data.setFinToken(rs.getString("fin_token"));
            	token_data.setStatus(rs.getInt("status"));
            	token_data.setDateAdded(rs.getString("date_added"));
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
