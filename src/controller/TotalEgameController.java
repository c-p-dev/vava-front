package controller;

import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Random;
import java.util.Scanner;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import bean.MgBettingProfileBean;
import bean.MgDepositBean;
import bean.MgLiveGamesTransBean;
import bean.MgPlayerAccountBean;
import bean.MgResponseStatusBean;
import bean.MgWithdrawAllBean;
import bean.ScTransactionBean;
import bean.UserBean;
import dao.MgLiveTransLogDao;
import dao.UserDao;
import util.NukeSSLCerts;
import util.StringManipulator;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;
import javax.net.ssl.HttpsURLConnection;

public class TotalEgameController {
	
    private String username		= "testagent212555";
	private String password		= "b43e0b";
	private String enc_creds	= "";
	private String api_base 	= "https://tegapi.totalegame.net/";
	public String charset		= "UTF-8";
	public String content_type	= "application/json";
	
	/*	Error Codes	*/
	public static final int	ACCOUNT_NOT_EXIST	= 46;
	
	//-----------------------------------------------------
    //  TotalEgameController constructor
    //      Initialize Object Properties
    //-----------------------------------------------------
	public TotalEgameController() {
		String creds			= username+":"+password;
		byte[] creds_b64		= Base64.getEncoder().encode(creds.getBytes());
		
		enc_creds				= new String(creds_b64);
	}
    
	public String addPlayerAccount(MgPlayerAccountBean user_profile)
	{
		/*	Variable Declaration	*/
		Gson gson							= new Gson();
		String url							= api_base+"AddPlayerAccount";
		String json_param					= "";
		String srv_resp						= "";
		
		/*	Convert parameters to JSON	*/
		json_param	= gson.toJson(user_profile, MgPlayerAccountBean.class);
		
		/*--------------------------------------------------------------------
        |	Execute HTTP POST Request to TEG
        |-------------------------------------------------------------------*/
		srv_resp 	= this.postToTeg(url, json_param);
		
		return srv_resp;
	}
	
	public String withdrawAll(String username)
	{
		/*	Variable Declaration	*/
		Gson gson							= new Gson();
		String url							= api_base+"WithdrawalAll";
		String json_param					= "";
		String srv_resp						= "";
		HashMap<String, Object>	teg_param	= new HashMap<String, Object>();
		
		/*	Parameters to be passed to TEG	*/
		teg_param.put("AccountNumber", username);
		
		/*	Convert parameters to JSON	*/
		json_param	= gson.toJson(teg_param, new TypeToken<HashMap<String, Object>>(){}.getType());
		
		/*--------------------------------------------------------------------
        |	Execute HTTP POST Request to TEG
        |-------------------------------------------------------------------*/
		srv_resp 	= this.postToTeg(url, json_param);
		
		return srv_resp;
	}
	
	public String deposit(String username, double money)
	{
		/*	Variable Declaration	*/
		Gson gson							= new Gson();
		String url							= api_base+"deposit";
		String json_param					= "";
		String srv_resp						= "";
		HashMap<String, Object>	teg_param	= new HashMap<String, Object>();
		
		/*	Parameters to be passed to TEG	*/
		teg_param.put("AccountNumber", username);
		teg_param.put("Amount", money);
		
		/*	Convert parameters to JSON	*/
		json_param		= gson.toJson(teg_param, new TypeToken<HashMap<String, Object>>(){}.getType());
		
		/*--------------------------------------------------------------------
        |	Execute HTTP POST Request to TEG
        |-------------------------------------------------------------------*/
		if (0 < money) {
			srv_resp 	= this.postToTeg(url, json_param);
		}
		else {
			srv_resp	= "{Status:{ErrorCode:0}}";
		}
		
		return srv_resp;
	}
	
	public String editAccount(MgPlayerAccountBean user_profile)
	{
		/*	Variable Declaration	*/
		Gson gson							= new Gson();
		String url							= api_base+"EditAccount";
		String json_param					= "";
		String srv_resp						= "";
		
		/*	Parameters to be passed to TEG	*/
		
		/*	Convert parameters to JSON	*/
		json_param		= gson.toJson(user_profile, MgPlayerAccountBean.class);
		
		/*--------------------------------------------------------------------
        |	Execute HTTP POST Request to TEG
        |-------------------------------------------------------------------*/
		srv_resp 		= this.postToTeg(url, json_param);
		System.out.println(srv_resp);
		return srv_resp;
	}
	
