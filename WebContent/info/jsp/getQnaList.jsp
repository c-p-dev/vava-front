<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="bean.UserBean" %>
<%@ page import="dao.MessageDao" %>
<%@ page import="bean.MessageBean" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.List" %>

<%@ include file="/inc/session_checker.jsp" %>		

<%
	Gson gson = new Gson();
	MessageDao mDao = new MessageDao();
	MessageBean mBean = new MessageBean();
	mBean.setRecv_userid(UID);
	mBean.setSend_siteid(Integer.parseInt(SITEID));

	List res = mDao.getUserQnaList(mBean);
	out.println(gson.toJson(res).toString());
%>





