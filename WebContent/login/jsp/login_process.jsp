<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import = "bean.UserBean" %>
<%@ page import = "dao.UserDao" %>
<%@ page import = "com.google.gson.Gson" %>
<%@ page import ="java.util.HashMap" %>


<%@ include file="/inc/session.jsp"%>


<%

	/*	Response Code	
	 * 	9 - fail (default)
	 *  0 - success
	 *  1 - wrong password
	 *  2 - unknown userid
	 * */

	String userid="";
	String passwd="";
		
	if(request.getParameter("userid") != null && request.getParameter("userid").trim().length() > 0){
   userid =request.getParameter("userid") ;
	}
	
	if(request.getParameter("passwd") != null && request.getParameter("passwd").trim().length() > 0){
   passwd =request.getParameter("passwd") ;
	}
		
	UserBean ub = new UserDao().checkLogin(SITEID, userid,passwd,IP,session.getId());
	
	int response_code = ub.getLoginStatus();
	
	if( response_code == 0){			

			checkSession = true;	
			 session = request.getSession(false);
			session.setMaxInactiveInterval(7200);	
			session.putValue("SSID",ub.getUserid());
			session.putValue("UID",ub.getUserid());
			session.putValue("NICK",ub.getNick());
			session.putValue("UCLEVEL",ub.getCharge_level());
			session.putValue("UGRADE",ub.getGrade());
			session.putValue("UBAL",ub.getMoney());
			session.putValue("UPOINT",ub.getPoint());
		}	
	
	
	Gson gson = new Gson();
	HashMap<String, Object> hsm = new HashMap<String, Object>();
	
	hsm.put("result",response_code);
	out.println(gson.toJson(hsm).toString());
%>
