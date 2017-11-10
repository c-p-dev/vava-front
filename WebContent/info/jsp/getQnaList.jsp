<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="bean.UserBean" %>
<%@ page import="dao.QnaDao" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.List" %>
<%
	UserBean userBean = (UserBean) session.getAttribute("currentSessionUser");
	Gson gson = new Gson();
	QnaDao qDao = new QnaDao();
	List res = qDao.getUserQnaList(userBean.getUserid());
	System.out.println(res);
	out.println(gson.toJson(res).toString());
%>





