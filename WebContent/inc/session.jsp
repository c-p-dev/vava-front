<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="bean.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.text.DecimalFormat" %>

<%
	boolean checkSession = false;		
	String UID = "";
	String SITEID = "1";
	String UCLEVEL = "";
	String NICK = "";
	int UBAL = 0;
	int UPOINT = 0;
	String IP = request.getRemoteAddr();
	
	if(session.getAttribute("currentSessionUser") != null){
		UserDao user_db 	=  new UserDao();
		UserBean sess_data 	=  (UserBean) session.getAttribute("currentSessionUser");
		UserBean bean 		=  user_db.getUserByUserId(sess_data.getUserid());
		
		checkSession = true;
		SITEID = String.valueOf(bean.getSiteid());
		UID = bean.getUserid();		
		UCLEVEL = bean.getCharge_level(); 
		NICK = bean.getNick();
		UBAL = bean.getMoney();
		UPOINT = bean.getPoint();
		IP = bean.getIp();
		
		//out.print(bean.getNick());  
	}
	
	DecimalFormat dfrmt	= new DecimalFormat("#,###,###,###,###");
	
%>

