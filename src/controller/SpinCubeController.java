package controller;

import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;

import javax.net.ssl.HttpsURLConnection;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;

import bean.MgPlayerAccountBean;
import bean.MgWithdrawAllBean;
import bean.ScBetBean;
import bean.ScTokenLogBean;
import bean.ScTransactionBean;
import bean.UserBean;
import dao.ScBetLogDao;
import dao.ScTokenLog;
import dao.UserDao;
import util.NukeSSLCerts;
import util.StringManipulator;

public class SpinCubeController {
	private String player_id	= "";
	
	public static final String SC_TOKEN_URL		= "https://sts.k2net.io/connect/token";
	public static final String SC_AGENT_UNAME	= "testagent212555";
	public static final String SC_AGENT_KEY		= "a4e94b08753842fdbbcd9a2aedcc80";
	public static final String SC_BASE_URL		= "https://api-vavasoft.k2net.io/api/v1/";
	
	//-----------------------------------------------------
    //  TotalEgameController constructor
    //      Initialize Object Properties
    //-----------------------------------------------------
	public SpinCubeController(String player_id) {
		this.player_id			= player_id;
	}
	
	public boolean checkTokenExpiration() throws ParseException
	{
		ScTokenLog sc_log_db		= new ScTokenLog();
		ScTokenLogBean token_data	= sc_log_db.getLatestToken();
		
		SimpleDateFormat dfrmt 		= new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		Date date_token				= dfrmt.parse(token_data.getExpireDate());
		
		Calendar cal_now			= Calendar.getInstance();
		Calendar cal_token			= Calendar.getInstance();
		
		cal_token.setTime(date_token);
		
		boolean token_sts			= false;
		
		if (cal_now.before(cal_token)) {
			token_sts = true;
		}
		
		return token_sts;
	}
	
