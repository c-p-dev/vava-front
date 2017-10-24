<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "net.vavasoft.dao.SmsDao" %>
<%
	SmsDao sd = new SmsDao();
	String nickname = request.getParameter("nick").trim();
	String cell_prefix = request.getParameter("cell_prefix").trim();
	String cell = request.getParameter("cell").trim();
	boolean res = sd.sendSmsByNickname(nickname,cell_prefix,cell);
	out.println(res);


%>
