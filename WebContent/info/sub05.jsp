<%@ include file="/inc/main_header.jsp"%>
<%@ include file="/inc/session.jsp"%>
<%@ include file="/inc/header.jsp"%>
<div id="contents_wrap">
	<div class="contents">
		<ul class="tabs">
			<li><a href="#tab1"  >내정보</a></li>
			<li><a href="#tab2"  class="dt-bet-div">베팅내역</a></li>
			<li><a href="#tab3" >1:1문의</a></li>
			<li class="dt-qna-tab"><a href="#tab4" class="dt-qna-tab" >쪽지함</a></li>
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
		// setTabActive($.urlParam("tab"));

		var tab = '<%=session.getAttribute("tb")%>';
		if(tab != ""){
			$("ul.tabs li a[href='#"+tab+"']").click();
		}
	});
</script>
<%@ include file="/inc/footer.jsp"%>
</body>
</html>