	public String getToken()
	{
		/*	Variable Declaration	*/
		Gson gson				= new Gson();
		JsonObject json_data	= new JsonObject();
		SimpleDateFormat dfrmt 	= new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Calendar cal 			= Calendar.getInstance();
		
		ScTokenLogBean sc_token	= new ScTokenLogBean();
		ScTokenLog sc_db		= new ScTokenLog();
		
		String token_clr		= "";
		String post_param		= "";
		String srv_resp			= "";
		
		/*	Convert parameters to JSON	*/
		post_param	= "grant_type=client_credentials&";
		post_param	= post_param.concat("client_id=").concat(SC_AGENT_UNAME).concat("&");
		post_param	= post_param.concat("client_secret=").concat(SC_AGENT_KEY);
		
		/*--------------------------------------------------------------------
        |	Execute HTTP POST Request to SpinCube
        |-------------------------------------------------------------------*/
		try {
			/*	Remove SSL check	*/
			NukeSSLCerts.nuke();
			
			/*--------------------------------------------------------------------
	        |	Make POST Request to TEG
	        |-------------------------------------------------------------------*/
			URL url_conn 					= new URL(SC_TOKEN_URL);
			HttpsURLConnection connection	= (HttpsURLConnection)url_conn.openConnection();
			
			/*	Configure POST Request	*/
			connection.setRequestMethod("POST");
			connection.setRequestProperty("Content-length", String.valueOf(post_param.getBytes().length)); 
			connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			connection.setDoOutput(true); 
			connection.setDoInput(true);
			
			/*	Configure POST output data	*/
			DataOutputStream output	= new DataOutputStream(connection.getOutputStream());
			output.writeBytes(post_param);
			output.close();
			
			/*	Get SpinCube response		*/
			InputStream response = connection.getInputStream();
			
			try (Scanner scanner = new Scanner(response)) {
				srv_resp = scanner.useDelimiter("\\A").next();
				
				json_data	= gson.fromJson(srv_resp, JsonObject.class);
				
				cal.add(Calendar.MINUTE, 20);
				
				token_clr	= json_data.get("access_token").toString();
				token_clr	= token_clr.replaceAll("\"", "");
				
				sc_token.setToken(token_clr);
				sc_token.setExpireDate(dfrmt.format(cal.getTime()));
				sc_db.addNewTransactionLog(sc_token);
				
				srv_resp	= token_clr;
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
		
		return srv_resp;
	}
	
	public String createPlayer() throws ParseException
	{
		/*	Variable Declaration	*/
		Gson gson				= new Gson();
		
		String url				= SC_BASE_URL.concat("agents/").concat(SC_AGENT_UNAME).concat("/Players");
		String post_param		= "";
		String srv_resp			= "";
		
		/*	Convert parameters to JSON	*/
		post_param	= "playerId=".concat(this.player_id);
		
		/*--------------------------------------------------------------------
        |	Execute HTTP POST Request to TEG
        |-------------------------------------------------------------------*/
		srv_resp 	= this.postToSc(url, post_param, "application/x-www-form-urlencoded");
		
		return srv_resp;
	}
	
	public String getGameUrl(String game_name) throws ParseException
	{
		/*	Variable Declaration	*/
		Gson gson				= new Gson();
		
		String url				= SC_BASE_URL.concat("agents/").concat(SC_AGENT_UNAME).concat("/Players/").concat(this.player_id).concat("/products/SVS/Sessions");
		String post_param		= "";
		String srv_resp			= "";
		JsonObject json_data	= new JsonObject();
		
		/*	Convert parameters to JSON	*/
		post_param	= "game=".concat(game_name).concat("&");
		post_param	= post_param.concat("langCode=ko-KR").concat("&");
		post_param	= post_param.concat("platform=Desktop");
		
		/*--------------------------------------------------------------------
        |	Execute HTTP POST Request to TEG
        |-------------------------------------------------------------------*/
		srv_resp 	= this.postToSc(url, post_param, "application/x-www-form-urlencoded");
		json_data	= gson.fromJson(srv_resp, JsonObject.class);
		srv_resp	= json_data.get("gameURL").toString();
		srv_resp	= srv_resp.replace("\"", "");
		
		return srv_resp;
	}
	
	public String lockUser(boolean lock_sts) throws ParseException
	{
		/*	Variable Declaration	*/
		Gson gson				= new Gson();
		
		String url				= SC_BASE_URL.concat("agents/").concat(SC_AGENT_UNAME).concat("/Players/").concat(this.player_id).concat("/products/SVS");
		String post_param		= "";
		String srv_resp			= "";
		
		/*	Convert parameters to JSON	*/
		post_param	= "isLock=".concat(Boolean.toString(lock_sts));
		
		/*--------------------------------------------------------------------
        |	Execute HTTP POST Request to TEG
        |-------------------------------------------------------------------*/
		srv_resp 	= this.postToSc(url, post_param, "application/x-www-form-urlencoded");
		
		return srv_resp;
	}
	
	public String makeTransaction(Double amount, String type) throws ParseException
	{
		/*	Variable Declaration	*/
		Gson gson					= new Gson();
		StringManipulator str_lib	= new StringManipulator();
		
		String url				= SC_BASE_URL.concat("agents/").concat(SC_AGENT_UNAME).concat("/Transactions");
		String post_param		= "";
		String srv_resp			= "";
		String idem_key			= this.player_id.concat(str_lib.getSaltString(9));
		boolean allow_trans		= false;
		
		/*	Convert parameters to JSON	*/
		if (null != amount) {
			post_param	= "amount=".concat(Double.toString(amount)).concat("&");
		}

		//post_param	= post_param.concat("externalTransactionId=4").concat("&");
		post_param	= post_param.concat("idempotencyKey=").concat(idem_key).concat("&");
		post_param	= post_param.concat("playerId=").concat(this.player_id).concat("&");
		post_param	= post_param.concat("type=").concat(type).concat("&");
		post_param	= post_param.concat("productId=SVS");
		
		/*--------------------------------------------------------------------
        |	Check if transaction is allowed
        |-------------------------------------------------------------------*/
		if (("deposit".equals(type))
		&& (0 < amount)) {
			allow_trans = true;
		}
		else if ("withdraw".equals(type)) {
			allow_trans	= true;
		}
		else {
			allow_trans	= false;
		}
		
		/*--------------------------------------------------------------------
        |	Execute HTTP POST Request to TEG
        |-------------------------------------------------------------------*/
		if (true == allow_trans) {
			srv_resp 	= this.postToSc(url, post_param, "application/x-www-form-urlencoded");
		}
		
		return srv_resp;
	}
	
	public String getBetDetails() throws ParseException
	{
		/*	Variable Declaration	*/
		
		StringManipulator str_lib	= new StringManipulator();
		ScBetLogDao sc_db			= new ScBetLogDao();
		
		ScBetBean last_bet_data	= new ScBetBean();
		String url				= SC_BASE_URL.concat("agents/").concat(SC_AGENT_UNAME).concat("/bets").concat("?");
		String srv_resp			= "";
		String last_buid		= "";
		
		/*--------------------------------------------------------------------
        |	Get the last Bet saved from the database
        |-------------------------------------------------------------------*/
		last_bet_data	= sc_db.getLastBetLog();
		
		if (null != last_bet_data.getBetUID()) {
			last_buid	= last_bet_data.getBetUID();
		}
		
		/*	Formats the query parameters on the URL	*/
		url	= url.concat("limit=100&").concat("startingAfter=").concat(last_buid);
		
		/*--------------------------------------------------------------------
        |	Execute HTTP POST Request to TEG
        |-------------------------------------------------------------------*/
		srv_resp 	= this.getToSc(url, "application/x-www-form-urlencoded");
		
		return srv_resp;
	}
	
	public String getBetPlaycheckUrl() throws ParseException
	{
		/*	Variable Declaration	*/
		Gson gson				= new Gson();
		
		String url				= SC_BASE_URL.concat("agents/").concat(SC_AGENT_UNAME).concat("/Players/").concat(this.player_id).concat("/products/SVS/betVisualizers");
		String post_param		= "";
		String srv_resp			= "";
		
		/*	Convert parameters to JSON	*/
		post_param	= "utcOffset=8&";
		post_param	= post_param.concat("langCode=ko-KR");
		
		/*--------------------------------------------------------------------
        |	Execute HTTP POST Request to TEG
        |-------------------------------------------------------------------*/
		srv_resp 	= this.postToSc(url, post_param, "application/x-www-form-urlencoded");
		
		return srv_resp;
	}
	
	public UserBean transferMoneyToVava(String username) throws ParseException
	{
		Gson gson				= new Gson();
		UserDao user_db			= new UserDao();
		
		SpinCubeController sc_ctrl		= null;
		ScTransactionBean withdraw_data = new ScTransactionBean();
		UserBean user_profile			= new UserBean();
		
		String srv_resp 	= "";
		String mg_username	= "";
		double money		= 0;
		
		/*--------------------------------------------------------------------
        |	Query Database
        |-------------------------------------------------------------------*/
		user_profile 	= user_db.getUserByUserId(username);
		
		/*--------------------------------------------------------------------
        |	Withdraw all money from MG and save to database
        |-------------------------------------------------------------------*/
		srv_resp 		= this.makeTransaction(null, "withdraw");
		withdraw_data	= gson.fromJson(srv_resp, ScTransactionBean.class);
		
		/*--------------------------------------------------------------------
        |	Update Money
        |-------------------------------------------------------------------*/
		money 			= user_profile.getMoney() + withdraw_data.getAmount();
		
		user_profile.setMoney((int)money);
		user_db.setUserMoney(username, money);

		return user_profile;
	}
	
	public String saveBetList() throws ParseException {
		
		Gson gson					= new Gson();
		ScBetLogDao sc_db			= new ScBetLogDao();
		
		List<ScBetBean> bet_list	= new ArrayList<ScBetBean>();
		String json_data		= "";
		
		/*--------------------------------------------------------------------
        |	Get the last Bet saved from the database
        |-------------------------------------------------------------------*/
		json_data 	= this.getBetDetails();
		
		/*--------------------------------------------------------------------
        |	Save Bet details to database
        |-------------------------------------------------------------------*/
		/*	Convert server response to Object	*/
		bet_list	= gson.fromJson(json_data, new TypeToken<List<ScBetBean>>(){}.getType());
		
		for (int idx = 0; idx < bet_list.size(); idx++) {
			sc_db.addNewTransactionLog(bet_list.get(idx));
		}
		
		return json_data;
	}
	
	public String getToSc(String url, String content_type) throws ParseException
	{
		/*	Variable Declaration	*/
		String responseBody = "";
		String bearer_auth	= "";
		
		ScTokenLog sc_db			= new ScTokenLog();
		ScTokenLogBean token_data	= sc_db.getLatestToken();
		
		boolean token_sts	= this.checkTokenExpiration();
		
		if (false == token_sts) {
			bearer_auth	= this.getToken();
		}
		else {
			bearer_auth	= token_data.getToken();
		}
		
		try {
			/*	Remove SSL check	*/
			NukeSSLCerts.nuke();
			
			/*--------------------------------------------------------------------
	        |	Make POST Request to TEG
	        |-------------------------------------------------------------------*/
			URL url_conn 					= new URL(url);
			HttpsURLConnection connection	= (HttpsURLConnection)url_conn.openConnection();
			
			/*	Configure POST Request	*/ 
			connection.setRequestProperty("Authorization", "Bearer "+bearer_auth);
			connection.setRequestProperty("Content-Type", content_type);
			connection.setDoOutput(true); 
			connection.setDoInput(true);
			
			/*	Get SpinCube response		*/
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
	
	public String postToSc(String url, String post_param, String content_type) throws ParseException
	{
		/*	Variable Declaration	*/
		String responseBody = "";
		String bearer_auth	= "";
		
		ScTokenLog sc_db			= new ScTokenLog();
		ScTokenLogBean token_data	= sc_db.getLatestToken();
		
		boolean token_sts	= this.checkTokenExpiration();
		
		if (false == token_sts) {
			bearer_auth	= this.getToken();
		}
		else {
			bearer_auth	= token_data.getToken();
		}
		
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
			connection.setRequestProperty("Content-length", String.valueOf(post_param.getBytes().length)); 
			connection.setRequestProperty("Authorization", "Bearer "+bearer_auth);
			connection.setRequestProperty("Content-Type", content_type);
			connection.setDoOutput(true); 
			connection.setDoInput(true);
			
			/*	Configure POST output data	*/
			DataOutputStream output	= new DataOutputStream(connection.getOutputStream());
			output.writeBytes(post_param);
			output.close();
			
			/*	Get SpinCube response		*/
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
