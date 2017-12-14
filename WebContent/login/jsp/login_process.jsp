<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import = "bean.UserBean" %>
<%@ page import = "bean.MgAccountAvailable" %>
<%@ page import = "bean.MgBettingProfileBean" %>
<%@ page import = "bean.BetConUserBean" %>
<%@ page import = "bean.MgPlayerAccountBean" %>
<%@ page import = "controller.*" %>
<%@ page import = "dao.UserDao" %>
<%@ page import = "dao.BetConDao" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "com.google.gson.Gson" %>
<%@ page import ="java.util.HashMap" %>
<%@ page import ="java.util.ArrayList" %>

<%

	/*	Response Code	
	 * 	9 - fail (default)
	 *  0 - success
	 *  1 - wrong password
	 *  2 - unknown userid
	 * */
	
	Gson gson 					= new Gson();
	HashMap<String, Object> hsm = new HashMap<String, Object>();
	
	String userid = request.getParameter("userid").trim();
	String passwd = request.getParameter("passwd").trim();
	
	int response_code = 9;

	try {
		UserBean ub;
		UserDao userDao = new UserDao();
		
		ub 				= userDao.getUser(userid,passwd);
		response_code 	= (int) ub.getLoginStatus();
		
		if (0 == response_code) {
			//create session 
			HttpSession user_session = request.getSession(true);	    
			session.setMaxInactiveInterval(7200);
	        session.setAttribute("currentSessionUser",ub);
	        int updateSession = userDao.updateUserAfterLogin(ub.getUserid(), session.getId());
	        
	        /*	Set Game Username	*/
	        String game_username			= Integer.toString(ub.getSiteid()).concat("_").concat(ub.getUserid());
	        
	        /*	Initialize Controllers	*/
	    	TotalEgameController teg_ctrl	= new TotalEgameController();
	    	SpinCubeController sc_ctrl		= new SpinCubeController(game_username);
	    	BetConstructController bc_ctrl	= new BetConstructController();
	    	
	        /*--------------------------------------------------------------------
	        |	Check registration on MG
	        |-------------------------------------------------------------------*/
	        String teg_json				= teg_ctrl.checkIsAccountAvailable(game_username);
	        System.out.println(teg_json);
	        MgAccountAvailable teg_resp	= gson.fromJson(teg_json, MgAccountAvailable.class);
	        
	        if (0 == teg_resp.getStatus().getErrorCode()) {
	        	/*	TEg account does not exist	*/
	        	if (true == teg_resp.getResult().getAccountAvailable()) {
	        		/*	Create TEg account	*/
	        		MgPlayerAccountBean user_profile 				= new MgPlayerAccountBean();
	        		MgBettingProfileBean bet_profile				= new MgBettingProfileBean();
	        		ArrayList<MgBettingProfileBean> bet_profiles	= new ArrayList<MgBettingProfileBean>();
	        		
	        		String cell_prefix	= "+".concat(ub.getCell().substring(0, 1));
	        		System.out.println(cell_prefix);
	        		bet_profile.setCategory("LGBetProfile");
	    			bet_profile.setProfileId(1202);
	    			
	    			bet_profiles.add(bet_profile);
	    			
	    			user_profile.setPreferredAccountNumber(Integer.toString(ub.getSiteid()).concat("_").concat(ub.getUserid()));
	    			user_profile.setFirstName(ub.getUserid().concat("FNAME"));
	    			user_profile.setLastName(ub.getUserid().trim().concat("LNAME"));
	    			user_profile.setEmail("");
	    			user_profile.setMobilePrefix(cell_prefix);
	    			user_profile.setMobileNumber(ub.getCell().substring(2));
	    			user_profile.setDepositAmount(0);
	    			user_profile.setPinCode("newplayer1");
	    			user_profile.setIsProgressive(0);
	    			user_profile.setBettingProfiles(bet_profiles);
	    			
	    			String add_resp = teg_ctrl.addPlayerAccount(user_profile);
	    			System.out.println(add_resp);
	        	}
	        }
	        
	        /*--------------------------------------------------------------------
	        |	Check registration on SpinCube
	        |-------------------------------------------------------------------*/
	        sc_ctrl.createPlayer();
	        
	        /*--------------------------------------------------------------------
	        |	Check registration on BetContruct
	        |-------------------------------------------------------------------*/
	        BetConDao bc_db			= new BetConDao();
	        BetConUserBean bc_user	= new BetConUserBean();
	        
	        bc_user	= bc_db.getUserByUsername(ub.getUserid(), ub.getSiteid());
	        
	        if (null == bc_user.getUsername()) {
	        	/*	Create Betcon account	*/
	        	bc_user.setUsername(ub.getUserid());
		        bc_user.setSession_token(Integer.toString(ub.getSiteid()).concat("_").concat(ub.getUserid()));
		        bc_user.setSite_id(ub.getSiteid());
				
		        bc_db.addNewBcUser(bc_user);
	        }
		}	
	
	} catch (SQLException e) {
		System.out.println(e);
		e.printStackTrace();
	}

	hsm.put("result",response_code);
	out.println(gson.toJson(hsm).toString());
%>
