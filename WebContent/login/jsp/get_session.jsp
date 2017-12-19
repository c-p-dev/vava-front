<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="bean.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import = "com.google.gson.Gson" %>


<%@ include file="/inc/session.jsp" %>	

<%	
	boolean SSID = false;
		
	Gson gson = new Gson();
	HashMap<String, Object> hsm = new HashMap<String, Object>();

	if(UID != null){
			UserDao user_db 	=  new UserDao();
			SSID = user_db.getUserSSID(SITEID,UID,session.getId());
	}

	hsm.put("validUser",SSID);
	out.println(gson.toJson(hsm).toString());
%>

