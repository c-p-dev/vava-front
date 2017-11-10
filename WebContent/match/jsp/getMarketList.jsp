<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.util.*"%>
<%@page import="bean.*"%>
<%@page import="java.lang.Integer"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="com.google.gson.reflect.TypeToken"%>


<jsp:useBean id="bm" class="bc4.BetConManager2" />
	
<%
String mid="";
if(request.getParameter("mid") != null && request.getParameter("mid").trim().length() > 0){
   mid =request.getParameter("mid") ;
}

		List<MarketListBean> mlb = bm.getMarketList(mid);

		Gson gson = new Gson();
		Type type = new TypeToken<List<MarketListBean>>() {}.getType();
	 	String json = gson.toJson(mlb, type);     
	 	out.print(json); 	
%>
