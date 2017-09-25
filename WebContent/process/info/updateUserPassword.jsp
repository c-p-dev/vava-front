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
		boolean result = false;
		
		String current_passwd = request.getParameter("current_password").trim();
		String new_passwd = request.getParameter("new_passowrd").trim();

		result = ud.updateUserPasswd(bean.getUserid(),current_passwd,new_passwd);
		out.println(result);

	}
%>