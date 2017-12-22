<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%@ page import="java.util.*"%>
<%@ page import="bean.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import = "com.google.gson.Gson" %>

<jsp:useBean id="bm" class="bc4.BetConManager2" />
	

<%
	HttpSession sess = request.getSession(false);	
	
	String SITEID="1"; 
	String UID =null;
	int UBAL=0;
	int UPOINT=0;
	
	if((String) sess.getAttribute("UID") != null){				
	 	UID = (String)sess.getAttribute("UID");		
		UBAL = (Integer)sess.getAttribute("UBAL");
		UPOINT = (Integer)sess.getAttribute("UPOINT");
	}
	
	Gson gson = new Gson();
	HashMap<String, Object> hsm = new HashMap<String, Object>();

	UserBean ub = bm.getUserInfo(SITEID,UID);
	
	if(ub.getUserid().equals(UID) && (ub.getPoint()!=UPOINT||ub.getMoney()!=UBAL)){
		sess.putValue("UBAL",ub.getMoney());
		sess.putValue("UPOINT",ub.getPoint());		
		hsm.put("R",true);
		
	}else{
		hsm.put("R",false);
	}
		hsm.put("uid",UID);
	out.println(gson.toJson(hsm).toString());
%>

