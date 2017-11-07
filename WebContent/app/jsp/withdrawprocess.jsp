<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="
	net.vavasoft.bean.UserBean,
	net.vavasoft.dao.UserDao,
	java.sql.SQLException,
	java.util.ArrayList,
	java.util.List,
	com.google.gson.reflect.TypeToken,
	java.util.StringTokenizer;" %>
<%

	if(session.getAttribute("currentSessionUser") != null){
		UserBean bean = (UserBean) session.getAttribute("currentSessionUser");
	 	UserDao ud = new UserDao();
	 	UserBean bean2 = ud.getUserByUserId(bean.getUserid()); 
	 	bean.setRegdate("20202020");
		boolean result = false;
		int withdraw = Integer.parseInt(request.getParameter("withdraw"));
		String xForwardedForHeader = request.getHeader("X-Forwarded-For");	 
	    if (xForwardedForHeader == null) {
	    	bean.setIp(request.getRemoteAddr());
	    }else{
	    	bean.setIp(new StringTokenizer(xForwardedForHeader, ",").nextToken().trim());  
	    }
	    
		result = ud.withdraw(bean2,withdraw);	
		out.println(result);

	}else{
		response.sendRedirect("index.jsp");
		return;
	}
	
%>