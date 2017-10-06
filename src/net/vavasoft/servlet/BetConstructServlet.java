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

import net.vavasoft.controller.BetConstructController;

@WebServlet("/betcon-callback")
public class BetConstructServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
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
		
		switch (Integer.valueOf(method)) {
			/* Create or Check Account	*/
			case 1:
				String srv_resp_1	= bc_ctrl.getBalance(reader.readLine());
				output.print(srv_resp_1);
				break;
			
			case 2:
				try {
					boolean srv_resp_2	= bc_ctrl.verifyParamHash(reader.readLine());
				} catch (NoSuchAlgorithmException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				break;
			
			case 3:
				String srv_resp_3	= bc_ctrl.getBalance(reader.readLine());
				break;
				
			case 0:
			default:
				break;
		}
		
		output.flush();
	}
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		Gson gson						= new Gson();
		String method 					= request.getParameter("method");
		String session_id				= request.getSession().getId();
		BufferedReader reader			= request.getReader();
		
		BetConstructController bc_ctrl	= new BetConstructController();
		PrintWriter output				= response.getWriter();
		
		switch (Integer.valueOf(method)) {
			/* Create or Check Account	*/
			case 1:
				String srv_resp_1	= bc_ctrl.getBalance(reader.readLine());
				output.print(srv_resp_1);
				break;
			
			case 2:
				try {
					boolean srv_resp_2	= bc_ctrl.verifyParamHash(reader.readLine());
				} catch (NoSuchAlgorithmException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				break;
			
			case 3:
				String srv_resp_3	= bc_ctrl.getBalance(reader.readLine());
				break;
			
			case 4:
				String srv_resp_4	= bc_ctrl.withdrawAndDeposit(reader.readLine(), 1);
				break;
			
			case 5:
				String srv_resp_5	= bc_ctrl.withdrawAndDeposit(reader.readLine(), 2);
				break;
			
			case 6:
				String srv_resp_6	= bc_ctrl.withdrawAndDeposit(reader.readLine(), 3);
				break;
			
			case 7:
				String srv_resp_7	= bc_ctrl.rollback(reader.readLine());
				break;
				
			case 8:
				String srv_resp_8	= bc_ctrl.refreshToken(reader.readLine());
				break;
				
			case 0:
				String srv_resp_0	= bc_ctrl.authentication(reader.readLine());
				break;
				
			default:
				break;
		}
		
		output.flush();
	}
}
