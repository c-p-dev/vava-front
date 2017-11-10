<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import = "bean.UserBean" %>
<%@ page import = "dao.UserDao" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "bean.JoinCodeBean" %>
<%@ page import = "dao.JoinCodeDao" %>

<%
	
	UserDao ud = new UserDao();
	JoinCodeDao jcDao = new JoinCodeDao();
	String recommend = request.getParameter("referrer").trim();
	String joincode = request.getParameter("recommend").trim();


	boolean result = jcDao.checkJoinCode(recommend, joincode);
	System.out.println(result);
	out.println(result);
%>





