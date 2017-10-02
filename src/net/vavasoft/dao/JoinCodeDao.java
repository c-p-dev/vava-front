package net.vavasoft.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.log4j.Logger;

import net.vavasoft.bean.UserBean;
import net.vavasoft.bean.JoinCodeBean;
import net.vavasoft.bean.SmsAuthBean;
import test.BetConManager_Test2;
public class JoinCodeDao {
	
	private static final DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static Logger logger = Logger.getLogger(JoinCodeDao.class);
	Date date = new Date();
	
	public boolean checkJoinCode(JoinCodeBean jcb) throws SQLException{
		boolean result = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		String query = "SELECT * FROM RT01.dbo.joincode_lst WHERE  joincode = ? and recommend = ?";
		
		try{	      
			
		 	Context initContext = new InitialContext();
		 	Context envContext = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/vava");
						 	
			con = ds.getConnection();			 	
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,jcb.getJoincode());
			pstmt.setString(2,jcb.getRecommend());
			rs = pstmt.executeQuery();
					   
			if(rs.next()){
				result = true;
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
		
		return result;
	}
	
	public boolean updateJoinCodeRegister(JoinCodeBean jcb) throws SQLException{
		boolean result = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int sts = 0;
		String query = "UPDATE joincode_lst SET userid = ?, usedate = ?, state = 'USE'  WHERE joincode = ? AND recommend = ? ";
		
		try{	      
			
		 	Context initContext = new InitialContext();
		 	Context envContext = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/vava");
						 	
			con = ds.getConnection();			 	
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,jcb.getUserid());
			pstmt.setString(2,sdf.format(date));
			pstmt.setString(3,jcb.getJoincode());
			pstmt.setString(4,jcb.getRecommend());

			sts = pstmt.executeUpdate();					   
			if(sts > 0 ) result = true;
			
	        pstmt.close();
	        con.close();
	        
		} catch(Exception e){
			logger.debug(e);
	       	e.printStackTrace();
		}finally{
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(con!=null) con.close();
		}
  	
		
		return result;
	}
	
}
