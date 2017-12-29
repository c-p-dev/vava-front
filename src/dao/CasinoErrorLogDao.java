package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Date;

import bean.CasinoErrorLogBean;
import util.DBConnector;

public class CasinoErrorLogDao {
	
public int addNewErrorLog(CasinoErrorLogBean error_data)
{
		
		Date date				= new Date();
		Connection con 			= null;
		PreparedStatement pstmt = null;
		int result 				= 0;
		String query 			= "INSERT INTO casino_apicall_log "
				+ " (username, site_id, message, game_provider, method, date_added)"
				+ " VALUES (?, ?, ?, ?, ?, CONVERT(datetime, GETDATE(), 120))";
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    
		    pstmt   			= con.prepareStatement(query);
            pstmt.setString(1, error_data.getUsername());
            pstmt.setInt(2, error_data.getSiteId());
            pstmt.setString(3, error_data.getMessage());
            pstmt.setInt(4, error_data.getGameProvider());
            pstmt.setString(5, error_data.getMethod());
            
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
