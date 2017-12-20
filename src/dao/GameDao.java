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
		String  query 			= "SELECT TOP 1000 * FROM game_lst WHERE game_type != 5 AND game_type != 6 AND game_type != 10 AND game_type != 11" ;
		
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
	
	public List<GameBean> getAllMinigames() {
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		String  query 			= "SELECT TOP 1000 * FROM game_lst WHERE game_type = 10 OR game_type = 11" ;
		
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
	
	public List<GameBean> getLadderGames() {
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		String  query 			= "SELECT TOP 1000 * FROM game_lst WHERE game_type = 11" ;
		
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
	
	public List<GameBean> getChingaGames() {
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		String  query 			= "SELECT TOP 1000 * FROM game_lst WHERE game_type = 10 " ;
		
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
		
		String  query 			= "SELECT game_provider, lk_game_providers.description AS game_provider_name,lk_game_providers.description_en, lk_game_providers.show_order " + 
				"FROM game_lst " +
				"JOIN lk_game_providers on game_lst.game_provider = lk_game_providers.game_provider_id " +
				"WHERE game_provider != 4 "+
				"GROUP BY game_provider, lk_game_providers.description, lk_game_providers.show_order ,lk_game_providers.description_en " +
				"ORDER BY  lk_game_providers.show_order ASC";
		
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
		
		String  query 			= "SELECT game_type, lk_game_types.description AS game_type_name " + 
				"FROM game_lst " +
				"JOIN lk_game_types ON game_lst.game_type = lk_game_types.game_type_id " +
				"WHERE game_provider != 4 " +
				"GROUP BY game_lst.game_type, lk_game_types.description";
		
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
		String query = "SELECT game_type, lk_game_types.description AS game_type_name " +
				"FROM game_lst " +
				"JOIN lk_game_types ON game_lst.game_type = lk_game_types.game_type_id " +
				"WHERE game_provider = ? AND game_type != 5 AND game_type != 6 AND game_type != 10 AND game_type != 11 " +
				"GROUP BY game_type, lk_game_types.description UNION " + 
				"SELECT 0 , '�쟾泥�' AS game_type_name";
		
		
		GameMenuBean gd = new GameMenuBean();
	
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
			
			if(game_provider == 0){
				query = "SELECT game_type, lk_game_types.description AS game_type_name " +
						"FROM game_lst " +
						"JOIN lk_game_types ON game_lst.game_type = lk_game_types.game_type_id " +
						"WHERE game_type != 5 AND game_type != 6 AND game_type != 10 AND game_type != 11 " +
						"GROUP BY game_type, lk_game_types.description UNION " + 
						"SELECT 0 , '�쟾泥�' AS game_type_name";
				
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
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
			
			if(game_type == 0 && game_provider == 0){
				query = "SELECT *"
						+ " FROM game_lst"
						+ " JOIN lk_game_providers ON game_provider = game_provider_id" 
						+ " WHERE game_provider != 4"
						+ " AND game_type != 5"
						+ " AND game_type != 6"
						+ " AND game_type != 10"
						+ " AND game_type != 11"
						+ " ORDER BY show_order ASC";
				
				pstmt  = con.prepareStatement(query);
			}
			else if (game_type != 0 && game_provider == 0){
				query = "SELECT * FROM game_lst WHERE game_type = ? AND game_provider != 4 ";
				pstmt  = con.prepareStatement(query);
				pstmt.setInt(1, game_type);
			}
			else if (game_type == 0 && game_provider != 0){
				query = "SELECT * FROM game_lst WHERE game_provider = ? AND game_type != 5 AND game_type != 6 AND game_type != 10 AND game_type != 11";
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
