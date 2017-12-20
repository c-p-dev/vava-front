<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/inc/session.jsp"%>

<jsp:useBean id="bm" class="bc4.BetConManager2" />
	
<%

  String [] sel =request.getParameterValues("sel") ;

   StringBuffer temp = new StringBuffer();
    for(String str : sel){
      temp.append(str + ",");
    }   
    
out.print(bm.getMaxBetAmt(SITEID,UID,temp.toString()).toString());
%>
