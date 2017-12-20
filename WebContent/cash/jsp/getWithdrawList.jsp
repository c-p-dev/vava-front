<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>

<%@ page import = "bean.UserBean" %>
<%@ page import = "dao.UserDao" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.List" %>
<%@ page import = "com.google.gson.reflect.TypeToken" %>
<%@ page import = "java.util.StringTokenizer" %>
<%@ page import = "com.google.gson.Gson" %>


<%@ include file="/inc/session.jsp"%>

<%
		Gson gson = new Gson();
		UserDao ud = new UserDao();
		List res = ud.getWithdrawList(UID);
		
		out.println(gson.toJson(res).toString());
	
%>


