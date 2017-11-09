<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.util.*"%>
<%@page import="net.vavasoft.bean.*"%>
<%@page import="java.lang.Integer"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="com.google.gson.reflect.TypeToken"%>


<jsp:useBean id="bm" class="net.vavasoft.bc4.BetConManager2" />
	
<%
String mid="";
if(request.getParameter("mid") != null && request.getParameter("mid").trim().length() > 0){
   mid =request.getParameter("mid") ;
}

		List<SelectionBean> sb = bm.getSelectionList(mid);

		Gson gson = new Gson();
		Type type = new TypeToken<List<SelectionBean>>() {}.getType();
	 	String json = gson.toJson(sb, type);     
	 	out.print(json); 	
%>
