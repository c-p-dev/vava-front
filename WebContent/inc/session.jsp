<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.*" %>
<%@page import="util.*"%>
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
ClassicAesEncryptor ce = new ClassicAesEncryptor();
SITEID = "1";	
HttpSession sess = request.getSession(false);		
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
DecimalFormat dfrmt	= new DecimalFormat("#,###,###,###,###");	
//sess.invalidate();
%>