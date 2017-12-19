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

//import bc4.Debug;
import bean.AccountListBean;
import betconstruct.AuthenticationOutput;


public class AccountDao {
	private static final DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	public List<HashMap> getPointHistory(String userid, String job, String fromDate, String toDate){
		List<HashMap> data = new ArrayList<HashMap>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String dataQuery = "SELECT regdate, acid,job, remain_point, case when money  < 0 then money else null end deduct_point, "
				+ "case when money > 0  then money else null end added_point From account_lst "
				+ " WHERE userid = ? "
				+ "AND cast ([regdate] as date) BETWEEN ? AND ? "
				+ "AND moneypoint = 'P' ";
		if(!job.equals("ALL")){
			dataQuery  = dataQuery + "AND job = ?";
		}
					
		DateFormat dateFormater = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

		try{
			
			Date dateFrom = sdf.parse(fromDate);
			Date dateTo = sdf.parse(toDate);
			
			DBConnector.getInstance();
			con 				= DBConnector.getConnection(); 	
			pstmt = con.prepareStatement(dataQuery);
			pstmt.setString(1,userid);
			pstmt.setString(2,sdf.format(dateFrom) );
			pstmt.setObject(3,sdf.format(dateTo));
			if(!job.equals("ALL")){
				pstmt.setObject(4,job);
			}

			rs = pstmt.executeQuery();
			System.out.println(dataQuery);
					   
			while(rs.next()){
				HashMap<String, Object> hsm = new HashMap<String, Object>();
				hsm.put("regdate", (rs.getString("regdate") != null ? dateFormater.format(dateFormater.parse(rs.getString("regdate"))) : null));
				hsm.put("job", (rs.getString("job") != null ? rs.getString("job") : null));
				hsm.put("deduct_point", (rs.getInt("deduct_point")));
				hsm.put("added_point", (rs.getInt("added_point")));
				hsm.put("remain_point", (rs.getInt("remain_point")));
				data.add(hsm);
			}
			
			rs.close();
	        pstmt.close();
	        con.close();
	  		    
		} catch(Exception e){
			System.out.println(e);
			e.printStackTrace();
		} 
		
		System.out.println(data);
	  	return data;
		
	}
	
	
	public List<HashMap> getPointHistory2(String SITEID, String UID, String job, String fromDate, String toDate){
		List<HashMap> data = new ArrayList<HashMap>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String add = "";
		
		//Debug.out("getPointHistory2[job]:" + job);
		
		if(!job.equals("ALL")){
			//pstmt.setObject(4,job);
			add = "and a.job='"+job+"'";
		}
		
		String dataQuery = "SELECT regdate, acid, job_kor job, remain_point, case when money  < 0 then money else null end deduct_point, "
				+ "case when money > 0  then money else null end added_point From account_lst a, job_trans b "
				+ " WHERE a.job = b.job and userid = ? and siteid=? "
				+  add + " AND cast ([regdate] as date) BETWEEN ? AND ? "
				+ " AND a.moneypoint = 'P' ";
		
		//if(!job.equals("ALL")){
		//	dataQuery  = dataQuery + "AND job = ?";
		//}
					
		//Debug.out("getPointHistory2:" + dataQuery);
		
		DateFormat dateFormater = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

		try{
			
			Date dateFrom = sdf.parse(fromDate);
			Date dateTo = sdf.parse(toDate);
			
			DBConnector.getInstance();
			con 				= DBConnector.getConnection(); 	
			pstmt = con.prepareStatement(dataQuery);
			pstmt.setString(1,UID);
			pstmt.setString(2,SITEID);
			pstmt.setString(3,sdf.format(dateFrom) );
			pstmt.setObject(4,sdf.format(dateTo));
			
			//if(!job.equals("ALL")){
			//	pstmt.setObject(4,job);
			//}

			rs = pstmt.executeQuery();
			System.out.println(dataQuery);
					   
			while(rs.next()){
				HashMap<String, Object> hsm = new HashMap<String, Object>();
				hsm.put("regdate", (rs.getString("regdate") != null ? dateFormater.format(dateFormater.parse(rs.getString("regdate"))) : null));
				hsm.put("job", (rs.getString("job") != null ? rs.getString("job") : null));
				hsm.put("deduct_point", (rs.getInt("deduct_point")));
				hsm.put("added_point", (rs.getInt("added_point")));
				hsm.put("remain_point", (rs.getInt("remain_point")));
				data.add(hsm);
			}
			
			rs.close();
	        pstmt.close();
	        con.close();
	  		    
		} catch(Exception e){
			System.out.println(e);
			e.printStackTrace();
		} 
		
		System.out.println(data);
	  	return data;
		
	}
	/*
	public List<HashMap> getMoneyUseHistory(String userid,String job, String moneypoint, String fromDate, String toDate){
		Gson gson = new Gson();
		List<HashMap> list = new ArrayList<HashMap>();
		String result = "";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String query = "SELECT regdate, acid,job, remain_point, case when money  < 0 then money else null end deduct_point, "
				+ "case when money > 0  then money else null end added_point "
				+ "From account_lst "
				+ "WHERE userid = ? "
				+ "AND cast ([regdate] as date) BETWEEN ? AND ? ";
			
		if(!job.equals("ALL")){
			query  = query + " AND job = ?";
		}else{
			query  = query + " AND '1' = ?";
		}
		if(!moneypoint.equals("ALL")){
			query  = query + " AND moneypoint = ?";
		}else{
			query  = query + " AND '1' = ?";
		}
				

		DateFormat dateFormater = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		
		try{	      
			
			Date dateFrom = sdf.parse(fromDate);
			Date dateTo = sdf.parse(toDate);
			
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();	 	
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,userid);
			pstmt.setString(2,sdf.format(dateFrom) );
			pstmt.setObject(3,sdf.format(dateTo));
			pstmt.setString(4,(job.equals("ALL") ? "1" : job));
			pstmt.setString(5,(moneypoint.equals("ALL") ? "1" : moneypoint));
			
			System.out.println(query.toString());
			rs = pstmt.executeQuery();
					   
			while(rs.next()){
				HashMap<String, Object> hsm = new HashMap<String, Object>();
				hsm.put("regdate", (rs.getString("regdate") != null ? dateFormater.format(dateFormater.parse(rs.getString("regdate"))) : null));
				hsm.put("job", (rs.getString("job") != null ? rs.getString("job") : null));
				hsm.put("deduct_point", (rs.getInt("deduct_point")));
				hsm.put("added_point", (rs.getInt("added_point")));
				hsm.put("remain_point", (rs.getInt("remain_point")));
				list.add(hsm);
			}
			
			rs.close();
	        pstmt.close();
	        con.close();
	  		    
		} catch(Exception e){
			System.out.println(e);
			e.printStackTrace();
		} 
		
	  	return list;
		
	}
*/
	public List<HashMap> getMoneyUseHistory(String SITEID, String UID,String job, String fromDate, String toDate){
		Gson gson = new Gson();
		List<HashMap> list = new ArrayList<HashMap>();
		String result = "";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String add="";
		
		if(!job.equals("ALL")){
			//pstmt.setObject(4,job);
			add = "and a.job='"+job+"'";
		}
		
		String query = "SELECT regdate, acid, b.job_kor job, "+ 
				" case when a.moneypoint='M' then money else 0 end money, "+
				" case when a.moneypoint='P' then money else 0 end point , " +
				" remain_point,remain_money "
				+ " From account_lst a, job_trans b "
				+ " WHERE a.job = b.job and siteid= ? and userid = ? "
				+ add + " AND cast ([regdate] as date) BETWEEN ? AND ? order by regdate desc";
				
	/*		
		if(!job.equals("ALL")){
			query  = query + " AND job = ?";
		}else{
			query  = query + " AND '1' = ?";
		}
	
		if(!moneypoint.equals("ALL")){
			query  = query + " AND moneypoint = ?";
		}else{
			query  = query + " AND '1' = ?";
		}
	*/			

		DateFormat dateFormater = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		
		try{	      
			
			Date dateFrom = sdf.parse(fromDate);
			Date dateTo = sdf.parse(toDate);
			
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();	 	
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,SITEID);
			pstmt.setString(2,UID);
			pstmt.setString(3,sdf.format(dateFrom) );
			pstmt.setObject(4,sdf.format(dateTo));
			//pstmt.setString(5,(job.equals("ALL") ? "1" : job));
			//pstmt.setString(6,(moneypoint.equals("ALL") ? "1" : moneypoint));
			
			//System.out.println(query.toString());
			rs = pstmt.executeQuery();
					   
			while(rs.next()){
				HashMap<String, Object> hsm = new HashMap<String, Object>();
				hsm.put("regdate", (rs.getString("regdate") != null ? dateFormater.format(dateFormater.parse(rs.getString("regdate"))) : null));
				hsm.put("job", (rs.getString("job") != null ? rs.getString("job") : null));
				hsm.put("money", (rs.getInt("money")));
				hsm.put("point", (rs.getInt("point")));
				hsm.put("remain_money", (rs.getInt("remain_money")));
				hsm.put("remain_point", (rs.getInt("remain_point")));
				list.add(hsm);
			}
			
			rs.close();
	        pstmt.close();
	        con.close();
	  		    
		} catch(Exception e){
			System.out.println(e);
			e.printStackTrace();
		} 
		
