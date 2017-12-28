<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import = "dao.JoinCodeDao" %>


<%@ include file="/inc/session.jsp" %>		


<%
	JoinCodeDao jcDao = new JoinCodeDao();

 String referrer="";
 String recommend="";
  
if(request.getParameter("referrer") != null && request.getParameter("referrer").trim().length() > 0){
   referrer =request.getParameter("referrer") ;
}

if(request.getParameter("recommend") != null && request.getParameter("recommend").trim().length() > 0){
   recommend =request.getParameter("recommend") ;
}

	boolean result = jcDao.checkJoinCode(SITEID, referrer, recommend);
	out.println(result);
%>





