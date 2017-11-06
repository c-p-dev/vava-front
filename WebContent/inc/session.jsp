<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="net.vavasoft.bean.*" %>
<%@ page import="net.vavasoft.dao.*" %>
<%@ page import="java.text.DecimalFormat" %>

<%
	boolean checkSession = false;		
	String UID = "";
	String SITEID = "1";
	String UCLEVEL = "";
	String NICK = "";
	int UBAL = 0;
	int UPOINT = 0;
	
	if(session.getAttribute("currentSessionUser") != null){		
		UserBean bean =  (UserBean) session.getAttribute("currentSessionUser");	
		checkSession = true;
		SITEID = String.valueOf(bean.getSiteid());
		UID = bean.getUserid();		
		UCLEVEL = bean.getCharge_level(); 
		NICK = bean.getNick();
		UBAL = bean.getMoney();
		UPOINT = bean.getPoint();
		
		//out.print(bean.getNick());  
	}
	
	DecimalFormat dfrmt	= new DecimalFormat("#,###,###,###,###.00");
%>

