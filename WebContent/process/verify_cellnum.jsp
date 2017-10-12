<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "net.vavasoft.dao.SmsDao"%>
<%@ page import = "java.util.StringTokenizer"%>
<%
	SmsDao sd = new SmsDao();
	String cell = request.getParameter("cell").trim();
	String cell_prefix = request.getParameter("cell_prefix").trim();

	// if(cell.substring(1).length() == 10 && cell.substring(0,1).equals("0") && cell_prefix.equals("+63")){
	// 	cell = cell.substring(1);
	// }

	String cell_no = cell_prefix + cell;
	boolean res = sd.checkActiveNumber(cell_prefix,cell);

	if(res){
		out.println(false);
	}else{
		out.println(true);
	}
%>