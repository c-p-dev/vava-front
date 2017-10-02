<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="
	net.vavasoft.bean.UserBean,
	net.vavasoft.dao.UserDao,
	net.vavasoft.controller.SmsController,
	java.util.StringTokenizer,
	net.vavasoft.bean.SmsAuthBean;" %>
<%
	SmsAuthBean sab = new SmsAuthBean();

	String tel =  request.getParameter("cell_prefix").trim() +  request.getParameter("cell").trim();	
	sab.setAuthcode(request.getParameter("cert").trim());
	sab.setTel(tel.replace("+",""));
	
	SmsController sm = new SmsController();
	boolean result = sm.verifyAuthCode(sab);

	out.println(result);
%>