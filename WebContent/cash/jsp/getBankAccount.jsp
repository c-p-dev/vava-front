<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
<%@ page import ="bean.ChargeBean" %>
<%@ page import ="dao.ChargeDao" %>
<%@ page import ="bean.UserBean" %>
<%@ page import ="dao.UserDao,java.sql.SQLException" %>
<%@ include file="/inc/session_checker.jsp"%>

<%
	
	UserDao userDao = new UserDao();
	UserBean userBean = (UserBean) userDao.getUserByUserId(UID);	
	String bank_info = userDao.getUserBankConfigAccount(userBean.getSiteid(),userBean.getCharge_level());
	out.println(bank_info);
	
	
%>