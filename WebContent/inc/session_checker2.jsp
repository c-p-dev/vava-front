<%
	if(checkSession){
		//System.out.println("not logged in");
		response.sendRedirect("/index.jsp"); 
		return;
	}
%>	