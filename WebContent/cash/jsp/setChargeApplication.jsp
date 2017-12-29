<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/inc/session.jsp"%>
<jsp:useBean id="CDao" class="dao.ChargeDao" />
<%	
	String ao="";
	String m="";	
	
	if(request.getParameter("bank_owner") != null && request.getParameter("bank_owner").trim().length() > 0){
   		ao =request.getParameter("bank_owner") ;
	}

	if(request.getParameter("money") != null && request.getParameter("money").trim().length() > 0){
   		m =request.getParameter("money") ;
	}
	
	boolean result = CDao.saveChargeApplication(SITEID,UID,ce.d(ao),ce.d(m),IP);
	out.println(result);
%>


	
	
	
	
	
	
	
	