<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<%@ page import = "dao.SmsDao"%>


<%@ include file="/inc/session.jsp" %>		

<%
 SmsDao sd = new SmsDao();
 
 String cell="";
 String cell_prefix="";
 String rSnd="";
 
if(request.getParameter("cell") != null && request.getParameter("cell").trim().length() > 0){
   cell =request.getParameter("cell") ;
}

if(request.getParameter("cell_prefix") != null && request.getParameter("cell_prefix").trim().length() > 0){
   cell_prefix =request.getParameter("cell_prefix") ;
}

if(request.getParameter("rSnd") != null && request.getParameter("rSnd").trim().length() > 0){
   rSnd =request.getParameter("rSnd") ;
}
 
  boolean res = sd.sendSms(cell_prefix,cell,IP,SITEID,rSnd);
	out.println(res);
%>

