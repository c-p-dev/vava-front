package net.vavasoft.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import net.vavasoft.controller.AsianGamingController;

@WebServlet("/AsianGamingServlet")
public class AsianGamingServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		Gson gson						= new Gson();
		String method 					= request.getParameter("method");
		String username					= request.getParameter("user_id");
		String session_id				= request.getSession().getId();
		
		AsianGamingController ag_ctrl	= new AsianGamingController();
		PrintWriter output				= response.getWriter();
		
		switch (Integer.valueOf(method)) {
			/* Create or Check Account	*/
			case 1:
				String srv_resp_1	= ag_ctrl.checkCreateAccount(username);
				output.print(srv_resp_1);
				break;
			
			case 2:
				String srv_resp_2	= ag_ctrl.createAgSession(username, session_id);
				output.print(srv_resp_2);
				break;
			
			case 3:
				String srv_resp_3	= ag_ctrl.forwardToAg(username, session_id, "22");
				output.print(srv_resp_3);
				break;
			
			case 4:
				String srv_resp_4	= ag_ctrl.launchGame(username, "22");
				output.print(srv_resp_4);
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
		
		
	}
	
}
