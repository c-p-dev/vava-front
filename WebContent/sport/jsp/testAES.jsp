<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.util.*"%>
<%@page import="bean.*"%>
<%@page import="java.lang.Integer"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="com.google.gson.reflect.TypeToken"%>

<%@page import="bc4.AesUtil"%>

<jsp:useBean id="bm" class="bc4.BetConManager2" />
	
<%

int iterationCount = 1000;
int keySize = 128;

String salt = "dc0da04af8fee58593442bf834b30739";
String iv = "dc0da04af8fee58593442bf834b30739";
String passphrase = "vava!@#$";       

String msg = "encrtpy this message";

AesUtil aesUtil = new AesUtil(keySize, iterationCount);
String enctext = aesUtil.encrypt(salt, iv, passphrase, msg);
//response.setStatus(HttpServletResponse.SC_OK);
//response.getWriter().print(plaintext);
//   	out.print(msg); 
//   	out.print("<br>"); 	     
	 	out.print(enctext); 	 	
%>

