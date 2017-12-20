<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.*"%>
<%@ page import="bean.*" %>
<%@ page import="dao.*" %>


<%@ include file="/inc/session.jsp"%>

<jsp:useBean id="bm" class="bc4.BetConManager2" />
	
<%
String amt = "";

if(request.getParameter("amt") != null && request.getParameter("amt").length() > 0){
  amt =request.getParameter("amt") ;
}

String [] sel =request.getParameterValues("sel") ;

   StringBuffer temp = new StringBuffer();
    for(String str : sel){
      temp.append(str + ",");
    }   
    
out.print( bm.setMultiBet(SITEID,UID,temp.toString(),amt,IP) );

%>
