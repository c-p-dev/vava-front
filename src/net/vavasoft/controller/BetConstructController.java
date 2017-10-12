package net.vavasoft.controller;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;

import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import net.vavasoft.bean.BcTransactionLogBean;
import net.vavasoft.bean.BetConUserBean;
import net.vavasoft.bean.UserBean;
import net.vavasoft.betconstruct.Authentication;
import net.vavasoft.betconstruct.AuthenticationOutput;
import net.vavasoft.betconstruct.GetBalance;
import net.vavasoft.betconstruct.GetBalanceOutput;
import net.vavasoft.betconstruct.RefreshToken;
import net.vavasoft.betconstruct.RefreshTokenOutput;
import net.vavasoft.betconstruct.Rollback;
import net.vavasoft.betconstruct.RollbackOutput;
import net.vavasoft.betconstruct.WithdrawAndDeposit;
import net.vavasoft.betconstruct.WithdrawAndDepositOutput;
import net.vavasoft.dao.BcTransactionLogDao;
import net.vavasoft.dao.BetConDao;
import net.vavasoft.dao.UserDao;
import net.vavasoft.util.StringManipulator;

public class BetConstructController {
	
	public static final String API_BASE_URL		= "http://casinoapi.betconstruct.com/authorization.php?";
	public static final String PARTNER_ID		= "1";
	public static final String SHARED_KEY		= "IamIronMan";
	public static final String HASH_TYPE		= "SHA-256";
	public static final String GAME_LANG		= "kr";
	public static final String OPEN_TYPE		= "real";
	public static final String BC_CURRENCY_KRW	= "KRW";
	public static final String BC_COUNTRY_KR	= "KR";
	public static final int SESS_SALT_LEN		= 7;
	
	/*	Withdraw and Deposit Transactions	*/
	public static final int BC_WITHDRAW_HOOK	= 1;
	public static final int BC_DEPOSIT_HOOK		= 2;
	public static final int BC_WITH_DEPO_HOOK	= 3;
	
	public static final int BC_TRANS_PENDING	= 0;
	public static final int BC_TRANS_COMPLETE	= 1;
	public static final int BC_TRANS_ROLLBACK	= 2;
	
	/*	Error Codes	*/
	public static final int BC_ERR_NONE			= 0;
	public static final int BC_ERR_NO_USER		= 8;
	public static final int BC_ERR_NO_BAL		= 21;
	public static final int BC_ERR_TOKEN_NG		= 102;
	public static final int BC_ERR_TRANS_NONE	= 107;
	public static final int BC_ERR_TRANS_DONE	= 110;
	public static final int BC_ERR_GENERAL		= 130;
	
	//-----------------------------------------------------
    //  BetConstructController verifyParamHash
    //      Verify if public key received is valid
    //-----------------------------------------------------
	public boolean verifyParamHash(String json_param, String public_key) throws NoSuchAlgorithmException
	{
		Gson gson				= new Gson();
		MessageDigest md 		= MessageDigest.getInstance(HASH_TYPE);		
		String md_key 			= json_param.concat(SHARED_KEY);
		String pub_key_cmp		= "";
		boolean verify_sts		= false;
		
		md.update(md_key.getBytes(), 0, md_key.length());
		pub_key_cmp	= new BigInteger(1,md.digest()).toString(16);
		
		if (public_key.equals(pub_key_cmp)) {
			verify_sts	= true;
		}
		
		return verify_sts;
	}
	
