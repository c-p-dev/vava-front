
<%@page contentType="text/html;charset=euc-kr"%>

<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.*" %>

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

<!DOCTYPE html>
<html>
	
<%

	//String snum = request.getParameter("num");
	
	String snum = "2";
	
	String result = "";
String json ="";

	JSONObject jsonobj = new JSONObject();
	
	//out.println(jsonobj);
	
	if (snum == null) {
		snum = "0";
	} else {
		int num = Integer.parseInt(snum);

		if (num % 2 == 0) {
			result = "\"¦��\"";
			
		} else {
			result = "\"Ȧ��\"";
		}

		PrintWriter pw = response.getWriter();
		
		out.println(pw);

		 jsonobj.put("num", result);

		json = jsonobj.toJSONString(); 

		//json = "{\"num\" :" + num + ",\"msg\" :" + result + "}";

		//out.print(json);

		return;

		// out.close();

	}

%>
<%="snum : " + snum%><br>
<%="json : " + json%><br>
<%="result : " + result %>



