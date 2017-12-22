<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import = "bean.UserBean" %>
<%@ page import = "bean.BetConUserBean" %>
<%@ page import = "dao.UserDao" %>
<%@ page import = "dao.BetConDao" %>
<%@ page import = java.util.ArrayList" %>
<%@ page import = "bean.MgBettingProfileBean" %>
<%@ page import = "bean.MgPlayerAccountBean" %>
<%@ page import = "controller.TotalEgameController" %>
<%@ page import = "controller.SpinCubeController" %>
<%@ page import ="com.google.gson.reflect.TypeToken" %>
<%@ page import ="java.util.StringTokenizer" %>
<%@ page import ="java.sql.SQLException" %>
<%@ page import ="bean.JoinCodeBean" %>
<%@ page import ="dao.JoinCodeDao" %>
<%@ page import ="bean.SmsAuthBean" %>
<%@ page import ="dao.SmsDao" %>


<%@ include file="/inc/session.jsp"%>

<%
	UserBean post_ub 		= new UserBean();
	JoinCodeBean jcBean 	= new JoinCodeBean();
	SmsAuthBean smsBean 	= new SmsAuthBean();
	BetConUserBean bc_user	= new BetConUserBean();
	
	UserDao ud 			= new UserDao();
	JoinCodeDao jcDao 	= new JoinCodeDao();
	SmsDao smsDao 		= new SmsDao();
	BetConDao bc_db		= new BetConDao();
	
	String xForwardedForHeader = request.getHeader("X-Forwarded-For");	 
	String ip = "";
    if (xForwardedForHeader == null) {
        ip = request.getRemoteAddr();
    }else{
        ip =  new StringTokenizer(xForwardedForHeader, ",").nextToken().trim();
    }
	// String cell = request.getParameter("cell_prefix").trim().substring(1) + request.getParameter("cell").trim();

	post_ub.setUserid(request.getParameter("userid").trim());
	post_ub.setBank_name(request.getParameter("bank_name").trim());
	post_ub.setBank_num(request.getParameter("bank_num").trim());
	post_ub.setBank_owner(request.getParameter("bank_owner").trim());
	post_ub.setCell(request.getParameter("cell"));
	post_ub.setCell_prefix(request.getParameter("cell_prefix"));
	post_ub.setPasswd(request.getParameter("passwd").trim());
	post_ub.setRecommend(request.getParameter("referrer").trim());
	post_ub.setNick(request.getParameter("nick").trim());
	post_ub.setIp(ip);

	jcBean.setUserid(request.getParameter("userid").trim());
	jcBean.setJoincode(request.getParameter("recommend").trim());
	jcBean.setRecommend(request.getParameter("referrer").trim());

	smsBean.setUserid(request.getParameter("userid").trim());
	// smsBean.setTel(cell);
	smsBean.setCell(request.getParameter("cell"));
	smsBean.setCell_prefix(request.getParameter("cell_prefix"));
	smsBean.setAuthcode(request.getParameter("cert").trim());
	
	String teg_resp	= "";
	String site_id	= "1";
	
    TotalEgameController teg_ctrl					= new TotalEgameController();
    SpinCubeController sc_ctrl						= new SpinCubeController(site_id.concat("_").concat(request.getParameter("userid")));
	MgPlayerAccountBean user_profile 				= new MgPlayerAccountBean();
	MgBettingProfileBean bet_profile				= new MgBettingProfileBean();
	ArrayList<MgBettingProfileBean> bet_profiles	= new ArrayList<MgBettingProfileBean>();

    boolean status = false;
	try {
		
		status = ud.setUser(post_ub);
		
		if (status) {
			String mb_pref	= request.getParameter("cell_prefix").trim().substring(1);
			
			boolean updateJoinCode = jcDao.updateJoinCodeRegister(jcBean);
			boolean updateSms = smsDao.updateUserAuthSms(smsBean);

			UserBean ub = new UserBean();
			ub = ud.getUser(request.getParameter("userid"), request.getParameter("passwd"), Integer.valueOf(site_id));
			
			/*--------------------------------------------------------------------
	        |	Add user to Microgaming System
	        |-------------------------------------------------------------------*/
	        /*	Configure MG User parameters	*/
			bet_profile.setCategory("LGBetProfile");
			bet_profile.setProfileId(1202);
			
			bet_profiles.add(bet_profile);
			
			user_profile.setPreferredAccountNumber(site_id.concat("_").concat(request.getParameter("userid").trim()));
			user_profile.setFirstName(request.getParameter("userid").trim().concat("FNAME"));
			user_profile.setLastName(request.getParameter("userid").trim().concat("LNAME"));
			user_profile.setEmail("");
			user_profile.setMobilePrefix(mb_pref);
			user_profile.setMobileNumber(request.getParameter("cell").trim());
			user_profile.setDepositAmount(0);
			user_profile.setPinCode("newplayer1");
			user_profile.setIsProgressive(0);
			user_profile.setBettingProfiles(bet_profiles);
			
			teg_resp = teg_ctrl.addPlayerAccount(user_profile);
			
			/*--------------------------------------------------------------------
	        |	Add User to Betconstruct Table
	        |-------------------------------------------------------------------*/
	        bc_user.setUsername(ub.getUserid());
	        bc_user.setSession_token(Integer.toString(ub.getSiteid()).concat("_").concat(ub.getUserid()));
	        bc_user.setSite_id(ub.getSiteid());
			
	        bc_db.addNewBcUser(bc_user);
	        
	        /*--------------------------------------------------------------------
	        |	Add User to SpinCube
	        |-------------------------------------------------------------------*/
	        sc_ctrl.createPlayer();
	        
			/*--------------------------------------------------------------------
	        |	Intialize user session
	        |-------------------------------------------------------------------*/
			HttpSession user_session = request.getSession(true);	    
			session.setMaxInactiveInterval(7200);
	        
	        boolean updateSession = ud.updateUserAfterLogin(Integer.toString(ub.getSiteid()), ub.getUserid(), request.getParameter("passwd").trim(), session.getId(), ip);
	        
	        checkSession 	= true;	
			session 		= request.getSession(false);
			session.setMaxInactiveInterval(7200);
			
			session.setAttribute("SITEID", ub.getSiteid());
			session.setAttribute("SSID", ub.getUserid());
			session.setAttribute("UID", ub.getUserid());
			session.setAttribute("NICK", ub.getNick());
			session.setAttribute("UCLEVEL", ub.getCharge_level());
			session.setAttribute("UGRADE", ub.getGrade());
			session.setAttribute("UBAL", ub.getMoney());
			session.setAttribute("UPOINT", ub.getPoint());
		}
		
		out.println(status);

	} catch (SQLException e) {
		e.printStackTrace();
	}


%>
