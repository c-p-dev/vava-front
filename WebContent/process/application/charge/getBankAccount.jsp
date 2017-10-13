<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
<%@ page import ="net.vavasoft.bean.ChargeBean" %>
<%@ page import ="net.vavasoft.dao.ChargeDao" %>
<%@ page import ="net.vavasoft.bean.UserBean" %>
<%@ page import ="net.vavasoft.dao.UserDao,java.sql.SQLException" %>

<%
	if(session.getAttribute("currentSessionUser") != null){
		UserBean userBean = (UserBean) session.getAttribute("currentSessionUser");	
		UserDao userDao = new UserDao();
		String bank_info = userDao.getUserBankConfigAccount(userBean.getSiteid(),userBean.getCharge_level());
		out.println(bank_info);
	}
	
%>