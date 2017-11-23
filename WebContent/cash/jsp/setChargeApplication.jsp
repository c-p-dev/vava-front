<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import = "bean.ChargeBean" %>
<%@ page import = "dao.ChargeDao" %>
<%@ page import = "bean.UserBean" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.List" %>
<%@ page import = "com.google.gson.reflect.TypeToken" %>
<%@ page import = "java.util.StringTokenizer" %>

<%
	
	
	if(session.getAttribute("currentSessionUser") != null){
		UserBean bean = (UserBean) session.getAttribute("currentSessionUser");
		ChargeBean chargeBean = new ChargeBean();
		ChargeDao chargeDao = new ChargeDao();
		boolean result = false;
		
		String ip = "";
		String xForwardedForHeader = request.getHeader("X-Forwarded-For");	 
	    if (xForwardedForHeader == null) {
	        ip = request.getRemoteAddr();
	    }else{
	        ip =  new StringTokenizer(xForwardedForHeader, ",").nextToken().trim();
	    }

		chargeBean.setBank_name(request.getParameter("bank_name").trim());
		chargeBean.setBank_owner(request.getParameter("bank_owner").trim());
		chargeBean.setMoney_req(Integer.parseInt(request.getParameter("money").replace(",", "")));
		chargeBean.setIp(ip);
	
		result = chargeDao.saveChargeApplication(bean, chargeBean);
		out.println(result);
		
	}else{
		response.sendRedirect("index.jsp");
		return;
	}
			
%>


	
	
	
	
	
	
	
	