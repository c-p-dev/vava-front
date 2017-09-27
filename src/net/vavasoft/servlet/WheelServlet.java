package net.vavasoft.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import net.vavasoft.controller.SpinWheelController;

@WebServlet("/WheelServlet")
public class WheelServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	public static Logger logger = Logger.getLogger(WheelServlet.class);
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		SpinWheelController spin_ctrl	= new SpinWheelController();
		String method 					= request.getParameter("method");
		String srv_resp					= "";
		PrintWriter output				= response.getWriter();
		
		switch (Integer.valueOf(method)) {
			case 1:
				srv_resp = spin_ctrl.getUserWheelDetails();
				break;
			
			case 2:
				srv_resp = spin_ctrl.calculateUserSpinResult();
				break;
			
			case 0:
			default:
				break;
		}
		
		response.setContentType("application/json");

		output.print(srv_resp);
		output.flush();
	}
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		SpinWheelController spin_ctrl	= new SpinWheelController();
		String method 					= request.getParameter("method");
		String srv_resp					= "";
		PrintWriter output				= response.getWriter();
		BufferedReader reader			= request.getReader();
		
		switch (Integer.valueOf(method)) {
			case 3:
				srv_resp = spin_ctrl.calculateTicketRng(reader.readLine());
				break;
			
			case 0:
			default:
				break;
		}
		
		response.setContentType("application/json");

		output.print(srv_resp);
		output.flush();
	}
}
