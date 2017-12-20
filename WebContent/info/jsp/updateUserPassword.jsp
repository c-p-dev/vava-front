<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "bean.UserBean" %>
<%@ page import = "dao.UserDao" %>
<%@ include file="/inc/session.jsp" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import ="java.util.HashMap" %>		

<%
	 	UserDao ud = new UserDao();
		
		String current_passwd = request.getParameter("current_password").trim();
		String new_passwd = request.getParameter("new_passowrd").trim();

		Gson gson = new Gson();
		HashMap<String, Object> hsm = new HashMap<String, Object>();
		
		boolean result = ud.updateUserPasswd(UID, current_passwd,new_passwd);
		
		hsm.put("result", result);
		out.println(gson.toJson(hsm).toString());

	
%>








