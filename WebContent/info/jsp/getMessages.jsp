<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="bean.UserBean" %>
<%@ page import="dao.QnaDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.google.gson.Gson" %>
<%
	UserBean userBean = (UserBean) session.getAttribute("currentSessionUser");
	Gson gson = new Gson();
	QnaDao qDao = new QnaDao();
	List res = qDao.getMessage(userBean.getUserid());
	if(res.size() > 0){
		boolean updateMsgList = qDao.updateReceivedMessages(userBean.getUserid());
	}
	out.println(gson.toJson(res).toString());
%>





