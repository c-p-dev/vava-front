<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.vavasoft.bean.UserBean,net.vavasoft.dao.UserDao,java.sql.SQLException,net.vavasoft.bean.JoinCodeBean,net.vavasoft.dao.JoinCodeDao;" %>
<%
	
	UserDao ud = new UserDao();
	JoinCodeDao jcDao = new JoinCodeDao();
	String recommend = request.getParameter("referrer").trim();
	String joincode = request.getParameter("recommend").trim();


	boolean result = jcDao.checkJoinCode(recommend, joincode);
	System.out.println(result);
	out.println(result);
%>