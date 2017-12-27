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
import bean.QnaBean;
public class QnaDao {
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
			String query = "INSERT INTO RT01.dbo.qna_lst (siteid, userid, txt, gubun, viewtype, regdate, writer, ip, quizid) VALUES (?,?,?,'QNA','Y',GETDATE(),'U',?,IDENT_CURRENT('RT01.dbo.qna_lst'))";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, qBean.getSiteid());
			pstmt.setString(2, qBean.getUserid());
			pstmt.setString(3, qBean.getTxt());
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
		} catch (Exception e) {
			e.printStackTrace();
			return false;

		} finally {
			if (stmt != null)
				stmt.close();
			if (con != null)
				con.close();
		}
		
		return result;
	}
	
	public List<HashMap> getMessage(QnaBean qBean) {
		Gson gson = new Gson();
		List<HashMap> list = new ArrayList<HashMap>();
		String result = "";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT title,REPLACE(txt,CHAR(10),'<br>') txt,viewtype,writer,ip,quizid,gubun,userid, convert(char(19),regdate,120) regdate, isnull(convert(char(19),ansdate,120),0) ansdate FROM qna_lst WHERE userid = ? AND gubun = 'QNA' OR quizid IN (select quizid from qna_lst where userid = ? and gubun = 'QNA' ) AND siteid = ? ORDER BY regdate ASC ";
		
		try{	      
			
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,qBean.getUserid());
			pstmt.setString(2,qBean.getUserid());
			pstmt.setInt(3,qBean.getSiteid());
			rs = pstmt.executeQuery();
					   
			while(rs.next()){
				HashMap<String, Object> hsm = new HashMap<String, Object>();
				hsm.put("title", (rs.getString("title") == null ? "" : rs.getString("title")));
				hsm.put("regdate", rs.getString("regdate"));
				hsm.put("ansdate", rs.getString("ansdate"));
				hsm.put("txt", (rs.getString("txt") == null ? "" : rs.getString("txt")));
				hsm.put("viewtype", (rs.getString("viewtype") == null ?  "" :  rs.getString("viewtype") ));
				hsm.put("writer", (rs.getString("writer") == null ?  "" :  rs.getString("writer") ));
				hsm.put("ip", (rs.getString("ip") == null ?  null :  rs.getString("ip") ));
				hsm.put("quizid", (rs.getString("quizid") == null ?  "" :  rs.getString("quizid") ));
				hsm.put("gubun", (rs.getString("gubun") == null ?  "" :  rs.getString("gubun") ));
				hsm.put("userid", (rs.getString("userid") == null ?  "" :  rs.getString("userid") ));
				hsm.put("class_name", (qBean.getUserid().equals(rs.getString("userid")) ? "inquiry_admin" : "inquiry_user"));
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
	
	public boolean updateReceivedMessages(QnaBean qBean) throws SQLException {
		boolean result = false;
		Connection con 			= null;
		PreparedStatement pstmt = null;
		int sts = 0;
		String  query = "UPDATE qna_lst SET viewdate = GETDATE()  WHERE qnaid IN (SELECT qnaid FROM qna_lst WHERE writer =  'A' and viewdate IS NULL AND quizid IN (SELECT quizid from qna_lst WHERE userid = ? and gubun = 'QNA' )) AND siteid = ?";		
		try {
			
			Context initContext = new InitialContext();
			DBConnector.getInstance();
			con = DBConnector.getConnection();
		    pstmt = con.prepareStatement(query);
            pstmt.setString(1, qBean.getUserid());
            pstmt.setInt(2,qBean.getSiteid());
			
            sts = pstmt.executeUpdate();
			
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
