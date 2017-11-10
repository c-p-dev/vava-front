

<%@page contentType="text/html;charset=euc-kr"%>

<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.*" %>
<%@ page import="com.google.gson.*"%>

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
 String json ="";
 

/*
 HashMap<String,String> map = new HashMap<String,String>();

	map.put("Command",cmd);

	//map.put("id","asdfasdfasdfasdfasdfasd");

	//map.put("comment",comment);
*/


	JSONObject jsonobj = new JSONObject();
	
		 jsonobj.put("Command", cmd);

		json = jsonobj.toJSONString(); 
		
		// finally output the json string       
    //out.print(json.toString());
    out.print(json);
    
		//return;

		
%>
	command :<%=cmd%><br>
	
</p>

</body>

</html>
