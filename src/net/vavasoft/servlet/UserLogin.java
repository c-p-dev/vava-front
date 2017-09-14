package net.vavasoft.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


import org.apache.log4j.Logger;
import net.arnx.jsonic.JSON;
import net.vavasoft.bean.UserBean;
import net.vavasoft.dao.UserDao;

@WebServlet("/UserLoginServlets")
public class UserLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static Logger logger = Logger.getLogger(UserLogin.class);
    public UserLogin() {
        super();
  
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HashMap<String, Object> result = new HashMap<String,Object>();
		HashMap<String, Object> validateUserhsm = validateUser(request,response);
		boolean status  = false;
		String message = "Login Error";
		PrintWriter out = response.getWriter();
//		int error = (int) validateUserhsm.get("error_count");
//		ArrayList ResponseList = (ArrayList) validateUserhsm.get("response_list");
		
//		if("submit".equals(request.getParameter("action"))){
			HashMap<String, Object> csHsm = createSessionProcess(request,response);
			status = (boolean) csHsm.get("status");
			message = (String) csHsm.get("message");
//		}
		response.setContentType("application/json");
		result.put("status",status);
		result.put("message",message);
//		result.put("response", ResponseList);
		
		String res = JSON.encode(result);	
		out.print(res);
		out.flush();
	}
	
	
	
	public HashMap validateUser(HttpServletRequest request, HttpServletResponse response){
		
		HashMap<String, Object> result = new HashMap<String,Object>();
		ArrayList ResponseList = new ArrayList();
		int error = 0;
		HashMap<String, Object> hashmaps;
		
		String userid = request.getParameter("userid").trim();
		String passwd = request.getParameter("passwd").trim();
		
		if((userid.equals("") && passwd.equals(""))){
			error ++;
			
		}
		
			
//		if(userid.equals("")){
//			error++;
//			hashmaps = new HashMap<String,Object>();
//			hashmaps.put("message","Invalid User");
//			hashmaps.put("field","userid");
//			hashmaps.put("valid",false);
//			ResponseList.add(hashmaps);	
//		}else{
//			hashmaps = new HashMap<String,Object>();
//			hashmaps.put("message","");
//			hashmaps.put("field","userid");
//			hashmaps.put("valid",true);
//			ResponseList.add(hashmaps);	
//		}
//		
//		if(passwd.equals("")){
//			error++;
//			hashmaps = new HashMap<String,Object>();
//			hashmaps.put("message","Invalid Password");
//			hashmaps.put("field","passwd");
//			hashmaps.put("valid",false);
//			ResponseList.add(hashmaps);	
//		}else{
//			hashmaps = new HashMap<String,Object>();
//			hashmaps.put("message","Invalid Password");
//			hashmaps.put("field","passwd");
//			hashmaps.put("valid",true);
//			ResponseList.add(hashmaps);	
//		}
		
		result.put("error_count", error );
//		result.put("response_list",ResponseList);
//		result.put("message",message);
		return result;
		
	}
	
	public HashMap createSessionProcess(HttpServletRequest request, HttpServletResponse response){
		UserBean userBean = new UserBean();
		UserDao ud = new UserDao();
		boolean status = false;
		String message = "";
		HashMap<String, Object> result = new HashMap<String,Object>();
		String userid = request.getParameter("userid").trim();
		String passwd = request.getParameter("passwd").trim();
		
		try {
			if(passwd.equals("") && userid.equals("") ){
				message = "User Id and Password is required";
			}else if( userid.equals("") ){
				message = "User Id is required";
			}else if(passwd.equals("")){
				message = "Password is required";
			}
			else{
				userBean = ud.getUser(userid, passwd);
				int loginStatus = userBean.getLoginStatus(); //0  success //1 wrong passwrod // 2 no account
				logger.debug(loginStatus);
				
				if(loginStatus == 0){
					HttpSession session = request.getSession(true);	    
					session.setMaxInactiveInterval(7200);
			        session.setAttribute("currentSessionUser",userBean);
			        status = true;
			        message = "Login Successful";
				}else if(loginStatus == 1){
					message = "Incorrect Password";
				}
				else{
					message = "User Id not found";
				}
			}
			
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
		result.put("status",status);
		result.put("message",message);
		
		return result;
	}
	
	

}
