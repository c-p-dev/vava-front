<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="net.vavasoft.bean.UserBean" %>
<%@ page import="net.vavasoft.bean.MessageBean" %>
<%@ page import="net.vavasoft.dao.MessageDao" %>
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





