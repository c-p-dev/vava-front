<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="
	net.vavasoft.bean.SmsAuthBean,
	net.vavasoft.dao.SmsDao,
	net.vavasoft.controller.SmsController,
	java.util.StringTokenizer;" %>
<%
	SmsAuthBean smsBean = new SmsAuthBean();
	SmsController smsCon = new SmsController();

	String cell = request.getParameter("cell").trim();
	String cell_prefix = request.getParameter("cell_prefix").trim();

	if(cell.substring(1).length() == 10 && cell.substring(0,1).equals("0") && cell_prefix.equals("+63")){
		cell = cell.substring(1);
	}
	
	smsBean.setTel(cell_prefix + cell);

	boolean res = smsCon.checkDuplicateNumber(smsBean);
	if(res){
		out.println(false);
	}else{
		out.println(true);
	}


	

%>