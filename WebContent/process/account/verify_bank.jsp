<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "net.vavasoft.dao.UserDao" %>
<%
	UserDao ud = new UserDao();
	String bo = request.getParameter("bo");
	String bn = request.getParameter("bn");
	String bnn = request.getParameter("bnn");
	String cp = request.getParameter("cp");
	String cll = request.getParameter("cll");
	String res = ud.getUserIdByBank(bo,bn,bnn,cp,cll);
	out.println(res);


%>
