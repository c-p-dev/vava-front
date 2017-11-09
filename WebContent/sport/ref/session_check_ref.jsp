<%@ page import="java.util.*"%>
<%@ page import="net.vavasoft.util.*"%>


<%!
String MID;
String MNAME;
String TLOGIN;
String MLEVEL;

int today_yyyy;
int today_mm;
int today_dd;

String SID;
%>

<%
boolean ISLOGIN = false;

session = request.getSession(false);
	
if ((String)session.getAttribute("MID") != null && !((String)session.getAttribute("MID")).equals("") ) {
	
	ISLOGIN = true;
	MID = (String)session.getAttribute("MID");
	MNAME = (String)session.getAttribute("MNAME");
	TLOGIN = (String)session.getAttribute("TLOGIN");
	MLEVEL = (String)session.getAttribute("MLEVEL");
	 
}else{

	response.sendRedirect("/index.jsp");

}
%>


