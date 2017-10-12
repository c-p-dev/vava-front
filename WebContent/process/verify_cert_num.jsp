<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import = "net.vavasoft.bean.UserBean"%>
<%@ page import = "net.vavasoft.dao.UserDao"%>
<%@ page import = "net.vavasoft.dao.SmsDao"%>
<%
	SmsDao sd = new SmsDao();
	String cell = request.getParameter("cell").trim();
	String cell_prefix = request.getParameter("cell_prefix").trim();
	String authcode = request.getParameter("cert").trim();

	// if(cell.substring(1).length() == 10 && cell.substring(0,1).equals("0") && cell_prefix.equals("+63")){
	// 	cell = cell.substring(1);
	// }
	
	// String cell_no = cell_prefix + cell;
	boolean result = sd.checkAuthCode(cell_prefix,cell,authcode);

	out.println(result);
%>