	//-----------------------------------------------------
    //  BetConstructController launchGame
    //      Creates the URL to play BC Games
	//		empty URL is error
    //-----------------------------------------------------
	public String launchGame(String username, String game_id)
	{
		StringManipulator str_lib	= new StringManipulator();
		BetConDao betcon_db			= new BetConDao();
		UserDao user_db			 	= new UserDao();
		
		String game_url		= "";
		String params_str	= "";
		UserBean user_data	= user_db.getUserByUserId(username);
		String token		= Integer.toString(user_data.getSiteid()).concat("_").concat(username).concat(str_lib.getSaltString(SESS_SALT_LEN));
		int create_token	= 0;
		
		/*--------------------------------------------------------------------
        |	Update Database with generated Token
        |-------------------------------------------------------------------*/
		create_token	= betcon_db.updateBcSessionByUsername(username, token, user_data.getSiteid());
		
		/*--------------------------------------------------------------------
        |	Token Successfully Created
        |-------------------------------------------------------------------*/
		if (0 != create_token) {
			/*--------------------------------------------------------------------
	        |	Build the GET Parameter String
	        |-------------------------------------------------------------------*/
			params_str			= params_str.concat("gameId=").concat(game_id).concat("&");
			params_str			= params_str.concat("token=").concat(token).concat("&");
			params_str			= params_str.concat("partnerId=").concat(PARTNER_ID).concat("&");
			params_str			= params_str.concat("tableId=").concat("1").concat("&");
			params_str			= params_str.concat("language=").concat(GAME_LANG).concat("&");
			params_str			= params_str.concat("openType=").concat(OPEN_TYPE);
			
			game_url			= API_BASE_URL.concat(params_str);
		}
		
		return game_url;
	}
	
	//-----------------------------------------------------
    //  BetConstructController authentication
    //      Called when a user clicks a BC Game
	//		creates a token to identify a user session
    //-----------------------------------------------------
	public String authentication(String json_input)
	{
		Gson gson					= new Gson();
		BetConDao betcon_db			= new BetConDao();
		
		Authentication json_data		= gson.fromJson(json_input, Authentication.class);
		BetConUserBean bc_user			= new BetConUserBean();
		UserBean user_data				= new UserBean();
		AuthenticationOutput auth_user	= new AuthenticationOutput();
		
		String json_output	= "";
		
		/*--------------------------------------------------------------------
        |	Get User Data from the Database
        |-------------------------------------------------------------------*/
		bc_user		= betcon_db.getUserBySessionToken(json_data.getToken());
		user_data	= betcon_db.getUserByPlayerId(bc_user.getPlayerId());
		
		/*--------------------------------------------------------------------
        |	Create Output Object for Response
        |-------------------------------------------------------------------*/
		auth_user.setOperatorId(json_data.getOperatorId());
		auth_user.setCurrency(BC_CURRENCY_KRW);
		auth_user.setCountry(BC_COUNTRY_KR);
		
		/*--------------------------------------------------------------------
        |	User Exist
        |-------------------------------------------------------------------*/
		if (null != user_data.getUserid()) {
			auth_user.setName(user_data.getNick());
			auth_user.setNickName(user_data.getNick());
			auth_user.setUserName(Integer.toString(user_data.getSiteid()).concat("_").concat(user_data.getUserid()));
			auth_user.setToken(json_data.getToken());
			auth_user.setTotalBalance(user_data.getMoney());
			auth_user.setGender(false);
			auth_user.setPlayerId(bc_user.getPlayerId());
			auth_user.setUserIp(user_data.getIp());
			auth_user.setHasError(false);
			auth_user.setErrorId(BC_ERR_NONE);
			auth_user.setErrorDescription("");
		}
		else {
			auth_user.setHasError(true);
			auth_user.setErrorId(BC_ERR_NO_USER);
			auth_user.setErrorDescription("User does not exist");
		}
		
		json_output	= gson.toJson(auth_user, AuthenticationOutput.class);
		
		return json_output;
	}
	
