package dao;

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
import util.DBConnector;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import bc4.Debug;
import bean.ChargeBean;
import bean.UserBean;

public class ChargeDao {
	private static final DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static Logger logger = Logger.getLogger(ChargeDao.class);
	
	//public boolean saveChargeApplication(UserBean uBean,ChargeBean cBean) throws SQLException {
	public boolean saveChargeApplication(String SITEID,String UID, String ao, String m, String IP) throws SQLException {
	
	
		//UserDao user_db		= new UserDao();
		//UserBean user_data	= new UserBean(); 
		
		PreparedStatement pstmt = null;
		Connection con = null;
		Statement stmt = null;
		int row = 0;
		boolean result = false;
		Date date = new Date();
		
		String  query = " DECLARE @INS_ID INT "+
						" Declare @c_level varchar(10)"+
						" Declare @c_cnt char(1)" + 
						" Declare @u_grd int " +
						" select @c_level = charge_level,@u_grd =grade from user_mst  WHERE siteid="+SITEID+" and userid = '"+UID+"'" +		
						" select @c_cnt = case when count(*)=0 then 'F' when  count(*) >0 then 'C' end from charge_lst  WHERE siteid="+SITEID+" and userid = '"+UID+"' and convert(char(8),regdate,112) = convert(char(8),getdate(),112)"+
						"INSERT INTO charge_lst (userid,siteid,charge_level,bank_owner,money, user_grade,regdate,chstate,ip,viewtype,money_req,chtype,bonus) "+
						" VALUES ('"+UID+"',"+SITEID+",@c_level,'"+ao+"','"+m+"',@u_grd,GETDATE(),'WAIT','"+IP+"','Y','"+m+"',@c_cnt,0)"+
						" SET @INS_ID = @@IDENTITY " +
						" IF @INS_ID>0 "+						
						//" INSERT INTO account_lst (userid,siteid,job,jobid,moneypoint,money,regdate,remain_money,remain_point) "+
						//" SELECT top 1 '"+UID+"', "+SITEID+",'WITHDRAW',@INS_ID ,'M', "+amt+"*-1,GETDATE(), money-"+amt+", point from user_mst WHERE siteid="+SITEID+" and userid = '"+UID+"' " +
						" UPDATE USER_MST SET charge_cnt = charge_cnt+1, charge_money= charge_money+"+m+" WHERE siteid="+SITEID+" and userid = '"+UID+"'";
		
		Debug.out("[saveChargeApplication] :" + query);
		
		try{
		
			DBConnector.getInstance();
			con = DBConnector.getConnection();
		    pstmt = con.prepareStatement(query);
		    
		  //  pstmt.setString(1,UID);
		  //  pstmt.setString(2,UID);
		  //  pstmt.setString(1,UID);
		   // pstmt.setString(2,SITEID);
		   // pstmt.setString(5,cBean.getCharge_level());
		   // pstmt.setString(5,cBean.getBank_name());
		  //  pstmt.setString(3,ao);
//		    pstmt.setString(6,cBean.getBank_num());
		  //  pstmt.setString(4,m);
		   // pstmt.setInt(7,uBean.getGrade());
		   // pstmt.setString(5,IP);
		  //  pstmt.setString(6,m);
		    
			row = pstmt.executeUpdate(); 
			//logger.debug(query);
			//logger.debug(row);
			pstmt.close();
			con.close();
			//logger.debug(row);
			
			Debug.out("[saveChargeApplication:row] :" + row);
			
			if(row > 0) {
				result = true;
				//user_data = user_db.getUserByUserId(cBean.getUserid());
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
		//String query = "SELECT * FROM charge_lst WHERE userid = ? ";
		//DecimalFormat formatter = new DecimalFormat("#,###");
		//DateFormat dateFormater = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		String query = "SELECT chid,convert(char(16),regdate,120) regdate,isnull(money_req,0) money_req,isnull(money,0) money ,convert(char(16),chdate,120) chdate,chstate "+
						" FROM charge_lst  "+
						" WHERE userid = ? order by regdate desc ";
		 		
		try{	      
			
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,userid);
			rs = pstmt.executeQuery();
					   
			while(rs.next()){
				HashMap<String, Object> hsm = new HashMap<String, Object>();
				
				/*
				hsm.put("chid", (rs.getString("chid") != null ? rs.getString("chid") : null));
				hsm.put("regdate", (rs.getString("regdate") != null ? sdf.format(dateFormater.parse(rs.getString("regdate"))) : null));
				double amount = (rs.getString("money_req") != null ? Double.parseDouble(rs.getString("money_req")) : 0);
				hsm.put("money", formatter.format(amount));
				hsm.put("chdate", (rs.getString("chdate") != null ? rs.getString("chdate") : null));
				hsm.put("chstate", (rs.getString("chstate") != null ?  rs.getString("chstate") : null));
				*/
				hsm.put("chid",rs.getString("chid"));
				hsm.put("regdate",rs.getString("regdate"));
				hsm.put("money",rs.getString("money"));
				hsm.put("chdate",rs.getString("chdate"));
				hsm.put("chstate",rs.getString("chstate"));
				
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
