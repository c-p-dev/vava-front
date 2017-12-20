<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="bean.MessageBean" %>
<%@ page import="dao.MessageDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.google.gson.Gson" %>

<%@ include file="/inc/session.jsp" %>	

<%

	MessageBean mBean = new MessageBean();
	MessageDao mDao = new MessageDao();
	
	
	mBean.setRecv_userid(UID);
	mBean.setMsgid(Integer.parseInt(request.getParameter("msgid")));


	Gson gson = new Gson();
	HashMap<String, Object> hsm = new HashMap<String, Object>();

	boolean res = mDao.updateMsg(mBean);
	hsm.put("updated",res);
	hsm.put("count", mDao.messageCount(UID));
	out.println(gson.toJson(hsm).toString());
%>
