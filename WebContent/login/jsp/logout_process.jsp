<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import = "bean.UserBean" %>
<%@ page import = "dao.UserDao" %>
<%@ page import = "java.sql.SQLException " %>

<%
	HttpSession user_session = request.getSession(true);	    
	session.invalidate(); 
	response.sendRedirect("/index.jsp");
%>

