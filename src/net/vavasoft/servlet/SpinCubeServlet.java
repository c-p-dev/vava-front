package net.vavasoft.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import net.vavasoft.controller.SpinCubeController;

@WebServlet("/spincube-api/*")
public class SpinCubeServlet extends HttpServlet {
	
	private static final long serialVersionUID 			= 1L;
	public static final String SC_METHOD_GET_TOKEN		= "/GetToken";
	public static final String SC_METHOD_CREATE_PLAYER	= "/CreatePlayer";
	public static final String SC_METHOD_LAUNCH_GAME	= "/GetGameUrl";

	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		Gson gson						= new Gson();
		String method 					= request.getPathInfo();
		String session_id				= request.getSession().getId();
		BufferedReader reader			= request.getReader();
		
		SpinCubeController sc_ctrl		= new SpinCubeController("agent007");
		PrintWriter output				= response.getWriter();
		
		if (method.equals(SC_METHOD_GET_TOKEN)) {
			String srv_resp_1 	= "";
			srv_resp_1 			= sc_ctrl.getToken();
			output.print(srv_resp_1);
		}
		else if (method.equals(SC_METHOD_CREATE_PLAYER)) {
			String srv_resp_2 	= "";
			srv_resp_2 			= sc_ctrl.createPlayer();
			output.print(srv_resp_2);
		}
		else if (method.equals(SC_METHOD_LAUNCH_GAME)) {
			String srv_resp_3 	= "";
			String game_name	= "SVS_instant_greyhounds";
			srv_resp_3 			= sc_ctrl.getGameUrl(game_name);
			output.print(srv_resp_3);
		}
		else {
			String srv_resp_0	= "Invalid Method";
			output.print(srv_resp_0);
		}
		
		output.flush();
	}
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		Gson gson						= new Gson();
		String method 					= request.getPathInfo();
		String session_id				= request.getSession().getId();
		BufferedReader reader			= request.getReader();
		
		SpinCubeController sc_ctrl		= new SpinCubeController("agent007");
		PrintWriter output				= response.getWriter();
		
		if (method.equals(SC_METHOD_GET_TOKEN)) {
			String srv_resp_1 	= "";
			srv_resp_1 			= sc_ctrl.getToken();
			output.print(srv_resp_1);
		}
		else {
			String srv_resp_0	= "Invalid Method";
			output.print(srv_resp_0);
		}
		
		output.flush();
	}
}
