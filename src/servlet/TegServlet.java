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
		
		PrintWriter output				= response.getWriter();
		
		switch (Integer.valueOf(method)) {
			case 1:
				UserBean udata_1	= (UserBean)request.getSession().getAttribute("currentSessionUser");
				String uname_1 		= udata_1.getUserid();
				int game_provider	= Integer.valueOf(request.getParameter("gm_provdr"));
				String lnk_dsp		= request.getParameter("lnk_dsp");
				String srv_resp_1	= "";
				
				try {
					srv_resp_1 			= teg_ctrl.userPlayCheck(uname_1, game_provider, lnk_dsp);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				output.print(srv_resp_1);
				break;
			
			case 2:
				UserBean udata_2	= (UserBean)request.getSession().getAttribute("currentSessionUser");
				String uname_2 		= udata_2.getUserid();
				String srv_resp_2	= "";
				
				SpinCubeController sc_ctrl		= new SpinCubeController(Integer.toString(udata_2.getSiteid()).concat("_").concat(udata_2.getUserid()));
				
				srv_resp_2 			= gson.toJson(teg_ctrl.transferMoneyToVava(uname_2), UserBean.class);
				
				try {
					srv_resp_2 			= gson.toJson(sc_ctrl.transferMoneyToVava(uname_2), UserBean.class);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				response.setContentType("application/json");
				output.print(srv_resp_2);
				break;
			
			case 3:
				UserDao user_db		= new UserDao();
				UserBean udata_3	= (UserBean)request.getSession().getAttribute("currentSessionUser");
				String uname_3 		= udata_3.getUserid();
				String srv_resp_3	= "";
				
				srv_resp_3 			= gson.toJson(user_db.getUserByUserId(udata_3.getUserid()));
				
				response.setContentType("application/json");
				output.print(srv_resp_3);
				break;
			
			case 4:
				teg_ctrl.extractLiveGameTransactions();
				break;
			
			case 5:
				UserBean sess_data5	= (UserBean)request.getSession().getAttribute("currentSessionUser");
				UserBean udata5		= new UserBean();
				UserDao user_db5	= new UserDao();
				String srv_resp_5	= "";
				System.out.println("show me the money");
				if (null != sess_data5) {
					udata5	= user_db5.getUserByUserId(sess_data5.getUserid());
					
					if (null != udata5) {
						if (0 >= udata5.getMoney()) {
							try {
								System.out.println(udata5.getUserid());
								srv_resp_5 = teg_ctrl.getAllMoney(udata5.getUserid());
							} catch (ParseException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
						}
					}
				}
				
				output.print(srv_resp_5);
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