	  	return list;
		
	}
	
	
	public List<AccountListBean> getPointKind(String SITEID){
		//Gson gson = new Gson();
		List<AccountListBean> list = new ArrayList<AccountListBean>();
		//String result = "";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String query = " select a.job, b.job_kor from account_lst a, job_trans b  where a.job = b.job and a.moneypoint='P' "+
						" and siteid="+SITEID+" group by a.job, b.job_kor order by a.job desc ";

		try{	      
						
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();	 	
			pstmt = con.prepareStatement(query);
			
			System.out.println(query.toString());
			rs = pstmt.executeQuery();
					   
			while(rs.next()){
				AccountListBean acb = new AccountListBean();
				
				acb.setJob(rs.getString("job"));
				acb.setTitle(rs.getString("job_kor"));
				list.add(acb);
			}
			
			rs.close();
	        pstmt.close();
	        con.close();
	  		    
		} catch(Exception e){
			System.out.println(e);
			e.printStackTrace();
		} 
		
	  	return list;
		
	}
	
	public List<AccountListBean> getUsedMoneyKind(String SITEID){
		//Gson gson = new Gson();
		List<AccountListBean> list = new ArrayList<AccountListBean>();
		//String result = "";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String query = " select a.job, b.job_kor from account_lst a, job_trans b  where a.job = b.job "+
						" and siteid="+SITEID+" group by a.job, b.job_kor order by a.job desc ";

		try{	      
						
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();	 	
			pstmt = con.prepareStatement(query);
			
			System.out.println(query.toString());
			rs = pstmt.executeQuery();
					   
			while(rs.next()){
				AccountListBean acb = new AccountListBean();
				
				acb.setJob(rs.getString("job"));
				acb.setTitle(rs.getString("job_kor"));
				list.add(acb);
			}
			
			rs.close();
	        pstmt.close();
	        con.close();
	  		    
		} catch(Exception e){
			System.out.println(e);
			e.printStackTrace();
		} 
		
	  	return list;
		
	}
	

}
