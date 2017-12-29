<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
<%@ page import="java.util.*"%>
<%@ page import ="bean.UserBean" %>
<%@ page import ="dao.UserDao" %>
<%@ page import ="bean.UserBean" %>
<%@page import="com.google.gson.Gson"%>

<%@ include file="/inc/session.jsp"%>

<%
	UserDao ud = new UserDao();	
	String amt="";
	
	if(request.getParameter("withdraw") != null && request.getParameter("withdraw").trim().length() > 0){
   		amt =request.getParameter("withdraw") ;
	}
	
	boolean result = ud.withdraw(SITEID,UID,ce.d(amt),IP);
	out.println(result);	
%>
