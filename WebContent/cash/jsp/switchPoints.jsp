<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="
	bean.UserBean,
	dao.UserDao,
	java.sql.SQLException,
	java.util.ArrayList,
	java.util.List,
	com.google.gson.reflect.TypeToken,
	com.google.gson.Gson,
	java.util.StringTokenizer" 
%>

<%@ include file="/inc/session.jsp"%>

<%
	Gson gson = new Gson();
	UserDao ud = new UserDao();

	String amt="";
	
	if(request.getParameter("point") != null && request.getParameter("point").trim().length() > 0){
   amt =request.getParameter("point") ;
	}
	
	UserBean bean =  (UserBean) ud.switchpoints(SITEID,UID,amt);
	
	out.println(gson.toJson(bean, UserBean.class));
		
%>