<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import = "bean.UserBean" %>
<%@ page import = "bean.MgAccountAvailable" %>
<%@ page import = "bean.MgBettingProfileBean" %>
<%@ page import = "bean.BetConUserBean" %>
<%@ page import = "bean.MgPlayerAccountBean" %>
<%@ page import = "dao.UserDao" %>
<%@ page import = "dao.BetConDao" %>
<%@ page import = "controller.*" %>
<%@ page import = "com.google.gson.Gson" %>
<%@ page import ="java.util.HashMap" %>
<%@ page import ="java.util.ArrayList" %>

<%@ include file="/inc/session.jsp"%>


<%

	/*	Response Code	
	 * 	9 - fail (default)
	 *  0 - success
	 *  1 - wrong password
	 *  2 - unknown userid
	 * */
	 Gson gson		= new Gson();

	String userid	= "";
	String passwd	= "";
		
	if (request.getParameter("userid") != null && request.getParameter("userid").trim().length() > 0) {
		userid =request.getParameter("userid") ;
	}
	
	if (request.getParameter("passwd") != null && request.getParameter("passwd").trim().length() > 0) {
   		passwd =request.getParameter("passwd") ;
	}
		
	UserBean ub = new UserDao().checkLogin(SITEID, userid,passwd,IP,sess.getId());
	
	int response_code = ub.getLoginStatus();
	
	if ( response_code == 0) {			
		
		SpinCubeController sc_ctrl = new SpinCubeController(SITEID+"_"+userid);  
		sc_ctrl.createPlayer();

    BetConDao bc_db		= new BetConDao();    
   	BetConUserBean bc_user	= new BetConUserBean();
    bc_user.setUsername(userid);
    bc_user.setSession_token(SITEID+"_"+userid);
    bc_user.setSite_id(1);

    bc_db.addNewBcUser(bc_user);	  
    
    
    checkSession 	= true;	
		//sess 		= request.getSession(false);
		sess.setMaxInactiveInterval(7200);	
		sess.putValue("SITEID",ub.getSiteid());
		sess.putValue("SSID",ub.getUserid());
		sess.putValue("UID",ub.getUserid());
		sess.putValue("NICK",ub.getNick());
		sess.putValue("UCLEVEL",ub.getCharge_level());
		sess.putValue("UGRADE",ub.getGrade());
		sess.putValue("UBAL",ub.getMoney());
		sess.putValue("UPOINT",ub.getPoint());
		
		
    
	}
	
	HashMap<String, Object> hsm = new HashMap<String, Object>();
	
	hsm.put("result",response_code);
	hsm.put("uid",userid);
	out.println(gson.toJson(hsm).toString());
%>
