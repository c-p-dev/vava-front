<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="
	net.vavasoft.bean.UserBean,
	net.vavasoft.dao.UserDao,
	net.vavasoft.controller.SmsController,
	java.util.StringTokenizer,
	net.vavasoft.bean.SmsAuthBean;" %>
<%
	SmsAuthBean sab = new SmsAuthBean();

	String tel =  request.getParameter("cell_prefix").trim() +  request.getParameter("cell").trim();	

	String cell = request.getParameter("cell").trim();
	String cell_prefix = request.getParameter("cell_prefix").trim();

	if(cell.substring(1).length() == 10 && cell.substring(0,1).equals("0") && cell_prefix.equals("+63")){
		cell = cell.substring(1);
	}
	sab.setTel(cell_prefix.substring(1) + cell);
	sab.setAuthcode(request.getParameter("cert").trim());
	
	
	SmsController sm = new SmsController();
	boolean result = sm.verifyAuthCode(sab);

	out.println(result);
%>