	public String getLiveGamesTransaction(String start_date, String end_date)
	{
		/*	Variable Declaration	*/
		Gson gson							= new Gson();
		String url							= api_base+"GetLiveGamesTransactions";
		String json_param					= "";
		String srv_resp						= "";
		HashMap<String, Object>	teg_param	= new HashMap<String, Object>();
		
		/*	Parameters to be passed to TEG	*/
		teg_param.put("FromDate", start_date);
		teg_param.put("ToDAte", end_date);
		
		/*	Convert parameters to JSON	*/
		json_param		= gson.toJson(teg_param, new TypeToken<HashMap<String, Object>>(){}.getType());
		
		/*--------------------------------------------------------------------
        |	Execute HTTP POST Request to TEG
        |-------------------------------------------------------------------*/
		srv_resp 	= this.postToTeg(url, json_param);
		
		return srv_resp;
	}
	
	public String getSpinBySpinData()
	{
		/*	Variable Declaration	*/
		Gson gson							= new Gson();
		String url							= api_base+"GetSpinBySpinData";
		String json_param					= "";
		String srv_resp						= "";
		HashMap<String, Object>	teg_param	= new HashMap<String, Object>();
		
		/*	Parameters to be passed to TEG	*/
		teg_param.put("LastRowId", "42439271547");
		
		/*	Convert parameters to JSON	*/
		json_param		= gson.toJson(teg_param, new TypeToken<HashMap<String, Object>>(){}.getType());
		
		/*--------------------------------------------------------------------
        |	Execute HTTP POST Request to TEG
        |-------------------------------------------------------------------*/
		srv_resp 	= this.postToTeg(url, json_param);
		System.out.println(srv_resp);
		return srv_resp;
	}
	
	public void extractLiveGameTransactions()
	{
		SimpleDateFormat dfrmt_start	= new SimpleDateFormat("yyyy-MM-dd 00:00:00");
		SimpleDateFormat dfrmt_end		= new SimpleDateFormat("yyyy-MM-dd 23:59:59");
		
		Gson gson						= new Gson();
		String json_resp				= "";
		MgLiveGamesTransBean trans_list	= new MgLiveGamesTransBean();
		MgLiveTransLogDao mg_db			= new MgLiveTransLogDao();
		
		Calendar cal_start				= Calendar.getInstance();
		Calendar cal_end				= Calendar.getInstance();
		
		cal_start.add(Calendar.DATE, -1);
		cal_end.add(Calendar.DATE, -1);
		
		String start_date	= dfrmt_start.format(cal_start.getTime());
		String end_date		= dfrmt_end.format(cal_end.getTime());
		
		json_resp	= this.getLiveGamesTransaction(start_date, end_date);
		
		trans_list	= gson.fromJson(json_resp, MgLiveGamesTransBean.class);
		
		for (int ctr = 0; ctr < trans_list.getResult().size(); ctr++) {
			mg_db.addNewTransactionLog(trans_list.getResult().get(ctr));
		}
	}
	
