<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="net.vavasoft.bean.UserBean" %>
<%@ page import="net.vavasoft.dao.MessageDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.google.gson.Gson" %>
<%
	UserBean userBean = (UserBean) session.getAttribute("currentSessionUser");
	Gson gson = new Gson();
	MessageDao mDao = new MessageDao();
	List res = mDao.getMessage(userBean.getUserid());
	if(res.size() > 0){
		boolean updateMsgList = mDao.updateReceivedMessages(userBean.getUserid());
	}
	out.println(gson.toJson(res).toString());
%>





