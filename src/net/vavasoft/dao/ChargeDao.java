package net.vavasoft.dao;

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
import net.vavasoft.bean.ChargeBean;
import net.vavasoft.bean.UserBean;
import net.vavasoft.util.DBConnector;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

public class ChargeDao {
	private static final DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static Logger logger = Logger.getLogger(ChargeDao.class);
	
	public boolean saveChargeApplication(UserBean uBean,ChargeBean cBean) throws SQLException {
		
		UserDao user_db		= new UserDao();
		UserBean user_data	= new UserBean(); 
		
		PreparedStatement pstmt = null;
		Connection con = null;
		Statement stmt = null;
		int row = 0;
		boolean result = false;
		Date date = new Date();
	
		String  query = "INSERT INTO RT01.dbo.charge_lst (userid,siteid,charge_level,bank_name,bank_owner,bank_num,money_req,user_grade,regdate,chstate,ip,viewtype) "+
				" VALUES (?,?,?,?,?,?,?,1,?,'PEND',?,'Y')";
		try{
		
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    pstmt = con.prepareStatement(query);
		    pstmt.setString(1,uBean.getUserid());
		    pstmt.setInt(2,uBean.getSiteid());
		    pstmt.setString(3,cBean.getCharge_level());
		    pstmt.setString(4,cBean.getBank_name());
		    pstmt.setString(5,cBean.getBank_owner());
		    pstmt.setString(6,cBean.getBank_num());
		    pstmt.setInt(7,cBean.getMoney_req());
		    pstmt.setString(8,sdf.format(date));
		    pstmt.setString(9,cBean.getIp());
		    
			row = pstmt.executeUpdate(); 
			logger.debug(query);
			logger.debug(row);
			pstmt.close();
			con.close();
			logger.debug(row);
			
			if(row > 0) {
				result = true;
				user_data = user_db.getUserByUserId(cBean.getUserid());
				//user_db.setUserMoney(userid, user_data.getMoney() + money);
			}
			
	  	}catch(Exception e){
	  		logger.debug(query);
	  		e.printStackTrace();
	  
	  	}finally{
	  		if(stmt!=null) stmt.close();
	  		if(con!=null) con.close();
	  	}
		
		return result;
	}
	
	public List<HashMap> getUserChargeList(String userid){
		Gson gson = new Gson();
		List<HashMap> list = new ArrayList<HashMap>();
		String result = "";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT * FROM RT01.dbo.charge_lst WHERE userid = ?";
		DecimalFormat formatter = new DecimalFormat("#,###");
		DateFormat dateFormater = new SimpleDateFormat("yyyy-MM-dd");
		
		try{	      
			
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,userid);
			rs = pstmt.executeQuery();
					   
			while(rs.next()){
				HashMap<String, Object> hsm = new HashMap<String, Object>();
				hsm.put("chid", (rs.getString("chid") != null ? rs.getString("chid") : null));
				hsm.put("regdate", (rs.getString("regdate") != null ? dateFormater.format(dateFormater.parse(rs.getString("regdate"))) : null));
				double amount = (rs.getString("money_req") != null ? Double.parseDouble(rs.getString("money_req")) : 0);
				hsm.put("money", formatter.format(amount));
				hsm.put("chdate", (rs.getString("chdate") != null ? rs.getString("chdate") : null));
				hsm.put("chstate", (rs.getString("chstate") != null ?  rs.getString("chstate") : null));
				
				list.add(hsm);
			}
			
			rs.close();
	        pstmt.close();
	        con.close();
	  		    
		} catch(Exception e){
			System.out.println(e);
			e.printStackTrace();
		} 
		
		System.out.println(list);
	  	return list;
		
	}
}
