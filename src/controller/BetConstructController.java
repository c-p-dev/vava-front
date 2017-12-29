package controller;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;

import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;

import bean.BcTransactionLogBean;
import bean.BetConUserBean;
import bean.CasinoErrorLogBean;
import bean.UserBean;
import betconstruct.Authentication;
import betconstruct.AuthenticationOutput;
import betconstruct.GetBalance;
import betconstruct.GetBalanceOutput;
import betconstruct.RefreshToken;
import betconstruct.RefreshTokenOutput;
import betconstruct.Rollback;
import betconstruct.RollbackOutput;
import betconstruct.WithdrawAndDeposit;
import betconstruct.WithdrawAndDepositOutput;
import dao.BcTransactionLogDao;
import dao.BetConDao;
import dao.CasinoErrorLogDao;
import dao.UserDao;
import util.StringManipulator;

public class BetConstructController {
	
	public static final int GP_BETCON					= 3;
	public static final String BC_MT_VERIFICATION		= "Hash Verification";
	public static final String BC_MT_AUTHENTICATION		= "Authentication";
	public static final String BC_MT_GET_BAL			= "Get balance";
	public static final String BC_MT_FIN_TRANS			= "Financial Transaction";
	public static final String BC_MT_ROLLBACK			= "Rollback";
	public static final String BC_MT_REFTOK				= "Refresh Token";
	
	public static final String API_BASE_URL		= "http://games.vava26.com/authorization.php?";
	public static final String PARTNER_ID		= "704";
	public static final String SHARED_KEY		= "JKGS*&D^ST*&JBDSN";
	public static final String HASH_TYPE		= "SHA-256";
	public static final String HASH_ENCODING	= "UTF-8";
	public static final String GAME_LANG		= "kor";
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
	public static final int BC_ERR_AMT_NG		= 109;
	public static final int BC_ERR_TRANS_DONE	= 110;
	public static final int BC_ERR_TRANS_DUPE	= 111;
	public static final int BC_ERR_GENERAL		= 130;
	
	//-----------------------------------------------------
    //  BetConstructController verifyParamHash
    //      Verify if public key received is valid
    //-----------------------------------------------------
	/**
	 * @param json_param
	 * @param public_key
	 * @param json_input
	 * @param username
	 * @param site_id
	 * @return
	 * @throws NoSuchAlgorithmException
	 * @throws UnsupportedEncodingException
	 */
	public boolean verifyParamHash(String json_param, String public_key, String json_input, String username, int site_id) throws NoSuchAlgorithmException, UnsupportedEncodingException
	{
		MessageDigest md 				= MessageDigest.getInstance(HASH_TYPE);
		CasinoErrorLogBean casino_data	= new CasinoErrorLogBean();
		CasinoErrorLogDao log_db		= new CasinoErrorLogDao();
		
		json_param				= json_param.replace(",\"PublicKey\":null", "");

		String md_key 			= json_param.concat(SHARED_KEY);
		String pub_key_cmp		= "";
		boolean verify_sts		= false;
		
		md.update(md_key.getBytes(HASH_ENCODING), 0, md_key.length());
		pub_key_cmp	= String.format("%064x", new BigInteger(1, md.digest()));

		if (public_key.equals(pub_key_cmp)) {
			verify_sts	= true;
		}
		else {
			casino_data.setUsername(username);
			casino_data.setSiteId(site_id);
			casino_data.setMessage(json_param.concat("<--->").concat(json_input));
			casino_data.setGameProvider(GP_BETCON);
			casino_data.setMethod(BC_MT_VERIFICATION);
			
			log_db.addNewErrorLog(casino_data);
		}
		
		return verify_sts;
	}
	
