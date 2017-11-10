

<%@page contentType="text/html;charset=euc-kr"%>

<%@page import="java.util.*"%>
<%@page import="org.json.simple.JSONObject"%>

<% request.setCharacterEncoding("utf-8"); %>

<% response.setContentType("text/html; charset=utf-8"); %>

<html>

<head>

<title>JSP Example</title>

</head>

<body>

<p>

<% 

 String cmd = request.getParameter("Command");

 //String id = request.getParameter("id");

 

 HashMap<String,String> map = new HashMap<String,String>();

	map.put("Command",cmd);

	//map.put("id",id);


%>
	command :<%=cmd%><br>
  command :<%=map.get("Command")%><br>

<%




%>

</p>

</body>

</html>

