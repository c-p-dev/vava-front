<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<jsp:useBean id="bm" class="bc4.BetConManager2" />
<%
String dt="";
if(request.getParameter("dt") != null && request.getParameter("dt").trim().length() > 0){
   dt =request.getParameter("dt") ;
}

out.print(bm.getTodayMatchInfo(dt).toString());
%>
