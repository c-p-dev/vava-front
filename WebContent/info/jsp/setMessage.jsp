<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<%@ page import="bean.UserBean" %>
<%@ page import="bean.QnaBean" %>
<%@ page import="dao.QnaDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import ="java.util.HashMap" %>

<%@ include file="/inc/session.jsp" %>		

<%
	Gson gson = new Gson();
	QnaDao qDao = new QnaDao();
	QnaBean qBean = new QnaBean();
	String txt= "";
		
	if(request.getParameter("txt") != null && request.getParameter("txt").trim().length() > 0){
   		txt = request.getParameter("txt") ;
	}

	qBean.setTxt(txt);
	qBean.setSiteid(Integer.parseInt(SITEID));
	qBean.setUserid(UID);
	qBean.setIp(IP);

	HashMap<String, Object> hsm = new HashMap<String, Object>();
	boolean res = qDao.setMessage(qBean);
	
	hsm.put("result", res);
	out.println(gson.toJson(hsm).toString());
%>





