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

import net.vavasoft.bean.UserBean;
import net.vavasoft.controller.TotalEgameController;


@WebServlet("/TegServlet")
public class TegServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	public static Logger logger = Logger.getLogger(UserRegister.class);
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		TotalEgameController teg_ctrl	= new TotalEgameController();
		String method 					= request.getParameter("method");
		String srv_resp					= "";
		PrintWriter output				= response.getWriter();
		
		switch (Integer.valueOf(method)) {
			case 1:
				UserBean user_data	= (UserBean)request.getSession().getAttribute("currentSessionUser");
				String username 	= user_data.getUserid();
				int game_provider	= Integer.valueOf(request.getParameter("gm_provdr"));

				srv_resp = teg_ctrl.userPlayCheck(username, game_provider);
				output.print(srv_resp);
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
