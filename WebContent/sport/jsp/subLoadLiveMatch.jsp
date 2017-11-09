<%@page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="bm" class="net.vavasoft.bc4.BetConManager2" />
<%
String mid="";
if(request.getParameter("mid") != null && request.getParameter("mid").trim().length() > 0){
   mid =request.getParameter("mid") ;
}
%>
	<%=bm.subLoadLiveMatch(mid).toString()%>