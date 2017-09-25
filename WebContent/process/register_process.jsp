<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="
	net.vavasoft.bean.UserBean,
	net.vavasoft.dao.UserDao,
	java.sql.SQLException,
	java.util.ArrayList,
	java.util.List,
	net.vavasoft.bean.MgBettingProfileBean,
	net.vavasoft.bean.MgPlayerAccountBean,
	net.vavasoft.controller.TotalEgameController,
	com.google.gson.reflect.TypeToken,
	java.util.StringTokenizer;" %>
<%
	
	String userid = request.getParameter("userid").trim();
	String bank_name = request.getParameter("bank_name").trim();
	String bank_num = request.getParameter("bank_num").trim();
	String bank_owner = request.getParameter("bank_owner").trim();
	String cell = request.getParameter("cell_prefix").trim() + request.getParameter("cell").trim();
	String cert = request.getParameter("cert").trim();
	String passwd = request.getParameter("passwd").trim();
	String recommend = request.getParameter("recommend").trim();
	String referrer = request.getParameter("referrer").trim();
	String nick = request.getParameter("nick").trim();		
	String ip = "";

	String xForwardedForHeader = request.getHeader("X-Forwarded-For");	 
    if (xForwardedForHeader == null) {
        ip = request.getRemoteAddr();
    }else{
        // As of https://en.wikipedia.org/wiki/X-Forwarded-For
        // The general format of the field is: X-Forwarded-For: client, proxy1, proxy2 ...
        // we only want the client
        ip =  new StringTokenizer(xForwardedForHeader, ",").nextToken().trim();
    }

    TotalEgameController teg_ctrl					= new TotalEgameController();
	MgPlayerAccountBean user_profile 				= new MgPlayerAccountBean();
	MgBettingProfileBean bet_profile				= new MgBettingProfileBean();
	ArrayList<MgBettingProfileBean> bet_profiles	= new ArrayList<MgBettingProfileBean>();


    UserDao ud = new UserDao();
    boolean status = false;
	try {
		status = ud.setUser(userid, passwd, cell, bank_name, bank_owner, bank_num, cert,ip,nick,referrer);
		if(status){
			String teg_resp	= "";
			String mb_pref	= request.getParameter("cell_prefix").trim().substring(1);
			
			bet_profile.setCategory("LGBetProfile");
			bet_profile.setProfileId(1202);
			
			bet_profiles.add(bet_profile);
			
			user_profile.setPreferredAccountNumber(request.getParameter("userid").trim());
			user_profile.setFirstName(request.getParameter("userid").trim().concat("FNAME"));
			user_profile.setLastName(request.getParameter("userid").trim().concat("LNAME"));
			user_profile.setEmail("");
			user_profile.setMobilePrefix(mb_pref);
			user_profile.setMobileNumber(request.getParameter("cell").trim());
			user_profile.setDepositAmount(0);
			user_profile.setPinCode(request.getParameter("passwd").trim());
			user_profile.setIsProgressive(0);
			user_profile.setBettingProfiles(bet_profiles);
			
			teg_resp = teg_ctrl.addPlayerAccount(user_profile);
			

			UserBean ub;
			ub = ud.getUser(userid,passwd);
			HttpSession user_session = request.getSession(true);	    
			session.setMaxInactiveInterval(7200);
	        session.setAttribute("currentSessionUser",ub);
	        int updateSession = ud.updateUserAfterLogin(ub.getUserid(), session.getId());
	        System.out.println(ub.getLoginStatus());	
	        System.out.println(updateSession);	
		}
		
		out.println(status);

	} catch (SQLException e) {
		e.printStackTrace();
	}


%>
