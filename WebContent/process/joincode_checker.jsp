<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.vavasoft.bean.UserBean,net.vavasoft.dao.UserDao,java.sql.SQLException,net.vavasoft.bean.JoinCodeBean,net.vavasoft.dao.JoinCodeDao;" %>
<%
	
	UserDao ud = new UserDao();
	JoinCodeBean jcbean = new JoinCodeBean();
	JoinCodeDao jcDao = new JoinCodeDao();
	jcbean.setJoincode(request.getParameter("recommend").trim());
	jcbean.setRecommend(request.getParameter("referrer").trim());
	
	boolean result = jcDao.checkJoinCode(jcbean);

	System.out.println(result);
	out.println(result);
%>