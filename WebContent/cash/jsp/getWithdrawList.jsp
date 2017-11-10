<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>

<%@ page import = "bean.UserBean" %>
<%@ page import = "dao.UserDao" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.List" %>
<%@ page import = "com.google.gson.reflect.TypeToken" %>
<%@ page import = "java.util.StringTokenizer" %>
<%@ page import = "com.google.gson.Gson" %>

<%
	if(session.getAttribute("currentSessionUser") != null){
		Gson gson = new Gson();
		UserBean bean = (UserBean) session.getAttribute("currentSessionUser");
		UserDao ud = new UserDao();
		List res = ud.getWithdrawList(bean.getUserid());
		
		out.println(gson.toJson(res).toString());
	}	
%>


