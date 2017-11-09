<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.util.*"%>
<%@page import="net.vavasoft.bean.*"%>
<%@page import="java.lang.Integer"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="com.google.gson.reflect.TypeToken"%>


<jsp:useBean id="bm" class="net.vavasoft.bc4.BetConManager2" />
	
<%
String bid="";

if(request.getParameter("bid") != null && request.getParameter("bid").trim().length() > 0){
   bid =request.getParameter("bid") ;
}

		List<BetSelList> bs = bm.getBetDetail(bid);

		Gson gson = new Gson();
		Type type = new TypeToken<List<BetSelList>>() {}.getType();
	 	String json = gson.toJson(bs, type);     
	 	out.print(json); 	
%>
