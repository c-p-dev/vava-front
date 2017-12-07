package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.log4j.Logger;

import bean.NoticeEventBean;
import util.DBConnector;

public class NoticeEventDao {
	
	private static final DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static Logger logger = Logger.getLogger(NoticeEventDao.class);
	
	public List<NoticeEventBean> getAllNoticeEvents() {
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
//		String  query 			= "SELECT * FROM bbs_lst WHERE begindate IS NOT NULL AND enddate IS  NOT NULL AND gubun ='NOTICE' OR gubun='EVENT' AND viewtype='Y' AND (enddate >= CAST (GETDATE() AS DATE) AND begindate <= CAST (GETDATE() AS DATE))";
		String  query 			= "SELECT * FROM bbs_lst WHERE  gubun ='NOTICE' OR gubun='EVENT' AND viewtype='Y' ORDER BY vieworder asc";
	
		
		List<NoticeEventBean>	ne_list = new ArrayList<>();
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    pstmt   			= con.prepareStatement(query);
			rs 					= pstmt.executeQuery();
            
            while (rs.next()) {
            	
            	NoticeEventBean ne_bean = new NoticeEventBean();
            	
            	ne_bean.setBbsid(rs.getInt("bbsid"));
            	
            	ne_bean.setSiteid(rs.getInt("siteid"));
            	ne_bean.setAdminid(rs.getString("adminid"));
            	ne_bean.setNick(rs.getString("nick"));
            	ne_bean.setTitle(rs.getString("title"));
            	ne_bean.setTxt(rs.getString("txt"));
            	ne_bean.setBegindate(rs.getString("begindate"));
            	ne_bean.setEnddate(rs.getString("enddate"));
            	ne_bean.setRegdate(rs.getString("regdate"));
            	ne_bean.setEditdate(rs.getString("editdate"));
            	ne_bean.setVieworder(rs.getInt("vieworder"));
            	ne_bean.setViewout(rs.getString("viewout"));
            	ne_bean.setViewtype(rs.getString("viewtype"));
            	ne_bean.setGubun(rs.getString("gubun"));
            	ne_bean.setKind(rs.getString("kind"));
            	ne_bean.setPopup_kind(rs.getString("popup_kind"));
            	ne_bean.setTarget(rs.getString("target"));
            	ne_bean.setLink(rs.getString("link"));
            	ne_bean.setWidth(rs.getInt("width"));
            	ne_bean.setHeight(rs.getInt("height"));
            	ne_bean.setPos_left(rs.getInt("pos_left"));
            	ne_bean.setScroll_yn(rs.getString("scroll_yn"));
            	ne_bean.setDevice(rs.getString("device"));
            	ne_bean.setImg(rs.getString("img"));
            	
            	ne_list.add(ne_bean);
            }
            
            rs.close();
	        pstmt.close();
	        con.close();
	        
	        
		}
		catch(Exception e) {
			System.out.println(e);
		}
		
