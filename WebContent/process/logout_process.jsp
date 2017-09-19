<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.vavasoft.bean.UserBean,net.vavasoft.dao.UserDao,java.sql.SQLException;" %>
<%
	HttpSession user_session = request.getSession(true);	    
	session.invalidate(); 
	response.sendRedirect("../index.jsp");
%>

