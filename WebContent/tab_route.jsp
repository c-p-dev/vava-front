<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "net.vavasoft.bean.UserBean" %>
<%
	String tab = "tab1";
	String pge = request.getParameter("pge");
	String location = "/";
	HttpSession user_session = request.getSession(true);	
	session.setMaxInactiveInterval(7200);    

	if(pge.equals("acc")){
	
		location = "/account/account.jsp";
		tab = request.getParameter("tb");
	
	}else if(pge.equals("sb5")){

		location = "/info/sub05.jsp";
		tab = request.getParameter("tb");
		
	}else if(pge.equals("sb4")){
		
		location = "/app/sub04.jsp";
		tab = request.getParameter("tb");
		
	}

	session.setAttribute("tb",tab);
    response.sendRedirect(location);
    
%>