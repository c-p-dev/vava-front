<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>




<%

	response.setHeader("Cache-Control","no-store"); 
	response.setHeader("Pragma","no-cache"); 
	response.setDateHeader("Expires",0); 	
	
	request.getSession().invalidate(); 	
	

	
	//session = request.getSession(true);		
	
	/* 
	if((String) session.getAttribute("UID") != null){			
		checkSession = true;			
	 	UID = (String)session.getAttribute("UID");		
		NICK  = (String)session.getAttribute("NICK ");
		UCLEVEL = (String)session.getAttribute("UCLEVEL");
		UGRADE = (Integer)session.getAttribute("UGRADE");
		UBAL = (Integer)session.getAttribute("UBAL");
		UPOINT = (Integer)session.getAttribute("UPOINT");
	} else{
		checkSession = false;	
	}
	*/
	
	response.sendRedirect("/"); 
%>
