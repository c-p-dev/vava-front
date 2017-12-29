<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>

<%@ page import = "bean.UserBean" %>
<%@ page import = "dao.UserDao" %>
<%@ page import = "java.sql.SQLException" %>

<%
	UserDao ud = new UserDao();
	UserBean uBean = new UserBean();
	uBean.setUserid(request.getParameter("referrer").trim());
	//System.out.println(request.getParameter("referrer").trim());
	boolean res  = ud.checkUserId(uBean);
	//System.out.println(res);
	out.println(res);
%>
