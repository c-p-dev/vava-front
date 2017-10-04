package net.vavasoft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import net.vavasoft.bean.GameBean;
import net.vavasoft.bean.UserBean;

public class GameDao {
	
	public List<GameBean> getAllGames() {
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		String  query 			= "SELECT TOP 1000 * FROM game_lst" ;
		
		List<GameBean>	game_list = new ArrayList<>();
		
		try {
			Context initContext = new InitialContext();
		 	Context envContext 	= (Context)initContext.lookup("java:/comp/env");
			DataSource ds 		= (DataSource)envContext.lookup("jdbc/vava");
			
		    con 				= ds.getConnection();
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
}
