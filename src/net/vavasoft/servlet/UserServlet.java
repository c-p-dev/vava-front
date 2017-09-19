package net.vavasoft.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import net.arnx.jsonic.JSON;
import net.vavasoft.bean.MgBettingProfileBean;
import net.vavasoft.bean.MgPlayerAccountBean;
import net.vavasoft.bean.UserBean;
import net.vavasoft.controller.TotalEgameController;
import net.vavasoft.dao.UserDao;


/**
 * Servlet implementation class UserServlet
 */
@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static Logger logger = Logger.getLogger(UserServlet.class);   
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String method = request.getParameter("method");
	
		if("logout".equals(method)){
			HttpSession session = request.getSession(true);	    
			session.invalidate();
			response.sendRedirect("index.jsp");
		}
		
	}

	/*	Response Code	
	 * 	9 - fail (default)
	 *  0 - success
	 *  1 - wrong password
	 *  2 - unknown userid
	 * */
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String method = request.getParameter("method");		
		int resp = 9;
		PrintWriter output				= response.getWriter();

		if("login".equals(method)){
			resp = userLogin(request);
		}
		
		output.print(resp);
		output.flush();
	}
	
	public int userLogin(HttpServletRequest request){
		UserBean ub;
		UserDao userDao = new UserDao();
		int response_code = 4;
		try {
			ub = userDao.getUser(request.getParameter("userid").trim(), request.getParameter("passwd").trim());
			response_code = (int) ub.getLoginStatus();
		} catch (SQLException e) {
			System.out.println(e);
			e.printStackTrace();
		}
		
		return response_code;
	}
	
	
	
	

}
