<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="bean.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import = "com.google.gson.Gson" %>

<%

	boolean checkSession = false;		
	Gson gson = new Gson();
	HashMap<String, Object> hsm = new HashMap<String, Object>();

	
	if(session.getAttribute("currentSessionUser") != null){
		checkSession = true;
	}

	hsm.put("result",checkSession);
	out.println(gson.toJson(hsm).toString());
	
	
	
%>

