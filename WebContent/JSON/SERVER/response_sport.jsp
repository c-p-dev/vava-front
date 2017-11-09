

<%@page contentType="text/html;charset=euc-kr"%>

<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.*" %>


<% request.setCharacterEncoding("utf-8"); %>

<% response.setContentType("text/html; charset=utf-8"); %>

<html>

<head>

<title>JSP Example</title>

</head>

<body>

<p>

<% 

 String number = request.getParameter("number");
 String id = request.getParameter("id");
 String comment = request.getParameter("comment");
String json ="";
 

/*
 HashMap<String,String> map = new HashMap<String,String>();

	map.put("number",number);

	map.put("id","asdfasdfasdfasdfasdfasd");

	map.put("comment",comment);
*/


	JSONObject jsonobj = new JSONObject();
	
		//PrintWriter pw = response.getWriter();
		//PrintWriter out = response.getWriter();
		
		 jsonobj.put("num", number);

		json = jsonobj.toJSONString(); 
		
		// finally output the json string       
    //out.print(json.toString());
    out.print(json);
    
		//return;
		
%>


</p>

</body>

</html>
