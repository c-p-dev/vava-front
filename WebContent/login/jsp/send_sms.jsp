<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "dao.SmsDao"%>
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

    int site_id = 1;
    String userid = request.getParameter("userid");
	String cell = request.getParameter("cell");
	String cell_prefix = request.getParameter("cell_prefix");
	boolean rSnd = Boolean.parseBoolean(request.getParameter("rSnd"));

    boolean res = sd.sendSms(userid,cell_prefix,cell,ip,site_id,rSnd);
	out.println(res);


%>