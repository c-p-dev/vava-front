<%@page contentType="text/html;charset=UTF-8"%>

<%@page import="java.util.*"%>
<%@page import="net.vavasoft.bean.*"%>
<%@page import="java.lang.Integer"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="com.google.gson.reflect.TypeToken"%>

<jsp:useBean id="bm" class="net.vavasoft.bc4.BetConManager2" />

<%   
out.print(bm.getMainPreMatch("0","0").toString());
%>


