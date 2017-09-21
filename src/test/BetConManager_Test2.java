package test;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;

import javax.sql.*;
import javax.naming.*;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import net.arnx.jsonic.JSON;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class BetConManager_Test2 {
	
	
	private static final DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static Logger logger = Logger.getLogger(BetConManager_Test2.class);
	public BetConManager_Test2(){}

public String getFromDB(String id) throws SQLException{
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		  
		String s = "";
		  
		String query = "SELECT money from RT01.dbo.user_mst where userid='matthew'" ;
		  
		try{	      
			
		 	Context initContext = new InitialContext();
		 	Context envContext = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/vava");
						 	
			con = ds.getConnection();			 	
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
					        
			if(rs.next()){		        	
				s = rs.getString("money");
			}

	        rs.close();
	        pstmt.close();
	        con.close();
	  		    
		} catch(Exception e){
		       	e.printStackTrace();
		
		} finally{
		 	  if(rs!=null) rs.close();
		 	  if(pstmt!=null) pstmt.close();
		 	  if(con!=null) con.close();
		}
  
	  return s;
		
	}
	
		
	public boolean setUser(String userid,String passwd,String cell,String bank_name,String bank_owner,String bank_num,String memotxt,String ip,String nick,String recommand) throws SQLException{
      
	  Connection con = null;
	  Statement stmt = null;
	  int row = 0;
	  boolean result = false;
	  
		try{
		
			Context initContext = new InitialContext();
		 	Context envContext = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/vava");
			
		    con = ds.getConnection();
		    Date date = new Date();
		    String  query = "INSERT INTO RT01.dbo.user_mst (userid,siteid,passwd,cell,bank_name,bank_owner,bank_num,regdate,state,watch,charge_level,ip,reg_ip,nick,recommand) "+
				" VALUES ('"+userid+"',1, '"+passwd+"','"+cell+"','"+bank_name+"','"+bank_owner+"','"+bank_num+"','"+sdf.format(date)+"','NORMAL','N','LOW','"+ip+"','"+ip+"','"+nick+"','"+recommand+"')" ;
								
			stmt = con.createStatement();
			
			row = stmt.executeUpdate(query); 
			logger.debug(query);
			logger.debug(row);
			stmt.close();
			con.close();
			logger.debug(row);
			if(row > 0) result = true;
		
			return result;
            	
	  	}catch(Exception e){
	  		e.printStackTrace();
	  		return false;

	  	}finally{
	  		if(stmt!=null) stmt.close();
	  		if(con!=null) con.close();
	  	}
	}
	
	public boolean checkUserId(String userid) throws SQLException{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		boolean result = false;
		
		try {
			Context initContext = new InitialContext();
		 	Context envContext = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/vava");
			
		    con = ds.getConnection();
			      		
		    String  query = "SELECT userid FROM RT01.dbo.user_mst WHERE userid ='"+userid+"'" ;
		    con = ds.getConnection();			 	
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next()){
	
				result = true;
			}
			return result;
			
			
		} catch(Exception e){
			logger.debug(e);
			return false;
		}finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
	  		if(con!=null) con.close();
		}
		
	}
	
	public boolean checkNickname(String nickname) throws SQLException{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		boolean result = false;
		
		try {
			Context initContext = new InitialContext();
		 	Context envContext = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/vava");
			
		    con = ds.getConnection();
			      		
		    String  query = "SELECT nick FROM RT01.dbo.user_mst WHERE nick ='"+nickname+"'" ;
		    con = ds.getConnection();			 	
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				result = true;
			}
			
			return result;
			
			
		} catch(Exception e){
			logger.debug(e);
			return false;
		}finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
	  		if(con!=null) con.close();
		}
		
	}
	
	
	public String getJson() {

		List<HashMap> list = new ArrayList<HashMap>();
		String encodeJson = "";

		try {
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			String query = "SELECT * from RT01.dbo.user_mst" ;
			
			Context initContext = new InitialContext();
		 	Context envContext = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/vava");
						 	
			con = ds.getConnection();			 	
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			

			while (rs.next()) {

				HashMap<String, Object> hsm = new HashMap<String, Object>();

				hsm.put("userid", rs.getString("userid"));
				hsm.put("passwd", rs.getString("passwd"));
				hsm.put("nick", rs.getString("nick"));
				hsm.put("cell", rs.getString("cell"));
				hsm.put("bank_name", rs.getString("bank_name"));

				list.add(hsm);
			}

			encodeJson = JSON.encode(list);			  
			    
			logger.debug(encodeJson);
			logger.debug("adfaskf;laskfasfjkdskjf jkdkdkk");
			
		} catch (Exception e) {
			System.out.println(e);
		}
		
		return encodeJson;
	}
	
	public boolean withdraw(String ip, String sesh,String withdraw ) throws SQLException{
	      
		  Connection con = null;
		  Statement stmt = null;
		  int row = 0;
		  boolean result = false;
		  
			try{
			
				Context initContext = new InitialContext();
			 	Context envContext = (Context)initContext.lookup("java:/comp/env");
				DataSource ds = (DataSource)envContext.lookup("jdbc/vava");
				
			    con = ds.getConnection();
			    Date date = new Date();
			    String  query = "INSERT INTO RT01.dbo.withdraw_lst (siteid,userid,bank_name,bank_owner,bank_num,money,regdate,wddate,wdstate,ip,viewtype,money_req) values ((SELECT siteid from RT01.dbo.user_mst where userid = '"+sesh+"'), '"+sesh+"',(SELECT bank_name from RT01.dbo.user_mst where userid = '"+sesh+"'), (SELECT bank_owner from RT01.dbo.user_mst where userid = '"+sesh+"'), (SELECT bank_num from RT01.dbo.user_mst where userid = '"+sesh+"'), '"+Integer.parseInt(withdraw)+"',(SELECT regdate from RT01.dbo.user_mst where userid = '"+sesh+"'),'"+sdf.format(date)+"','PEND', '"+ip+"' ,'y','"+Integer.parseInt(withdraw)+"')";			
				
				stmt = con.createStatement();
				row = stmt.executeUpdate(query);
				System.out.print("pasok ang query");
				stmt.close();
				con.close();
				
				if(row > 0) result = true;
				
				return result;
	            	
		  	}catch(Exception e){
		  		System.out.print(e);
		  		System.out.print("sala ang query");
		  		return false;

		  	}finally{
		  		if(stmt!=null) stmt.close();
		  		if(con!=null) con.close();
		  	}
		}

}