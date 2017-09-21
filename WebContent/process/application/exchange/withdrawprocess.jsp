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
	 	bean.setRegdate("20202020");
		boolean result = false;
		int withdraw = Integer.parseInt(request.getParameter("withdraw"));
		String ip = "";
		String xForwardedForHeader = request.getHeader("X-Forwarded-For");	 
	    if (xForwardedForHeader == null) {
	        ip = request.getRemoteAddr();
	    }else{
	        ip =  new StringTokenizer(xForwardedForHeader, ",").nextToken().trim();
	    }
	    
		result = ud.withdraw(bean.getUserid(),bean.getSiteid(),bean.getBank_name(),bean.getBank_num(),bean.getBank_owner(),bean.getRegdate(),ip,withdraw);	
		out.println(result);

	}else{
		response.sendRedirect("index.jsp");
		return;
	}
	
%>