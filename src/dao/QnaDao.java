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

import bean.MessageBean;
import bean.UserBean;
import bean.QnaBean;
public class QnaDao {
	private static final DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static Logger logger = Logger.getLogger(QnaDao.class);
	
	public boolean setMessage(QnaBean qBean) throws SQLException {
		Connection con = null;
		Statement stmt = null;
		PreparedStatement pstmt = null;
		int row = 0;
		boolean result = false;

		try {

			DBConnector.getInstance();
			con = DBConnector.getConnection();
			Date date = new Date();
			String query = "INSERT INTO RT01.dbo.qna_lst (siteid, userid, txt, gubun, viewtype, regdate, writer, ip, quizid) "
			        + " VALUES (1,?,?,'QNA','Y',?,'U',?,IDENT_CURRENT('RT01.dbo.qna_lst'))";

			pstmt = con.prepareStatement(query);
			pstmt.setString(1, qBean.getUserid());
			pstmt.setString(2, qBean.getTxt());
			pstmt.setString(3, sdf.format(date));
			pstmt.setString(4, qBean.getIp());

			row = pstmt.executeUpdate();
			logger.debug(query);
			logger.debug(row);
			pstmt.close();
			con.close();
			logger.debug(row);
			if (row > 0) {
				result = true;
			}

			return result;

		} catch (Exception e) {
			e.printStackTrace();
			return false;

		} finally {
			if (stmt != null)
				stmt.close();
			if (con != null)
				con.close();
		}
	}
	
	public List<HashMap> getMessage(String userid) {
		Gson gson = new Gson();
		List<HashMap> list = new ArrayList<HashMap>();
		String result = "";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT * from qna_lst where userid = ? and gubun = 'QNA' OR quizid IN (select quizid from qna_lst where userid = ? and gubun = 'QNA' ) ORDER BY regdate ASC ";
		DecimalFormat formatter = new DecimalFormat("#,###");
		DateFormat dateFormater = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		
		try{	      
			
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,userid);
			pstmt.setString(2,userid);
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
				hsm.put("class_name", (userid.equals(rs.getString("userid")) ? "inquiry_admin" : "inquiry_user"));
				
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
	
	public boolean updateReceivedMessages(String userid) throws SQLException {
		boolean result = false;
		Connection con 			= null;
		PreparedStatement pstmt = null;
		int sts = 0;
		String  query 			= "UPDATE qna_lst SET viewdate = ? WHERE qnaid IN (SELECT qnaid FROM qna_lst WHERE writer =  'A' and viewdate IS NULL AND quizid IN (SELECT quizid from qna_lst WHERE userid = ? and gubun = 'QNA' ))";		
		Date date = new Date();
		try {
			Context initContext = new InitialContext();
			DBConnector.getInstance();
			con = DBConnector.getConnection();
		    pstmt   			= con.prepareStatement(query);
            pstmt.setString(1, sdf.format(date));
            pstmt.setString(2, userid);
			sts = pstmt.executeUpdate();
			System.out.println(sts);
			System.out.println("updated msg_lst ");
	        pstmt.close();
	        con.close();
	        if (sts > 0) {
				result = true;
			}
		}
		catch(Exception e) {
			System.out.println(e);
			logger.debug(e);
		}
		
		if(sts > 0 ) result = true;
		
		return result;
	}
}
