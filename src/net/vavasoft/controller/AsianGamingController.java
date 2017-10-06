package net.vavasoft.controller;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigInteger;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.security.MessageDigest;
import java.util.Base64;

import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import net.vavasoft.bean.UserBean;
import net.vavasoft.dao.UserDao;
import net.vavasoft.util.DesEncrypter;

public class AsianGamingController {
	
	public static final String SITE_ID 			= "1";
	public static final String API_KEY 			= "abtMbZZzuNAQ";
	public static final String DES_KEY 			= "sOz9Zo5v";
	public static final String ENC_PARAM_ALGO	= "DES";
	public static final String ENC_KEY_ALGO		= "MD5";
	
	public static final byte[] DES_KEY_BYTE		= DES_KEY.getBytes();
	
	public static final String DES_PARAM_SUFX	= "/\\\\/";
	public static final String CAGENT_PARAM		= "BQ0_AGIN";
	public static final String METHOD_PARAM		= "lg";
	public static final String ACTYPE_PARAM		= "1";
	public static final String CURRENCY_PARAM	= "KRW";
	public static final String PROD_ID_PARAM	= "BQ0";
	public static final String AG_DM_PARAM		= "m.vava21.com";
	//public static final String AG_DM_PARAM		= "2deceb53.ngrok.io";
	public static final String MH5_PARAM		= "n";
	
	public static final String LANG_EN_PARAM	= "3";
	public static final String LANG_KR_PARAM	= "3";

	public static final String GAME_ALL_PARAM	= "0";	
	public static final String GAME_AGQ_PARAM	= "1";
	public static final String GAME_AGIN_PARAM	= "2";
	public static final String GAME_MULT_PARAM	= "3";
	public static final String GAME_VIP_PARAM	= "4";
	public static final String GAME_BID_PARAM	= "5";
	public static final String GAME_EGAM_PARAM	= "8";
	public static final String GAME_BAC_AGIN	= "22";
	public static final String GAME_DRAGON_AGQ	= "23";
	public static final String GAME_DRAGON_AGIN	= "24";
	public static final String GAME_ROULT_AGQ	= "25";
	public static final String GAME_ROULT_AGIN	= "26";
	public static final String GAME_SICB_AGQ	= "27";
	public static final String GAME_VIP_AGIN	= "30";
	public static final String GAME_VIP_LED		= "31";
	public static final String GAME_BULL_PARAM	= "32";
	public static final String GAME_LIVES_PARAM	= "34";
	
