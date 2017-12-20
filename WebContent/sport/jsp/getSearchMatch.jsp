<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    
<%@page import="java.util.*"%>
<%@page import="bean.*"%>
<%@page import="java.lang.Integer"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="com.google.gson.reflect.TypeToken"%>



<jsp:useBean id="bm" class="bc4.BetConManager2" />
	

<%

String key="";
if(request.getParameter("key") != null && request.getParameter("key").trim().length() > 0){
   key =request.getParameter("key") ;
}


		List<MatchSearchResultBean> msrb = bm.getSearchMatch(key);

		Gson gson = new Gson();
		Type type = new TypeToken<List<MatchSearchResultBean>>() {}.getType();
	 	String json = gson.toJson(msrb, type);     
	 	out.print(json); 
%>

