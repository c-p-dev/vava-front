<%@page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="bm" class="net.vavasoft.bc4.BetConManager2" />
<%
String uid="";
if(request.getParameter("uid") != null && request.getParameter("uid").trim().length() > 0){
   uid =request.getParameter("uid") ;
}

String sid="1"; //site_id

%>
<%=bm.getFavMatch(sid,uid).toString()%>
