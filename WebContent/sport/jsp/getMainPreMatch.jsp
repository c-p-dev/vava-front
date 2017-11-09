<%@page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="bm" class="net.vavasoft.bc4.BetConManager2" />
<%
String sid="";
if(request.getParameter("sid") != null && request.getParameter("sid").trim().length() > 0){
   sid =request.getParameter("sid") ;
}

String min="";
if(request.getParameter("min") != null && request.getParameter("min").trim().length() > 0){
   min =request.getParameter("min") ;
}

out.println(bm.getMainPreMatch(sid,min).toString());

%>
