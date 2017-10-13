<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import = "net.vavasoft.bean.UserBean" %>
<%@ page import = "net.vavasoft.dao.UserDao" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.List" %>
<%@ page import = "com.google.gson.reflect.TypeToken" %>
<%@ page import = "java.util.StringTokenizer" %>

<%

	
	

	if(session.getAttribute("currentSessionUser") != null){
		UserBean bean = (UserBean) session.getAttribute("currentSessionUser");
	 	UserDao ud = new UserDao();
	 	String bank_name = request.getParameter("bank_name").trim();
		String bank_num = request.getParameter("bank_num").trim();
		String bank_owner = request.getParameter("bank_owner").trim();
		String cell = request.getParameter("cell").trim();
		String cell_prefix = request.getParameter("cell_prefix").trim();

		boolean result = false;

		result = ud.updateUserProfile(bean.getUserid(), bank_name, bank_owner,bank_num, cell_prefix+cell);
		if(result){
			//override session here
			HttpSession user_session = request.getSession(true);	    
			session.setMaxInactiveInterval(7200);
	        session.setAttribute("currentSessionUser",ud.getUserInfoByUserid(bean.getUserid()));
		}

		out.println(result);

	}

%>

