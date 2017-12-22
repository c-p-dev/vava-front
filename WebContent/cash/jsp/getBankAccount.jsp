<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>

<%@ page import="java.util.*"%>
<%@ page import ="bean.ChargeBean" %>
<%@ page import ="dao.ChargeDao" %>
<%@ page import ="bean.UserBean" %>
<%@ page import ="dao.UserDao,java.sql.SQLException" %>

<%@page import="com.google.gson.Gson"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="com.google.gson.reflect.TypeToken"%>



<%@ include file="/inc/session.jsp"%>

<%
	String pw="";
	
	if(request.getParameter("pw") != null && request.getParameter("pw").trim().length() > 0){
   pw =request.getParameter("pw") ;
	}

	Gson gson = new Gson();
	HashMap<String, Object> hsm = new HashMap<String, Object>();
	
	UserDao userDao = new UserDao();
	UserBean ub = userDao.getUserBankConfigAccount(SITEID, UID, pw);
	
	hsm.put("BN",ub.getBank_name());
	hsm.put("BO",ub.getBank_owner());
	
	out.println(gson.toJson(hsm).toString());
%>

