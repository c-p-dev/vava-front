package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;

import bean.ScBetBean;
import bean.ScTokenLogBean;
import bean.MgLiveGamesTransBean.MgLiveGamesTransData;
import util.DBConnector;

public class ScBetLogDao {
	
	public int addNewTransactionLog(ScBetBean bet_data){
		Date date				= new Date();
		Connection con 			= null;
		PreparedStatement pstmt = null;
		int result 				= 0;
		String query 			= "INSERT INTO sc_bet_log "
				+ "(sc_bet_uid, username, amount, payout, currency, game_code, platform, status, start_time, end_time, date_added) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )";
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    
		    pstmt   			= con.prepareStatement(query);
            pstmt.setString(1, bet_data.getBetUID());
            pstmt.setString(2, bet_data.getPlayerId());
            pstmt.setDouble(3, bet_data.getBetAmount());
            pstmt.setDouble(4, bet_data.getPayoutAmount());
            pstmt.setString(5, bet_data.getCurrency());
            pstmt.setString(6, bet_data.getGameCode());
            pstmt.setString(7, bet_data.getPlatform());
            pstmt.setString(8, bet_data.getBetStatus());
            pstmt.setString(9, bet_data.getGameStartTime());
            pstmt.setString(10, bet_data.getGameEndTime());
            pstmt.setString(11, bet_data.getCreatedDateUTC());
			
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
	
	public ScBetBean getLastBetLog()
	{
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		String  query 			= "SELECT TOP 1 * FROM sc_bet_log ORDER BY bet_id DESC" ;
		
		ScBetBean bet_data		= new ScBetBean();
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    
		    pstmt   			= con.prepareStatement(query);
			
            rs 					= pstmt.executeQuery();
            
            if (rs.next()) {
            	bet_data.setBetUID(rs.getString("sc_bet_uid"));
            	bet_data.setPlayerId(rs.getString("username"));
            }
            
            rs.close();
	        pstmt.close();
	        con.close();
		}
		catch(Exception e) {
			
		}
		
		return bet_data;
	}
}
