<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="net.vavasoft.bean.UserBean" %>
<%@ page import="net.vavasoft.dao.AccountDao" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.reflect.TypeToken" %>
<%@ page import="java.util.StringTokenizer" %>
<%

	if(session.getAttribute("currentSessionUser") != null){
		UserBean bean = (UserBean) session.getAttribute("currentSessionUser");
		Gson gson = new Gson();
	 	AccountDao aDao = new AccountDao();

	 	String userid = bean.getUserid();
		String job = request.getParameter("job").trim();
		String moneypoint = request.getParameter("moneypoint").trim();
		String fromDate = request.getParameter("fromDate").trim();
		String toDate = request.getParameter("toDate").trim();
		
		List res = aDao.getMoneyUseHistory(userid, job, moneypoint, fromDate, toDate);
	 	System.out.print(res);
		out.println(gson.toJson(res).toString());
	}
	

%>
