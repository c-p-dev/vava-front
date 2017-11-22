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

import bean.UserBean;
public class QnaDao {
	private static final DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static Logger logger = Logger.getLogger(QnaDao.class);
	
	public List<HashMap> getUserQnaList(String userid){
		Gson gson = new Gson();
		List<HashMap> list = new ArrayList<HashMap>();
		String result = "";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT * FROM RT01.dbo.qna_lst WHERE userid = ?";
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
				
				hsm.put("title", (rs.getString("title") == null ? "" : rs.getString("title")));
				hsm.put("regdate", (rs.getString("regdate") == null ?  "" : sdf.format(dateFormater.parse(rs.getString("regdate"))) ));
				hsm.put("ansdate", (rs.getString("ansdate") == null ? "" : sdf.format(dateFormater.parse(rs.getString("ansdate"))) ));
				hsm.put("txt", (rs.getString("txt") == null ? "" : rs.getString("txt")));
				hsm.put("viewtype", (rs.getString("viewtype") == null ?  "" :  rs.getString("viewtype") ));
				hsm.put("writer", (rs.getString("writer") == null ?  "" :  rs.getString("writer") ));
				hsm.put("ip", (rs.getString("ip") == null ?  null :  rs.getString("ip") ));
				hsm.put("quizid", (rs.getString("quizid") == null ?  "" :  rs.getString("quizid") ));
				hsm.put("gubun", (rs.getString("gubun") == null ?  "" :  rs.getString("gubun") ));
				hsm.put("userid", (rs.getString("userid") == null ?  "" :  rs.getString("userid") ));
				
				list.add(hsm);
				System.out.println(hsm);
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
