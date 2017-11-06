<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "net.vavasoft.bean.ChargeBean "%>
<%@ page import = "net.vavasoft.bean.UserBean "%>
<%@ page import = "net.vavasoft.dao.ChargeDao "%>
<%@ page import = "java.sql.SQLException "%>
<%@ page import = "java.util.ArrayList "%>
<%@ page import = "java.util.List "%>
<%@ page import = "com.google.gson.reflect.TypeToken "%>
<%@ page import = "com.google.gson.Gson" %>
<%@ page import = "java.util.StringTokenizer "%>
<%
	if(session.getAttribute("currentSessionUser") != null){
		Gson gson = new Gson();
		ChargeDao cDao = new ChargeDao();
		UserBean userBean = (UserBean) session.getAttribute("currentSessionUser");

		List res = cDao.getUserChargeList(userBean.getUserid());
		out.println(gson.toJson(res).toString());
	}
	
%>