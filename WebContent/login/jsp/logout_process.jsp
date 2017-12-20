<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<%
	
	response.setHeader("Cache-Control","no-store"); 
	response.setHeader("Pragma","no-cache"); 
	response.setDateHeader("Expires",0); 		
	
	HttpSession sess = request.getSession(false);
		
	sess.removeAttribute("UID");
	sess.removeAttribute("NICK");
	sess.removeAttribute("UCLEVEL");
	sess.removeAttribute("UGRADE");
	sess.removeAttribute("UBAL");
	sess.removeAttribute("UPOINT");
			
	sess.invalidate(); 		
		
	response.sendRedirect("/"); 
%>
	 