	//-----------------------------------------------------
    //  AsianGamingController constructor
    //      Create Asian Gaming Account
    //-----------------------------------------------------
	public String checkCreateAccount(String user_id)
	{
		String url_base			= "http://gi.aggdemo.com:81/doBusiness.do?";
		String params_str		= "";
		String enc_params		= "";
		String ag_create_url	= "";
		
		/*--------------------------------------------------------------------
        |	Build the GET Parameter String
        |-------------------------------------------------------------------*/
		params_str			= params_str.concat("cagent=").concat(CAGENT_PARAM).concat(DES_PARAM_SUFX);
		params_str			= params_str.concat("loginname=").concat(SITE_ID).concat("_").concat(user_id).concat(DES_PARAM_SUFX);
		params_str			= params_str.concat("method=").concat(METHOD_PARAM).concat(DES_PARAM_SUFX);
		params_str			= params_str.concat("actype=").concat(ACTYPE_PARAM).concat(DES_PARAM_SUFX);
		params_str			= params_str.concat("password=").concat(SITE_ID).concat("_").concat(user_id).concat(DES_PARAM_SUFX);
		params_str			= params_str.concat("oddtype=").concat("A").concat(DES_PARAM_SUFX);
		params_str			= params_str.concat("cur=").concat(CURRENCY_PARAM);
		
		/*--------------------------------------------------------------------
        |	Encrypt the Parameters
        |-------------------------------------------------------------------*/
		try {
			enc_params			= this.encryptParams(params_str);
			ag_create_url		= url_base.concat(enc_params);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return ag_create_url;
	}
	
	public String createAgSession(String user_id, String session_id)
	{
		String sess_url_base	= "http://uatapi.hgline88.com:3381/resource/player-tickets.ucs?";
		String url_full			= "";
		String params_str		= "";
		UserDao user_db			= new UserDao();
		UserBean user_profile	= new UserBean();
		
		/*--------------------------------------------------------------------
        |	Get User information from Database
        |-------------------------------------------------------------------*/
		user_profile			= user_db.getUserByUserId(user_id);
		
		/*--------------------------------------------------------------------
        |	Build the GET Parameter String
        |-------------------------------------------------------------------*/
		params_str			= params_str.concat("productid=").concat(PROD_ID_PARAM).concat("&");
		params_str			= params_str.concat("username=").concat(SITE_ID).concat("_").concat(user_id).concat("&");
		params_str			= params_str.concat("session_token=").concat(session_id).concat("&");
		params_str			= params_str.concat("credit=").concat(Integer.toString(user_profile.getMoney()));
		
		url_full			= sess_url_base.concat(params_str);
		
		return url_full;
	}
	
	public String forwardToAg(String user_id, String session_id, String lnk_dsp)
	{
		String url_base			= "http://gci.aggdemo.com:81/forwardGame.do?";
		String params_str		= "";
		String enc_params		= "";
		String ag_game_url		= "";
		
		/*--------------------------------------------------------------------
        |	Build the GET Parameter String
        |-------------------------------------------------------------------*/
		params_str			= params_str.concat("cagent=").concat(CAGENT_PARAM).concat(DES_PARAM_SUFX);
		params_str			= params_str.concat("loginname=").concat(SITE_ID).concat("_").concat(user_id).concat(DES_PARAM_SUFX);
		params_str			= params_str.concat("password=").concat(SITE_ID).concat("_").concat(user_id).concat(DES_PARAM_SUFX);
		params_str			= params_str.concat("dm=").concat(AG_DM_PARAM).concat(DES_PARAM_SUFX);
		params_str			= params_str.concat("sid=").concat(CAGENT_PARAM).concat("0123456789123").concat(DES_PARAM_SUFX);
		params_str			= params_str.concat("mh5=").concat(MH5_PARAM).concat(DES_PARAM_SUFX);
		params_str			= params_str.concat("actype=").concat(ACTYPE_PARAM).concat(DES_PARAM_SUFX);
		params_str			= params_str.concat("lang=").concat(LANG_KR_PARAM).concat(DES_PARAM_SUFX);
		params_str			= params_str.concat("gametype=").concat(lnk_dsp);
		
		/*--------------------------------------------------------------------
        |	Encrypt the Parameters
        |-------------------------------------------------------------------*/
		try {
			enc_params		= this.encryptParams(params_str);
			ag_game_url		= url_base.concat(enc_params);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return ag_game_url;
	}
	
	public String launchGame(String user_id, String session_id, String lnk_dsp) throws MalformedURLException, IOException
	{
		String ag_create_url	= checkCreateAccount(session_id);
		String ag_sess_url		= createAgSession(user_id, session_id);
		String ag_game_url		= forwardToAg(user_id, session_id, lnk_dsp);
		
		InputStream  con_create	= new URL(ag_create_url).openStream();
		InputStream  con_sess	= new URL(ag_sess_url).openStream();
		
		return ag_game_url;
	}
	
	public String encryptParams(String params) throws Exception
	{
		String params_uri	= "params=";
		String key_uri		= "key=";
		String get_uri		= "";
		
		/*--------------------------------------------------------------------
        |	Encrypt Parameters using DES Algorithm
        |-------------------------------------------------------------------*/
		/*	Convert String DES Key to Secret Key type	*/
		SecretKey key 			= new SecretKeySpec(DES_KEY_BYTE, 0, DES_KEY_BYTE.length, ENC_PARAM_ALGO);
		DesEncrypter encrypter 	= new DesEncrypter(key);
		
		String enc_params 		= encrypter.encrypt(params);
		
		/*--------------------------------------------------------------------
        |	Encrypt API Key using MD5.
        |	Encrypted Parameters are salted with API Key to make
        |	it different request which is protection against
        |	Man-in-middle attack
        |-------------------------------------------------------------------*/
		MessageDigest md 		= MessageDigest.getInstance(ENC_KEY_ALGO);
		String md_key 			= enc_params.concat(API_KEY);
		
		md.update(md_key.getBytes(), 0, md_key.length());
		
		/*--------------------------------------------------------------------
        |	Construct Encrypted GET Parameters
        |-------------------------------------------------------------------*/
		get_uri	= params_uri.concat(enc_params).concat("&");
		get_uri	= get_uri.concat(key_uri).concat(new BigInteger(1,md.digest()).toString(16));
		
		return get_uri;
	}
}
