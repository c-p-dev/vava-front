<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
	
	HttpSession sess = request.getSession(false);		
	//sess.invalidate(); 
	
	 //session = request.getSession(false);
	 
	if((String) sess.getAttribute("UID") != null){			
		checkSession = true;			
	 	UID = (String)sess.getAttribute("UID");		
		NICK  = (String)sess.getAttribute("NICK");
		UCLEVEL = (String)sess.getAttribute("UCLEVEL");
		UGRADE = (Integer)sess.getAttribute("UGRADE");
		UBAL = (Integer)sess.getAttribute("UBAL");
		UPOINT = (Integer)sess.getAttribute("UPOINT");
	}
	
	IP = request.getRemoteAddr();
	
	// ip block
	// UserDao user_db2 	=  new UserDao();
	// boolean invalidIp = user_db2.checkIPBlockList(IP);
	
	// if(invalidIp){
	// 	System.out.println("Redirecting to Error...");
	// 	response.sendRedirect("/error.jsp"); 
	// 	return;
	// }	
	
	
	DecimalFormat dfrmt	= new DecimalFormat("#,###,###,###,###");	
	
	
		
%>
