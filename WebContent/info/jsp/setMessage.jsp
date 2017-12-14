<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="bean.UserBean" %>
<%@ page import="bean.QnaBean" %>
<%@ page import="dao.QnaDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.google.gson.Gson" %>
<%
	UserBean userBean = (UserBean) session.getAttribute("currentSessionUser");
	QnaBean qBean = new QnaBean();
	QnaDao qDao = new QnaDao();
	
	qBean.setUserid(userBean.getUserid());
	qBean.setTxt(request.getParameter("txt"));
	qBean.setIp(request.getRemoteAddr());
	
	boolean res = qDao.setMessage(qBean);
	out.print(res);
%>





