<%@page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@page import="controller.*, java.util.HashMap"%>
<%@page import="java.lang.reflect.InvocationTargetException, java.lang.reflect.Method, java.io.BufferedReader"%>

<%
	
	HttpSession user_session 		= request.getSession();
	String json_output				= "";
	String method_param				= request.getParameter("method");
	TotalEgameController teg_obj 	= new TotalEgameController();

	if (("getSpinBySpinData".equals(method_param))
	|| ("getPlayersUpdatedBalance".equals(method_param))
	|| ("getBettingProfileList".equals(method_param))) {
		Method method_noparam		= teg_obj.getClass().getDeclaredMethod(method_param);
		out.println(method_noparam.invoke(teg_obj));
	}
	else if (("addPlayerAccount".equals(method_param))
	|| ("getAccountDetails".equals(method_param))
	|| ("deposit".equals(method_param))
	|| ("withdraw".equals(method_param))) {		
		Method method_strparam		= teg_obj.getClass().getDeclaredMethod(method_param, String.class);
		BufferedReader reader		= request.getReader();
		out.println(method_strparam.invoke(teg_obj, reader.readLine()));
	}
	else if (("getPlayerFundsInPlayDetails".equals(method_param))
	|| ("userPlayCheck".equals(method_param))) {
		Method method_strparam		= teg_obj.getClass().getDeclaredMethod(method_param, String.class);
		out.println(method_strparam.invoke(teg_obj, user_session.getAttribute("vava_username")));
	}
	else {
		out.println("METHOD NOT AVAILABLE");
	}
%>