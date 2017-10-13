<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "net.vavasoft.bean.UserBean" %>
<%@ page import = "net.vavasoft.dao.UserDao" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.List" %>
<%@ page import = "com.google.gson.reflect.TypeToken" %>
<%@ page import = "java.util.StringTokenizer" %>
<%@ page import = "com.google.gson.Gson" %>

<%
	if(session.getAttribute("currentSessionUser") == null){
		System.out.println("not logged in");
		response.sendRedirect("/index.jsp"); // if no session redirect to index 
		return;
	}
%>	









