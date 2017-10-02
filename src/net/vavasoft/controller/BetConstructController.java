package net.vavasoft.controller;

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
import net.vavasoft.betconstruct.GetBalance;
import net.vavasoft.betconstruct.GetBalanceOutput;
import net.vavasoft.betconstruct.Rollback;
import net.vavasoft.betconstruct.RollbackOutput;
import net.vavasoft.betconstruct.WithdrawAndDeposit;
import net.vavasoft.betconstruct.WithdrawAndDepositOutput;
import net.vavasoft.dao.BcTransactionLogDao;
import net.vavasoft.dao.BetConDao;
import net.vavasoft.dao.UserDao;

public class BetConstructController {
	
	public static final String SHARED_KEY	= "IamIronMan";
	public static final String HASH_TYPE	= "SHA-256";
	
	public boolean verifyParamHash(String json_param) throws NoSuchAlgorithmException
	{
		Gson gson				= new Gson();
		MessageDigest md 		= MessageDigest.getInstance(HASH_TYPE);		
		String md_key 			= json_param.concat(SHARED_KEY);
		
		md.update(md_key.getBytes(), 0, md_key.length());
		
		return false;
	}
	
	public String authentication(String json_input)
	{
		Gson gson	= new Gson();
		
		return "OKAY";
	}
	
	public String getBalance(String json_input, String session_token)
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
		
		if (0 != user_data.getUserid().length()) {
			bc_user.setHas_error(false);
			bc_user.setError_id(0);
			bc_user.setError_description("");
			bc_user.setPlayer_id(json_data.getPlayerId());
			bc_user.setTotal_balance(user_data.getMoney());
			bc_user.setToken(session_token);
		}
		
		json_output	= gson.toJson(bc_user, GetBalanceOutput.class);
		
		return json_output;
	}
	
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
		
		user_data	= betcon_db.getUserByPlayerId(json_data.getPlayerId());
		trans_data	= log_db.getActiveTransactionByPlayerId(json_data.getPlayerId());
		
		if (0 == trans_data.getTransaction_id()) {
			/*	Setup data for new entry	*/
			trans_data.setPlayerId(json_data.getPlayerId());
			trans_data.setRgs_id(json_data.getRgsTransactionId());
			trans_data.setToken("1122334455");
			trans_data.setCurrency("KRW");
			
			trans_valid	= true;
		}
		else if (3 != trans_data.getStatus()) {
			trans_valid = true;
		}
		else {
			/*	No Processing	*/
		}
		
		if ((0 != user_data.getUserid().length())
		&& (true == trans_valid)) {
			switch (action) {
				case 1:
					trans_data.setWithdraw_amount(json_data.getWithdrawAmount());
					trans_data.setTransaction_type(1);
					
					bal_remain	= user_data.getMoney() - json_data.getWithdrawAmount();
					break;
				
				case 2:
					trans_data.setDeposit_amount(json_data.getDepositAmount());
					trans_data.setTransaction_type(2);
					
					bal_remain	= user_data.getMoney() + json_data.getDepositAmount();
					
					break;
				
				case 3:
					trans_data.setWithdraw_amount(json_data.getWithdrawAmount());
					trans_data.setDeposit_amount(json_data.getDepositAmount());
					trans_data.setTransaction_type(3);
					
					bal_remain	= (user_data.getMoney() + json_data.getDepositAmount()) - json_data.getWithdrawAmount();
					break;
					
				default:
					bal_remain	= user_data.getMoney();
					break;
			}
			
			if (0 == trans_data.getTransaction_id()) {
				/*	Add Database Record	*/
				log_db.addNewTransactionLog(trans_data);
			}
			else {
				log_db.updateNewTransactionLog(trans_data);
			}
			
			user_db.setUserMoney(user_data.getUserid(), bal_remain);
			
			resp_data.setHasError(false);
			resp_data.setErrorId(0);
			resp_data.setErrorDescription("");
			resp_data.setPlayerId(json_data.getPlayerId());
			resp_data.setToken("12345");
			resp_data.setTotalBalance(bal_remain);
			resp_data.setPlatformTransactionId(1);
		}
		
		json_output	= gson.toJson(resp_data, WithdrawAndDepositOutput.class);
		
		return json_output;
	}
	
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
		
		user_data	= betcon_db.getUserByPlayerId(json_data.getPlayerId());
		trans_data	= log_db.getActiveTransactionByRgsId(json_data.getRgsTransactionId());
		
		if ((0 != trans_data.getTransaction_id())
		&& (3 != trans_data.getStatus())) {
			
			switch (trans_data.getTransaction_type()) {
				case 1:
					balance = (int)user_data.getMoney() + (int)trans_data.getWithdraw_amount();
					break;
				
				case 2:
					balance = (int)user_data.getMoney() - (int)trans_data.getDeposit_amount();
					break;
				
				case 3:
					balance = (int)user_data.getMoney() + (int)trans_data.getWithdraw_amount();
					balance = balance - (int)trans_data.getDeposit_amount();
					break;
					
				default:
					balance = user_data.getMoney();
			}
			
			user_db.setUserMoney(user_data.getUserid(), balance);
			
			resp_data.setHasError(false);
			resp_data.setErrorId(0);
			resp_data.setErrorDescription("");
			resp_data.setToken("1122334455");
			resp_data.setTotalBalance(balance);
		}
		
		json_output	= gson.toJson(resp_data, RollbackOutput.class);
		
		return json_output;
	}
}
