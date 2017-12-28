<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import = "bean.UserBean" %>
<%@ page import = "bean.BetConUserBean" %>
<%@ page import = "dao.UserDao" %>
<%@ page import = "dao.BetConDao" %>

<%@ page import = "bean.MgBettingProfileBean" %>
<%@ page import = "bean.MgPlayerAccountBean" %>
<%@ page import = "controller.TotalEgameController" %>
<%@ page import = "controller.SpinCubeController" %>
<%@ page import ="com.google.gson.reflect.TypeToken" %>


<%@ page import ="bean.JoinCodeBean" %>
<%@ page import ="dao.JoinCodeDao" %>
<%@ page import ="bean.SmsAuthBean" %>
<%@ page import ="dao.SmsDao" %>


<%@ include file="/inc/session.jsp"%>


<%
	JoinCodeBean jcBean 	= new JoinCodeBean();
	SmsAuthBean smsBean 	= new SmsAuthBean();

	
	UserDao ud 			= new UserDao();
	JoinCodeDao jcDao 	= new JoinCodeDao();
	SmsDao smsDao 		= new SmsDao();

	String userid = request.getParameter("userid").trim();
	String bank_name = request.getParameter("bank_name").trim();
	String bank_num = request.getParameter("bank_num").trim();
	String bank_owner = request.getParameter("bank_owner").trim();
	String cell = request.getParameter("cell").trim();
	String cell_prefix = request.getParameter("cell_prefix").trim();
	String passwd = request.getParameter("passwd").trim();
	String referrer = request.getParameter("referrer").trim();
	String nick = request.getParameter("nick").trim();
	String recommend = request.getParameter("recommend").trim();
	String cert = request.getParameter("cert").trim();
	
  	UserBean ub = new UserBean();
	
		ub.setUserid(userid);
		ub.setSiteid(Integer.parseInt(SITEID));
		ub.setBank_name(bank_name);
		ub.setBank_num(bank_num);
		ub.setBank_owner(bank_owner);
		ub.setCell(cell);
		ub.setCell_prefix(cell_prefix);
		ub.setPasswd(passwd);
		ub.setRecommend(referrer);
		ub.setNick(nick);
		ub.setJoincode(recommend);
		ub.setAuthcode(cert);
		ub.setIp(IP);
		ub.setSSid(sess.getId());
	
	boolean status = ud.setUser(ub);
	
	if (status) {

		boolean updateJoinCode = jcDao.updateJoinCodeRegister(ub);
		boolean updateSms = smsDao.updateUserAuthSms(ub);
	
        
		SpinCubeController sc_ctrl = new SpinCubeController(SITEID+"_"+userid);  
		sc_ctrl.createPlayer();

    BetConDao bc_db		= new BetConDao();    
   	BetConUserBean bc_user	= new BetConUserBean();
    bc_user.setUsername(userid);
    bc_user.setSession_token(SITEID+"_"+userid);
    bc_user.setSite_id(1);

    bc_db.addNewBcUser(bc_user);	        

/*
		sess.setAttribute("SITEID", SITEID);
		sess.setAttribute("SSID", sess.getId());
		sess.setAttribute("UID", userid);
		sess.setAttribute("NICK", nick);
		sess.setAttribute("UCLEVEL", "LOW");
		sess.setAttribute("UGRADE", 1);
		sess.setAttribute("UBAL", 0);
		sess.setAttribute("UPOINT",0);	
*/
		}
		
		out.println(status);
%>
