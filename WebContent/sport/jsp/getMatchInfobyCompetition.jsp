<%@page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="bm" class="bc4.BetConManager2" />
<%
String cid="";
if(request.getParameter("cid") != null && request.getParameter("cid").trim().length() > 0){
   cid =request.getParameter("cid") ;
}
%>
<%=bm.getMatchInfobyCompetition(cid)%>