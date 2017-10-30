<%@ include file = "../process/session_checker.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" />
<%
	UserBean user_data	= (UserBean)session.getAttribute("currentSessionUser");
%>

<div id="contents_wrap">
	<div class="contents">
		<ul class="tabs">
			<li><a href="#tab1"  >내정보</a></li>
			<li><a href="#tab2"  class="dt-bet-div">베팅내역</a></li>
			<li><a href="#tab3" >1:1문의</a></li>
			<li><a href="#tab4" >쪽지함</a></li>
		</ul>
		<div class="tab_container">
			<div id="tab1" class="tab_content">
				<jsp:include page="profile.jsp" />
			</div>
			<div id="tab2" class="tab_content">
				<jsp:include page="betting_history.jsp" />
			</div>
			<div id="tab3" class="tab_content">
				<jsp:include page="contact.jsp" />
			</div>
			<div id="tab4" class="tab_content">
				<jsp:include page="qna.jsp" />
			</div>
		</div>
	</div>
</div><!-- contents -->
<script>
	$(document).ready(function(){
		setTabActive($.urlParam("tab"));
	});
</script>
<jsp:include page="../footer.jsp" />