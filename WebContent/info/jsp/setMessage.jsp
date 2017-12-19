<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="bean.UserBean" %>
<%@ page import="bean.MessageBean" %>
<%@ page import="dao.MessageDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.google.gson.Gson" %>

<%@ page import="bean.QnaBean" %>
<%@ page import="dao.QnaDao" %>

<%@ include file="/inc/session.jsp" %>	

<%
	QnaBean qBean = new QnaBean();
	QnaDao qDao = new QnaDao();
	
	qBean.setUserid(UID);
	qBean.setTxt(request.getParameter("txt"));
	qBean.setSiteid(Integer.parseInt(SITEID));
	qBean.setIp(IP);
	
	boolean res = qDao.setMessage(qBean);
	out.print(res);
%>





