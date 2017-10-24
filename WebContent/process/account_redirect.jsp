<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "net.vavasoft.bean.UserBean" %>
<%
	String tab = request.getParameter("tab").trim();
	System.out.println(tab);

	HttpSession user_session = request.getSession(true);	    
	session.setMaxInactiveInterval(7200);
    session.setAttribute("account_tab",tab);

    response.sendRedirect("../account/account.jsp");
    
%>





