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
	public static Logger logger = Logger.getLogger(UserRegister.class);
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		
		SpinWheelController spin_ctrl	= new SpinWheelController();
		String method 					= request.getParameter("method");
		String srv_resp					= "";
		PrintWriter output				= response.getWriter();
		
		if ("getUserWheelDetails".equals(method)) {
			srv_resp = spin_ctrl.getUserWheelDetails();
		}
		else if ("calculateUserSpinResult".equals(method)) {
			srv_resp = spin_ctrl.calculateUserSpinResult();
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
		
		if ("calculateTicketRng".equals(method)) {
			srv_resp = spin_ctrl.calculateTicketRng(reader.readLine());
			System.out.println(srv_resp);
		}
		
		response.setContentType("application/json");

		output.print(srv_resp);
		output.flush();
	}
}
