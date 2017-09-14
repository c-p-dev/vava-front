
package test;


import java.sql.*;
import javax.sql.*;



//import javax.json.Json;
//import javax.json.JsonObject;
import javax.naming.*;


public class BetConManager_Test {

	public BetConManager_Test(){}

	public String getFromDB(String id) throws SQLException{
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		  
		String s = "";
		  
		String query = "SELECT  name from sample_db.dbo.member where id='"+id+"'" ;
		  
		try{	      
			
		 	Context initContext = new InitialContext();
		 	Context envContext = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/vava");
						 	
			con = ds.getConnection();			 	
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
					        
			if(rs.next()){		        	
				s = rs.getString("name");
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

	

}

