<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "bean.UserBean" %>
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

		location = "/info/info.jsp";
		tab = request.getParameter("tb");
		
	}else if(pge.equals("sb4")){
		
		location = "/cash/cash.jsp";
		tab = request.getParameter("tb");
		
	}

	session.setAttribute("tb",tab);
    response.sendRedirect(location);
    
%>