<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="
	net.vavasoft.bean.ChargeBean,
	net.vavasoft.bean.UserBean,
	net.vavasoft.dao.ChargeDao,
	java.sql.SQLException,
	java.util.ArrayList,
	java.util.List,
	com.google.gson.reflect.TypeToken,
	java.util.StringTokenizer,
	com.google.gson.Gson;" %>
<%
	if(session.getAttribute("currentSessionUser") != null){
		Gson gson = new Gson();
		ChargeDao cDao = new ChargeDao();
		UserBean userBean = (UserBean) session.getAttribute("currentSessionUser");
		List res = cDao.getUserChargeList(userBean);
		out.println(gson.toJson(res).toString());
	}
	
%>