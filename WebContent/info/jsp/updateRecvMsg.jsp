<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import = "bean.UserBean" %>
<%@ page import = "dao.MessageDao" %>
<%@ page import = "bean.MessageBean" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "java.util.List" %>
<%@ page import="com.google.gson.Gson" %>

<%@ include file="/inc/session.jsp" %>		

<%

	MessageDao qDao = new MessageDao();
	MessageBean qBean = new MessageBean();

	int msg = Integer.parse(request.getParameter('msgid'));
	
	qBean.setUserid(UID);
	qBean.setMsgid(msg);
	
	HashMap<String, Object> hsm = new HashMap<String, Object>();
	boolean res = qDao.updateRecvMessage(qBean);
	
	hsm.put("result", res);
	out.println(gson.toJson(res).toString());


%>