		return ne_list;
		
	}
	
	public List<NoticeEventBean> getAllNotice() {
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
//		String  query 			= "SELECT * FROM bbs_lst WHERE begindate IS NOT NULL AND enddate IS  NOT NULL AND gubun ='NOTICE' AND viewtype='Y' AND (enddate >= CAST (GETDATE() AS DATE) AND begindate <= CAST (GETDATE() AS DATE))" ;
		String  query 			= "SELECT * FROM bbs_lst WHERE gubun ='NOTICE' AND viewtype='Y' ORDER BY vieworder asc " ;
		List<NoticeEventBean>	ne_list = new ArrayList<>();
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    pstmt   			= con.prepareStatement(query);
			rs 					= pstmt.executeQuery();
            
            while (rs.next()) {
            	
            	NoticeEventBean ne_bean = new NoticeEventBean();
            	
            	ne_bean.setBbsid(rs.getInt("bbsid"));
            	
            	ne_bean.setSiteid(rs.getInt("siteid"));
            	ne_bean.setAdminid(rs.getString("adminid"));
            	ne_bean.setNick(rs.getString("nick"));
            	ne_bean.setTitle(rs.getString("title"));
            	ne_bean.setTxt(rs.getString("txt"));
            	ne_bean.setBegindate(rs.getString("begindate"));
            	ne_bean.setEnddate(rs.getString("enddate"));
            	ne_bean.setRegdate(rs.getString("regdate"));
            	ne_bean.setEditdate(rs.getString("editdate"));
            	ne_bean.setVieworder(rs.getInt("vieworder"));
            	ne_bean.setViewout(rs.getString("viewout"));
            	ne_bean.setViewtype(rs.getString("viewtype"));
            	ne_bean.setGubun(rs.getString("gubun"));
            	ne_bean.setKind(rs.getString("kind"));
            	ne_bean.setPopup_kind(rs.getString("popup_kind"));
            	ne_bean.setTarget(rs.getString("target"));
            	ne_bean.setLink(rs.getString("link"));
            	ne_bean.setWidth(rs.getInt("width"));
            	ne_bean.setHeight(rs.getInt("height"));
            	ne_bean.setPos_left(rs.getInt("pos_left"));
            	ne_bean.setScroll_yn(rs.getString("scroll_yn"));
            	ne_bean.setDevice(rs.getString("device"));
            	ne_bean.setImg(rs.getString("img"));
            	
            	ne_list.add(ne_bean);
            }
            
            rs.close();
	        pstmt.close();
	        con.close();
	        
	        
		}
		catch(Exception e) {
			System.out.println(e);
		}
		
		return ne_list;
		
	}
	
	public List<NoticeEventBean> getAllEvent() {
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
//		String  query 			= "SELECT * FROM bbs_lst WHERE begindate IS NOT NULL AND enddate IS  NOT NULL AND gubun='EVENT' AND viewtype='Y' AND (enddate >= CAST (GETDATE() AS DATE) AND begindate <= CAST (GETDATE() AS DATE)) " ;
		String  query  = "SELECT * FROM bbs_lst WHERE  gubun='EVENT' AND viewtype='Y' ORDER BY vieworder asc";
		List<NoticeEventBean>	ne_list = new ArrayList<>();
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    pstmt   			= con.prepareStatement(query);
			rs 					= pstmt.executeQuery();
            
            while (rs.next()) {
            	
            	NoticeEventBean ne_bean = new NoticeEventBean();
            	
            	ne_bean.setBbsid(rs.getInt("bbsid"));
            	
            	ne_bean.setSiteid(rs.getInt("siteid"));
            	ne_bean.setAdminid(rs.getString("adminid"));
            	ne_bean.setNick(rs.getString("nick"));
            	ne_bean.setTitle(rs.getString("title"));
            	ne_bean.setTxt(rs.getString("txt"));
            	ne_bean.setBegindate(rs.getString("begindate"));
            	ne_bean.setEnddate(rs.getString("enddate"));
            	ne_bean.setRegdate(rs.getString("regdate"));
            	ne_bean.setEditdate(rs.getString("editdate"));
            	ne_bean.setVieworder(rs.getInt("vieworder"));
            	ne_bean.setViewout(rs.getString("viewout"));
            	ne_bean.setViewtype(rs.getString("viewtype"));
            	ne_bean.setGubun(rs.getString("gubun"));
            	ne_bean.setKind(rs.getString("kind"));
            	ne_bean.setPopup_kind(rs.getString("popup_kind"));
            	ne_bean.setTarget(rs.getString("target"));
            	ne_bean.setLink(rs.getString("link"));
            	ne_bean.setWidth(rs.getInt("width"));
            	ne_bean.setHeight(rs.getInt("height"));
            	ne_bean.setPos_left(rs.getInt("pos_left"));
            	ne_bean.setScroll_yn(rs.getString("scroll_yn"));
            	ne_bean.setDevice(rs.getString("device"));
            	ne_bean.setImg(rs.getString("img"));
            	
            	ne_list.add(ne_bean);
            }
            
            rs.close();
	        pstmt.close();
	        con.close();
	        
	        
		}
		catch(Exception e) {
			System.out.println(e);
		}
		
		return ne_list;
		
	}
	
	public List<NoticeEventBean> getAllPopup() {
		
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		String  query 			= "SELECT * FROM bbs_lst WHERE begindate IS NOT NULL AND enddate IS  NOT NULL AND gubun='POPUP' AND viewtype='Y' AND (enddate >= CAST (GETDATE() AS DATE) AND begindate <= CAST (GETDATE() AS DATE)) " ;
		//String  query 			= "SELECT * FROM bbs_lst WHERE gubun='POPUP' AND viewtype='Y'" ;
		List<NoticeEventBean>	ne_list = new ArrayList<>();
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    pstmt   			= con.prepareStatement(query);
			rs 					= pstmt.executeQuery();
            
            while (rs.next()) {
            	
            	NoticeEventBean ne_bean = new NoticeEventBean();
            	
            	ne_bean.setBbsid(rs.getInt("bbsid"));
            	ne_bean.setSiteid(rs.getInt("siteid"));
            	ne_bean.setAdminid(rs.getString("adminid"));
            	ne_bean.setNick(rs.getString("nick"));
            	ne_bean.setTitle(rs.getString("title"));
            	ne_bean.setTxt(rs.getString("txt"));
            	ne_bean.setBegindate(rs.getString("begindate"));
            	ne_bean.setEnddate(rs.getString("enddate"));
            	ne_bean.setRegdate(rs.getString("regdate"));
            	ne_bean.setEditdate(rs.getString("editdate"));
            	ne_bean.setVieworder(rs.getInt("vieworder"));
            	ne_bean.setViewout(rs.getString("viewout"));
            	ne_bean.setViewtype(rs.getString("viewtype"));
            	ne_bean.setGubun(rs.getString("gubun"));
            	ne_bean.setKind(rs.getString("kind"));
            	ne_bean.setPopup_kind(rs.getString("popup_kind"));
            	ne_bean.setTarget(rs.getString("target"));
            	ne_bean.setLink(rs.getString("link"));
            	ne_bean.setWidth(rs.getInt("width"));
            	ne_bean.setHeight(rs.getInt("height"));
            	ne_bean.setPos_left(rs.getInt("pos_left"));
            	ne_bean.setScroll_yn(rs.getString("scroll_yn"));
            	ne_bean.setDevice(rs.getString("device"));
            	ne_bean.setImg(rs.getString("img"));
            	
            	ne_list.add(ne_bean);
            }
            
            rs.close();
	        pstmt.close();
	        con.close();
	        
	        
		}
		catch(Exception e) {
			System.out.println(e);
		}
		
		return ne_list;
		
	}
	
	public List<NoticeEventBean> getAllBanner() {
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		String query = "SELECT * FROM bbs_lst WHERE begindate IS NOT NULL AND enddate IS  NOT NULL AND gubun='BANNER' AND viewtype='Y'  AND kind='MAIN' AND (enddate >= CAST (GETDATE() AS DATE) AND begindate <= CAST (GETDATE() AS DATE)) ORDER BY vieworder asc";
		List<NoticeEventBean>	ne_list = new ArrayList<>();
		
		try {
			DBConnector.getInstance();
			con 				= DBConnector.getConnection();
		    pstmt   			= con.prepareStatement(query);
			rs 					= pstmt.executeQuery();
            
            while (rs.next()) {
            	
            	NoticeEventBean ne_bean = new NoticeEventBean();
            	
            	ne_bean.setBbsid(rs.getInt("bbsid"));
            	
            	ne_bean.setSiteid(rs.getInt("siteid"));
            	ne_bean.setAdminid(rs.getString("adminid"));
            	ne_bean.setNick(rs.getString("nick"));
            	ne_bean.setTitle(rs.getString("title"));
            	ne_bean.setTxt(rs.getString("txt"));
            	ne_bean.setBegindate(rs.getString("begindate"));
            	ne_bean.setEnddate(rs.getString("enddate"));
            	ne_bean.setRegdate(rs.getString("regdate"));
            	ne_bean.setEditdate(rs.getString("editdate"));
            	ne_bean.setVieworder(rs.getInt("vieworder"));
            	ne_bean.setViewout(rs.getString("viewout"));
            	ne_bean.setViewtype(rs.getString("viewtype"));
            	ne_bean.setGubun(rs.getString("gubun"));
            	ne_bean.setKind(rs.getString("kind"));
            	ne_bean.setPopup_kind(rs.getString("popup_kind"));
            	ne_bean.setTarget(rs.getString("target"));
            	ne_bean.setLink(rs.getString("link"));
            	ne_bean.setWidth(rs.getInt("width"));
            	ne_bean.setHeight(rs.getInt("height"));
            	ne_bean.setPos_left(rs.getInt("pos_left"));
            	ne_bean.setScroll_yn(rs.getString("scroll_yn"));
            	ne_bean.setDevice(rs.getString("device"));
            	ne_bean.setImg(rs.getString("img"));
            	
            	ne_list.add(ne_bean);
            }
            
            rs.close();
	        pstmt.close();
	        con.close();
	        
	        
		}
		catch(Exception e) {
			System.out.println(e);
		}
		
		return ne_list;
		
	}

}