	//-----------------------------------------------------
    //  BetConstructController launchGame
    //      Creates the URL to play BC Games
	//		empty URL is error
    //-----------------------------------------------------
	public String launchGame(String username, String game_id, int site_id)
	{
		SimpleDateFormat dfrmt 		= new SimpleDateFormat("yyyyMMddHHmmss");
		Calendar cal_now			= Calendar.getInstance();
		
		BetConDao betcon_db			= new BetConDao();
		UserDao user_db			 	= new UserDao();
		
		String game_url		= "";
		String params_str	= "";
		UserBean user_data	= user_db.getUserByUserId(username, site_id);
		String token		= Integer.toString(user_data.getSiteid()).concat("_").concat(username).concat("T").concat(dfrmt.format(cal_now.getTime()));
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
	public String authentication(String json_input) throws NoSuchAlgorithmException, UnsupportedEncodingException
	{
		Gson gson_null				= new Gson();
		Gson gson					= new GsonBuilder().serializeNulls().create();
		BetConDao betcon_db			= new BetConDao();
		CasinoErrorLogDao log_db	= new CasinoErrorLogDao();
		
		Authentication json_data		= gson.fromJson(json_input, Authentication.class);
		BetConUserBean bc_user			= new BetConUserBean();
		UserBean user_data				= new UserBean();
		CasinoErrorLogBean error_data	= new CasinoErrorLogBean();
		AuthenticationOutput auth_user	= new AuthenticationOutput();
		
		String json_output	= "";
		String json_body	= "";
		String pubkey		= "";
		
		/*--------------------------------------------------------------------
        |	Remove Public Key for verification
        |-------------------------------------------------------------------*/
		pubkey		= json_data.getPublicKey();
		json_data.setPublicKey(null);
		json_body	= gson.toJson(json_data, Authentication.class);
		json_data.setPublicKey(pubkey);
		
		/*--------------------------------------------------------------------
        |	Get User Data from the Database
        |-------------------------------------------------------------------*/
		bc_user		= betcon_db.getUserBySessionToken(json_data.getToken());
		user_data	= betcon_db.getUserByPlayerId(bc_user.getPlayerId());
		
		/*--------------------------------------------------------------------
        |	Check Parameter Hashing
        |-------------------------------------------------------------------*/
		boolean key_check = this.verifyParamHash(json_body, json_data.getPublicKey(), json_input, user_data.getUserid(), user_data.getSiteid());
		
		if (true == key_check) {
			/*--------------------------------------------------------------------
	        |	Create Output Object for Response
	        |-------------------------------------------------------------------*/
			auth_user.setOperatorId(json_data.getOperatorId());
			auth_user.setCurrency(BC_CURRENCY_KRW);
			auth_user.setCountry(BC_COUNTRY_KR);
			
			/*--------------------------------------------------------------------
	        |	Initialize Error Input data
	        |-------------------------------------------------------------------*/
			error_data.setUsername(user_data.getUserid());
			error_data.setSiteId(user_data.getSiteid());
			error_data.setGameProvider(GP_BETCON);
			error_data.setMethod(BC_MT_AUTHENTICATION);
			
			/*--------------------------------------------------------------------
	        |	User Exist
	        |-------------------------------------------------------------------*/
			if (null != user_data.getUserid()) {
				auth_user.setName(user_data.getNick());
				auth_user.setNickName(user_data.getNick());
				auth_user.setUserName(user_data.getUserid());
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
				auth_user.setErrorId(BC_ERR_TOKEN_NG);
				auth_user.setErrorDescription("Invalid Token");
				
				error_data.setMessage("Invalid Token");
				log_db.addNewErrorLog(error_data);
			}
		}
		else {
			auth_user.setHasError(true);
			auth_user.setErrorId(BC_ERR_GENERAL);
			auth_user.setErrorDescription("Invalid Public Key");
			
			error_data.setMessage("Invalid Public Key");
			log_db.addNewErrorLog(error_data);
		}
		
		json_output	= gson_null.toJson(auth_user, AuthenticationOutput.class);
		
		return json_output;
	}
	
	//-----------------------------------------------------
    //  BetConstructController getBalance
    //      Called by BetConstruct when game launched successfully.
	//		Sends the user data to BetConstruct
    //-----------------------------------------------------
	public String getBalance(String json_input) throws NoSuchAlgorithmException, UnsupportedEncodingException
	{
		Gson gson						= new Gson();
		BetConDao betcon_db				= new BetConDao();
		CasinoErrorLogDao log_db		= new CasinoErrorLogDao();
		
		GetBalance json_data 			= gson.fromJson(json_input, GetBalance.class);
		UserBean user_data				= new UserBean();
		BetConUserBean token_data		= new BetConUserBean();
		CasinoErrorLogBean error_data	= new CasinoErrorLogBean();
		GetBalanceOutput bc_user		= new GetBalanceOutput();
		
		String json_output			= "";
		String json_body			= "";
		String pubkey				= "";
		
		/*--------------------------------------------------------------------
        |	Remove Public Key for verification
        |-------------------------------------------------------------------*/
		pubkey		= json_data.getPublicKey();
		json_data.setPublicKey(null);
		json_body	= gson.toJson(json_data, GetBalance.class);
		json_data.setPublicKey(pubkey);
		
		/*--------------------------------------------------------------------
        |	Get User Data from the Database
        |-------------------------------------------------------------------*/
		user_data	= betcon_db.getUserByPlayerId(json_data.getPlayerId());
		
		/*--------------------------------------------------------------------
        |	Check Parameter Hashing
        |-------------------------------------------------------------------*/
		boolean key_check = this.verifyParamHash(json_body, json_data.getPublicKey(), json_input, user_data.getUserid(), user_data.getSiteid());
		
		if (true == key_check) {
			/*--------------------------------------------------------------------
	        |	User exists
	        |-------------------------------------------------------------------*/
			if (null != user_data.getUserid()) {
				/*--------------------------------------------------------------------
		        |	Check Token validity
		        |-------------------------------------------------------------------*/
				token_data	= betcon_db.getUserBySessionToken(json_data.getToken());
				
				/*--------------------------------------------------------------------
		        |	Initialize Error Input data
		        |-------------------------------------------------------------------*/
				error_data.setUsername(user_data.getUserid());
				error_data.setSiteId(user_data.getSiteid());
				error_data.setGameProvider(GP_BETCON);
				error_data.setMethod(BC_MT_GET_BAL);
				
				/*--------------------------------------------------------------------
		        |	If token exists
		        |-------------------------------------------------------------------*/
				if (null != token_data.getSession_token()) {
					bc_user.setHas_error(false);
					bc_user.setError_id(BC_ERR_NONE);
					bc_user.setError_description("");
					bc_user.setPlayer_id(json_data.getPlayerId());
					bc_user.setTotal_balance(user_data.getMoney());
					bc_user.setToken(json_data.getToken());
				}
				else {
					bc_user.setHas_error(true);
					bc_user.setError_id(BC_ERR_TOKEN_NG);
					bc_user.setError_description("Invalid Token");
					
					error_data.setMessage("Invalid Token");
					log_db.addNewErrorLog(error_data);
				}
			}
			else {
				bc_user.setHas_error(true);
				bc_user.setError_id(BC_ERR_NO_USER);
				bc_user.setError_description("User does not exist");
				
				error_data.setMessage("User does not exist");
				log_db.addNewErrorLog(error_data);
			}
		}
		else {
			bc_user.setHas_error(true);
			bc_user.setError_id(BC_ERR_GENERAL);
			bc_user.setError_description("Invalid Public Key");
			
			error_data.setMessage("Invalid Public Key");
			log_db.addNewErrorLog(error_data);
		}
		
		json_output	= gson.toJson(bc_user, GetBalanceOutput.class);
		
		return json_output;
	}
	
	//-----------------------------------------------------
    //  BetConstructController withdrawAndDeposit
    //      Called when Betting, Winning or losing
	//		creates a token to identify a user session
    //-----------------------------------------------------
	public String withdrawAndDeposit(String json_input, int action) throws NoSuchAlgorithmException, UnsupportedEncodingException
	{
		Gson gson					= new Gson();
		
		BetConDao betcon_db			= new BetConDao();
		CasinoErrorLogDao err_db	= new CasinoErrorLogDao();
		UserDao user_db				= new UserDao();
		BcTransactionLogDao	log_db	= new BcTransactionLogDao();
		
		UserBean user_data					= new UserBean();
		BcTransactionLogBean trans_data		= new BcTransactionLogBean();
		WithdrawAndDepositOutput resp_data	= new WithdrawAndDepositOutput();
		BetConUserBean token_data			= new BetConUserBean();
		BcTransactionLogBean token_exprd	= new BcTransactionLogBean();
		CasinoErrorLogBean error_data		= new CasinoErrorLogBean();
		
		WithdrawAndDeposit json_data		= gson.fromJson(json_input, WithdrawAndDeposit.class);
		
		BigDecimal bal_remain	= new BigDecimal(0);
		String json_output		= "";
		boolean trans_valid		= false;
		int db_add_upd_ok		= 0;
		String json_body		= "";
		String pubkey			= "";
		System.out.println(json_input);
		/*--------------------------------------------------------------------
        |	Remove Public Key for verification
        |-------------------------------------------------------------------*/
		pubkey		= json_data.getPublicKey();
		json_data.setPublicKey(null);
		
		json_body	= gson.toJson(json_data, WithdrawAndDeposit.class);
		json_data.setPublicKey(pubkey);
		
		JsonElement json_elem	= gson.fromJson(json_body, JsonElement.class);
		JsonObject json_obj		= json_elem.getAsJsonObject();
		
		JsonElement raw_jel		= gson.fromJson(json_input, JsonElement.class);
		JsonObject raw_job		= raw_jel.getAsJsonObject();
		
		if (null != json_obj.get("DepositAmount")) {
			/*	Extract Deposit Amount as String	*/
			String depo_amt			= raw_job.get("DepositAmount").toString();
			
			json_obj.addProperty("DepositAmount", depo_amt);
			json_body	= json_obj.toString();
			json_body	= json_body.replace(":\"".concat(depo_amt).concat("\""), ":".concat(depo_amt));
			
			json_elem	= gson.fromJson(json_body, JsonElement.class);
			json_obj	= json_elem.getAsJsonObject();
		}
		
		if (null != json_obj.get("WithdrawAmount")) {
			String widro_amt	= raw_job.get("WithdrawAmount").toString();
			
			json_obj.addProperty("WithdrawAmount", widro_amt);
			json_body	= json_obj.toString();
			json_body	= json_body.replace(":\"".concat(widro_amt).concat("\""), ":".concat(widro_amt));
			
			json_elem	= gson.fromJson(json_body, JsonElement.class);
			json_obj	= json_elem.getAsJsonObject();
		}
		
		/*--------------------------------------------------------------------
        |	Get User Data from the Database
        |-------------------------------------------------------------------*/
		user_data	= betcon_db.getUserByPlayerId(json_data.getPlayerId());
		
		/*--------------------------------------------------------------------
        |	Check Parameter Hashing
        |-------------------------------------------------------------------*/
		boolean key_check = this.verifyParamHash(json_body, json_data.getPublicKey(), json_input, user_data.getUserid(), user_data.getSiteid());
		
		if (true == key_check) {
			/*--------------------------------------------------------------------
	        |	Get Transaction by RGS ID
	        |-------------------------------------------------------------------*/
			trans_data	= log_db.getActiveTransactionByRgsId(json_data.getRgsTransactionId());
			
			/*--------------------------------------------------------------------
	        |	Check Token validity for Withdraw and WithdrawAndDeposit
	        |-------------------------------------------------------------------*/
			token_data	= betcon_db.getUserBySessionToken(json_data.getToken());
			
			/*--------------------------------------------------------------------
	        |	Check Token validity for Deposit
	        |-------------------------------------------------------------------*/
			token_exprd	= log_db.getLogByUserToken(json_data.getPlayerId(), json_data.getToken());
			
			/*--------------------------------------------------------------------
	        |	Initialize Error Input data
	        |-------------------------------------------------------------------*/
			error_data.setUsername(user_data.getUserid());
			error_data.setSiteId(user_data.getSiteid());
			error_data.setGameProvider(GP_BETCON);
			error_data.setMethod(BC_MT_FIN_TRANS);
			
			/*--------------------------------------------------------------------
	        |	Invalid Token
	        |-------------------------------------------------------------------*/
			if ((null == token_data.getSession_token())
			&& (action != BC_DEPOSIT_HOOK)) {
				resp_data.setHasError(true);
				resp_data.setErrorId(BC_ERR_TOKEN_NG);
				resp_data.setErrorDescription("Invalid Token");
				
				error_data.setMessage("Invalid Token");
				err_db.addNewErrorLog(error_data);
			}
			/*--------------------------------------------------------------------
	        |	User does not exist
	        |-------------------------------------------------------------------*/
			else if (null == user_data.getUserid()) {
				resp_data.setHasError(true);
				resp_data.setErrorId(BC_ERR_NO_USER);
				resp_data.setErrorDescription("User does not exist");
				
				error_data.setMessage("User does not exist");
				err_db.addNewErrorLog(error_data);
			}
			/*--------------------------------------------------------------------
	        |	Token does not exist for the User making Deposits
	        |-------------------------------------------------------------------*/
			else if ((null == token_exprd.getToken())
			&& (null == token_data.getSession_token())
			&& (action == BC_DEPOSIT_HOOK)) {
				resp_data.setHasError(true);
				resp_data.setErrorId(BC_ERR_TOKEN_NG);
				resp_data.setErrorDescription("Invalid Token");
				
				error_data.setMessage("Invalid Token");
				err_db.addNewErrorLog(error_data);
			}
			/*--------------------------------------------------------------------
	        |	Transaction does not exist yet
	        |-------------------------------------------------------------------*/
			else if (0 == trans_data.getTransaction_id()) {
				/*	Setup data for new entry	*/
				trans_data.setPlayerId(json_data.getPlayerId());
				trans_data.setGameId(json_data.getGameId());
				trans_data.setRgs_id(json_data.getRgsTransactionId());
				trans_data.setToken(json_data.getToken());
				trans_data.setCurrency(BC_CURRENCY_KRW);
				
				if (null != json_data.getRgsRelatedTransactionId()) {
					trans_data.setRgs_related_id(json_data.getRgsRelatedTransactionId());
				}
				
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
				
				switch (action) {
					/*	Withdraw	*/
					case BC_DEPOSIT_HOOK:
						resp_data.setErrorId(BC_ERR_TRANS_DUPE);
						break;
					
					case BC_WITHDRAW_HOOK:
					case BC_WITH_DEPO_HOOK:
					default:
						resp_data.setErrorId(BC_ERR_TRANS_DONE);
						break;
				}
				
				resp_data.setHasError(true);
				resp_data.setErrorDescription("Transaction Already Complete");
				
				error_data.setMessage("Transaction Already Complete");
				err_db.addNewErrorLog(error_data);
			}
			
			/*--------------------------------------------------------------------
	        |	Transaction should be processed
	        |-------------------------------------------------------------------*/
			if (true == trans_valid) {
				
				switch (action) {
					/*	Withdraw	*/
					case BC_WITHDRAW_HOOK:
						if (0 >= json_data.getWithdrawAmount()) {
							trans_valid = false;
							resp_data.setHasError(true);
							resp_data.setErrorId(BC_ERR_AMT_NG);
							resp_data.setErrorDescription("Wrong Transaction Amount");
							
							error_data.setMessage("Wrong Transaction Amount");
							err_db.addNewErrorLog(error_data);
						}
						else {
							trans_data.setWithdraw_amount(new BigDecimal(json_data.getWithdrawAmount()).setScale(0, BigDecimal.ROUND_HALF_UP).doubleValue());
							trans_data.setTransaction_type(1);
							
							bal_remain	= new BigDecimal(user_data.getMoney()).subtract(new BigDecimal(json_data.getWithdrawAmount()));
						}
						
						break;
					
					/*	Deposit	*/
					case BC_DEPOSIT_HOOK:
						if (0 >= json_data.getDepositAmount()) {
							trans_valid = false;
							resp_data.setHasError(true);
							resp_data.setErrorId(BC_ERR_AMT_NG);
							resp_data.setErrorDescription("Wrong Transaction Amount");
							
							error_data.setMessage("Wrong Transaction Amount");
							err_db.addNewErrorLog(error_data);
						}
						else {
							trans_data.setDeposit_amount(new BigDecimal(json_data.getDepositAmount()).setScale(0, BigDecimal.ROUND_HALF_UP).doubleValue());
							trans_data.setTransaction_type(2);
							
							bal_remain	= new BigDecimal(user_data.getMoney()).add(new BigDecimal(json_data.getDepositAmount()));
						}
						
						
						break;
					
					/*	Withdraw and Deposit	*/
					case BC_WITH_DEPO_HOOK:
						if ((0 >= json_data.getDepositAmount())
						|| (0 >= json_data.getWithdrawAmount())) {
							trans_valid = false;
							resp_data.setHasError(true);
							resp_data.setErrorId(BC_ERR_AMT_NG);
							resp_data.setErrorDescription("Wrong Transaction Amount");
							
							error_data.setMessage("Wrong Transaction Amount");
							err_db.addNewErrorLog(error_data);
						}
						else {
							trans_data.setWithdraw_amount(new BigDecimal(json_data.getWithdrawAmount()).setScale(0, BigDecimal.ROUND_HALF_UP).doubleValue());
							trans_data.setDeposit_amount(new BigDecimal(json_data.getDepositAmount()).setScale(0, BigDecimal.ROUND_HALF_UP).doubleValue());
							trans_data.setTransaction_type(3);
							
							bal_remain	= new BigDecimal(user_data.getMoney()).add(new BigDecimal(json_data.getDepositAmount()));
							bal_remain	= bal_remain.subtract(new BigDecimal(json_data.getWithdrawAmount()));
						}
						break;
						
					default:
						bal_remain	= new BigDecimal(user_data.getMoney());
						break;
				}

				/*--------------------------------------------------------------------
		        |	Money is greater than transaction
		        |-------------------------------------------------------------------*/
				if (null != json_data.getWithdrawAmount()) {
					if (-1 == new BigDecimal(user_data.getMoney()).compareTo(new BigDecimal(json_data.getWithdrawAmount()))) {
						trans_valid	= false;
						resp_data.setHasError(true);
						resp_data.setErrorId(BC_ERR_NO_BAL);
						resp_data.setErrorDescription("Not Enough Balance");
						
						error_data.setMessage("Not Enough Balance");
						err_db.addNewErrorLog(error_data);
					}
				}
				
				if (true == trans_valid) {
					/*--------------------------------------------------------------------
			        |	Sets status of transaction to processed
			        |-------------------------------------------------------------------*/
					trans_data.setType_description(json_data.getTypeId());
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
						
						error_data.setMessage("Database Error");
						err_db.addNewErrorLog(error_data);
					}
				}
				
				/*--------------------------------------------------------------------
		        |	Transaction completed Successfully
		        |-------------------------------------------------------------------*/
				if (true == trans_valid) {
					user_db.setUserMoney(user_data.getUserid(), user_data.getSiteid(), bal_remain.setScale(0, BigDecimal.ROUND_HALF_UP).intValue());
					
					resp_data.setHasError(false);
					resp_data.setErrorId(BC_ERR_NONE);
					resp_data.setErrorDescription("");
					resp_data.setPlayerId(json_data.getPlayerId());
					resp_data.setToken(json_data.getToken());
					resp_data.setTotalBalance(bal_remain.setScale(0, BigDecimal.ROUND_HALF_UP).intValue());
					resp_data.setPlatformTransactionId(1);
				}
			}
		}
		else {
			resp_data.setHasError(true);
			resp_data.setErrorId(BC_ERR_GENERAL);
			resp_data.setErrorDescription("Invalid Public Key");
			
			error_data.setMessage("Invalid Public Key");
			err_db.addNewErrorLog(error_data);
		}
		
		json_output	= gson.toJson(resp_data, WithdrawAndDepositOutput.class);
		
		return json_output;
	}
	
