<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" 
	import="net.vavasoft.bean.ChargeBean,
	net.vavasoft.dao.ChargeDao,
	net.vavasoft.bean.UserBean,
	net.vavasoft.dao.UserDao,java.sql.SQLException;" %>
<%
	if(session.getAttribute("currentSessionUser") != null){
		UserBean userBean = (UserBean) session.getAttribute("currentSessionUser");	
		UserDao userDao = new UserDao();
		String bank_info = userDao.getUserBankConfigAccount(userBean.getSiteid(),userBean.getCharge_level());
		out.println(bank_info);
	}
	
%>