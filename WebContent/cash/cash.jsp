<%@ include file="/inc/session.jsp"%>
<%@ include file="/inc/session_checker.jsp"%>
<%@ include file="/inc/main_header.jsp"%>
<%@ include file="/inc/header.jsp"%>

<div id="contents_wrap" class="cash_tab">
	<div class="contents">
		<ul class="tabs">
			<li><a href="#tab1">충전신청</a></li>
			<li><a href="#tab2">환전신청</a></li>
			<li><a href="#tab3">포인트전환</a></li>
			<!-- <li><a href="#tab4">머니전환</a></li> -->
			<li><a href="#tab5" class="dt-point-tab">포인트 사용 내역</a></li>
			<li><a href="#tab6" class="dt-money-use">머니 사용 내역</a></li>
		</ul>
		<div class="tab_container">
			<div id="tab1" class="tab_content">
				<jsp:include page="/cash/charge_tab.jsp" /> 
			</div>
			<div id="tab2" class="tab_content">
				<jsp:include page="/cash/exchange_tab.jsp" />
			</div>
			<div id="tab3" class="tab_content">
				<jsp:include page="/cash/switch_points.jsp" />
			</div>
			<div id="tab5" class="tab_content">
				<jsp:include page="/cash/point_tab.jsp" /> 
			</div>
			<div id="tab6" class="tab_content">
				<jsp:include page="/cash/moneyuse_tab.jsp" /> 
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