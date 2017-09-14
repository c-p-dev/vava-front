<%@page contentType="text/html;charset=UTF-8"%>

<jsp:useBean id="bm" class="test.BetConManager_Test" />
	
<%
String mid="5";
String name = bm.getFromDB(mid);

%>

<%=name%>