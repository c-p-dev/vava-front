<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="bean.UserBean" %>
<%@ page import="dao.QnaDao" %>
<%@ page import="bean.QnaBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.google.gson.Gson" %>

<%@ include file="/inc/session.jsp"%>

<%
	Gson gson = new Gson();
	QnaBean qBean = new QnaBean();
	QnaDao qDao = new QnaDao();
	
	qBean.setSiteid(Integer.parseInt(SITEID));
	qBean.setUserid(UID);

	List res = qDao.getMessage(qBean);
	
	if(res.size() > 0){
		boolean updateMsgList = qDao.updateReceivedMessages(qBean);
		//System.out.println("update fetched messages result : " + updateMsgList );
	}
	
	out.println(gson.toJson(res).toString());
%>





