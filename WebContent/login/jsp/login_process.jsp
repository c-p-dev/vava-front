<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import = "bean.UserBean" %>
<%@ page import = "dao.UserDao" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "com.google.gson.Gson" %>
<%@ page import ="java.util.HashMap" %>

<%

	/*	Response Code	
	 * 	9 - fail (default)
	 *  0 - success
	 *  1 - wrong password
	 *  2 - unknown userid
	 * */

	// UserBean post_ub = new UserBean();
	// post_ub.setUserid(request.getParameter("userid").trim());
	// post_ub.setPasswd(request.getParameter("passwd").trim());
	Gson gson = new Gson();
	HashMap<String, Object> hsm = new HashMap<String, Object>();

	String userid = request.getParameter("userid").trim();
	String passwd = request.getParameter("passwd").trim();

	int response_code = 9;

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
	        int updateSession = userDao.updateUserAfterLogin(ub.getUserid(), session.getId());
	        System.out.println(updateSession);
		}	
	
	} catch (SQLException e) {
		System.out.println(e);
		e.printStackTrace();
	}

	

	hsm.put("result",response_code);
	out.println(gson.toJson(hsm).toString());
%>
