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

public class MessageDao {
	private static final DateFormat	sdf		= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static Logger			logger	= Logger.getLogger(MessageDao.class);

	public List<HashMap> getUserQnaList(String userid){
		List<HashMap> data = new ArrayList<HashMap>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT '°ü¸®ÀÚ' as send_userid1, * FROM msg_lst WHERE recv_userid = ? AND gubun = 'MSG' AND viewtype='Y' ORDER BY send_date ASC";
		


		DateFormat dateFormater = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		try {

			Context initContext = new InitialContext();
			DBConnector.getInstance();
			con = DBConnector.getConnection();
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userid);

			rs = pstmt.executeQuery();
			System.out.println(query);

			while (rs.next()) {
				HashMap<String, Object> hsm = new HashMap<String, Object>();
				hsm.put("msgid", rs.getInt("msgid"));
				hsm.put("recv_siteid", rs.getInt("recv_siteid"));
				hsm.put("recv_userid", rs.getString("recv_userid"));
				hsm.put("recv_date", (rs.getString("recv_date") != null
				        ? dateFormater.format(dateFormater.parse(rs.getString("recv_date"))) : ""));
				hsm.put("send_userid", rs.getString("send_userid1"));
				hsm.put("gubun", rs.getString("gubun"));
				hsm.put("viewtype", rs.getString("viewtype"));
				hsm.put("send_date", (rs.getString("send_date") != null
				        ? dateFormater.format(dateFormater.parse(rs.getString("send_date"))) : ""));
				hsm.put("title", (rs.getString("title") != null ? rs.getString("title") : "    "));
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
}