	//-----------------------------------------------------
    //  BetConstructController getBalance
    //      Called by BetConstruct when game launched successfully.
	//		Sends the user data to BetConstruct
    //-----------------------------------------------------
	public String getBalance(String json_input)
	{
		Gson gson				= new Gson();
		BetConDao betcon_db		= new BetConDao();
		
		GetBalance json_data 		= gson.fromJson(json_input, GetBalance.class);
		UserBean user_data			= new UserBean();
		GetBalanceOutput bc_user	= new GetBalanceOutput();
		String json_output			= "";

		/*--------------------------------------------------------------------
        |	Get User Data from the Database
        |-------------------------------------------------------------------*/
		user_data	= betcon_db.getUserByPlayerId(json_data.getPlayerId());
		
		/*--------------------------------------------------------------------
        |	User exists
        |-------------------------------------------------------------------*/
		if (null != user_data.getUserid()) {
			bc_user.setHas_error(false);
			bc_user.setError_id(BC_ERR_NONE);
			bc_user.setError_description("");
			bc_user.setPlayer_id(json_data.getPlayerId());
			bc_user.setTotal_balance(user_data.getMoney());
			bc_user.setToken(json_data.getToken());
		}
		else {
			bc_user.setHas_error(true);
			bc_user.setError_id(BC_ERR_NO_USER);
			bc_user.setError_description("User does not exist");
		}
		
		json_output	= gson.toJson(bc_user, GetBalanceOutput.class);
		
		return json_output;
	}
	
	//-----------------------------------------------------
    //  BetConstructController withdrawAndDeposit
    //      Called when Betting, Winning or losing
	//		creates a token to identify a user session
    //-----------------------------------------------------
	public String withdrawAndDeposit(String json_input, int action)
	{
		Gson gson					= new Gson();
		BetConDao betcon_db			= new BetConDao();
		UserDao user_db				= new UserDao();
		BcTransactionLogDao	log_db	= new BcTransactionLogDao();
		
		UserBean user_data					= new UserBean();
		BcTransactionLogBean trans_data		= new BcTransactionLogBean();
		WithdrawAndDepositOutput resp_data	= new WithdrawAndDepositOutput();
		
		WithdrawAndDeposit json_data		= gson.fromJson(json_input, WithdrawAndDeposit.class);
		
		double bal_remain	= 0;
		String json_output	= "";
		boolean trans_valid	= false;
		int db_add_upd_ok	= 0;
		
		/*--------------------------------------------------------------------
        |	Get User Data from the Database
        |-------------------------------------------------------------------*/
		user_data	= betcon_db.getUserByPlayerId(json_data.getPlayerId());
		
		/*--------------------------------------------------------------------
        |	Get Transaction by RGS ID
        |-------------------------------------------------------------------*/
		trans_data	= log_db.getActiveTransactionByRgsId(json_data.getRgsTransactionId());
		
		/*--------------------------------------------------------------------
        |	Transaction does not exist yet
        |-------------------------------------------------------------------*/
		if (0 == trans_data.getTransaction_id()) {
			/*	Setup data for new entry	*/
			trans_data.setPlayerId(json_data.getPlayerId());
			trans_data.setRgs_id(json_data.getRgsTransactionId());
			trans_data.setRgs_related_id(json_data.getRgsRelatedTransactionId());
			trans_data.setToken(json_data.getToken());
			trans_data.setCurrency(BC_CURRENCY_KRW);
			
			trans_valid	= true;
		}
		/*--------------------------------------------------------------------
        |	Transaction exists but processing is not yet completed
        |-------------------------------------------------------------------*/
		else if (0 == trans_data.getStatus()) {
			trans_valid = true;
		}
		/*--------------------------------------------------------------------
        |	Transaction already processed
        |-------------------------------------------------------------------*/
		else {
			resp_data.setHasError(true);
			resp_data.setErrorId(BC_ERR_TRANS_DONE);
			resp_data.setErrorDescription("Transaction Already Complete");
		}
		
		/*--------------------------------------------------------------------
        |	User exists and Transaction should be processed
        |-------------------------------------------------------------------*/
		if ((null != user_data.getUserid())
		&& (true == trans_valid)) {
			
			switch (action) {
				/*	Withdraw	*/
				case BC_WITHDRAW_HOOK:
					trans_data.setWithdraw_amount(json_data.getWithdrawAmount());
					trans_data.setTransaction_type(1);
					
					bal_remain	= user_data.getMoney() - json_data.getWithdrawAmount();
					break;
				
				/*	Deposit	*/
				case BC_DEPOSIT_HOOK:
					trans_data.setDeposit_amount(json_data.getDepositAmount());
					trans_data.setTransaction_type(2);
					
					bal_remain	= user_data.getMoney() + json_data.getDepositAmount();
					
					break;
				
				/*	Withdraw and Deposit	*/
				case BC_WITH_DEPO_HOOK:
					trans_data.setWithdraw_amount(json_data.getWithdrawAmount());
					trans_data.setDeposit_amount(json_data.getDepositAmount());
					trans_data.setTransaction_type(3);
					
					bal_remain	= (user_data.getMoney() + json_data.getDepositAmount()) - json_data.getWithdrawAmount();
					break;
					
				default:
					bal_remain	= user_data.getMoney();
					break;
			}
			
			/*--------------------------------------------------------------------
	        |	Money is greater than transaction
	        |-------------------------------------------------------------------*/
			if (0 > bal_remain) {
				trans_valid	= false;
				resp_data.setHasError(true);
				resp_data.setErrorId(BC_ERR_NO_BAL);
				resp_data.setErrorDescription("Not Enough Balance");
			}
			
			/*--------------------------------------------------------------------
	        |	Sets status of transaction to processed
	        |-------------------------------------------------------------------*/
			trans_data.setStatus(BC_TRANS_COMPLETE);
			
			if (0 == trans_data.getTransaction_id()) {
				/*	Add Database Record	*/
				db_add_upd_ok	= log_db.addNewTransactionLog(trans_data);
			}
			else {
				db_add_upd_ok	= log_db.updateNewTransactionLog(trans_data);
			}
			
			/*--------------------------------------------------------------------
	        |	Database processing failed
	        |-------------------------------------------------------------------*/
			if (0 == db_add_upd_ok) {
				trans_valid	= false;
				resp_data.setHasError(true);
				resp_data.setErrorId(BC_ERR_GENERAL);
				resp_data.setErrorDescription("Database Error");
			}
			/*--------------------------------------------------------------------
	        |	Transaction completed Successfully
	        |-------------------------------------------------------------------*/
			else {
				user_db.setUserMoney(user_data.getUserid(), bal_remain);
				
				resp_data.setHasError(false);
				resp_data.setErrorId(BC_ERR_NONE);
				resp_data.setErrorDescription("");
				resp_data.setPlayerId(json_data.getPlayerId());
				resp_data.setToken(json_data.getToken());
				resp_data.setTotalBalance(bal_remain);
				resp_data.setPlatformTransactionId(1);
			}
		}
		
		json_output	= gson.toJson(resp_data, WithdrawAndDepositOutput.class);
		
		return json_output;
	}
	
