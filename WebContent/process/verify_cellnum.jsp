<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="
	net.vavasoft.bean.SmsAuthBean,
	net.vavasoft.dao.SmsDao,
	net.vavasoft.controller.SmsController,
	java.util.StringTokenizer;" %>
<%
	SmsAuthBean smsBean = new SmsAuthBean();
	SmsController smsCon = new SmsController();
	smsBean.setTel(request.getParameter("cell_prefix").substring(1) + request.getParameter("cell"));
	boolean res = smsCon.checkDuplicateNumber(smsBean);
	if(res){
		out.println(false);
	}else{
		out.println(true);
	}

	

%>