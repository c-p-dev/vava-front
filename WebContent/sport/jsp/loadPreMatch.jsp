<%@page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="bm" class="bc4.BetConManager2" />
<%
StringBuffer result = bm.getPreMatches();
%>
<%=result.toString()%>