<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/inc/session.jsp"%>


<jsp:useBean id="bm" class="bc4.BetConManager2" />

<%
out.print(bm.getMarketCategory().toString());
%>
