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
				String srv_resp_1	= bc_ctrl.getBalance(reader.readLine(), session_id);
				output.print(srv_resp_1);
				break;
			
			case 2:
				
				break;
			
			case 3:
				
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
