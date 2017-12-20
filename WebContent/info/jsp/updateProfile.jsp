<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import = "bean.UserBean" %>
<%@ page import = "dao.UserDao" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.List" %>
<%@ page import = "com.google.gson.reflect.TypeToken" %>
<%@ page import = "java.util.StringTokenizer" %>

<%

	
	

	if(session.getAttribute("UID") != null){
	 	UserDao ud 			= new UserDao();
	 	String bank_name 	= request.getParameter("bank_name").trim();
		String bank_num 	= request.getParameter("bank_num").trim();
		String bank_owner 	= request.getParameter("bank_owner").trim();
		String cell 		= request.getParameter("cell").trim();
		String cell_prefix 	= request.getParameter("cell_prefix").trim();

		boolean result = false;

		result = ud.updateUserProfile(session.getAttribute("UID"), bank_name, bank_owner,bank_num, cell_prefix,cell);
		
		if (result) {
			/*	Override session here	*/
			HttpSession user_session = request.getSession(true);
			session.setMaxInactiveInterval(7200);
	        
		}

		out.println(result);

	}

%>

