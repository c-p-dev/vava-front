<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%@page import="java.util.*"%>
<%@page import="bean.*"%>
<%@page import="java.lang.Integer"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="com.google.gson.reflect.TypeToken"%>


<%@ include file="/inc/session.jsp"%>

<jsp:useBean id="bm" class="bc4.BetConManager2" />
	
<%
String sid="1"; //site_id

String [] selid =request.getParameterValues("selid") ;
//String [] selp =request.getParameterValues("selp") ;


   StringBuffer temp_sel = new StringBuffer();
    for(String str : selid){
      temp_sel.append(str + ",");
    }  
   
    List<CartSelList> csl = bm.getCart(temp_sel.toString());

		Gson gson = new Gson();
		Type type = new TypeToken<List<CartSelList>>() {}.getType();
	 	String json = gson.toJson(csl, type);     
	 	out.print(json); 	 	
%>

