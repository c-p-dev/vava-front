<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="
	net.vavasoft.bean.UserBean,
	net.vavasoft.dao.UserDao,
	java.sql.SQLException,
	java.util.ArrayList,
	java.util.List,
	com.google.gson.reflect.TypeToken,
	java.util.StringTokenizer,
	com.google.gson.Gson;" %>
<%
	if(session.getAttribute("currentSessionUser") != null){
		Gson gson = new Gson();
		UserBean bean = (UserBean) session.getAttribute("currentSessionUser");
		UserDao ud = new UserDao();
		List res = ud.getUserChargeList(bean.getUserid());
		
		out.println(gson.toJson(res).toString());
	}

	
		


	
%>