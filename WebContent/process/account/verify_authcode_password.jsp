<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "net.vavasoft.dao.SmsDao" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.HashMap" %>
<%
	Gson gson = new Gson();
	HashMap<String,Object> hsm = new HashMap<String,Object>();
	SmsDao sd = new SmsDao();
	
	String authcode = request.getParameter("ac");
	String cell = request.getParameter("cll");
	String cell_prefix = request.getParameter("cp");
	String nickname = request.getParameter("nk");
	String userid = request.getParameter("ud");
	
	boolean res = sd.checkAuthCodeByUseridNick(userid, nickname,cell_prefix,cell,authcode);
	hsm.put("result",res);
	out.println(gson.toJson(hsm).toString());
%>
