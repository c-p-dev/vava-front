<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<jsp:useBean id="bm" class="bc4.BetConManager2" />

<%
String mid="";
String sid="";
if(request.getParameter("mid") != null && request.getParameter("mid").trim().length() > 0){
   mid =request.getParameter("mid") ;
}

if(request.getParameter("sid") != null && request.getParameter("sid").trim().length() > 0){
   sid =request.getParameter("sid") ;
}

//StringBuffer result = bc4.getStatusbyMatchId(mid,sid);
%>

<%=bm.getStatusbyMatchId(mid,sid).toString()%>