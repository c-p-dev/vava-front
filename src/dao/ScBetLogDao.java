package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import bean.ScBetBean;
import bean.ScTokenLogBean;
import bean.MgLiveGamesTransBean.MgLiveGamesTransData;
import util.DBConnector;

public class ScBetLogDao {
	
	public int addNewTransactionLog(ScBetBean bet_data)
	{
		Date date_now					= new Date();
		SimpleDateFormat date_format	= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Connection con 					= null;
		PreparedStatement pstmt 		= null;
		int result 						= 0;
		String query 					= "INSERT INTO spincube_log "
				+ "(betuid, playerid, betamount, payoutamount, currency, gamecode, platform, betstatus, gamestarttimeutc, gameendtimeutc, createddateutc, betdate, siteid, userid, productid) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )";
		
		String[] uname_split	= bet_data.getPlayerId().split("_");
		Integer site_id			= Integer.valueOf(uname_split[0]);
		String userid			= uname_split[1];
		
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
            pstmt.setString(12, date_format.format(date_now));
            pstmt.setInt(13, site_id);
            pstmt.setString(14, uname_split[1]);
            pstmt.setString(15, bet_data.getProductId());
			
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
		String  query 			= "SELECT TOP 1 * FROM spincube_log ORDER BY betdate DESC" ;
		
		ScBetBean bet_data		= new ScBetBean();
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    pstmt   			= con.prepareStatement(query);
            rs 					= pstmt.executeQuery();
            
            if (rs.next()) {
            	bet_data.setBetUID(rs.getString("betuid"));
            	bet_data.setPlayerId(rs.getString("playerid"));
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
