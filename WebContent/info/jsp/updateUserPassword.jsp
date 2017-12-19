<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import = "bean.UserBean" %>
<%@ page import = "dao.UserDao" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.List" %>
<%@ page import = "com.google.gson.reflect.TypeToken" %>
<%@ page import = "java.util.StringTokenizer" %>

<%@ include file="/inc/session.jsp" %>	

<%
	
	
 	UserDao ud = new UserDao();
	boolean result = false;
	
	String current_passwd = request.getParameter("current_password").trim();
	String new_passwd = request.getParameter("new_passowrd").trim();

	result = ud.updateUserPasswd(UID,current_passwd,new_passwd);
	out.println(result);

	
%>








