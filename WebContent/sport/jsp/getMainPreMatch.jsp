<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/inc/session.jsp"%>


<jsp:useBean id="bm" class="bc4.BetConManager2" />
	
	
<%
String sid="";
if(request.getParameter("sid") != null && request.getParameter("sid").trim().length() > 0){
   sid =request.getParameter("sid") ;
}

String min="";
if(request.getParameter("min") != null && request.getParameter("min").trim().length() > 0){
   min =request.getParameter("min") ;
}

out.println(bm.getMainPreMatch(sid,min).toString());

%>
