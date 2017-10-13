<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "net.vavasoft.dao.SmsDao"%>
<%@ page import = "java.util.StringTokenizer"%>

<%
	SmsDao sd = new SmsDao();
	String xForwardedForHeader = request.getHeader("X-Forwarded-For");	 
	String ip = "";
    if (xForwardedForHeader == null) {
        ip = request.getRemoteAddr();
    }else{
        ip =  new StringTokenizer(xForwardedForHeader, ",").nextToken().trim();
    }

    String userid = request.getParameter("userid").trim();
	String cell = request.getParameter("cell").trim();
	String cell_prefix = request.getParameter("cell_prefix").trim();
	
    boolean res = sd.sendSms(userid,cell_prefix,cell,ip);
	out.println(res);


%>