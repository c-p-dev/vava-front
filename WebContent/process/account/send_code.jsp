<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "net.vavasoft.dao.UserDao"%>
<%@ page import = "net.vavasoft.dao.SmsDao" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.HashMap" %>
<%

	String method = request.getParameter("method");
	Gson gson = new Gson();
	HashMap<String,Object> hsm = new HashMap<String,Object>();
	UserDao ud = new UserDao();

	String cell = request.getParameter("cll").trim();
	String cell_prefix = request.getParameter("cp").trim();
	String nick = request.getParameter("nk").trim();

	boolean userExists = false;
	String message = "Sms failed";
	boolean sent = false;

	if(method.equals("f1")){
		userExists = ud.checkCellNumByNick(nick,cell_prefix,cell);
	}else if (method.equals("f2")){
		String userid = request.getParameter("ud");
		userExists = ud.checkCellNumByUseridNick(userid,nick,cell_prefix,cell);
	}
	
	//send sms
	if(userExists) {
		SmsDao sd = new SmsDao();
		sent = sd.sendSmsByNickname(nick,cell_prefix,cell);
		if(sent){
			message = "Sms sent";
		}
	}	

	hsm.put("result",sent);
	hsm.put("message",message);
	out.println(gson.toJson(hsm).toString());


%>
