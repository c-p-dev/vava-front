<%@ page contentType="text/html; charset=euc-kr" %>

<%@ page import = "net.vavasoft.admin.*" %>

<jsp:useBean id="admin_info" class="net.vavasoft.admin.AdminInfoManager"/>

<%
String mid=request.getParameter("mid");
String mpass=request.getParameter("mpass");

AdminInfoBean aib = admin_info.checkUser(mid,mpass);

java.text.SimpleDateFormat ymd = new java.text.SimpleDateFormat("yy.MM.dd HH:mm");
    
if(aib.getResult()==1){                                     //°ü¸®ÀÚ
	
	//session.invalidate();
	
	session = request.getSession(false);
	session.setMaxInactiveInterval(7200);  //timeout = 7200 ms 
	
	session.putValue("MID",aib.getAid());
	session.putValue("MNAME",aib.getAname());
	session.putValue("TLOGIN",ymd.format(new java.util.Date()));
              
   response.sendRedirect("/e_money/transaction.jsp");
        
}else if(aib.getResult()==9){
%>


<!-- process wrong password  --> 

<%
}else if(aib.getResult()==-1){
%>

<!-- process not exist ID  --> 

<%
}else if(aib.getResult()==2){
%>

<!-- process suspended ID  --> 

<%
}else{
%>

<%
}
%>