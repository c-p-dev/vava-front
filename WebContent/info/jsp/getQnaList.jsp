<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="bean.UserBean" %>
<%@ page import="dao.MessageDao" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.List" %>
<%
	UserBean userBean = (UserBean) session.getAttribute("currentSessionUser");
	Gson gson = new Gson();
	MessageDao mDao = new MessageDao();
	List res = mDao.getUserQnaList(userBean.getUserid());
	System.out.println(res);
	out.println(gson.toJson(res).toString());
%>





