<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="net.vavasoft.bean.UserBean" %>
<%@ page import="net.vavasoft.bean.AccountListBean" %>
<%@ page import="net.vavasoft.dao.AccountDao" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.reflect.TypeToken" %>
<%@ page import="java.util.StringTokenizer" %>
<%

	if(session.getAttribute("currentSessionUser") != null){
	
		UserBean bean = (UserBean) session.getAttribute("currentSessionUser");
		Gson gson = new Gson();
		AccountListBean alBean = new AccountListBean();
	 	AccountDao aDao = new AccountDao();
		
		alBean.setUserid(bean.getUserid());
		alBean.setJob(request.getParameter("job").trim());
		alBean.setFromDate(request.getParameter("fromDate").trim());
		alBean.setToDate(request.getParameter("toDate").trim());

	 	List res = aDao.getPointHistory(alBean);
	 	System.out.println(res);
		out.print(gson.toJson(res).toString());
	}
	
%>


