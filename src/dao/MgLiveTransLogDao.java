package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Date;

import bean.ScTokenLogBean;
import bean.MgLiveGamesTransBean.MgLiveGamesTransData;
import util.DBConnector;

public class MgLiveTransLogDao {
	
	public int addNewTransactionLog(MgLiveGamesTransData trans_data) {
		
		Date date				= new Date();
		Connection con 			= null;
		PreparedStatement pstmt = null;
		int result 				= 0;
		String query 			= "INSERT INTO mg_livetrans_log "
				+ "(username, table_code, round_id, currency, bet_amount, payout, status, bet_type, date_added) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ? )";
		
		
		try {
			DBConnector.getInstance();
			
			con 				= DBConnector.getConnection();
		    
		    pstmt   			= con.prepareStatement(query);
            pstmt.setString(1, trans_data.getAccountName());
            pstmt.setString(2, trans_data.getTableCode());
            pstmt.setString(3, trans_data.getRoundId());
            pstmt.setString(4, trans_data.getCurrency());
            pstmt.setDouble(5, trans_data.getBet());
            pstmt.setDouble(6, trans_data.getPayout());
            pstmt.setString(7, trans_data.getTransactionStatus());
            pstmt.setString(8, trans_data.getBetType());
            pstmt.setString(9, trans_data.getDate());
			
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
