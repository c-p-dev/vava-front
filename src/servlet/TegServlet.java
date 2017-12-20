package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.google.gson.Gson;

import bean.UserBean;
import controller.SpinCubeController;
import controller.TotalEgameController;
import dao.UserDao;


@WebServlet("/TegServlet")
public class TegServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	public static Logger logger = Logger.getLogger(TegServlet.class);
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		Gson gson						= new Gson();
		TotalEgameController teg_ctrl	= new TotalEgameController();
		
		String method 					= request.getParameter("method");
		String username					= (String)request.getSession().getAttribute("UID");
		int site_id						= (int)request.getSession().getAttribute("SITEID");
		
		PrintWriter output				= response.getWriter();
		
		switch (Integer.valueOf(method)) {
			case 1:
				int game_provider	= Integer.valueOf(request.getParameter("gm_provdr"));
				String lnk_dsp		= request.getParameter("lnk_dsp");
				String srv_resp_1	= "";
				
				try {
					srv_resp_1 			= teg_ctrl.userPlayCheck(username, site_id, game_provider, lnk_dsp);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				output.print(srv_resp_1);
				break;
			
			case 2:
				/*	No Processing	*/
				break;
			
			case 3:
				UserDao user_db		= new UserDao();
				String srv_resp_3	= "";
				
				srv_resp_3 			= gson.toJson(user_db.getUserByUserId(username));
				
				response.setContentType("application/json");
				output.print(srv_resp_3);
				break;
			
			case 4:
				teg_ctrl.extractLiveGameTransactions();
				break;
			
			case 5:
				UserBean udata5		= new UserBean();
				UserDao user_db5	= new UserDao();
				String srv_resp_5	= "";
				
				if (null != username) {
					udata5	= user_db5.getUserByUserId(username);
					
					if (null != udata5) {
						if (0 >= udata5.getMoney()) {
							try {
								srv_resp_5 = teg_ctrl.getAllMoney(username, site_id);
							} catch (ParseException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
						}
					}
				}
				
				response.setContentType("application/json");
				output.print(srv_resp_5);
				break;
			
			case 6:
				String srv_resp_6	= "";
				
				srv_resp_6	= teg_ctrl.getBetPlaycheck(username);
				
				output.print(srv_resp_6);
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
