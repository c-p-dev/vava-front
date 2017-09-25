<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="
	net.vavasoft.bean.UserBean,
	net.vavasoft.dao.UserDao,
	java.sql.SQLException,
	java.util.ArrayList,
	java.util.List,
	com.google.gson.reflect.TypeToken,
	java.util.StringTokenizer,
	com.google.gson.Gson;" %>

<%
	if(session.getAttribute("currentSessionUser") == null){
		System.out.println("not logged in");
		response.sendRedirect("/index.jsp"); // if no session redirect to index 
		return;
	}
%>	