	//-----------------------------------------------------
    //  BetConstructController rollback
    //      Called when a bet has been cancelled
	//		Rolls back a transaction
    //-----------------------------------------------------
	public String rollback(String json_input)
	{
		Gson gson					= new Gson();
		BetConDao betcon_db			= new BetConDao();
		UserDao user_db				= new UserDao();
		BcTransactionLogDao	log_db	= new BcTransactionLogDao();
		
		UserBean user_data					= new UserBean();
		BcTransactionLogBean trans_data		= new BcTransactionLogBean();
		RollbackOutput resp_data			= new RollbackOutput();
		
		Rollback json_data		= gson.fromJson(json_input, Rollback.class);
		
		int balance 		= 0;
		String json_output	= "";
		
		/*--------------------------------------------------------------------
        |	Get User Data from the Database
        |-------------------------------------------------------------------*/
		user_data	= betcon_db.getUserByPlayerId(json_data.getPlayerId());
		
		/*--------------------------------------------------------------------
        |	Get transaction data from database
        |-------------------------------------------------------------------*/
		trans_data	= log_db.getActiveTransactionByRgsId(json_data.getRgsTransactionId());
		
		/*--------------------------------------------------------------------
        |	Transaction Exists
        |-------------------------------------------------------------------*/
		if ((0 != trans_data.getTransaction_id())
		&& (1 == trans_data.getStatus())) {
			
			switch (trans_data.getTransaction_type()) {
				/*	Roll back a Withdraw Transaction	*/
				case BC_WITHDRAW_HOOK:
					balance = (int)user_data.getMoney() + (int)trans_data.getWithdraw_amount();
					break;
				
				/*	Roll back a Deposit Transaction	*/
				case BC_DEPOSIT_HOOK:
					balance = (int)user_data.getMoney() - (int)trans_data.getDeposit_amount();
					break;
				
				/*	Roll back a Withdraw and Deposit Transaction	*/
				case BC_WITH_DEPO_HOOK:
					balance = (int)user_data.getMoney() + (int)trans_data.getWithdraw_amount();
					balance = balance - (int)trans_data.getDeposit_amount();
					break;
					
				default:
					balance = user_data.getMoney();
			}
			
			/*--------------------------------------------------------------------
	        |	Update Transaction Status to Rolled Back
	        |-------------------------------------------------------------------*/
			trans_data.setStatus(BC_TRANS_ROLLBACK);
			log_db.updateNewTransactionLog(trans_data);
			
			/*--------------------------------------------------------------------
	        |	Update user money
	        |-------------------------------------------------------------------*/
			user_db.setUserMoney(user_data.getUserid(), balance);
			
			resp_data.setHasError(false);
			resp_data.setErrorId(BC_ERR_NONE);
			resp_data.setErrorDescription("");
			resp_data.setToken(json_data.getToken());
			resp_data.setTotalBalance(balance);
		}
		else {
			resp_data.setHasError(true);
			resp_data.setErrorId(BC_ERR_TRANS_NONE);
			resp_data.setErrorDescription("Transaction Not Found");
		}
		
		json_output	= gson.toJson(resp_data, RollbackOutput.class);
		
		return json_output;
	}
	
