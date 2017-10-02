<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="
	net.vavasoft.bean.UserBean,
	net.vavasoft.dao.UserDao,
	net.vavasoft.controller.SmsController,
	java.util.StringTokenizer;" %>
<%

	String userid = request.getParameter("userid").trim();
	String cell_prefix = request.getParameter("cell_prefix").trim();
	String cell = request.getParameter("cell").trim();
	String ip = "";
	String tel = cell_prefix + cell;
	tel = tel.replace("+","");

	String xForwardedForHeader = request.getHeader("X-Forwarded-For");	 
    if (xForwardedForHeader == null) {
        ip = request.getRemoteAddr();
    }else{
        // As of https://en.wikipedia.org/wiki/X-Forwarded-For
        // The general format of the field is: X-Forwarded-For: client, proxy1, proxy2 ...
        // we only want the client
        ip =  new StringTokenizer(xForwardedForHeader, ",").nextToken().trim();
    }

	SmsController sm = new SmsController();
	boolean res = sm.verifyNumber(userid,tel,ip);
	
	out.println(res);

%>