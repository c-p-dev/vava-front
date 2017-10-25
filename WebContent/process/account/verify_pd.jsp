<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "net.vavasoft.dao.SmsDao" %>
<%@ page import = "net.vavasoft.dao.UserDao" %>
<%@ page import = "net.vavasoft.bean.UserBean" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.HashMap" %>
<%
	String method = request.getParameter("method");
	Gson gson = new Gson();
	HashMap<String,Object> hsm = new HashMap<String,Object>();

	boolean result = false;

	if(method.equals("by_phone")){
		SmsDao sd = new SmsDao();
	
		String authcode = request.getParameter("ac");
		String cell = request.getParameter("cll");
		String cell_prefix = request.getParameter("cp");
		String nickname = request.getParameter("nk");
		String userid = request.getParameter("ud");

		result = sd.checkAuthCodeByUseridNick(userid, nickname,cell_prefix,cell,authcode);

	}else if(method.equals("by_bank")){
		
		UserDao ud = new UserDao();
		UserBean ub = new UserBean();

		String bank_owner = request.getParameter("bo");
		String bank_name = request.getParameter("bn");
		String bank_number = request.getParameter("bnn");
		String cell_prefix = request.getParameter("cp");
		String cell = request.getParameter("cll");

		result = ud.getUserIdPassByBank(bank_owner,bank_name,bank_number,cell_prefix,cell);

	}else{
		result = false;

	}
	
	hsm.put("result",result);
	out.println(gson.toJson(hsm).toString());
	
%>