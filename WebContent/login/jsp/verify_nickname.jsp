<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "net.vavasoft.dao.UserDao"%>
<%@ page import = "java.util.StringTokenizer"%>
<%
	UserDao ud = new UserDao();
	String nick = request.getParameter("nickname").trim();
	boolean res = ud.checkNickname(nick);
	out.print(res);
%>