<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="dao.UserDao" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.*" %>

	<%!
	boolean checkSession;
	String SITEID; 
	String UID;
	String NICK;
	String UCLEVEL;
	int UGRADE;
	int UBAL;
	int UPOINT;
	String IP;
	%>
	
	<%
	
	SITEID = "1";	
	 session = request.getSession(false);		
	 
	if((String) session.getAttribute("UID") != null){			
		checkSession = true;			
	 	UID = (String)session.getAttribute("UID");		
		NICK  = (String)session.getAttribute("NICK");
		UCLEVEL = (String)session.getAttribute("UCLEVEL");
		UGRADE = (Integer)session.getAttribute("UGRADE");
		UBAL = (Integer)session.getAttribute("UBAL");
		UPOINT = (Integer)session.getAttribute("UPOINT");
	}
	
	IP = request.getRemoteAddr();
	
	// ip block
	UserDao user_db2 	=  new UserDao();
	boolean invalidIp = user_db2.checkIPBlockList(IP);
	
	if(invalidIp){
		System.out.println("Redirecting to Error...");
		response.sendRedirect("/error.jsp"); 
		return;
	}	
	
	
	DecimalFormat dfrmt	= new DecimalFormat("#,###,###,###,###");	
	
	//	session.invalidate(); 
		
%>
