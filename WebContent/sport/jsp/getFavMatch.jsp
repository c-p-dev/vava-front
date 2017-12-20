<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/inc/session.jsp"%>

<jsp:useBean id="bm" class="bc4.BetConManager2" />

<%
String uid="";
if(request.getParameter("uid") != null && request.getParameter("uid").trim().length() > 0){
   uid =request.getParameter("uid") ;
}

String sid="1"; //site_id

%>
<%=bm.getFavMatch(SITEID,UID).toString()%>
