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
	//boolean result = false;
	Gson gson = new Gson();
	UserDao ud = new UserDao();
	//UserBean bean = (UserBean) ud.getUserByUserId(UID);
	
	String amt="";
	
	if(request.getParameter("point") != null && request.getParameter("point").trim().length() > 0){
   amt =request.getParameter("point") ;
	}
	
	//int points = Integer.parseInt(request.getParameter("point"));
	//bean.setIp(IP);

	UserBean bean =  (UserBean) ud.switchpoints(SITEID,UID,amt);
	
	//result = ud.switchpoints(bean,bean.getMoney(),bean.getPoint(),points);
	//result = ud.userpoints(bean,bean.getMoney(),bean.getPoint(),points);	
	
	//UserBean usermoney = ud.getUserByUserId(UID);
	
	out.println(gson.toJson(bean, UserBean.class));
		
	
%>