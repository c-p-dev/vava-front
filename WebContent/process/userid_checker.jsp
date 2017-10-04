<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.vavasoft.bean.UserBean,net.vavasoft.dao.UserDao,java.sql.SQLException;" %>
<%
	// return false if userid exists
	String userid = request.getParameter("userid");
	UserDao ud = new UserDao();
	UserBean uBean = new UserBean();
	uBean.setUserid(request.getParameter("userid").trim());
	System.out.println(ud.checkUserId(uBean));
	if(ud.checkUserId(uBean)){
		out.println(false);
	}else{
		out.println(true);
	}
	
%>