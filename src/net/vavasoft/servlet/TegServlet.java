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
		
		PrintWriter output				= response.getWriter();
		
		switch (Integer.valueOf(method)) {
			case 1:
				UserBean udata_1	= (UserBean)request.getSession().getAttribute("currentSessionUser");
				String uname_1 		= udata_1.getUserid();
				int game_provider	= Integer.valueOf(request.getParameter("gm_provdr"));
				String srv_resp_1	= "";
				
				srv_resp_1 			= teg_ctrl.userPlayCheck(uname_1, game_provider);
				output.print(srv_resp_1);
				break;
			
			case 2:
				UserBean udata_2	= (UserBean)request.getSession().getAttribute("currentSessionUser");
				String uname_2 		= udata_2.getUserid();
				int srv_resp_2		= 0;
				
				srv_resp_2 			= teg_ctrl.transferMoneyToVava(uname_2);
				output.print(srv_resp_2);
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
