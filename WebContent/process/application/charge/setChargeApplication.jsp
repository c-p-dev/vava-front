<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="
	net.vavasoft.bean.ChargeBean,
	net.vavasoft.dao.ChargeDao,
	net.vavasoft.bean.UserBean,
	java.sql.SQLException,
	java.util.ArrayList,
	java.util.List,
	com.google.gson.reflect.TypeToken,
	java.util.StringTokenizer;" %>
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
		chargeBean.setBank_num(request.getParameter("bank_num").trim());
		chargeBean.setBank_owner(request.getParameter("bank_owner").trim());
		chargeBean.setMoney_req(Integer.parseInt(request.getParameter("money")));
		chargeBean.setIp(ip);
	
		result = chargeDao.saveChargeApplication(bean, chargeBean);
		out.println(result);
		
	}else{
		response.sendRedirect("index.jsp");
		return;
	}
		


	
%>