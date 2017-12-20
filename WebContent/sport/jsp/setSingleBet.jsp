<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.*"%>
<%@ page import="bean.*" %>
<%@ page import="dao.*" %>

<%@ include file="/inc/session.jsp"%>

<jsp:useBean id="bm" class="bc4.BetConManager2" />
		
<%
String [] amt =request.getParameterValues("amt") ;
String [] sel =request.getParameterValues("sel") ;

   StringBuffer temp_sel = new StringBuffer();
    for(String str : sel){
      temp_sel.append(str + ",");
    }   
   
   StringBuffer temp_amt = new StringBuffer();
    for(String str : amt){
      temp_amt.append(str + ",");
   }   
     
out.print( bm.setSingleBet(SITEID,UID,temp_sel.toString(),temp_amt.toString(),IP) );

%>
