<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="
	net.vavasoft.bean.UserBean,
	net.vavasoft.dao.UserDao,
	java.sql.SQLException,
	java.util.ArrayList,
	java.util.List,
	com.google.gson.reflect.TypeToken,
	com.google.gson.Gson,
	java.util.StringTokenizer;" %>
<%

	if(session.getAttribute("currentSessionUser") != null){
		UserBean bean = (UserBean) session.getAttribute("currentSessionUser");
	 	UserDao ud = new UserDao();
	 	Gson gson = new Gson();
	 	bean.setRegdate("20202020");
		boolean result = false;
		int points = Integer.parseInt(request.getParameter("point"));
		String xForwardedForHeader = request.getHeader("X-Forwarded-For");	 
	    if (xForwardedForHeader == null) {
	    	bean.setIp(request.getRemoteAddr());
	    }else{
	    	bean.setIp(new StringTokenizer(xForwardedForHeader, ",").nextToken().trim());  
	    }
	    
		
		UserBean user_data  = ud.getUserByUserId(bean.getUserid());
		user_data.getMoney();
		
		result = ud.switchpoints(bean,user_data.getMoney(),user_data.getPoint(),points);
		result = ud.userpoints(bean,user_data.getMoney(),user_data.getPoint(),points);	
		UserBean usermoney = ud.getUserByUserId(bean.getUserid());
		out.println(gson.toJson(usermoney, UserBean.class));
		
	}else{
		response.sendRedirect("index.jsp");
		return;
	}
	
%>