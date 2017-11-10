<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
String sid="";
if(request.getParameter("sid") != null && request.getParameter("sid").trim().length() > 0){
   sid =request.getParameter("sid") ;
}
String mid="";
if(request.getParameter("mid") != null && request.getParameter("mid").trim().length() > 0){
   mid =request.getParameter("mid") ;
}
String tab="";
if(request.getParameter("tab") != null && request.getParameter("tab").trim().length() > 0){
   tab =request.getParameter("tab") ;
}
%>

<%@ include file="/inc/main_header.jsp" %>

<%@ include file="/inc/session.jsp" %>

<body id="myAnchor" ng-app="Vava" ng-controller="mc"> 

<a href="#myAnchor" class="go-top">▲</a>
<div id="wrap">
	
<%@ include file="/inc/header.jsp" %>

<div id="contents_wrap">
	<div class="game_contents">
		<table width="100%" valign="top" border="0" cellspacing="0" cellpadding="0">
			<tr>
				
				<td width="260" valign="top">
					<div class="game_left_wrap">
					
						<div ng-include="leftTab">								
						</div>
					
					</div>
				</td><!-- left -->				
				
				<td width="80%" style="padding:0 10px 0 10px;"  valign="top">

					<div ng-include="centerTab" onload="fmain()"></div>

				</td>

				<td width="260" class="game_right_wrap" valign="top">
					<div ng-include="rightTab">								
					</div>							
				</td>
				
			</tr>
		</table>
	</div>
</div><!-- contents -->


<input type="hidden" id="mid" value="<%=mid%>">
<input type="hidden" id="sid" value="<%=sid%>">
<input type="hidden" id="tab" value="<%=tab%>">

<%@ include file="/inc/footer.jsp" %>

</div><!-- wrap -->
</body>
</html>
