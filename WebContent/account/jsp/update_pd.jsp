<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "bean.UserBean" %>
<%@ page import = "bean.SmsAuthBean" %>
<%@ page import = "dao.UserDao" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import ="java.util.HashMap" %>
<%@ page import="com.google.gson.Gson" %>
<%
	Gson gson = new Gson();
	HashMap<String, Object> hsm = new HashMap<String, Object>();
 	UserDao ud = new UserDao();
 	UserBean ub = new UserBean();
 	SmsAuthBean sb = new SmsAuthBean();

 	String form = request.getParameter("form");
	String new_passwd  =  request.getParameter("newpd");
	String cell = request.getParameter("cll");
	String cell_prefix = request.getParameter("cp");

	boolean result = false;

	ub.setCell_prefix(cell_prefix);
	ub.setCell(cell);
	ub.setPasswd(new_passwd);
	
	if(form.equals("f1")){
	
		String authcode = request.getParameter("ac");
		String nick = request.getParameter("nk");
		String userid = request.getParameter("ud");

		ub.setUserid(userid);
		ub.setNick(nick);
		sb.setAuthcode(authcode);

		result = ud.forgotPasswordUpdate1(ub,sb);

	}else if(form.equals("f2")){
		String bank_owner = request.getParameter("bo");
		String bank_name = request.getParameter("bn");
		String bank_number = request.getParameter("bnn");

		ub.setBank_owner(bank_owner);
		ub.setBank_name(bank_name);
		ub.setBank_num(bank_number);

		result = ud.forgotPasswordUpdate2(ub);
	}
	
	hsm.put("result",result);
	out.println(gson.toJson(hsm).toString());
%>
