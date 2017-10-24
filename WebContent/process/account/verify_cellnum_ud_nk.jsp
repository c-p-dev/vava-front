<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "net.vavasoft.dao.UserDao"%>
<%
	UserDao ud = new UserDao();
	String cell = request.getParameter("cll");
	String cell_prefix = request.getParameter("cp");
	String nick = request.getParameter("nk");
	String userid = request.getParameter("ud");
	boolean res = ud.checkCellNumByUseridNick(userid, nick,cell_prefix,cell);
	out.println(res);

%>