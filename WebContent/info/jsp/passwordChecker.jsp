<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "bean.UserBean" %>
<%@ page import = "dao.UserDao" %>
<%@ include file="/inc/session.jsp" %>	

<%
	
	UserDao ud = new UserDao();
	String passwd = request.getParameter("passwd").trim();
	boolean result = ud.checkUserPassword(UID, passwd);

	out.println(result);	
%>







