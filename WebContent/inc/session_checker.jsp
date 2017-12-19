<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="dao.UserDao" %>
<%@ page import="java.text.DecimalFormat" %>

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
		
	DecimalFormat dfrmt	= new DecimalFormat("#,###,###,###,##0");	

	if(!checkSession){
	//	out.println("not logged in");
	//response.sendRedirect("/index.jsp"); 
	//	return;
	}
%>	


