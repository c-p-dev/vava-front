<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.vavasoft.bean.UserBean,net.vavasoft.dao.UserDao,java.sql.SQLException;" %>
<%

	/*	Response Code	
	 * 	9 - fail (default)
	 *  0 - success
	 *  1 - wrong password
	 *  2 - unknown userid
	 * */

	String userid = request.getParameter("userid").trim();
	String passwd = request.getParameter("passwd").trim();
	int response_code = 4;

	try {
		UserBean ub;
		UserDao userDao = new UserDao();
		
		
		ub = userDao.getUser(userid,passwd);
		response_code = (int) ub.getLoginStatus();
		
		if(response_code == 0){
			//create session 
			HttpSession user_session = request.getSession(true);	    
			session.setMaxInactiveInterval(7200);
	        session.setAttribute("currentSessionUser",ub);
		}	
	
	} catch (SQLException e) {
		System.out.println(e);
		e.printStackTrace();
	}

	

	out.println(response_code);
%>
