<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<jsp:useBean id="bm" class="bc4.BetConManager2" />

<%
String sd="";
String dt="";
if(request.getParameter("sd") != null && request.getParameter("sd").trim().length() > 0){
   sd =request.getParameter("sd") ;
}

if(request.getParameter("dt") != null && request.getParameter("dt").trim().length() > 0){
   dt =request.getParameter("dt") ;
}

out.print(bm.getMatchInfobySport(sd,dt).toString());
%>
