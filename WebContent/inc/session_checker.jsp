<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	if(!checkSession){
	//	out.println("not logged in");
	response.sendRedirect("/index.jsp"); 
	//	return;
	}
%>	


