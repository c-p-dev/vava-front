package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import controller.SpinCubeController;

@WebServlet("/spincube-api/*")
public class SpinCubeServlet extends HttpServlet {
	
	private static final long serialVersionUID 			= 1L;
	public static final String SC_METHOD_GET_TOKEN		= "/GetToken";
	public static final String SC_METHOD_CREATE_PLAYER	= "/CreatePlayer";
	public static final String SC_METHOD_LAUNCH_GAME	= "/GetGameUrl";
	public static final String SC_METHOD_DEPOSIT		= "/Deposit";
	public static final String SC_METHOD_WITHDRAW		= "/Withdraw";
	public static final String SC_METHOD_LOCK_STS		= "/UpdUserLock";
	public static final String SC_METHOD_GET_BETS		= "/GetBetDetails";

	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		Gson gson						= new Gson();
		String method 					= request.getPathInfo();
		String session_id				= request.getSession().getId();
		BufferedReader reader			= request.getReader();
		
		SpinCubeController sc_ctrl		= new SpinCubeController("1_agent007");
		PrintWriter output				= response.getWriter();
		
		if (method.equals(SC_METHOD_GET_TOKEN)) {
			String srv_resp_1 	= "";
			srv_resp_1 			= sc_ctrl.getToken();
			output.print(srv_resp_1);
		}
		else if (method.equals(SC_METHOD_CREATE_PLAYER)) {
			String srv_resp_2 	= "";
			try {
				srv_resp_2 			= sc_ctrl.createPlayer();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			output.print(srv_resp_2);
		}
		else if (method.equals(SC_METHOD_LAUNCH_GAME)) {
			String srv_resp_3 	= "";
			String game_name	= "SVS_instant_greyhounds";
			try {
				srv_resp_3 			= sc_ctrl.getGameUrl(game_name);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			output.print(srv_resp_3);
		}
		else if (method.equals(SC_METHOD_DEPOSIT)) {
			String srv_resp_3 	= "";
			double amount	= 10000;
			try {
				srv_resp_3 			= sc_ctrl.makeTransaction(amount, "deposit");
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			output.print(srv_resp_3);
		}
		else if (method.equals(SC_METHOD_WITHDRAW)) {
			String srv_resp_4 	= "";
			Double amount	= null;
			try {
				srv_resp_4 			= sc_ctrl.makeTransaction(amount, "withdraw");
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			output.print(srv_resp_4);
		}
		else if (method.equals(SC_METHOD_LOCK_STS)) {
			String srv_resp_5 	= "";
			boolean lock_sts	= true;
			try {
				srv_resp_5 			= sc_ctrl.lockUser(lock_sts);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			output.print(srv_resp_5);
		}
		else if (method.equals(SC_METHOD_GET_BETS)) {
			String srv_resp_6 	= "";
			
			try {
				srv_resp_6 			= sc_ctrl.saveBetList();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			output.print(srv_resp_6);
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
