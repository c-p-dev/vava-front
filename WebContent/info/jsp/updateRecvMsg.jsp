<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import = "bean.UserBean" %>
<%@ page import = "dao.MessageDao" %>
<%@ page import = "bean.MessageBean" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "java.util.List" %>
<%@ page import="com.google.gson.Gson" %>

<%@ include file="/inc/session.jsp" %>		

<%

	MessageDao mDao = new MessageDao();
	MessageBean mBean = new MessageBean();

	int msg = Integer.parseInt(request.getParameter("msgid"));
	
	mBean.setRecv_userid(UID);
	mBean.setMsgid(msg);
	
	Gson gson = new Gson();
	HashMap<String, Object> hsm = new HashMap<String, Object>();
	boolean res = mDao.updateRecvMessage(mBean);
	
	hsm.put("result", res);
	out.println(gson.toJson(res).toString());


%>