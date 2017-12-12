<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="bean.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import = "com.google.gson.Gson" %>

<%

	boolean checkSession = false;	
	boolean validUser = false;
	boolean inValidIp = false;		
	Gson gson = new Gson();
	HashMap<String, Object> hsm = new HashMap<String, Object>();

	
	if(session.getAttribute("currentSessionUser") != null){
		checkSession = true;

		UserDao user_db 	=  new UserDao();
		UserBean sess_data 	=  (UserBean) session.getAttribute("currentSessionUser");		
		UserBean bean 		=  user_db.getUserByUserId(sess_data.getUserid());
		
		if(bean.getSess().equals(session.getId())){
			validUser = true;
		}
	}

	hsm.put("result",checkSession);
	hsm.put("validUser",validUser);
	out.println(gson.toJson(hsm).toString());
	
	
	
%>

