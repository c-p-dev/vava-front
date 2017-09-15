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
import net.vavasoft.bean.MgPlayerAccountBean;
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
		
		return srv_resp;
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