	//-----------------------------------------------------
    //  BetConstructController rollback
    //      Called when a bet has been cancelled
	//		Rolls back a transaction
    //-----------------------------------------------------
	public String rollback(String json_input) throws NoSuchAlgorithmException, UnsupportedEncodingException
	{
		Gson gson					= new Gson();
		BetConDao betcon_db			= new BetConDao();
		UserDao user_db				= new UserDao();
		BcTransactionLogDao	log_db	= new BcTransactionLogDao();
		CasinoErrorLogDao err_db	= new CasinoErrorLogDao();
		
		UserBean user_data					= new UserBean();
		BcTransactionLogBean trans_data		= new BcTransactionLogBean();
		RollbackOutput resp_data			= new RollbackOutput();
		BetConUserBean token_data			= new BetConUserBean();
		BcTransactionLogBean token_exprd	= new BcTransactionLogBean();
		CasinoErrorLogBean error_data		= new CasinoErrorLogBean();
		
		Rollback json_data		= gson.fromJson(json_input, Rollback.class);
		
		int balance 		= 0;
		String json_output	= "";
		String json_body	= "";
		String pubkey		= "";
		
		/*--------------------------------------------------------------------
        |	Remove Public Key for verification
        |-------------------------------------------------------------------*/
		pubkey		= json_data.getPublicKey();
		json_data.setPublicKey(null);
		json_body	= gson.toJson(json_data, Rollback.class);
		json_data.setPublicKey(pubkey);
		
		/*--------------------------------------------------------------------
        |	Get User Data from the Database
        |-------------------------------------------------------------------*/
		user_data	= betcon_db.getUserByPlayerId(json_data.getPlayerId());
		
		/*--------------------------------------------------------------------
        |	Check Parameter Hashing
        |-------------------------------------------------------------------*/
		boolean key_check = this.verifyParamHash(json_body, json_data.getPublicKey(), json_input, user_data.getUserid(), user_data.getSiteid());
		
		if (true == key_check) {
			/*--------------------------------------------------------------------
	        |	Check Token validity for Withdraw and WithdrawAndDeposit
	        |-------------------------------------------------------------------*/
			token_data	= betcon_db.getUserBySessionToken(json_data.getToken());
			
			/*--------------------------------------------------------------------
	        |	Check Token validity for Deposit
	        |-------------------------------------------------------------------*/
			token_exprd	= log_db.getLogByUserToken(json_data.getPlayerId(), json_data.getToken());
			
			/*--------------------------------------------------------------------
	        |	Get transaction data from database
	        |-------------------------------------------------------------------*/
			trans_data	= log_db.getActiveTransactionByRgsId(json_data.getRgsTransactionId());			
			
			/*--------------------------------------------------------------------
	        |	Initialize Error Input data
	        |-------------------------------------------------------------------*/
			error_data.setUsername(user_data.getUserid());
			error_data.setSiteId(user_data.getSiteid());
			error_data.setGameProvider(GP_BETCON);
			error_data.setMethod(BC_MT_ROLLBACK);
			
			/*--------------------------------------------------------------------
	        |	Transaction Exists
	        |-------------------------------------------------------------------*/
			if ((null != trans_data.getToken())
			&& (null != token_data.getSession_token())
			&& (null != token_exprd.getToken())
			&& (BC_TRANS_PENDING != trans_data.getStatus())) {
				
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
				
				if (BC_TRANS_COMPLETE == trans_data.getStatus()) {
					/*--------------------------------------------------------------------
			        |	Update Transaction Status to Rolled Back
			        |-------------------------------------------------------------------*/
					trans_data.setStatus(BC_TRANS_ROLLBACK);
					log_db.updateNewTransactionLog(trans_data);
					
					/*--------------------------------------------------------------------
			        |	Update user money
			        |-------------------------------------------------------------------*/
					user_db.setUserMoney(user_data.getUserid(), user_data.getSiteid(), balance);
				}
				else {
					balance = user_data.getMoney();
				}
				
				resp_data.setHasError(false);
				resp_data.setErrorId(BC_ERR_NONE);
				resp_data.setErrorDescription("");
				resp_data.setToken(json_data.getToken());
				resp_data.setTotalBalance(balance);
			}
			else if ((null == token_exprd.getToken())
			&& (null == token_data.getSession_token())) {
				resp_data.setHasError(true);
				resp_data.setErrorId(BC_ERR_TOKEN_NG);
				resp_data.setErrorDescription("Invalid Token");
				
				error_data.setMessage("Invalid Token");
				err_db.addNewErrorLog(error_data);
			}
			else if (null == user_data.getUserid()) {
				resp_data.setHasError(true);
				resp_data.setErrorId(BC_ERR_NO_USER);
				resp_data.setErrorDescription("User does not exist");
				
				error_data.setMessage("User does not exist");
				err_db.addNewErrorLog(error_data);
			}
			else {
				resp_data.setHasError(true);
				resp_data.setErrorId(BC_ERR_TRANS_NONE);
				resp_data.setErrorDescription("Transaction Not Found");
				
				error_data.setMessage("Transaction Not Found");
				err_db.addNewErrorLog(error_data);
			}
		}
		else {
			resp_data.setHasError(true);
			resp_data.setErrorId(BC_ERR_GENERAL);
			resp_data.setErrorDescription("Invalid Public Key");
			
			error_data.setMessage("Invalid Public Key");
			err_db.addNewErrorLog(error_data);
		}
		
		json_output	= gson.toJson(resp_data, RollbackOutput.class);
		
		return json_output;
	}
	
