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


import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import bean.MgBettingProfileBean;
import bean.MgPlayerAccountBean;
import bean.MgWithdrawAllBean;
import bean.SmsAuthBean;
import bean.UserBean;
import controller.SpinCubeController;
import controller.TotalEgameController;
import dao.SmsDao;
import net.vavasoft.util.DBConnector;

public class UserDao {
	
	private static final DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static Logger logger = Logger.getLogger(UserDao.class);
	public UserDao(){}
	
	public UserBean getUser(String userid,String password) throws SQLException{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		UserBean uib = new UserBean();
		String query = "SELECT * FROM RT01.dbo.user_mst WHERE userid = ?";

		try {
			DBConnector.getInstance();
			con = DBConnector.getConnection();
			
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,userid);
			rs = pstmt.executeQuery();
					   
			if(rs.next()){
				if (rs.getString("passwd").equals(password)){
					uib.setLoginStatus(0); //success
					uib.setSiteid(rs.getInt("siteid"));
					uib.setUserid(rs.getString("userid"));
					uib.setNick(rs.getString("nick"));
					uib.setCharge_level(rs.getString("charge_level"));
					
				}else{
					uib.setLoginStatus(1); // wrong password
				}
			}else{
				uib.setLoginStatus(2); // no account
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
  	
	  	return uib;
	}
	
	public boolean setUser(UserBean user) throws SQLException{      
		  Connection con = null;
		  Statement stmt = null;
		  PreparedStatement pstmt = null;
		  int row = 0;
		  boolean result = false;
		  
			try {
				DBConnector.getInstance();
				con = DBConnector.getConnection();
				
				SmsDao sd = new SmsDao();
				String mobile_no = sd.formatCellNumber(user.getCell_prefix(), user.getCell());
				Date date = new Date();
			    String  query = "INSERT INTO RT01.dbo.user_mst (userid,siteid,passwd,cell,bank_name,bank_owner,bank_num,regdate,state,watch,charge_level,ip,reg_ip,nick,recommend) "+
						" VALUES (?,1,?,? ,?,?,?,?,'NORMAL','N','LOW',?,?,?,?)";
									
			    pstmt = con.prepareStatement(query);
			    pstmt.setString(1,user.getUserid());
			    pstmt.setString(2,user.getPasswd());
			    pstmt.setString(3,mobile_no);
			    pstmt.setString(4,user.getBank_name());
			    pstmt.setString(5,user.getBank_owner());
			    pstmt.setString(6,user.getBank_num());
			    pstmt.setString(7,sdf.format(date));
			    pstmt.setString(8,user.getIp());
			    pstmt.setString(9,user.getIp());
			    pstmt.setString(10,user.getNick());
			    pstmt.setString(11,user.getRecommend());
			    
				row = pstmt.executeUpdate(); 
				logger.debug(query);
				logger.debug(row);
				pstmt.close();
				con.close();
				logger.debug(row);
				if(row > 0) {

					result = true;
				}
			
				return result;
	            	
		  	}catch(Exception e){
		  		e.printStackTrace();
		  		return false;

		  	}finally{
		  		if(stmt!=null) stmt.close();
		  		if(con!=null) con.close();
		  	}
	}
	
	public boolean checkUserId(UserBean user) throws SQLException{

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;
		
		try {
			DBConnector.getInstance();
			con = DBConnector.getConnection();
			      		
		    String  query = "SELECT userid FROM RT01.dbo.user_mst WHERE userid = ? " ;
		    pstmt = con.prepareStatement(query);
			pstmt.setString(1,user.getUserid());
			rs = pstmt.executeQuery();
			if(rs.next()){
				result = true;
			}
			
			
			
		} catch(Exception e){
			logger.debug(e);
			
		}finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
	  		if(con!=null) con.close();
		}
		
		return result;
	}
	
