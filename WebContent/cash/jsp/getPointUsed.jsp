<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="bean.UserBean" %>
<%@ page import="dao.AccountDao" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.reflect.TypeToken" %>
<%@ page import="java.util.StringTokenizer" %>
<%

	if(session.getAttribute("currentSessionUser") != null){
		UserBean bean = (UserBean) session.getAttribute("currentSessionUser");
		Gson gson = new Gson();
	 	AccountDao aDao = new AccountDao();
		
	 	String userid  = bean.getUserid();
		String job = request.getParameter("job").trim();
		String fromDate = request.getParameter("fromDate").trim();
		String toDate = request.getParameter("toDate").trim();

		List res = aDao.getPointHistory(userid, job, fromDate, toDate);
	 	System.out.println(res);
		out.print(gson.toJson(res).toString());
	}
	
%>


