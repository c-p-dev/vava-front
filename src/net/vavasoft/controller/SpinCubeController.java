package net.vavasoft.controller;

import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Calendar;
import java.util.Scanner;

import javax.net.ssl.HttpsURLConnection;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import net.vavasoft.bean.MgPlayerAccountBean;
import net.vavasoft.util.NukeSSLCerts;

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
	
	public String getToken()
	{
		/*	Variable Declaration	*/
		Gson gson				= new Gson();
		JsonObject json_data	= new JsonObject();
		SimpleDateFormat dfrmt 	= new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
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
				
				System.out.println(json_data.get("access_token"));
				System.out.println(json_data.get("expires_in"));
				
				Calendar cal = Calendar.getInstance();
				cal.add(Calendar.MINUTE, 30);
				System.out.println(dfrmt.format(cal.getTime()));
				
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
	
	public String createPlayer()
	{
		/*	Variable Declaration	*/
		Gson gson				= new Gson();
		JsonObject json_data	= new JsonObject();
		SimpleDateFormat dfrmt 	= new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
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
	
	public String getGameUrl(String game_name)
	{
		/*	Variable Declaration	*/
		Gson gson				= new Gson();
		JsonObject json_data	= new JsonObject();
		SimpleDateFormat dfrmt 	= new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		String url				= SC_BASE_URL.concat("agents/").concat(SC_AGENT_UNAME).concat("/Players/").concat(this.player_id).concat("/products/SVS/Sessions");
		String post_param		= "";
		String srv_resp			= "";
		
		/*	Convert parameters to JSON	*/
		post_param	= "game=".concat(game_name).concat("&");
		post_param	= post_param.concat("langCode=ko-KR").concat("&");
		post_param	= post_param.concat("platform=Desktop");
		
		/*--------------------------------------------------------------------
        |	Execute HTTP POST Request to TEG
        |-------------------------------------------------------------------*/
		srv_resp 	= this.postToSc(url, post_param, "application/x-www-form-urlencoded");
		
		return srv_resp;
	}
	
	public String postToSc(String url, String post_param, String content_type)
	{
		/*	Variable Declaration	*/
		String responseBody = "";
		String bearer_auth	= "eyJhbGciOiJSUzI1NiIsImtpZCI6IjQ3QkVBRjkzRkQ4MTkyMDM0NjI0MEQ3RDAzM0FCMTgxNDQxMDZCOEMiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJSNzZ2a18yQmtnTkdKQTE5QXpxeGdVUVFhNHcifQ.eyJuYmYiOjE1MDg5MzM0NTMsImV4cCI6MTUwODkzNTI1MywiaXNzIjoiaHR0cHM6Ly9zdHMuazJuZXQuaW8iLCJhdWQiOlsiaHR0cHM6Ly9zdHMuazJuZXQuaW8vcmVzb3VyY2VzIiwiazIiXSwiY2xpZW50X2lkIjoidGVzdGFnZW50MjEyNTU1IiwiY2xpZW50X2FnZW50IjoidGVzdGFnZW50MjEyNTU1IiwiY2xpZW50X29wZXJhdGlvbiI6ImFueSIsInNjb3BlIjpbImFwaSJdfQ.n5YRnsClP47PbkzEDFERaE_5qs89ZxBPRKi_5mbVkxsCXHPYd1OElMCnGb32EybBKWLEOYDxn03nqO2yw4djdNf5l89vALUwM5sDnOFgcg9FgTZ9ER6fcggEMdbMrUIEINUm0_cucj_lqfu2mKth2XGYfpK2eeFj15Qxzmga6eXhZDMqzvdzE5bPERnQl2HciXJk106hMj2TE9Jc22o0jKAItOeGOdXh_QzO6OwAzusEIPaKhljosgOeY9keavogOAFnhWB6PxzHDGuxNGKH_D9HhDVrc6psQIS4WDiGsIShW9VUcoouCye97ZR7UP_nEV6nZv57pMJ7jh-ehb8BJTnekCnJtXQqJ9UH4xM0o0sR3JY6dDJdw9QFb23DLmjJgUIelaVL4RpHNOtWyxPlcLb0-59NuISyn6hSnXnAVMIYiSe1YhDLQ5zNDIaDbIdonRTCwqxz566uZMoCKZ5f2DkREG-UfK-LWhGDpDDSXX1wXoKT0K6Vk4KA8Vkfovf1KqsTnkPxx-N75cxHyVjtJNvwcizjqnNcjxY1ZRHcJSwiBEtlzavRm486MvQYXK_W2Mjf4aCLpDAOMs0YfUctdJvYm93DAlpw2-NJeS5LZxiZGPs_fZXhIXTACW_p3Qd5ATrwKfB3tPomzPBMYBKvBDoiJHj98CnoEePZQOX3lxw";
		
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
