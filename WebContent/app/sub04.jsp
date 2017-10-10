<%@ include file = "../process/session_checker.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" />
<link href="/css/point_tab.css" rel="stylesheet" type="text/css"><!--공통-->

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
				<!-- <ul class="smk_accordion">
					<li>
						<div class="accordion_title"><h3>머니사용내역</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
								<div class="float_inline">
									<div class="my_search_wrap">
										<table cellspacing="0" cellpadding="0" class="my_search_select">
											<tr>
												<td>
													<select class="input_style02">
														<option>전체</option>
													</select>
												</td>
												<td>
													<select class="input_style02">
														<option>전체</option>
													</select>
												</td>
												<td><input class="input_style04"  placeholder="기간" value="2017-00-00 ~ 2017-00-00"><a href="#" onClick="show_over(this);show_layer('depth2');"><img src="/images/car_icon.jpg"></a>
													<div id="depth2" style="display:none; width:; position:absolute; z-index:100000000; left:530px;top:130px;">
														<table border="0" cellspacing="0" cellpadding="0" class="car_table">
															<tr>
																<td bgcolor="#303030" style="border-radius:3px; padding:5px; box-shadow: 10px 10px 20px -5px rgba(10, 10, 5, 5);">
																	<table width="100%" border="0" cellspacing="0" cellpadding="0">
																		<tr>
																			<td>
																				<ul class="car_period">
																					<li class="select">전체</li>
																					<li>최근24시간</li>
																					<li>최근3일</li>
																					<li>최근7일</li>
																				</ul>
																			</td>
																		</tr>
																	</table>
																	<table width="100%" border="0" cellspacing="10" cellpadding="0">
																		<tr>
																			<td>
																				<table width="100%" border="0" cellspacing="0" cellpadding="0">
																					<tr>
																						<td align="left" height="30" ><a href="#"><img src="/images/arrow_left.png"></a></td>
																						<td align="center">2017년 01월</td>
																						<td align="right"><a href="#"><img src="/images/arrow_right.png"></a></td>
																					</tr>
																					<tr>
																						<td colspan="3"><img src="/images/cale.jpg" width="100%"></td>
																					</tr>
																				</table>
																				<table border="0" cellpadding="0" cellspacing="1" bgcolor="#242424">
																					<tr>
																						<td><a href="#"><span class="cale_off">30</span></a></td>
																						<td><a href="#"><span class="cale_off">30</span></a></td>
																						<td><a href="#"><span class="cale">1</span></a></td>
																						<td><a href="#"><span class="cale">2</span></a></td>
																						<td><a href="#"><span class="cale_on">3</span></a></td>
																						<td><a href="#"><span class="cale">4</span></a></td>
																						<td><a href="#"><span class="cale">5</span></a></td>
																					</tr>
																					<tr>
																						<td><a href="#"><span class="cale">6</span></a></td>
																						<td><a href="#"><span class="cale">7</span></a></td>
																						<td><a href="#"><span class="cale">8</span></a></td>
																						<td><a href="#"><span class="cale">9</span></a></td>
																						<td><a href="#"><span class="cale">01</span></a></td>
																						<td><a href="#"><span class="cale">11</span></a></td>
																						<td><a href="#"><span class="cale">12</span></a></td>
																					</tr>
																					<tr>
																						<td><a href="#"><span class="cale">13</span></a></td>
																						<td><a href="#"><span class="cale">14</span></a></td>
																						<td><a href="#"><span class="cale">15</span></a></td>
																						<td><a href="#"><span class="cale">16</span></a></td>
																						<td><a href="#"><span class="cale">17</span></a></td>
																						<td><a href="#"><span class="cale">18</span></a></td>
																						<td><a href="#"><span class="cale">19</span></a></td>
																					</tr>
																					<tr>
																						<td><a href="#"><span class="cale">20</span></a></td>
																						<td><a href="#"><span class="cale">21</span></a></td>
																						<td><a href="#"><span class="cale">22</span></a></td>
																						<td><a href="#"><span class="cale">23</span></a></td>
																						<td><a href="#"><span class="cale">24</span></a></td>
																						<td><a href="#"><span class="cale">25</span></a></td>
																						<td><a href="#"><span class="cale">26</span></a></td>
																					</tr>
																					<tr>
																						<td><a href="#"><span class="cale">27</span></a></td>
																						<td><a href="#"><span class="cale">28</span></a></td>
																						<td><a href="#"><span class="cale">29</span></a></td>
																						<td><a href="#"><span class="cale">30</span></a></td>
																						<td><a href="#"><span class="cale_off">1</span></a></td>
																						<td><a href="#"><span class="cale_off">2</span></a></td>
																						<td><a href="#"><span class="cale_off">3</span></a></td>
																					</tr>
																				</table>
																			</td>
																			<td>
																				<table width="100%" border="0" cellspacing="0" cellpadding="0">
																					<tr>
																						<td><a href="#"><img src="/images/arrow_left.png"></a></td>
																						<td height="30" align="center"><a href="#"><span class="font_style01">2017년 00월</span></a></td>
																						<td align="right"><a href="#"><img src="/images/arrow_right.png"></a></td>
																					</tr>
																					<tr>
																						<td colspan="3"><img src="/images/cale.jpg" width="100%"></td>
																					</tr>
																				</table>
																				<table border="0" cellpadding="0" cellspacing="1" bgcolor="#242424">
																					<tr>
																						<td><a href="#"><span class="cale_off">30</span></a></td>
																						<td><a href="#"><span class="cale_off">30</span></a></td>
																						<td><a href="#"><span class="cale">1</span></a></td>
																						<td><a href="#"><span class="cale">2</span></a></td>
																						<td><a href="#"><span class="cale_on">3</span></a></td>
																						<td><a href="#"><span class="cale">4</span></a></td>
																						<td><a href="#"><span class="cale">5</span></a></td>
																					</tr>
																					<tr>
																						<td><a href="#"><span class="cale">6</span></a></td>
																						<td><a href="#"><span class="cale">7</span></a></td>
																						<td><a href="#"><span class="cale">8</span></a></td>
																						<td><a href="#"><span class="cale">9</span></a></td>
																						<td><a href="#"><span class="cale">01</span></a></td>
																						<td><a href="#"><span class="cale">11</span></a></td>
																						<td><a href="#"><span class="cale">12</span></a></td>
																					</tr>
																					<tr>
																						<td><a href="#"><span class="cale">13</span></a></td>
																						<td><a href="#"><span class="cale">14</span></a></td>
																						<td><a href="#"><span class="cale">15</span></a></td>
																						<td><a href="#"><span class="cale">16</span></a></td>
																						<td><a href="#"><span class="cale">17</span></a></td>
																						<td><a href="#"><span class="cale">18</span></a></td>
																						<td><a href="#"><span class="cale">19</span></a></td>
																					</tr>
																					<tr>
																						<td><a href="#"><span class="cale">20</span></a></td>
																						<td><a href="#"><span class="cale">21</span></a></td>
																						<td><a href="#"><span class="cale">22</span></a></td>
																						<td><a href="#"><span class="cale">23</span></a></td>
																						<td><a href="#"><span class="cale">24</span></a></td>
																						<td><a href="#"><span class="cale">25</span></a></td>
																						<td><a href="#"><span class="cale">26</span></a></td>
																					</tr>
																					<tr>
																						<td><a href="#"><span class="cale">27</span></a></td>
																						<td><a href="#"><span class="cale">28</span></a></td>
																						<td><a href="#"><span class="cale">29</span></a></td>
																						<td><a href="#"><span class="cale">30</span></a></td>
																						<td><a href="#"><span class="cale_off">1</span></a></td>
																						<td><a href="#"><span class="cale_off">2</span></a></td>
																						<td><a href="#"><span class="cale_off">3</span></a></td>
																					</tr>
																				</table>
																			</td>																			
																		</tr>
																	</table>
																</td>
															</tr>
														</table>
														<div style="float:right; padding:7px 2px 7px 10px;"><a href="#" onClick="show_layer('depth2','hidden');"><img src="/images/car_close.png"></a></div>
													</div>
												</td>
												<td>
													<a href="#"><span class="btn1">검색</span></a>
												</td>
											</tr>
										</table>
									</div>
									<div class="my_search_list">
										<table class="list_table" cellspacing="0" cellpadding="0" width="100%">
											<tr>
												<td class="list_table_t" width="18%">일시</td>
												<td class="list_table_t" width="15%">게임종류</td>
												<td class="list_table_t" width="13%">구분</td>
												<td class="list_table_t" width="18%">차감금액</td>
												<td class="list_table_t" width="18%">가산금액</td>
												<td class="list_table_t" width="18%">잔액</td>
											</tr>
											<tr>
												<td class="list_table_center">2017-00-00 00:00:00</td>
												<td class="list_table_center">실시간</td>
												<td class="list_table_center">머니전환</td>
												<td class="list_table_center"><span class="font_008">-123,456,780</span>원</td>
												<td class="list_table_center"></td>
												<td class="list_table_center"><span class="font_002">123,456,780</span>원</td>
											</tr>
											<tr>
												<td class="list_table_center">2017-00-00 00:00:00</td>
												<td class="list_table_center">실시간</td>
												<td class="list_table_center">머니전환</td>
												<td class="list_table_center"></td>
												<td class="list_table_center"><span class="font_004">123,456,780</span>원</td>
												<td class="list_table_center"><span class="font_002">123,456,780</span>원</td>
											</tr>
											<tr>
												<td class="list_table_center">2017-00-00 00:00:00</td>
												<td class="list_table_center">실시간</td>
												<td class="list_table_center">머니전환</td>
												<td class="list_table_center"><span class="font_008">-123,456,780</span>원</td>
												<td class="list_table_center"></td>
												<td class="list_table_center"><span class="font_002">123,456,780</span>원</td>
											</tr>
											<tr>
												<td class="list_table_center">2017-00-00 00:00:00</td>
												<td class="list_table_center">실시간</td>
												<td class="list_table_center">머니전환</td>
												<td class="list_table_center"></td>
												<td class="list_table_center"><span class="font_004">123,456,780</span>원</td>
												<td class="list_table_center"><span class="font_002">123,456,780</span>원</td>
											</tr>
											<tr>
												<td class="list_table_center">2017-00-00 00:00:00</td>
												<td class="list_table_center">실시간</td>
												<td class="list_table_center">머니전환</td>
												<td class="list_table_center"><span class="font_008">-123,456,780</span>원</td>
												<td class="list_table_center"></td>
												<td class="list_table_center"><span class="font_002">123,456,780</span>원</td>
											</tr>
										</table>
									</div>
									<div class="btn_wrap">
										<a href="#"><div class="page"> >> </div></a> <a href="#"><span class="page"> > </span></a> <a href="#"><div class="page_on">1</div></a> <a href="#"><div class="page">2</div></a> <a href="#"><div class="page">3</div></a> <a href="#"><div class="page">4</div></a> <a href="#"><div class="page">5</div></a> <a href="#"><div class="page"> > </div></a> <a href="#"><div class="page"> >> </div></a>
									</div>
								</div>
							</div>
						</div>
					</li>
					<li>
						<div class="accordion_title"><h3>머니사용내역</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
									<p style="text-align:center">머니 사용 내역이 없습니다.</p>
							</div>
						</div>
					</li>
				</ul> -->
				<jsp:include page="moneyuse_tab.jsp" /> 
			</div>

		</div>


	</div>
</div><!-- contents -->
<jsp:include page="../footer.jsp" />