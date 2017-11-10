package servlet;

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

import controller.BetConstructController;

@WebServlet("/casino-webhook/*")
public class BetConstructServlet extends HttpServlet {
	
	private static final long serialVersionUID 		= 1L;
	public static final String BC_WEBHOOK_AUTH		= "/Authentication";
	public static final String BC_WEBHOOK_GETBAL	= "/GetBalance";
	public static final String BC_WEBHOOK_WITHDRAW	= "/Withdraw";
	public static final String BC_WEBHOOK_DEPOSIT	= "/Deposit";
	public static final String BC_WEBHOOK_WITHDEPO	= "/WithdrawAndDeposit";
	public static final String BC_WEBHOOK_ROLLBCK	= "/Rollback";
	public static final String BC_WEBHOOK_REFTOK	= "/RefreshToken";
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		Gson gson						= new Gson();
		String method 					= request.getParameter("method");
		String session_id				= request.getSession().getId();
		BufferedReader reader			= request.getReader();
		
		BetConstructController bc_ctrl	= new BetConstructController();
		PrintWriter output				= response.getWriter();
		System.out.println(request.getPathInfo());
		
		
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
		
		BetConstructController bc_ctrl	= new BetConstructController();
		PrintWriter output				= response.getWriter();
		
		if (method.equals(BC_WEBHOOK_AUTH)) {
			String srv_resp_1 = "";
			try {
				srv_resp_1 = bc_ctrl.authentication(reader.readLine());
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			output.print(srv_resp_1);
		}
		else if (method.equals(BC_WEBHOOK_GETBAL)) {
			String srv_resp_2 = "";
			try {
				srv_resp_2 = bc_ctrl.getBalance(reader.readLine());
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			output.print(srv_resp_2);
		}
		else if (method.equals(BC_WEBHOOK_WITHDRAW)) {
			String srv_resp_3 = "";;
			try {
				srv_resp_3 = bc_ctrl.withdrawAndDeposit(reader.readLine(), 1);
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			output.print(srv_resp_3);
		}
		else if (method.equals(BC_WEBHOOK_DEPOSIT)) {
			String srv_resp_4 = "";;
			try {
				srv_resp_4 = bc_ctrl.withdrawAndDeposit(reader.readLine(), 2);
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			output.print(srv_resp_4);
		}
		else if (method.equals(BC_WEBHOOK_WITHDEPO)) {
			String srv_resp_5 = "";;
			try {
				srv_resp_5 = bc_ctrl.withdrawAndDeposit(reader.readLine(), 3);
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			output.print(srv_resp_5);
		}
		else if (method.equals(BC_WEBHOOK_ROLLBCK)) {
			String srv_resp_6 = "";;
			try {
				srv_resp_6 = bc_ctrl.rollback(reader.readLine());
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			output.print(srv_resp_6);
		}
		else if (method.equals(BC_WEBHOOK_REFTOK)) {
			String srv_resp_7 = "";;
			try {
				srv_resp_7 = bc_ctrl.refreshToken(reader.readLine());
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			output.print(srv_resp_7);
		}
		else {
			String srv_resp_0	= "Invalid Method";
			output.print(srv_resp_0);
		}
		
		output.flush();
	}
}
