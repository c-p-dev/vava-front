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
	
	public int addScMobileLst(String username, double money, String type, String token)
	{
		DateFormat trid_format	= new SimpleDateFormat("yyyyMMddHHmmss");
		Date date				= new Date();
		Connection con 			= null;
		PreparedStatement pstmt = null;
		int result 				= 0;
		String query 			= "INSERT INTO spincube_lst "
				+ "(siteid, userid, job, money, token, regdate, trid) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?)";
		
		String[] user_arr		= username.split("_");
		int site_id				= Integer.valueOf(user_arr[0]);
		String userid			= user_arr[1];
		String job				= "D";
		
		if ("withdraw".equals(type)) {
			job	= "W";
		}
		
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    
		    pstmt   			= con.prepareStatement(query);
            pstmt.setInt(1, site_id);
            pstmt.setString(2, userid);
            pstmt.setString(3, job);
            pstmt.setLong(4, (new Double(money)).longValue());
            pstmt.setString(5, token);
            pstmt.setString(6, sdf.format(date));
            pstmt.setString(7, userid.concat("_").concat(Integer.toString(site_id)).concat(trid_format.format(date)));
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
