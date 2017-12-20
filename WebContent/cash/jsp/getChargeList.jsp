<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import = "dao.ChargeDao "%>
<%@ page import = "java.util.List "%>
<%@ page import = "com.google.gson.Gson" %>

<%@ include file="/inc/session.jsp"%>


<%	
		Gson gson = new Gson();
		ChargeDao cDao = new ChargeDao();
		
		List res = cDao.getUserChargeList(UID);
		out.println(gson.toJson(res).toString());	
%>