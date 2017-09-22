package net.vavasoft.controller;

import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Random;
import java.util.Scanner;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import net.vavasoft.bean.MgBettingProfileBean;
import net.vavasoft.bean.MgDepositBean;
import net.vavasoft.bean.MgPlayerAccountBean;
import net.vavasoft.bean.MgResponseStatusBean;
import net.vavasoft.bean.MgWithdrawAllBean;
import net.vavasoft.bean.UserBean;
import net.vavasoft.dao.UserDao;
import net.vavasoft.util.NukeSSLCerts;

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
		System.out.println(srv_resp);
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
		srv_resp 	= this.postToTeg(url, json_param);
		
		return srv_resp;
	}
	
	public String userPlayCheck(String username, int game_provider)
	{	
		/*	Variable Declaration	*/
		Gson gson				= new Gson();
		String game_url_base	= "https://webservice.basestatic.net/ETILandingPage/index.aspx?";
		String game_url_full	= "";
		String srv_resp			= "";
		double money			= 0;
		
		MgWithdrawAllBean withdraw_data = new MgWithdrawAllBean();
		MgDepositBean deposit_data 		= new MgDepositBean();
		
		UserBean user_profile	= new UserBean();
		UserDao user_db			= new UserDao();

		/*--------------------------------------------------------------------
        |	Withdraw all cash from TEG System
        |-------------------------------------------------------------------*/
		srv_resp		= this.withdrawAll(username);
		withdraw_data	= gson.fromJson(srv_resp, MgWithdrawAllBean.class);
		
		/*--------------------------------------------------------------------
        |	Query Database and Update Money
        |-------------------------------------------------------------------*/
		user_profile 	= user_db.getUserByUserId(username);
		money 			= user_profile.getMoney();
		
		if (0 == withdraw_data.getStatus().getErrorCode()) {
			
			money 	= money + withdraw_data.getResult().getTransactionAmount();
			
			user_profile.setMoney((int)money);
			user_db.setUserMoney(username, money);
		}
		
		/*--------------------------------------------------------------------
        |	Game is from MicroGaming (TotalEgame API)
        |-------------------------------------------------------------------*/
		if (1 == game_provider) {
			/*	Deposit all money from VAVA to MG	*/
			srv_resp		= this.deposit(username, money);
			deposit_data	= gson.fromJson(srv_resp, MgDepositBean.class);
			
			if (0 == deposit_data.getStatus().getErrorCode()) {
				/*	Update database to empty VAVA money of user	*/
				user_db.setUserMoney(username, 0);
				
				/*--------------------------------------------------------------------
		        |	Sets the Game URL
		        |-------------------------------------------------------------------*/
				game_url_full	= game_url_base.concat("LoginName=").concat(username);
				game_url_full	= game_url_full.concat("&Password=").concat(user_profile.getPasswd());
				game_url_full	= game_url_full.concat("&UL=ko-kr&CasinoID=2635&ClientID=7&BetProfileID=MobilePostLogin&StartingTab=Baccarat&BrandID=igaming&altProxy=TNG");
			}
		}
		/*--------------------------------------------------------------------
        |	Game is from Asian Gaming
        |-------------------------------------------------------------------*/
		else {
			
		}
		
		return game_url_full;
	}
	
	public UserBean transferMoneyToVava(String username)
	{
		Gson gson				= new Gson();
		UserDao user_db			= new UserDao();

		MgWithdrawAllBean withdraw_data = new MgWithdrawAllBean();
		UserBean user_profile			= new UserBean();
		
		String srv_resp = "";
		double money	= 0;
		int ret			= 0;
		
		/*--------------------------------------------------------------------
        |	Withdraw all money from MG and save to database
        |-------------------------------------------------------------------*/
		srv_resp 		= this.withdrawAll(username);
		withdraw_data	= gson.fromJson(srv_resp, MgWithdrawAllBean.class);
		
		if (0 == withdraw_data.getStatus().getErrorCode()) {
			/*--------------------------------------------------------------------
	        |	Query Database and Update Money
	        |-------------------------------------------------------------------*/
			user_profile 	= user_db.getUserByUserId(username);
			money 			= user_profile.getMoney() + withdraw_data.getResult().getTransactionAmount();
			
			user_profile.setMoney((int)money);
			user_db.setUserMoney(username, money);
			
			ret = 1;
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
