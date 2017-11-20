package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import bean.GameBean;
import bean.GameMenuBean;
import bean.UserBean;
import util.DBConnector;

public class GameDao {
	
	public List<GameBean> getAllGames() {
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		String  query 			= "SELECT TOP 1000 * FROM game_lst" ;
		
		List<GameBean>	game_list = new ArrayList<>();
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    pstmt   			= con.prepareStatement(query);
			rs 					= pstmt.executeQuery();
            
            while (rs.next()) {
            	GameBean game_data = new GameBean();
            	
            	game_data.setGame_id(rs.getInt("game_id"));
            	game_data.setGame_name(rs.getString("game_name"));
            	game_data.setGame_provider(rs.getInt("game_provider"));
            	game_data.setGame_type(rs.getInt("game_type"));
            	game_data.setLink_dsp(rs.getString("link_dsp"));
            	game_data.setGame_img(rs.getString("game_img"));
            	game_data.setDate_added(rs.getString("date_added"));
            	
            	game_list.add(game_data);
            }
            
            rs.close();
	        pstmt.close();
	        con.close();
		}
		catch(Exception e) {
			
		}
		
		return game_list;
	}
	
	public List<GameBean> getCasinoGames() {
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		String  query 			= "SELECT TOP 1000 * FROM game_lst WHERE game_type != 5 AND game_type != 6" ;
		
		List<GameBean>	game_list = new ArrayList<>();
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    pstmt   			= con.prepareStatement(query);
			rs 					= pstmt.executeQuery();
            
            while (rs.next()) {
            	GameBean game_data = new GameBean();
            	
            	game_data.setGame_id(rs.getInt("game_id"));
            	game_data.setGame_name(rs.getString("game_name"));
            	game_data.setGame_provider(rs.getInt("game_provider"));
            	game_data.setGame_type(rs.getInt("game_type"));
            	game_data.setLink_dsp(rs.getString("link_dsp"));
            	game_data.setGame_img(rs.getString("game_img"));
            	game_data.setDate_added(rs.getString("date_added"));
            	
            	game_list.add(game_data);
            }
            
            rs.close();
	        pstmt.close();
	        con.close();
		}
		catch(Exception e) {
			
		}
		
		return game_list;
	}
	
	public List<GameBean> getRacingGames() {
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		String  query 			= "SELECT TOP 1000 * FROM game_lst WHERE game_type = 5" ;
		
		List<GameBean>	game_list = new ArrayList<>();
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    pstmt   			= con.prepareStatement(query);
			rs 					= pstmt.executeQuery();
            
            while (rs.next()) {
            	GameBean game_data = new GameBean();
            	
            	game_data.setGame_id(rs.getInt("game_id"));
            	game_data.setGame_name(rs.getString("game_name"));
            	game_data.setGame_provider(rs.getInt("game_provider"));
            	game_data.setGame_type(rs.getInt("game_type"));
            	game_data.setLink_dsp(rs.getString("link_dsp"));
            	game_data.setGame_img(rs.getString("game_img"));
            	game_data.setDate_added(rs.getString("date_added"));
            	
            	game_list.add(game_data);
            }
            
            rs.close();
	        pstmt.close();
	        con.close();
		}
		catch(Exception e) {
			
		}
		
		return game_list;
	}
	
	public List<GameBean> getVirtualGames() {
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		String  query 			= "SELECT TOP 1000 * FROM game_lst WHERE game_type = 6" ;
		
		List<GameBean>	game_list = new ArrayList<>();
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    pstmt   			= con.prepareStatement(query);
			rs 					= pstmt.executeQuery();
            
            while (rs.next()) {
            	GameBean game_data = new GameBean();
            	
            	game_data.setGame_id(rs.getInt("game_id"));
            	game_data.setGame_name(rs.getString("game_name"));
            	game_data.setGame_provider(rs.getInt("game_provider"));
            	game_data.setGame_type(rs.getInt("game_type"));
            	game_data.setLink_dsp(rs.getString("link_dsp"));
            	game_data.setGame_img(rs.getString("game_img"));
            	game_data.setDate_added(rs.getString("date_added"));
            	
            	game_list.add(game_data);
            }
            
            rs.close();
	        pstmt.close();
	        con.close();
		}
		catch(Exception e) {
			
		}
		
		return game_list;
	}

	public List<GameBean> getGameProviders() {
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		
		String  query 			= "SELECT game_provider, " + 
				"CASE game_provider " + 
				"  WHEN 1 THEN '마이크로게임 카지노' " + 
				"  WHEN 2 THEN '아시안게임 카지노'  " + 
				"  WHEN 3 THEN '베컨 카지노' " +  
				"  WHEN 4 THEN '가상게임' " +  
				" END as game_provider_name " + 
				"FROM game_lst WHERE game_provider != 4 " + 
				"GROUP BY game_provider" ;
		
		List<GameBean>	provider_list = new ArrayList<>();
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    pstmt   			= con.prepareStatement(query);
			rs 					= pstmt.executeQuery();
            
            while (rs.next()) {
            	GameBean lst_data = new GameBean();
            	lst_data.setGame_provider(rs.getInt("game_provider"));
            	lst_data.setProvider_name(rs.getString("game_provider_name"));
            	provider_list.add(lst_data);
            }
            
            rs.close();
	        pstmt.close();
	        con.close();
		}
		catch(Exception e) {
			
		}
		
		return provider_list;
	}
	
	public List<GameBean> getGameType() {
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		
		String  query 			= "SELECT game_type, " + 
				"CASE game_type " + 
				"WHEN 1 THEN '라이브 룰렛' " + 
				"WHEN 2 THEN '라이브 식보' " + 
				"WHEN 3 THEN '라이브 바카라' " + 
				"WHEN 4 THEN '라이브 드래곤 타이거' " + 
				"WHEN 5 THEN '3D Horses' " + 
				"WHEN 6 THEN '3D Animals' " + 
				"WHEN 7 THEN 'Poker' " + 
				"WHEN 8 THEN 'Black Jack' " + 
				"WHEN 9 THEN 'Roullete' " + 
				"WHEN 10 THEN 'Chinga Choong' " + 
				"WHEN 11 THEN 'Ogwill' " + 
				"END as game_type_name " + 
				"FROM game_lst WHERE game_provider != 4 " +  
				"GROUP BY game_type " ;
		
		List<GameBean>	type_list = new ArrayList<>();
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    pstmt   			= con.prepareStatement(query);
			rs 					= pstmt.executeQuery();
            
            while (rs.next()) {
            	GameBean lst_data = new GameBean();
            	lst_data.setGame_type(rs.getInt("game_type"));
            	lst_data.setGame_type_name(rs.getString("game_type_name"));
            	type_list.add(lst_data);
            }
            
            rs.close();
	        pstmt.close();
	        con.close();
		}
		catch(Exception e) {
			
		}
		
		return type_list;
	}

	public GameMenuBean getGameByProvider(int game_provider){
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		String query = "SELECT game_type, CASE game_type " + 
				"WHEN 1 THEN '라이브 룰렛' " + 
				"WHEN 2 THEN '라이브 식보' " + 
				"WHEN 3 THEN '라이브 바카라' " + 
				"WHEN 4 THEN '라이브 드래곤 타이거' " + 
				"WHEN 5 THEN '3D Horses' " + 
				"WHEN 6 THEN '3D Animals' " + 
				"WHEN 7 THEN 'Poker' " + 
				"WHEN 8 THEN 'Black Jack' " + 
				"WHEN 9 THEN 'Roullete' " + 
				"WHEN 10 THEN 'Chinga Choong' " + 
				"WHEN 11 THEN 'Ogwill' " + 
				"END as game_type_name FROM game_lst WHERE game_provider = ? Group by game_type UNION " + 
				"SELECT 0 , 'ALL' AS game_type_name";
		
		
		GameMenuBean gd = new GameMenuBean();
	
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
			
			if(game_provider == 0){
				query = "SELECT game_type, CASE game_type " + 
						"WHEN 1 THEN '라이브 룰렛' " + 
						"WHEN 2 THEN '라이브 식보' " + 
						"WHEN 3 THEN '라이브 바카라' " + 
						"WHEN 4 THEN '라이브 드래곤 타이거' " + 
						"WHEN 5 THEN '3D Horses' " + 
						"WHEN 6 THEN '3D Animals' " + 
						"WHEN 7 THEN 'Poker' " + 
						"WHEN 8 THEN 'Black Jack' " + 
						"WHEN 9 THEN 'Roullete' " + 
						"WHEN 10 THEN 'Chinga Choong' " + 
						"WHEN 11 THEN 'Ogwill' " + 
						"END as game_type_name FROM game_lst WHERE game_provider != 4 GROUP BY game_type UNION " + 
						"SELECT 0 , 'ALL' AS game_type_name";
				
				pstmt   			= con.prepareStatement(query);
			}else{
				
				pstmt   			= con.prepareStatement(query);
			    pstmt.setInt(1, game_provider);
			}
		    
			rs 					= pstmt.executeQuery();
            
			List<Object> gamelist2 = new ArrayList<>();
			
            while (rs.next()) {
            	
            	gd.setGame_provider(game_provider);
            	
            	int game_type = rs.getInt("game_type");
            	String game_type_name = rs.getString("game_type_name");
            
     
            	HashMap<String,Object> hsm = new HashMap();

            	hsm.put("data",getGamesByTypeAndProvider(game_type,game_provider));

            	
        	
            	hsm.put("game_type_name",game_type_name);
            
            	
            	gamelist2.add(hsm);
            	
            	
            }
            
            gd.setGames(gamelist2);
            rs.close();
	        pstmt.close();
	        con.close();
		}
		catch(Exception e) {
			
		}
		
		return gd;
		
	}
	
	public List<GameBean> getGamesByTypeAndProvider(int game_type , int game_provider){
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		
		String  query 			= "SELECT * FROM game_lst WHERE game_type = ? AND game_provider = ? " ;
		List<GameBean>	game_list = new ArrayList<>();
		System.out.println("game_type : "+ game_type);
		System.out.println("game_provider: " + game_provider);
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
			
			if(game_type == 0 && game_provider == 0){
				query = "SELECT * FROM game_lst WHERE game_provider != 4";
				pstmt  = con.prepareStatement(query);
			}
			else if (game_type != 0 && game_provider == 0){
				query = "SELECT * FROM game_lst WHERE game_type = ? AND game_provider != 4 ";
				pstmt  = con.prepareStatement(query);
				pstmt.setInt(1, game_type);
			}
			else if (game_type == 0 && game_provider != 0){
				query = "SELECT * FROM game_lst WHERE game_provider = ? ";
				pstmt  = con.prepareStatement(query);
				pstmt.setInt(1, game_provider);
			}
			else{
				pstmt = con.prepareStatement(query);
			    pstmt.setInt(1, game_type);
			    pstmt.setInt(2, game_provider);
			}
			
			rs 					= pstmt.executeQuery();
            
            while (rs.next()) {
            	GameBean game_data = new GameBean();
            	game_data.setGame_id(rs.getInt("game_id"));
            	game_data.setGame_name(rs.getString("game_name"));
            	game_data.setGame_provider(rs.getInt("game_provider"));
            	game_data.setGame_type(rs.getInt("game_type"));
            	game_data.setLink_dsp(rs.getString("link_dsp"));
            	game_data.setGame_img(rs.getString("game_img"));
            	game_data.setDate_added(rs.getString("date_added"));
            	
            	game_list.add(game_data);
            }
            
            
            rs.close();
	        pstmt.close();
	        con.close();
		}
		catch(Exception e) {
			
		}
		
		return game_list;
		
	}

}