	public boolean checkNickname(String nickname) throws SQLException{

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		boolean result = false;
		
		try {
			DBConnector.getInstance();
			con = DBConnector.getConnection();
			      		
		    String  query = "SELECT nick FROM RT01.dbo.user_mst WHERE nick = ? " ;
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,nickname);
			rs = pstmt.executeQuery();
			logger.debug("this is rs: " + rs);
			if(rs.next()){
				logger.debug("rs.next :" + rs.getString("nick"));
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
	
	public String registerUser(String json_post){
		System.out.println(json_post);
		Gson gson = new Gson();
		HashMap<String, String> json_data 	= gson.fromJson(json_post, new TypeToken<HashMap<String, String>>(){}.getType());
		System.out.println(json_data);
		logger.debug(json_data);
		
		return json_post;
		
	}
	
	public UserBean getUserByUserId(String user_id)
	{
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		String  query 			= "SELECT TOP 1 * FROM user_mst WHERE userid = ?" ;
		
		UserBean user_data		= new UserBean();
		
		try {
			DBConnector.getInstance();
			con = DBConnector.getConnection();
		    
		    pstmt   			= con.prepareStatement(query);
            pstmt.setString(1, user_id);
            
			rs      = pstmt.executeQuery();
            
            if (rs.next()) {
            	user_data.setUserid(rs.getString("userid"));
            	user_data.setPasswd(rs.getString("passwd"));
            	user_data.setSiteid(rs.getInt("siteid"));
            	user_data.setMoney(rs.getInt("money"));
            	user_data.setPoint(rs.getInt("point"));
            	user_data.setNick(rs.getString("nick"));
            	user_data.setCell(rs.getString("cell"));
            	user_data.setRegdate(rs.getString("regdate"));
            	user_data.setState(rs.getString("state"));
            	user_data.setGrade(rs.getInt("grade"));
            	user_data.setWatch(rs.getString("watch"));
            	user_data.setRecommend_yn(rs.getString("recommend_yn"));
            	user_data.setCharge_level(rs.getString("charge_level"));
            	user_data.setBank_name(rs.getString("bank_name"));
            	user_data.setBank_owner(rs.getString("bank_owner"));
            	user_data.setBank_num(rs.getString("bank_num"));
            	user_data.setRecommend(rs.getString("recommend"));
            }
            
            rs.close();
	        pstmt.close();
	        con.close();
		}
		catch(Exception e) {
			logger.debug(e);
		}
		
		return user_data;
	}
	
	public int setUserMoney(String user_id, double money) {

		Connection con 			= null;
		PreparedStatement pstmt = null;
		int sts					= 0;
		String  query 			= "UPDATE user_mst SET money = ? WHERE userid = ?";		
		
		try {
			DBConnector.getInstance();
			con = DBConnector.getConnection();
		    
		    pstmt   			= con.prepareStatement(query);
            pstmt.setDouble(1, money);
            pstmt.setString(2, user_id);
            
			sts      = pstmt.executeUpdate();
           
	        pstmt.close();
	        con.close();
		}
		catch(Exception e) {
			logger.debug(e);
		}
		
		return sts;
	}
	
	public String getUserBankConfigAccount(int siteid,String charge_level) throws SQLException{
		String bankAccount = "";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			DBConnector.getInstance();
			con = DBConnector.getConnection();
		
		    String query = "";
		    	query = "SELECT CONCAT(bank_low_name,' ' ,bank_low_owner,' ',bank_low_num) as bank_account from dbo.config_mst WHERE siteid=?";
		    if(charge_level == "HIGH"){
		    	query = "SELECT CONCAT(bank_high_name,' ' ,bank_high_owner,' ',bank_high_num) as bank_account from dbo.config_mst WHERE siteid=?"; 
			}else if(charge_level == "MIDDLE"){
				query = "SELECT CONCAT(bank_middle_name,' ' ,bank_middle_owner,' ',bank_middle_num) as bank_account from dbo.config_mst WHERE siteid=?"; 
			}
			
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1,siteid);
			rs = pstmt.executeQuery();
			if(rs.next()){
				bankAccount =  rs.getString("bank_account");
			}
			
		} catch(Exception e){
			logger.debug(e);
			
		}finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
	  		if(con!=null) con.close();
		}
		
