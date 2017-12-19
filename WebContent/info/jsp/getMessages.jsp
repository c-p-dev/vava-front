<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="bean.UserBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.google.gson.Gson" %>

<%@ page import="dao.QnaDao" %>
<%@ page import="bean.QnaBean" %>

<%@ include file="/inc/session.jsp"%>

<%
	Gson gson = new Gson();
	QnaDao qDao = new QnaDao();
	QnaBean qBean = new QnaBean();
	
	qBean.setUserid(UID);
	qBean.setSiteid(Integer.parseInt(SITEID));
	
	List res = qDao.getMessage(qBean);
	
	//if(res.size() > 0){
		//boolean updateMsgList = qDao.updateReceivedMessages(SITEID,UID);
	//}
	
	out.println(gson.toJson(res).toString());
%>





