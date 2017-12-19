<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="
	bean.UserBean,
	dao.UserDao,
	java.sql.SQLException,
	java.util.ArrayList,
	java.util.List,
	com.google.gson.reflect.TypeToken,
	java.util.StringTokenizer" 
%>


<%@ include file="/inc/session_checker.jsp"%>

<%
	UserDao ud = new UserDao();
 	//UserBean bean = ud.getUserByUserId(UID); 
	//int withdraw = Integer.parseInt(request.getParameter("withdraw"));
	//bean.setIp(IP);
	//boolean result = ud.withdraw(bean,withdraw);	
	
	String amt="";
	
	if(request.getParameter("withdraw") != null && request.getParameter("withdraw").trim().length() > 0){
   amt =request.getParameter("withdraw") ;
	}
	
	boolean result = ud.withdraw(SITEID,UID,amt,IP);
	out.println(result);	
%>
<%=SITEID%>,<%=UID%>,<%=amt%>,<%=IP%>