<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="
	net.vavasoft.bean.SmsAuthBean,
	net.vavasoft.controller.SmsController,
	java.util.StringTokenizer;" %>
<%
	
	String xForwardedForHeader = request.getHeader("X-Forwarded-For");	 
	String ip = "";
    if (xForwardedForHeader == null) {
        ip = request.getRemoteAddr();
    }else{
        // As of https://en.wikipedia.org/wiki/X-Forwarded-For
        // The general format of the field is: X-Forwarded-For: client, proxy1, proxy2 ...
        // we only want the client
        ip =  new StringTokenizer(xForwardedForHeader, ",").nextToken().trim();
    }
    SmsAuthBean smsBean = new SmsAuthBean();
    String cell = request .getParameter("cell").trim();
    smsBean.setUserid(request.getParameter("userid").trim());
    smsBean.setTel(request.getParameter("cell_prefix").trim() + request.getParameter("cell").trim());
    smsBean.setIp(ip);

	SmsController sm = new SmsController();
	boolean res = sm.verifyNumber(smsBean);
	
	out.println(res);
	// out.println(false);

%>