package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import bean.BcTransactionLogBean;
import util.DBConnector;

public class FinancialMovementDao {
	
	private static final DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	public int addMgTransactionLog(String username, double money, String type)
	{
		Date date				= new Date();
		Connection con 			= null;
		PreparedStatement pstmt = null;
		int result 				= 0;
		String query 			= "INSERT INTO mg_fin_movements "
				+ "(username, amount, type, date_added) "
				+ "VALUES (?, ?, ?, ?)";
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    
		    pstmt   			= con.prepareStatement(query);
            pstmt.setString(1, username);
            pstmt.setLong(2, (new Double(money)).longValue());
            pstmt.setString(3, type);
            pstmt.setString(4, sdf.format(date));
			
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
	
	public int addScTransactionLog(String username, double money, String type)
	{
		Date date				= new Date();
		Connection con 			= null;
		PreparedStatement pstmt = null;
		int result 				= 0;
		String query 			= "INSERT INTO sc_fin_movements "
				+ "(username, amount, type, date_added) "
				+ "VALUES (?, ?, ?, ?)";
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    
		    pstmt   			= con.prepareStatement(query);
            pstmt.setString(1, username);
            pstmt.setLong(2, (new Double(money)).longValue());
            pstmt.setString(3, type);
            pstmt.setString(4, sdf.format(date));
			
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
