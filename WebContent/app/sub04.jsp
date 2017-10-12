<%@ include file = "../process/session_checker.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" />

<div id="contents_wrap">
	<div class="contents">
		<ul class="tabs">
			<li><a href="#tab1">충전신청</a></li>
			<li><a href="#tab2">환전신청</a></li>
			<li><a href="#tab3">포인트전환</a></li>
			<li><a href="#tab4">머니전환</a></li>
			<li><a href="#tab5" class="dt-point-tab">포인트 사용 내역</a></li>
			<li><a href="#tab6" class="dt-money-use">머니 사용 내역</a></li>
		</ul>
		<div class="tab_container">
			<div id="tab1" class="tab_content">
				<jsp:include page="charge_tab.jsp" /> 
			</div>
			<div id="tab2" class="tab_content">
				<jsp:include page="exchange_tab.jsp" />
			</div>
			<div id="tab3" class="tab_content">
				<jsp:include page="switch_points.jsp" />
			</div>
			<div id="tab4" class="tab_content">
				<ul class="smk_accordion">
					<li>
						<div class="accordion_title"><h3>머니전환</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
								<div class="blue_wrap">
									<div class="float_inline">
										<div class="cash_box">
											<div class="cash_in">
												<div class="cash_1"><p style="float:left">전환가능금액</p><p style="float:right"><span  class="font_002">10,000,000</span> 원</p></div>
											</div>
											<div class="cash_in">
												<div class="cash_4">
													<select class="input_style03">
														<option>이동전게임</option>
													</select>	
												</div>
												<div class="cash_4">
													<select class="input_style03">
														<option>이동후게임</option>
													</select>		
												</div>	
											</div>	
											<div class="cash_in">
												<div class="cash_8">
													<input class="input_style03" placeholder="전환금액">
												</div>
												<div class="cash_5">
													최소 이전 가능 금액은 1만원 입니다.
												</div>
											</div>
											<div class="cash_in">
												<a href="#"><span class="btn1">1만원</span></a> <a href="#"><span class="btn1">5만원</span></a> <a href="#"><span class="btn1">10만원</span></a> <a href="#"><span class="btn1">100만원</span></a> <a href="#"><span class="btn1">정정</span></a> <a href="#"><span class="btn3c">전환신청</span></a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</li>
				</ul>
			</div>
			<div id="tab5" class="tab_content">
				<jsp:include page="point_tab.jsp" /> 
			</div>
			<div id="tab6" class="tab_content">
				<jsp:include page="moneyuse_tab.jsp" /> 
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