	//-----------------------------------------------------
    //  BetConstructController refreshToken
    //      Called when a User's Token has expired
	//		Creates a new Token
    //-----------------------------------------------------
	public String refreshToken(String json_input)
	{
		Gson gson					= new Gson();
		StringManipulator str_lib	= new StringManipulator();
		BetConDao betcon_db			= new BetConDao();
		
		RefreshToken json_data 		= gson.fromJson(json_input, RefreshToken.class);
		RefreshTokenOutput bc_token	= new RefreshTokenOutput();
		BetConUserBean bc_user		= new BetConUserBean();
		String json_output			= "";
		String token				= "";
		String vava_uname			= "";
		int uname_idx				= 0;
		
		/*--------------------------------------------------------------------
        |	Get user information from database
        |-------------------------------------------------------------------*/
		bc_user		= betcon_db.getUserBySessionToken(json_data.getToken());
		
		if (null != bc_user.getUsername()) {
			uname_idx	= bc_user.getUsername().indexOf("_") + 1;
			vava_uname	= bc_user.getUsername().substring(uname_idx);
			System.out.println(vava_uname);
			/*--------------------------------------------------------------------
	        |	Create a random character token
	        |-------------------------------------------------------------------*/
			token	= bc_user.getUsername().concat(str_lib.getSaltString(SESS_SALT_LEN));
			
			/*--------------------------------------------------------------------
	        |	Update Database with generated Token
	        |-------------------------------------------------------------------*/
			betcon_db.updateBcSessionByUsername(vava_uname, token, bc_user.getSite_id());
			
			bc_token.setHasError(false);
			bc_token.setErrorId(BC_ERR_NONE);
			bc_token.setErrorDescription("");
			bc_token.setToken(token);
		}
		else {
			bc_token.setHasError(true);
			bc_token.setErrorId(BC_ERR_TOKEN_NG);
			bc_token.setErrorDescription("Invalid Token");
		}
		
		json_output	= gson.toJson(bc_token, RefreshTokenOutput.class);
		
		return json_output;
	}
}
