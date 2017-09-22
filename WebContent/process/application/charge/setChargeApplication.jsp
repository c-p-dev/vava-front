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
	 	String bank_name = request.getParameter("bank_name").trim();
		String bank_num = request.getParameter("bank_num").trim();
		String bank_owner = request.getParameter("bank_owner").trim();
		int money = Integer.parseInt(request.getParameter("money"));
		boolean result = false;

		String ip = "";
		String xForwardedForHeader = request.getHeader("X-Forwarded-For");	 
	    if (xForwardedForHeader == null) {
	        ip = request.getRemoteAddr();
	    }else{
	        ip =  new StringTokenizer(xForwardedForHeader, ",").nextToken().trim();
	    }
		result = ud.saveChargeApplication(bean.getUserid(),bean.getSiteid(),bean.getCharge_level(),bank_name,bank_owner,bank_num,money,ip);
		out.println(result);

	}else{
		response.sendRedirect("index.jsp");
		return;
	}
		


	
%>