		return bankAccount;
		
	}
	
	public boolean withdraw(UserBean trans_data,int withdraw) throws SQLException{

		PreparedStatement pstmt = null;
		Connection con = null;
		Statement stmt = null;
		int row = 0;
		boolean result = false;
		Date date = new Date();
	
		String  query = "INSERT INTO RT01.dbo.withdraw_lst (siteid,userid,bank_name,bank_owner,bank_num,money,regdate,wddate,wdstate,ip,viewtype,money_req) "+
				" VALUES (?,?,?,?,?,?,?,?,'PEND',?,'y',?)";
		try{
		
			DBConnector.getInstance();
			con = DBConnector.getConnection();
			
		    pstmt = con.prepareStatement(query);
		    pstmt.setInt(1,trans_data.getSiteid());
		    pstmt.setString(2,trans_data.getUserid());
		    pstmt.setString(3,trans_data.getBank_name());
		    pstmt.setString(4,trans_data.getBank_owner());
		    pstmt.setString(5,trans_data.getBank_num());
		    pstmt.setInt(6,withdraw);
		    pstmt.setString(7,sdf.format(date));
		    pstmt.setString(8,sdf.format(date));
		    pstmt.setString(9,trans_data.getIp());
		    pstmt.setInt(10,withdraw);
		    
			row = pstmt.executeUpdate(); 
			logger.debug(query);
			logger.debug(row);
			pstmt.close();
			con.close();
			logger.debug(row);
			
	  	}catch(Exception e){
	  		logger.debug(query);
	  		e.printStackTrace();
	  
	  	}finally{
	  		if(stmt!=null) stmt.close();
	  		if(con!=null) con.close();
	  	}
		
		return result;
			
	}

	public List<HashMap> getWithdrawList(String userid){
		Gson gson = new Gson();
		List<HashMap> list = new ArrayList<HashMap>();
		String result = "";
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String query = "SELECT * FROM RT01.dbo.withdraw_lst WHERE userid = ?";
		DecimalFormat formatter = new DecimalFormat("#,###");
		DateFormat dateFormater = new SimpleDateFormat("yyyy-MM-dd");
		
		try{	      
			
			DBConnector.getInstance();
			con = DBConnector.getConnection();
			
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,userid);
			rs = pstmt.executeQuery();
					   
			while(rs.next()){
				HashMap<String, Object> hsm = new HashMap<String, Object>();
				hsm.put("wdid", (rs.getString("wdid") != null ? rs.getString("wdid") : null));
				hsm.put("regdate", (rs.getString("regdate") != null ? dateFormater.format(dateFormater.parse(rs.getString("regdate"))) : null));
				double amount = (rs.getString("money_req") != null ? Double.parseDouble(rs.getString("money_req")) : 0);
				hsm.put("money", formatter.format(amount));
				hsm.put("chdate", (rs.getString("wddate") != null ? rs.getString("wddate") : null));
				hsm.put("chstate", (rs.getString("wdstate") != null ?  rs.getString("wdstate") : null));
				
				list.add(hsm);
			}
			
			
			
			rs.close();
	        pstmt.close();
	        con.close();
	        System.out.print(query);
		} catch(Exception e){
			System.out.println(e);
			e.printStackTrace();
		} 
	  	return list;
		
	}	
	
	public int updateUserAfterLogin(String userid,String sessionId){
		
		Gson gson				= new Gson();
		Connection con 			= null;
		PreparedStatement pstmt = null;
		int sts = 0;
		String  query 			= "UPDATE user_mst SET sess  = ?, login_cnt = login_cnt + 1 WHERE userid = ?";		
		
		try {
			DBConnector.getInstance();
			con = DBConnector.getConnection();
			
		    pstmt   			= con.prepareStatement(query);
            pstmt.setString(1, sessionId);
            pstmt.setString(2, userid);
			sts = pstmt.executeUpdate();
			
	        pstmt.close();
	        con.close();
	        
	        /*--------------------------------------------------------------------
	        |	Withdraw all money from MG
	        |-------------------------------------------------------------------*/
	        ArrayList<MgBettingProfileBean> bet_profls	= new ArrayList<MgBettingProfileBean>();
			MgPlayerAccountBean mg_user		= new MgPlayerAccountBean();
			MgBettingProfileBean bet_profl	= new MgBettingProfileBean();
			UserBean user_data				= this.getUserByUserId(userid);
			SpinCubeController sc_ctrl		= new SpinCubeController(Integer.toString(user_data.getSiteid()).concat("_").concat(userid));
			
			double money					= user_data.getMoney();
			
	        TotalEgameController teg_ctrl 	= new TotalEgameController();
	        MgWithdrawAllBean withdraw_data = new MgWithdrawAllBean();
	        String mg_username				= Integer.toString(user_data.getSiteid()).concat("_").concat(userid);
	        
	        String withdraw_resp			= teg_ctrl.withdrawAll(mg_username);
	        withdraw_data					= gson.fromJson(withdraw_resp, MgWithdrawAllBean.class);
	        
	        switch (withdraw_data.getStatus().getErrorCode()) {
		        /*	MG Account does not Exist	*/
		        case 46:
		        	/*	Create account for MG	*/
					bet_profl.setCategory("LGBetProfile");
					bet_profl.setProfileId(1202);
					
					bet_profls.add(bet_profl);
					
					mg_user.setPreferredAccountNumber(mg_username);
					mg_user.setFirstName(user_data.getUserid().trim().concat("FNAME"));
					mg_user.setLastName(user_data.getUserid().trim().concat("LNAME"));
					mg_user.setEmail("");
					mg_user.setMobilePrefix(user_data.getCell().substring(1, 3));
					mg_user.setMobileNumber(user_data.getCell().substring(3));
					mg_user.setDepositAmount(0);
					mg_user.setPinCode("newplayer1");
					mg_user.setIsProgressive(0);
					mg_user.setBettingProfiles(bet_profls);
					teg_ctrl.addPlayerAccount(mg_user);
	        		break;
	        		
	        	case 0:
	        		money 	= money + withdraw_data.getResult().getTransactionAmount();
	    			
	        		user_data.setMoney((int)money);
	    			this.setUserMoney(userid, money);
	        	default:
	        		break;
	        }
	        
	        sc_ctrl.transferMoneyToVava(userid);
		}
		catch(Exception e) {
			System.out.println(e);
			logger.debug(e);
		}
		
		return sts;
		
	}

	public boolean updateUserProfile(String userid, String bank_name, String bank_owner,String bank_num, String cell_prefix, String cell){
		boolean result = false;
		Connection con 			= null;
		PreparedStatement pstmt = null;
		int sts = 0;
		String  query 			= "UPDATE user_mst SET bank_name=? ,bank_owner = ?, bank_num = ?, cell=? WHERE userid = ?";		
		
		try {
			DBConnector.getInstance();
			con = DBConnector.getConnection();
			SmsDao sd = new SmsDao();
			String mobile_no = sd.formatCellNumber(cell_prefix, cell);
		    pstmt   			= con.prepareStatement(query);
            pstmt.setString(1, bank_name);
            pstmt.setString(2, bank_owner);
            pstmt.setString(3, bank_num);
            pstmt.setString(4, mobile_no);
            pstmt.setString(5, userid);
			sts = pstmt.executeUpdate();
			
	        pstmt.close();
	        con.close();
	        
		}
		catch(Exception e) {
			System.out.println(e);
			logger.debug(e);
		}
		
		if(sts > 0 ) result = true;
		
		return result;
		
	}
	
	public UserBean getUserInfoByUserid (String userid) throws SQLException{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		UserBean uib = new UserBean();
		String query = "SELECT * FROM RT01.dbo.user_mst WHERE userid = ?";
		
		try{	      
			
			DBConnector.getInstance();
			con = DBConnector.getConnection();	 	
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,userid);
			rs = pstmt.executeQuery();
					   
			if(rs.next()){
				uib.setLoginStatus(0); //success
				uib.setUserid(rs.getString("userid"));
				uib.setNick(rs.getString("nick"));
				uib.setCell(rs.getString("cell"));
				uib.setGrade(rs.getInt("grade"));
				uib.setWatch(rs.getString("watch"));
				uib.setRecommend_yn(rs.getString("recommend_yn"));
				uib.setMoney(rs.getInt("money"));
				uib.setPoint(rs.getInt("point"));
				uib.setBank_name(rs.getString("bank_name"));
				uib.setBank_owner(rs.getString("bank_owner"));
				uib.setBank_num(rs.getString("bank_num"));	
				uib.setCharge_level(rs.getString("charge_level"));
				uib.setSiteid(rs.getInt("siteid"));
			}else{
				uib.setLoginStatus(2); // no account
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
  	
	  	return uib;
	}
	
	public boolean checkUserPassword(String userid, String passwd) throws SQLException{
		boolean result = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		UserBean uib = new UserBean();
		String query = "SELECT passwd FROM RT01.dbo.user_mst WHERE userid = ? and passwd = ?";
		
		try{	      
			
			DBConnector.getInstance();
			con = DBConnector.getConnection();	 	
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,userid);
			pstmt.setString(2,passwd);
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
	
	public boolean updateUserPasswd(String userid,String current_passwd,String new_passwd) throws SQLException{
		boolean result = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int sts = 0;
		String query = "UPDATE user_mst SET passwd = ? WHERE userid = ? AND passwd = ? ";
		
		try{	      
			
			DBConnector.getInstance();
			con = DBConnector.getConnection();			 	
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,new_passwd);
			pstmt.setString(2,userid);
			pstmt.setString(3,current_passwd);

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
	
	public boolean switchpoints(UserBean trans_data,int money,int point,int points) throws SQLException{

		PreparedStatement pstmt = null;
		Connection con = null;
		Statement stmt = null;
		int row = 0;
		boolean result = false;
		Date date = new Date();
	
		String  query = "INSERT INTO RT01.dbo.account_lst (userid,siteid,job,jobid,title,moneypoint,money,regdate,remain_money,remain_point,adminid) "+
				" VALUES (?,?,'POINT2MONEY','','','P',?,?,?,?,'')," + 
				"(?,?,'POINT2MONEY','','','M',?,?,?,?,'')";
		try{
		
			DBConnector.getInstance();
			con = DBConnector.getConnection();
		    pstmt = con.prepareStatement(query);
		    pstmt.setString(1,trans_data.getUserid());
		    pstmt.setInt(2,trans_data.getSiteid());
		    pstmt.setInt(3,(points*-1));
		    pstmt.setString(4,sdf.format(date));
		    pstmt.setInt(5,(money+points));
		    pstmt.setInt(6,(point-points));
		    pstmt.setString(7,trans_data.getUserid());
		    pstmt.setInt(8,trans_data.getSiteid());
		    pstmt.setInt(9,points);
		    pstmt.setString(10,sdf.format(date));
		    pstmt.setInt(11,(money+points));
		    pstmt.setInt(12,(point-points));
			row = pstmt.executeUpdate(); 
			logger.debug(query);
			logger.debug(row);
			pstmt.close();
			con.close();
			logger.debug(row);
			System.out.println("pasok sa app");
	  	}catch(Exception e){
	  		logger.debug(query);
	  		e.printStackTrace();
	  
	  	}finally{
	  		if(stmt!=null) stmt.close();
	  		if(con!=null) con.close();
	  	}
		
		return result;
			
	}
	
	public boolean userpoints(UserBean trans_data,int money,int point,int points) throws SQLException{

		PreparedStatement pstmt = null;
		Connection con = null;
		Statement stmt = null;
		int row = 0;
		boolean result = false;
		Date date = new Date();
	
		String  query = "UPDATE RT01.dbo.user_mst SET money = ?, point = ? where  userid =?";
		try{
		
			DBConnector.getInstance();
			con = DBConnector.getConnection();
		    pstmt = con.prepareStatement(query);
		    pstmt.setInt(1,(money+points));
		    pstmt.setInt(2,(point-points));
		    pstmt.setString(3,trans_data.getUserid());
			row = pstmt.executeUpdate(); 
			logger.debug(query);
			logger.debug(row);
			pstmt.close();
			con.close();
			logger.debug(row);
			
	  	}catch(Exception e){
	  		logger.debug(query);
	  		e.printStackTrace();
	  
	  	}finally{
	  		if(stmt!=null) stmt.close();
	  		if(con!=null) con.close();
	  	}
		
		return result;
			
	}
	
	public boolean checkCellNumByNick(String nickname,String cell_prefix,String cell ) throws SQLException{

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		SmsDao sd = new SmsDao();
		boolean result = false;
		System.out.println(cell);
		try {
			DBConnector.getInstance();
			con = DBConnector.getConnection();
			String mobile_no = sd.formatCellNumber(cell_prefix,cell);
		    String  query = "SELECT * FROM RT01.dbo.user_mst WHERE nick = ? AND cell = ?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,nickname);
			pstmt.setString(2,mobile_no);
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
	
	public boolean checkCellNumByUseridNick(String userid, String nickname,String cell_prefix,String cell ) throws SQLException{

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		SmsDao sd = new SmsDao();
		boolean result = false;
		System.out.println(cell);
		try {
			DBConnector.getInstance();
			con = DBConnector.getConnection();
			String mobile_no = sd.formatCellNumber(cell_prefix,cell);
		    String  query = "SELECT * FROM RT01.dbo.user_mst WHERE nick = ? AND cell = ? AND userid = ?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,nickname);
			pstmt.setString(2,mobile_no);
			pstmt.setString(3,userid);
			rs = pstmt.executeQuery();			
			if(rs.next()){
				result = true;
			}
			
			return result;
			
			
		} catch(Exception e){
			logger.debug(e);
			return false;
		}
		
	}
	
	public String getUserIdByBank(String bank_owner,String bank_name, String bank_num, String cell_prefix, String cell) throws SQLException{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String result = null;
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
			SmsDao sd = new SmsDao();
			String mobile_no =  sd.formatCellNumber(cell_prefix, cell);      		
		    String query = "SELECT userid FROM RT01.dbo.user_mst " + 
		    		"WHERE bank_owner = ? " + 
		    		"AND  bank_name = ? " + 
		    		"AND bank_num = ? " + 
		    		"AND cell = ? ";
		    	 	
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,bank_owner);
			pstmt.setString(2,bank_name);
			pstmt.setString(3,bank_num);
			pstmt.setString(4,mobile_no);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				result = rs.getString("userid");
			}
			
			return result;
		} catch(Exception e){
			logger.debug(e);
			return null;
		}
		
		
		
	}

	public boolean getUserIdPassByBank (String bank_owner,String bank_name, String bank_num, String cell_prefix, String cell) throws SQLException{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;
		
		try {
			
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
			SmsDao sd = new SmsDao();
			String mobile_no =  sd.formatCellNumber(cell_prefix, cell);      		
		    String query = "SELECT userid FROM RT01.dbo.user_mst " + 
		    		"WHERE bank_owner = ? " + 
		    		"AND  bank_name = ? " + 
		    		"AND bank_num = ? " + 
		    		"AND cell = ? ";
		    
		    System.out.println(bank_owner);
		    System.out.println(bank_name);
		    System.out.println(bank_num);
		    System.out.println(cell_prefix);
		    System.out.println(cell);
		    
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,bank_owner);
			pstmt.setString(2,bank_name);
			pstmt.setString(3,bank_num);
			pstmt.setString(4,mobile_no);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				result = true;
			}

			
			return result;
		} catch(Exception e){
			logger.debug(e);
			return false;
		}
		
		
		
	}
	
	public boolean forgotPasswordUpdate1(UserBean ub, SmsAuthBean sb)throws SQLException{
		boolean result = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int sts = 0;
		
		
		String query = "UPDATE u SET u.passwd = ? FROM user_mst u "
				+ "LEFT JOIN sms_auth s ON u.userid = s.userid "
				+ "WHERE u.userid = ?  AND u.nick = ? AND u.cell = ?  AND s.authcode = ? ";
		
		try{	      
			SmsDao sd = new SmsDao();
			String mobile_no = sd.formatCellNumber(ub.getCell_prefix(), ub.getCell());
	
			DBConnector.getInstance();
			con = DBConnector.getConnection();			 	
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,ub.getPasswd());
			pstmt.setString(2,ub.getUserid());
			pstmt.setString(3,ub.getNick());
			pstmt.setString(4,mobile_no);
			pstmt.setString(5,sb.getAuthcode());

			sts = pstmt.executeUpdate();					   
			if(sts > 0 ) result = true;
			
	        pstmt.close();
	        con.close();
	        
		} catch(Exception e){
			logger.debug(e);
	       	e.printStackTrace();
	       	result = false;
		}
  	
		
		return result;
	}
	
	public boolean forgotPasswordUpdate2(UserBean ub)throws SQLException{
		boolean result = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int sts = 0;
		
		String query = "UPDATE user_mst SET passwd = ?  "
				+ "WHERE bank_owner = ?  AND bank_name  = ? AND bank_num = ?  AND cell = ? ";
		try{	      
			SmsDao sd = new SmsDao();
			String mobile_no = sd.formatCellNumber(ub.getCell_prefix(), ub.getCell());
	
			DBConnector.getInstance();
			con = DBConnector.getConnection();			 	
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,ub.getPasswd());
			pstmt.setString(2,ub.getBank_owner());
			pstmt.setString(3,ub.getBank_name());
			pstmt.setString(4,ub.getBank_num());
			pstmt.setString(5,mobile_no);

			sts = pstmt.executeUpdate();					   
			if(sts > 0 ) result = true;
			
	        pstmt.close();
	        con.close();
	        
		} catch(Exception e){
			logger.debug(e);
	       	e.printStackTrace();
	       	result = false;
		}
  	
		
		return result;
	}

}
