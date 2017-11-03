<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%


	String manual = request.getParameter("man");
	if(manual.equals("manual")){
		response.sendRedirect("../casino/manual.jsp");
	}else if(manual.equals("manual2")){
		response.sendRedirect("../casino/manual2.jsp");
	}
	


%>
