<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/inc/session.jsp"%>

<jsp:useBean id="bm" class="bc4.BetConManager2" />

<%
String mid="";
if(request.getParameter("mid") != null && request.getParameter("mid").trim().length() > 0){
   mid =request.getParameter("mid") ;
}

String flag="";
if(request.getParameter("f") != null && request.getParameter("f").trim().length() > 0){
   flag =request.getParameter("f") ;
}

%>
<%=bm.setFavMatch(SITEID,UID,mid,flag).toString()%>
