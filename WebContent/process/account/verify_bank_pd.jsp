<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "net.vavasoft.dao.UserDao" %>
<%@ page import = "net.vavasoft.bean.UserBean" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.HashMap" %>
<%
	UserDao ud = new UserDao();
	UserBean ub = new UserBean();
	Gson gson = new Gson();
	HashMap<String,Object> hsm = new HashMap<String,Object>();

	String bank_owner = request.getParameter("bo");
	String bank_name = request.getParameter("bn");
	String bank_number = request.getParameter("bnn");
	String cell_prefix = request.getParameter("cp");
	String cell = request.getParameter("cll");

	boolean res = ud.getUserIdPassByBank(bank_owner,bank_name,bank_number,cell_prefix,cell);
	hsm.put("result",res);
	out.println(gson.toJson(hsm).toString());


%>