	public String userPlayCheck(String username, int game_provider, String lnk_dsp) throws MalformedURLException, IOException, ParseException
	{	
		/*	Variable Declaration	*/
		Gson gson					= new Gson();
		StringManipulator strlib	= new StringManipulator();
				
		String game_url_base	= "https://webservice.basestatic.net/ETILandingPage/index.aspx?";
		String game_url_full	= "";
		String srv_resp			= "";
		String sc_resp			= "";		
		String mg_username		= "";
		String mg_pincode		= "";
		String session_id		= "";
		double money			= 0;
		
		AsianGamingController ag_ctrl	= new AsianGamingController();
		BetConstructController bc_ctrl	= new BetConstructController();
		SpinCubeController sc_ctrl		= null;
		MgWithdrawAllBean withdraw_data = new MgWithdrawAllBean();
		MgDepositBean deposit_data 		= new MgDepositBean();
		MgPlayerAccountBean edit_data	= new MgPlayerAccountBean();
		
		ArrayList<MgBettingProfileBean> bet_profls	= new ArrayList<MgBettingProfileBean>();
		MgPlayerAccountBean mg_user		= new MgPlayerAccountBean();
		MgBettingProfileBean bet_profl	= new MgBettingProfileBean();
		ScTransactionBean sc_trans_data	= new ScTransactionBean();
				
		UserBean user_profile	= new UserBean();
		UserDao user_db			= new UserDao();
		
		/*--------------------------------------------------------------------
        |	Query Database and Update Money
        |-------------------------------------------------------------------*/
		user_profile 	= user_db.getUserByUserId(username);
		money 			= user_profile.getMoney();
		mg_username		= Integer.toString(user_profile.getSiteid()).concat("_").concat(username);
		
		/*--------------------------------------------------------------------
        |	Withdraw all cash from TEG System
        |-------------------------------------------------------------------*/
		srv_resp		= this.withdrawAll(mg_username);
		withdraw_data	= gson.fromJson(srv_resp, MgWithdrawAllBean.class);
		
		if (0 == withdraw_data.getStatus().getErrorCode()) {
			
			money 	= money + withdraw_data.getResult().getTransactionAmount();
			
			user_profile.setMoney((int)money);
			user_db.setUserMoney(username, money);
		}
		else {
			
			switch (withdraw_data.getStatus().getErrorCode()) {
				/*	MG Account does not Exist	*/
				case ACCOUNT_NOT_EXIST:
					/*	Create account for MG	*/
					bet_profl.setCategory("LGBetProfile");
					bet_profl.setProfileId(1202);
					
					bet_profls.add(bet_profl);
					
					mg_user.setPreferredAccountNumber(mg_username);
					mg_user.setFirstName(user_profile.getUserid().trim().concat("FNAME"));
					mg_user.setLastName(user_profile.getUserid().trim().concat("LNAME"));
					mg_user.setEmail("");
					mg_user.setMobilePrefix(user_profile.getCell().substring(1, 3));
					mg_user.setMobileNumber(user_profile.getCell().substring(3));
					mg_user.setDepositAmount(0);
					mg_user.setPinCode("newplayer1");
					mg_user.setIsProgressive(0);
					mg_user.setBettingProfiles(bet_profls);
					this.addPlayerAccount(mg_user);
					break;
			}
			
		}
		
		/*--------------------------------------------------------------------
        |	Withdraw all cash from SpinCube System
        |-------------------------------------------------------------------*/
		sc_ctrl			= new SpinCubeController(mg_username);
		sc_resp			= sc_ctrl.makeTransaction(null, "withdraw");
		sc_trans_data	= gson.fromJson(sc_resp, ScTransactionBean.class);
		
		if (null != sc_trans_data) {
			if (0 < sc_trans_data.getAmount()) {
				money 	= money + sc_trans_data.getAmount();
				
				user_profile.setMoney((int)money);
				user_db.setUserMoney(username, money);
			}
		}
		
		/*--------------------------------------------------------------------
        |	Game is from MicroGaming (TotalEgame API)
        |-------------------------------------------------------------------*/
		if (1 == game_provider) {
			/*	Deposit all money from VAVA to MG	*/
			srv_resp		= this.deposit(mg_username, money);
			deposit_data	= gson.fromJson(srv_resp, MgDepositBean.class);
			
			if (0 == deposit_data.getStatus().getErrorCode()) {
				/*	Update database to empty VAVA money of user	*/
				user_db.setUserMoney(username, 0);
				
				/*--------------------------------------------------------------------
		        |	Change PinCode of MG User
		        |-------------------------------------------------------------------*/
				/*	Get a random pincode	*/
				mg_pincode	= strlib.getSaltString(7);
				
				edit_data.setAccountNumber(mg_username);
				edit_data.setPinCode(mg_pincode);
				
				this.editAccount(edit_data);
				
				/*--------------------------------------------------------------------
		        |	Sets the Game URL
		        |-------------------------------------------------------------------*/
				game_url_full	= game_url_base.concat("LoginName=").concat(mg_username);
				game_url_full	= game_url_full.concat("&Password=").concat(mg_pincode);
				game_url_full	= game_url_full.concat("&UL=ko-kr&CasinoID=2635&ClientID=7&BetProfileID=MobilePostLogin&StartingTab=");
				game_url_full	= game_url_full.concat(lnk_dsp);
				game_url_full	= game_url_full.concat("Baccarat&BrandID=igaming&altProxy=TNG");
			}
		}
		/*--------------------------------------------------------------------
        |	Game is from Asian Gaming
        |-------------------------------------------------------------------*/
		else if (2 == game_provider) {
			game_url_full		= ag_ctrl.launchGame(username, lnk_dsp);
		}
		/*--------------------------------------------------------------------
        |	Game is from SpinCube
        |-------------------------------------------------------------------*/
		else if (4 == game_provider) {
			sc_ctrl.makeTransaction(money, "deposit");
			
			/*	Update database to empty VAVA money of user	*/
			user_db.setUserMoney(username, 0);
			
			game_url_full		= sc_ctrl.getGameUrl(lnk_dsp);
		}
		else {
			game_url_full		= bc_ctrl.launchGame(username, lnk_dsp);
		}
		
		return game_url_full;
	}
	