	//-----------------------------------------------------
    //  BetConstructController refreshToken
    //      Called when a User's Token has expired
	//		Creates a new Token
    //-----------------------------------------------------
	public String refreshToken(String json_input) throws NoSuchAlgorithmException, UnsupportedEncodingException
	{
		Gson gson						= new Gson();
		SimpleDateFormat dfrmt 			= new SimpleDateFormat("yyyyMMddHHmmss");
		Calendar cal_now				= Calendar.getInstance();
		BetConDao betcon_db				= new BetConDao();
		CasinoErrorLogDao err_db		= new CasinoErrorLogDao();
		
		RefreshToken json_data 			= gson.fromJson(json_input, RefreshToken.class);
		RefreshTokenOutput bc_token		= new RefreshTokenOutput();
		BetConUserBean bc_user			= new BetConUserBean();
		CasinoErrorLogBean error_data	= new CasinoErrorLogBean();
		
		String json_output			= "";
		String token				= "";
		String json_body			= "";
		String pubkey				= "";
		
		/*--------------------------------------------------------------------
        |	Remove Public Key for verification
        |-------------------------------------------------------------------*/
		pubkey		= json_data.getPublicKey();
		json_data.setPublicKey(null);
		json_body	= gson.toJson(json_data, RefreshToken.class);
		json_data.setPublicKey(pubkey);
		
		/*--------------------------------------------------------------------
        |	Get user information from database
        |-------------------------------------------------------------------*/
		bc_user		= betcon_db.getUserBySessionToken(json_data.getToken());

		/*--------------------------------------------------------------------
        |	Check Parameter Hashing
        |-------------------------------------------------------------------*/
		boolean key_check = this.verifyParamHash(json_body, json_data.getPublicKey(), json_input, bc_user.getUsername(), bc_user.getSite_id());
		
		if (true == key_check) {
			
			/*--------------------------------------------------------------------
	        |	Initialize Error Input data
	        |-------------------------------------------------------------------*/
			error_data.setUsername(bc_user.getUsername());
			error_data.setSiteId(bc_user.getSite_id());
			error_data.setGameProvider(GP_BETCON);
			error_data.setMethod(BC_MT_REFTOK);
			
			if (null != bc_user.getUsername()) {
				/*--------------------------------------------------------------------
		        |	Create a random character token
		        |-------------------------------------------------------------------*/
				token	= Integer.toString(bc_user.getSite_id()).concat("_").concat(bc_user.getUsername()).concat("T").concat(dfrmt.format(cal_now.getTime()));
				
				/*--------------------------------------------------------------------
		        |	Update Database with generated Token
		        |-------------------------------------------------------------------*/
				betcon_db.updateBcSessionByUsername(bc_user.getUsername(), token, bc_user.getSite_id());
				
				bc_token.setHasError(false);
				bc_token.setErrorId(BC_ERR_NONE);
				bc_token.setErrorDescription("");
				bc_token.setToken(token);
			}
			else {
				bc_token.setHasError(true);
				bc_token.setErrorId(BC_ERR_TOKEN_NG);
				bc_token.setErrorDescription("Invalid Token");
				
				error_data.setMessage("Invalid Token");
				err_db.addNewErrorLog(error_data);
			}
		}
		else {
			bc_token.setHasError(true);
			bc_token.setErrorId(BC_ERR_GENERAL);
			bc_token.setErrorDescription("Invalid Public Key");
			
			error_data.setMessage("Invalid Public Key");
			err_db.addNewErrorLog(error_data);
		}
		
		json_output	= gson.toJson(bc_token, RefreshTokenOutput.class);
		
		return json_output;
	}
}
