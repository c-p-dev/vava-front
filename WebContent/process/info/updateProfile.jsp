<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="
	net.vavasoft.bean.UserBean,
	net.vavasoft.dao.UserDao,
	java.sql.SQLException,
	java.util.ArrayList,
	java.util.List,
	com.google.gson.reflect.TypeToken,
	java.util.StringTokenizer;" %>
<%

	
	

	if(session.getAttribute("currentSessionUser") != null){
		UserBean bean = (UserBean) session.getAttribute("currentSessionUser");
	 	UserDao ud = new UserDao();
	 	String bank_name = request.getParameter("bank_name").trim();
		String bank_num = request.getParameter("bank_num").trim();
		String bank_owner = request.getParameter("bank_owner").trim();
		String cell = request.getParameter("cell").trim();
		String cell_prefix = request.getParameter("cell_prefix").trim();

		boolean result = false;

		result = ud.updateUserProfile(bean.getUserid(), bank_name, bank_owner,bank_num, cell_prefix+cell);
		if(result){
			//override session here
			HttpSession user_session = request.getSession(true);	    
			session.setMaxInactiveInterval(7200);
	        session.setAttribute("currentSessionUser",ud.getUserInfoByUserid(bean.getUserid()));
		}

		out.println(result);

	}
	// else{
	// 	response.sendRedirect("index.jsp");
	// 	return;
	// }
		
	

	//out.println(response_code);
%>
