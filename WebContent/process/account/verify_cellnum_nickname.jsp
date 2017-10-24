<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "net.vavasoft.dao.UserDao"%>
<%@ page import = "java.util.StringTokenizer"%>
<%
	UserDao ud = new UserDao();
	String cell = request.getParameter("cell").trim();
	String cell_prefix = request.getParameter("cell_prefix").trim();
	String nick = request.getParameter("nick").trim();
	boolean res = ud.checkCellNumByNick(nick,cell_prefix,cell);
	out.println(res);

%>