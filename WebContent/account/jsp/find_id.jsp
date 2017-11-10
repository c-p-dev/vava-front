<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "dao.UserDao" %>
<%@ page import = "dao.SmsDao"%>
<%@ page import = "java.util.StringTokenizer"%>
<%@ page import="com.google.gson.Gson" %>
<%@ page import ="java.util.HashMap" %>

<%
	String method = request.getParameter("method");
	
	Gson gson = new Gson();
	HashMap<String, Object> hsm = new HashMap<String, Object>();
	String userid = null;

	SmsDao sd = new SmsDao();
		
	if(method.equals("by_phone")){
		
		String cell = request.getParameter("cll").trim();
		String cell_prefix = request.getParameter("cp").trim();
		String nick = request.getParameter("nk").trim();
		String authcode = request.getParameter("ac").trim();
		int site_id = Integer.parseInt(request.getParameter("sd"));
		
		userid = sd.checkAuthCodeByNickname(nick,cell_prefix,cell,authcode);

		String mobile_no = sd.formatCellNumber(cell_prefix, cell);
		if(userid != null){
				
			sd.updateValidSmsDeliveryLog(mobile_no,"Y");
		
		}else{
			
			sd.saveSmsAuthLog(mobile_no,authcode,site_id);
		
		}
	}
	else if (method.equals("by_bank")){

		UserDao ud = new UserDao();
		String bo = request.getParameter("bo");
		String bn = request.getParameter("bn");
		String bnn = request.getParameter("bnn");
		String cp = request.getParameter("cp");
		String cll = request.getParameter("cll");

		userid = ud.getUserIdByBank(bo,bn,bnn,cp,cll);
	}
	else{
		userid = null;
	}

	hsm.put("userid", userid);
	out.println(gson.toJson(hsm).toString());




%>