<%@page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="bm" class="bc4.BetConManager2" />
<%
String mid="";
if(request.getParameter("mid") != null && request.getParameter("mid").trim().length() > 0){
   mid =request.getParameter("mid") ;
}

String flag="";
if(request.getParameter("f") != null && request.getParameter("f").trim().length() > 0){
   flag =request.getParameter("f") ;
}

String sid="1"; //site_id
String uid="testuser";

//StringBuffer result = bc4.setFavMatch(sid,uid,mid,flag);
%>
<%=bm.setFavMatch(sid,uid,mid,flag).toString()%>
