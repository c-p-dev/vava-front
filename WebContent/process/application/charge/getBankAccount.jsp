<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.vavasoft.bean.UserBean,net.vavasoft.dao.UserDao,java.sql.SQLException;" %>
<%
	if(session.getAttribute("currentSessionUser") != null){
		UserBean bean = (UserBean) session.getAttribute("currentSessionUser");	
		UserDao ud = new UserDao();
		String bank_info = ud.getUserBankConfigAccount(bean.getSiteid(),bean.getCharge_level());
		out.println(bank_info);
	}
	
%>