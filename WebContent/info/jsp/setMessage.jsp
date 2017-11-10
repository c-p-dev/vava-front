<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="bean.UserBean" %>
<%@ page import="bean.MessageBean" %>
<%@ page import="dao.MessageDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.google.gson.Gson" %>
<%
	UserBean userBean = (UserBean) session.getAttribute("currentSessionUser");
	MessageBean mBean = new MessageBean();
	MessageDao mDao = new MessageDao();
	
	mBean.setSend_userid(userBean.getUserid());
	mBean.setTxt(request.getParameter("txt"));

	boolean res = mDao.setMessage(mBean);
	out.print(res);
%>





