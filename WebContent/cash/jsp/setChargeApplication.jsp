<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="/inc/session.jsp"%>

<jsp:useBean id="CDao" class="dao.ChargeDao" />
	
<%
	
	/*
		UserDao ud = new UserDao();
		UserBean bean = (UserBean)  ud.getUserByUserId(UID);
		ChargeBean chargeBean = new ChargeBean();
		ChargeDao chargeDao = new ChargeDao();
		boolean result = false;
	
		//chargeBean.setBank_name(request.getParameter("bank_name").trim());
		chargeBean.setBank_owner(request.getParameter("bank_owner").trim());
		chargeBean.setMoney_req(Integer.parseInt(request.getParameter("money").replace(",", "")));
		chargeBean.setIp(IP);
	*/
	
	String ao="";
	String m="";
	
	if(request.getParameter("bank_owner") != null && request.getParameter("bank_owner").trim().length() > 0){
   ao =request.getParameter("bank_owner") ;
	}

	if(request.getParameter("money") != null && request.getParameter("money").trim().length() > 0){
   m =request.getParameter("money") ;
	}
	

		//result = new ChargeDao().saveChargeApplication(bean, chargeBean);
		boolean result = CDao.saveChargeApplication(SITEID,UID,ao,m,IP);
		out.println(result);
%>


	
	
	
	
	
	
	
	