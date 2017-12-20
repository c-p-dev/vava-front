<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="bm" class="bc4.BetConManager2" />


<%@ include file="/inc/session.jsp"%>


<%
String mid="";
if(request.getParameter("mid") != null && request.getParameter("mid").trim().length() > 0){
   mid =request.getParameter("mid") ;
}
%>
	<%=bm.subLoadLiveMatch(mid).toString()%>