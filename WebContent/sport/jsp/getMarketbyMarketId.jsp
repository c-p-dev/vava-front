<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/inc/session.jsp"%>

<jsp:useBean id="bm" class="bc4.BetConManager2" />
	
<%
	String mkid="";if(request.getParameter("mkid") != null && request.getParameter("mkid").trim().length() > 0){
	   mkid =request.getParameter("mkid") ;
	}
	//StringBuffer result = bc4.BetConManager.getMarketbyMarketId(mkid);
%>

	<%=bm.getMarketbyMarketId(mkid).toString()%>
	