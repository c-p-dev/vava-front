package net.vavasoft.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import net.arnx.jsonic.JSON;
import net.vavasoft.bean.MgBettingProfileBean;
import net.vavasoft.bean.MgPlayerAccountBean;
import net.vavasoft.controller.TotalEgameController;
import test.BetConManager_Test2;


/**
 * Servlet implementation class UserServlets
 */
@WebServlet("/UserServlets")
public class UserRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static Logger logger = Logger.getLogger(UserRegister.class);
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		BetConManager_Test2 bm = new BetConManager_Test2();
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		out.print(bm.getJson());
		out.flush();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = "validate";
		boolean status  = false;
		String message = "View error list";
		
		HashMap<String, Object> result = new HashMap<String,Object>();
		HashMap<String, Object> validationHsm = validateForm(request,response);
		PrintWriter out = response.getWriter();
		
		int errors = (int) validationHsm.get("error_count");
		ArrayList ResponseList = (ArrayList) validationHsm.get("response_list");
		
		action = request.getParameter("action").toString();
		if("submit".equals(request.getParameter("action")) && errors <= 0){
			HashMap<String, Object> saveUserHsm = saveUser(request,response);
			status = (boolean) saveUserHsm.get("status");
			message = (String) saveUserHsm.get("message");
		
		}
		
		response.setContentType("application/json");
		result.put("status",status);
		result.put("response",ResponseList);
		result.put("message",message);
		
		String res = JSON.encode(result);	
		out.print(res);
		out.flush();
	}
	
	public HashMap validateForm (HttpServletRequest request, HttpServletResponse response){
		
		int error = 0;
		String message = "Form is not valid";
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
		String ip = getClientIpAddress(request);
		
		HashMap<String, Object> hsm = new HashMap<String, Object>();
		HashMap<String, Object> result = new HashMap<String,Object>();
		HashMap<String, Object> hashmaps;
		HashMap<String, Object> useridhsm = validateUserid(userid);
		HashMap<String, Object> userexistshsm = validateUserExists(referrer);
		HashMap<String, Object> nickexistshsm = validateNickname(nick);

		boolean validUserId = (boolean) useridhsm.get("valid");
		boolean userExists = (boolean)  userexistshsm.get("valid");
		boolean nickexists = (boolean) nickexistshsm.get("valid");
		
		ArrayList ResponseList = new ArrayList();
		
		
		
//		logger.debug(validUserId);
	
		
		if(!validUserId){
			error++;
			hashmaps = new HashMap<String,Object>();
			hashmaps.put("message",(String) useridhsm.get("message"));
			hashmaps.put("field","userid");
			hashmaps.put("valid",false);
			ResponseList.add(hashmaps);	
		}else{
			hashmaps = new HashMap<String,Object>();
			hashmaps.put("message",(String) useridhsm.get("message"));
			hashmaps.put("field","userid");
			hashmaps.put("valid",true);
			ResponseList.add(hashmaps);
		}
		
		if (!nickexists){
			error++;
			hashmaps = new HashMap<String,Object>();
			hashmaps.put("message",(String) nickexistshsm.get("message") );
			hashmaps.put("field","nick");
			hashmaps.put("valid",false);
			ResponseList.add(hashmaps);	
			
		}else{
			hashmaps = new HashMap<String,Object>();
			hashmaps.put("message", (String) nickexistshsm.get("message"));
			hashmaps.put("field","nick");
			hashmaps.put("valid",true);
			ResponseList.add(hashmaps);
		}
		
		if (!checkPasswd(passwd)){
			error++;
			hashmaps = new HashMap<String,Object>();
			hashmaps.put("message","Invalid Password");
			hashmaps.put("field","passwd");
			hashmaps.put("valid",false);
			ResponseList.add(hashmaps);	
			
		}else{
			hashmaps = new HashMap<String,Object>();
			hashmaps.put("message", "Valid Password");
			hashmaps.put("field","passwd");
			hashmaps.put("valid",true);
			ResponseList.add(hashmaps);
		}
		
		if(bank_owner.length()<= 0){
			error++;
			hashmaps = new HashMap<String,Object>();
			hashmaps.put("message","Invalid Name");
			hashmaps.put("field","bank_owner");
			hashmaps.put("valid",false);
			ResponseList.add(hashmaps);	
		}
		
		if(!checkBankAccNum(bank_num)){
			error++;
			hashmaps = new HashMap<String,Object>();
			hashmaps.put("message","Invalid Bank Account");
			hashmaps.put("field","bank_num");
			hashmaps.put("valid",false);
			ResponseList.add(hashmaps);	
			
		}
		if(!checkPhoneNum(cell)){
			error++;
			hashmaps = new HashMap<String,Object>();
			hashmaps.put("message","Invalid Mobile Phone Number");
			hashmaps.put("field","cell");
			hashmaps.put("valid",false);
			ResponseList.add(hashmaps);	
		}
		
		if(cert.length() <= 0 ){
			error++;
			hashmaps = new HashMap<String,Object>();
			hashmaps.put("message","Invalid Certification Number");
			hashmaps.put("field","cert");
			hashmaps.put("valid",false);
			ResponseList.add(hashmaps);	
		}
		if(!userExists){
			error++;
			hashmaps = new HashMap<String,Object>();
			hashmaps.put("message",(String) userexistshsm.get("message"));
			hashmaps.put("field","referrer");
			hashmaps.put("valid",false);
			ResponseList.add(hashmaps);	
			
		}
		if(recommend.length() <= 0){
			error++;
			hashmaps = new HashMap<String,Object>();
			hashmaps.put("message","Invalid Recommendation Code");
			hashmaps.put("field","recommend");
			hashmaps.put("valid",false);
			ResponseList.add(hashmaps);	
		}
		
		hsm.put("error_count", error );
		hsm.put("response_list",ResponseList);
		
		return hsm;
		
	}
	
	public HashMap saveUser(HttpServletRequest request, HttpServletResponse response){
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
		String ip = getClientIpAddress(request);
		
		boolean status = false;
		String message = "error";
		BetConManager_Test2 bm = new BetConManager_Test2();
		HashMap<String, Object> hsm = new HashMap<String, Object>();
		try {
			status = bm.setUser(userid, passwd, cell, bank_name, bank_owner, bank_num, cert,ip,nick,referrer);
			if(!status){
				message = "Theres a problem adding user.";
			}else{
				message = "Added User Successfully";
				this.createMgAccount(request);
			}
			
		} catch (SQLException e) {
			message = e.toString();
			logger.debug(e);
			e.printStackTrace();
		}

		hsm.put("status", status );
		hsm.put("message",message);	

		return hsm;
		
	}
	
	public String createMgAccount(HttpServletRequest request)
	{
		TotalEgameController teg_ctrl					= new TotalEgameController();
		MgPlayerAccountBean user_profile 				= new MgPlayerAccountBean();
		MgBettingProfileBean bet_profile				= new MgBettingProfileBean();
		ArrayList<MgBettingProfileBean> bet_profiles	= new ArrayList<MgBettingProfileBean>();
		
		String teg_resp	= "";
		String mb_pref	= request.getParameter("cell_prefix").trim().substring(1);
		
		bet_profile.setCategory("LGBetProfile");
		bet_profile.setProfileId(1202);
		
		bet_profiles.add(bet_profile);
		
		user_profile.setPreferredAccountNumber(request.getParameter("userid").trim());
		user_profile.setFirstName(request.getParameter("nick"));
		user_profile.setLastName(request.getParameter("bank_owner").trim());
		user_profile.setEmail("");
		user_profile.setMobilePrefix(mb_pref);
		user_profile.setMobileNumber(request.getParameter("cell").trim());
		user_profile.setDepositAmount(0);
		user_profile.setPinCode(request.getParameter("passwd").trim());
		user_profile.setIsProgressive(0);
		user_profile.setBettingProfiles(bet_profiles);
		
		teg_resp = teg_ctrl.addPlayerAccount(user_profile);
		
		return teg_resp;
	}
	
	public HashMap validateUserid(String userid){
		HashMap<String, Object> hsm = new HashMap<String, Object>();
		boolean valid = false;
		String message = "Invalid Id";
		Pattern p = Pattern.compile("[\\\"\\\'\\/`.,;:!\\[\\]@#$%&*()_+=|<>?{}\\\\[\\\\]~-]", Pattern.CASE_INSENSITIVE);
		Matcher m = p.matcher(userid);
		boolean speacialChar = m.find();
		BetConManager_Test2 bm = new BetConManager_Test2();
		boolean checkUserIdDuplicate = true;
		try {
			checkUserIdDuplicate = bm.checkUserId(userid);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if(!(userid.length() >= 6  && userid.length() <= 12 )){
			message = "Invalid Character Length";
		}else if(speacialChar){
			message = "Id must not contain Special Character";
		}else if(checkUserIdDuplicate){
			message = "Id is already taken";
		}else{
			message ="Valid User Id";
			valid = true;
		}
		
		hsm.put("valid", valid );
		hsm.put("message",message);
		
		
//		logger.debug(hsm);
		return hsm;
		

	}
	
	
	public HashMap validateUserExists(String userid){

		HashMap<String, Object> hsm = new HashMap<String, Object>();
		boolean valid = false;
		String message = "Invalid User Id";
		
		BetConManager_Test2 bm = new BetConManager_Test2();
		boolean checkUserIdDuplicate = true;
		try {
			checkUserIdDuplicate = bm.checkUserId(userid);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if(userid.length() <= 0){
			message = "Invalid Character Length";
		}else if(!checkUserIdDuplicate){
			message = "Unknown User";
		}else{
			message ="Valid User Id";
			valid = true;
		}
		
		hsm.put("valid", valid );
		hsm.put("message",message);
		
		
//		logger.debug(hsm);
		return hsm;
		

	}
	
	
	public HashMap validateNickname(String nickname){
		HashMap<String, Object> hsm = new HashMap<String, Object>();
		boolean valid = false;
		String message = "Invalid Nickname";
		
		
		Pattern p = Pattern.compile("[\\\"\\\'\\/`.,;:!\\[\\]@#$%&*()_+=|<>?{}\\\\[\\\\]~-]", Pattern.CASE_INSENSITIVE);
		Matcher m = p.matcher(nickname);
		boolean speacialChar = m.find();
		
		BetConManager_Test2 bm = new BetConManager_Test2();
		boolean checkNickDuplicate = true;
		try {
			checkNickDuplicate = bm.checkNickname(nickname);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if(nickname.length() <= 0 && nickname.length() <= 20){
			message = "Invalid Character Length";
		}else if(speacialChar){
			message = "Characater must not contain special Character";
		}
		else if(checkNickDuplicate){
			message = "Nickname Already Exists";
		}else{
			message ="Valid Nickname";
			valid = true;
		}
		
		hsm.put("valid", valid );
		hsm.put("message",message);
		
		
//		logger.debug(hsm);
		return hsm;
		

	}
	
	
	public boolean checkStringLength(String val){
		boolean valid = false;
		if(val.length() > 0){
			valid = true;
		}
		return valid;
	}
	
	
	public boolean checkBankAccNum(String val){
		boolean valid = false;
		if(val.matches("[0-9]{4,12}")){
			valid = true;
		}
		return valid;
	}
	
	
	public boolean checkPhoneNum(String val){
		boolean valid = false;
		if(val.matches("\\+[0-9]{11,}")){
			valid = true;
		}
		return valid;
	}

	
	public boolean checkPasswd(String val){
		boolean valid = false;
		if(val.length() >= 4 && val.length() <=20 ){
			valid = true;
		}
		return valid;
	}
	
	
	public static String getClientIpAddress(HttpServletRequest request) {
	    String xForwardedForHeader = request.getHeader("X-Forwarded-For");
	    if (xForwardedForHeader == null) {
	        return request.getRemoteAddr();
	    } else {
	        // As of https://en.wikipedia.org/wiki/X-Forwarded-For
	        // The general format of the field is: X-Forwarded-For: client, proxy1, proxy2 ...
	        // we only want the client
	        return new StringTokenizer(xForwardedForHeader, ",").nextToken().trim();
	    }
	}
	
	
	

}
