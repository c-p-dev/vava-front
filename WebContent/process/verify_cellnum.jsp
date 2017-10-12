<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "net.vavasoft.dao.SmsDao"%>
<%@ page import = "java.util.StringTokenizer"%>
<%
	SmsDao sd = new SmsDao();
	String cell = request.getParameter("cell").trim();
	String cell_prefix = request.getParameter("cell_prefix").trim();

	boolean res = sd.checkActiveNumber(cell_prefix,cell);
	if(res){
		out.println(false);
	}else{
		out.println(true);
	}
%>