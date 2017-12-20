<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    
<%@page import="java.util.*"%>
<%@page import="bean.*"%>
<%@page import="java.lang.Integer"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="com.google.gson.reflect.TypeToken"%>

<jsp:useBean id="bm" class="bc4.BetConManager2" />
	


<%
//String sid="1"; //site_id

String key="";
if(request.getParameter("key") != null && request.getParameter("key").trim().length() > 0){
   key =request.getParameter("key") ;
}

%>

<%=key%>
