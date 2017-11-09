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

import bean.MessageBean;
import bean.UserBean;
import net.vavasoft.util.DBConnector;

public class MessageDao {
	private static final DateFormat	sdf		= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static Logger			logger	= Logger.getLogger(MessageDao.class);

	public List<HashMap> getMessage(String userid) {
		List<HashMap> data = new ArrayList<HashMap>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT * FROM msg_lst WHERE recv_userid = ? OR send_userid = ? AND gubun = 'MSG' ORDER BY send_date ASC";

		DateFormat dateFormater = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		try {

			Context initContext = new InitialContext();
			DBConnector.getInstance();
			con = DBConnector.getConnection();
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userid);
			pstmt.setString(2, userid);

			rs = pstmt.executeQuery();
			System.out.println(query);

			while (rs.next()) {
				HashMap<String, Object> hsm = new HashMap<String, Object>();
				hsm.put("msgid", rs.getInt("msgid"));
				hsm.put("recv_siteid", rs.getInt("recv_siteid"));
				hsm.put("recv_userid", rs.getString("recv_userid"));
				hsm.put("recv_date", (rs.getString("recv_date") != null
				        ? dateFormater.format(dateFormater.parse(rs.getString("recv_date"))) : ""));
				hsm.put("send_userid", rs.getString("send_userid"));
				hsm.put("gubun", rs.getString("gubun"));
				hsm.put("viewtype", rs.getString("viewtype"));
				hsm.put("send_date", (rs.getString("send_date") != null
				        ? dateFormater.format(dateFormater.parse(rs.getString("send_date"))) : ""));
				hsm.put("title", (rs.getString("title")));
				hsm.put("txt", (rs.getString("txt")));
				hsm.put("class_name", (userid.equals(rs.getString("send_userid")) ? "inquiry_admin" : "inquiry_user"));
				data.add(hsm);
			}

			rs.close();
			pstmt.close();
			con.close();

			System.out.println(data);

		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
		}

		return data;

	}

	public boolean setMessage(MessageBean mBean) throws SQLException {
		Connection con = null;
		Statement stmt = null;
		PreparedStatement pstmt = null;
		int row = 0;
		boolean result = false;

		try {

			DBConnector.getInstance();
			con = DBConnector.getConnection();
			Date date = new Date();
			String query = "INSERT INTO RT01.dbo.msg_lst (send_siteid,send_userid,gubun,viewtype,send_date,txt) "
			        + " VALUES (1,?,'MSG','N',?,?)";

			pstmt = con.prepareStatement(query);
			pstmt.setString(1, mBean.getSend_userid());
			pstmt.setString(2, sdf.format(date));
			pstmt.setString(3, mBean.getTxt());

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

	public boolean updateReceivedMessages(String userid) throws SQLException {
		boolean result = false;
		Connection con 			= null;
		PreparedStatement pstmt = null;
		int sts = 0;
		String  query 			= "UPDATE msg_lst SET recv_date = ? , viewtype = 'Y' WHERE send_userid = ? OR recv_userid = ?  AND viewtype = 'N'";		
		Date date = new Date();
		try {
			Context initContext = new InitialContext();
			DBConnector.getInstance();
			con = DBConnector.getConnection();
		    pstmt   			= con.prepareStatement(query);
            pstmt.setString(1, sdf.format(date));
            pstmt.setString(2, userid);
            pstmt.setString(3, userid);
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