	public String getAllMoney(String username) throws ParseException
	{
		Gson gson						= new Gson();
		String json_data				= "";
		SpinCubeController sc_ctrl		= null;
		UserBean user_data				= new UserBean();
		UserDao user_db					= new UserDao();
		
		user_data	= user_db.getUserByUserId(username);
		sc_ctrl		= new SpinCubeController(Integer.toString(user_data.getSiteid()).concat("_").concat(user_data.getUserid()));
		
		user_data	= this.transferMoneyToVava(username);
		user_data	= sc_ctrl.transferMoneyToVava(username);
		
		json_data	= gson.toJson(user_data, UserBean.class);
		
		return json_data;
	}
	
	public UserBean transferMoneyToVava(String username)
	{
		Gson gson				= new Gson();
		UserDao user_db			= new UserDao();

		MgWithdrawAllBean withdraw_data = new MgWithdrawAllBean();
		UserBean user_profile			= new UserBean();
		
		String srv_resp 	= "";
		String mg_username	= "";
		double money		= 0;
		
		/*--------------------------------------------------------------------
        |	Query Database
        |-------------------------------------------------------------------*/
		user_profile 	= user_db.getUserByUserId(username);
		mg_username		= Integer.toString(user_profile.getSiteid()).concat("_").concat(username);
		
		/*--------------------------------------------------------------------
        |	Withdraw all money from MG and save to database
        |-------------------------------------------------------------------*/
		srv_resp 		= this.withdrawAll(mg_username);
		withdraw_data	= gson.fromJson(srv_resp, MgWithdrawAllBean.class);
		
		if (0 == withdraw_data.getStatus().getErrorCode()) {
			/*--------------------------------------------------------------------
	        |	Update Money
	        |-------------------------------------------------------------------*/
			money 			= user_profile.getMoney() + withdraw_data.getResult().getTransactionAmount();
			
			user_profile.setMoney((int)money);
			user_db.setUserMoney(username, money);
		}
		
		return user_profile;
	}
	
	public String postToTeg(String url, String json_param)
	{
		/*	Variable Declaration	*/
		String responseBody = "";
		
		try {
			/*	Remove SSL check	*/
			NukeSSLCerts.nuke();
			
			/*--------------------------------------------------------------------
	        |	Make POST Request to TEG
	        |-------------------------------------------------------------------*/
			URL url_conn 					= new URL(url);
			HttpsURLConnection connection	= (HttpsURLConnection)url_conn.openConnection();
			
			/*	Configure POST Request	*/
			connection.setRequestMethod("POST");
			connection.setRequestProperty("Content-length", String.valueOf(json_param.getBytes().length)); 
			connection.setRequestProperty("Authorization", "Basic "+enc_creds.toString());
			connection.setRequestProperty("Content-Type", content_type);
			connection.setDoOutput(true); 
			connection.setDoInput(true);
			
			/*	Configure POST output data	*/
			DataOutputStream output	= new DataOutputStream(connection.getOutputStream());
			output.writeBytes(json_param);
			output.close();
			
			/*	Get TEG response			*/
			InputStream response = connection.getInputStream();
			
			try (Scanner scanner = new Scanner(response)) {
				responseBody = scanner.useDelimiter("\\A").next();
			}
			
		}
		catch (MalformedURLException e) {
			/*	Auto-generated catch block	*/
			e.printStackTrace();
		}
		catch (IOException e) {
			/*	Auto-generated catch block	*/
			e.printStackTrace();
		}
		
		return responseBody;
	}

}
