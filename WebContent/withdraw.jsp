<!DOCTYPE html>
<html lang="ko">
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.vavasoft.bean.UserBean"%>
<jsp:useBean id="bm" class="test.BetConManager_Test2" />
<title>무제 문서</title>
<meta name="viewport" content="width=1400,minimum-scale=0,maximum-scale=5,target-densitydpi=device-dpi">
<script src="http://code.jquery.com/jquery-1.12.1.min.js"></script><!--공통-->
<script type="text/javascript" src="js/header.js" charset="utf-8"></script><!-- header -->
<script type="text/javascript" src="js/select.js" charset="utf-8"></script><!-- util_select -->
<script type="text/javascript" src="js/my_select.js"></script><!-- 내정보,스포츠,실시간,경기결과 select -->
<script type="text/javascript" src="js/visual_slider.js"></script><!-- VisualBanner, CasinoBanner -->
<script type="text/javascript" src="js/script.js"></script><!-- VisualBanner, CasinoBanner -->
<script type="text/javascript" src="js/multislider.js"></script><!-- contents_slider -->
<script type="text/javascript" src="js/tabulous.js"></script><!-- MainTab -->
<script type="text/javascript" src="js/accordion.js"></script><!-- sub_아코디언 -->
<script type="text/javascript" src="js/sub_tab.js"></script><!-- sub_tab -->
<script type="text/javascript" src="js/jquery-popover.js"></script><!-- point_popup -->
<script type="text/javascript" src="js/popup.js"></script><!-- popup -->
<script type="text/javascript" src="js/left_menu.js"></script><!-- left_menu -->
<script type="text/javascript" src="js/gallery.js"></script><!-- 갤러리게시판 view 팝업 -->
<script type="text/javascript" src="js/showid.js"></script><!-- 달력 -->
<script type="text/javascript" src="js/sports_acc.js"></script><!-- 스포츠아코디언, 베팅내역 아코디언 -->
<script type="text/javascript" src="js/vertical_tab.js"></script><!-- 세로탭 -->
<script type="text/javascript" src="js/over.js"></script><!-- 말풍선 -->
<script type="text/javascript" src="js/over_script.js"></script><!-- 말풍선 -->
<script type="text/javascript" src="js/table.js"></script><!-- main_table_slide -->
<script type="text/javascript" src="js/gateway.js"></script><!-- gateway -->
<script type="text/javascript" src="js/img_hover.js"></script><!-- casino_hover -->
<script type="text/javascript" src="js/text_slide.js"></script><!-- text_slide -->
<script type="text/javascript" src="js/switch.js"></script><!-- switch -->
<link href="css/common.css" rel="stylesheet" type="text/css"><!--공통-->
<link href="css/layout.css" rel="stylesheet" type="text/css"><!--공통-->
<link href="css/main.css" rel="stylesheet" type="text/css"><!-- main -->
<link href="css/sub.css" rel="stylesheet" type="text/css"><!-- sub -->
<link href="css/game.css" rel="stylesheet" type="text/css"><!-- game -->
<link href="css/gateway.css" rel="stylesheet" type="text/css"><!-- gateway -->
</head>


<body id="myAnchor">

<!-- top버튼 -->
<a href="#myAnchor" class="go-top">▲</a>
<script>
/*Add class when scroll down*/
$(window).scroll(function(event){
  	var scroll = $(window).scrollTop();
    if (scroll >= 50) {
        $(".go-top").addClass("show");
    } else {
        $(".go-top").removeClass("show");
    }
});
/*Animation anchor*/
$('a').click(function(){
    $('html, body').animate({
        scrollTop: $( $(this).attr('href') ).offset().top
    }, 1000);
});
</script>

<div id="wrap">
<div id="header_wrap">
	<div class="nav">
		<div class="util_wrap"></div>
        <ul class="util_left">
            <li><span class="util_time">00:00:00</span></li>
            <li>
                <select id="language" name="language">
                  <option value="0">한국어</option>
                  <option value="1">영어</option>
                  <option value="2">중국어</option>
                  <option value="3">일본어</option>
                </select> 
                <script type="text/javascript">
                    $(function(){
                        $('#language').selectlist({
                            zIndex: 10,
                            width: 95,
                            height: 34
                        });		
                    })
                </script>
            </li>
            <li><a href="sub02.html"><span class="util_btn">공지/이벤트</span></a></li>
            <li><a href="sub03.html"><span class="util_btn">도움말</span></a></li>
            <li><a href="sub06.html"><span class="util_btn">경기결과</span></a></li>
        </ul>
		<div class="top_wrap">
            <div class="top">
                <span class="logo"><a href="index.html"><img src="images/logo.png"></a></span>
                <ul class="top_right">
                    <li><input type="text" class="input_style01 input_blue" placeholder="ID"><a href="sub01.html"><img src="images/input_mark.png"></a></li><!-- input_blue 인풋활성화 -->
                    <li><input type="text" class="input_style01 input_red" placeholder="PW"><a href="sub01.html"><img src="images/input_mark.png"></a></li><!-- input_red 인풋조건미충족 -->
                    <li><a href="#"><span class="top_btn1">로그인</span></a></li>
                    <li><a href="#"><span class="top_btn2">회원가입</span></a></li>
                </ul>
            </div>
        </div>
        <div class="nav_wrap">
			<div class="stroke">
				<ul>
					<li><a href="bet01.html">실시간</a></li>
					<li><a href="bet02.html">스포츠</a></li>
					<li><a href="bet03.html">가상게임</a></li>
					<li><a href="bet04.html">카지노</a></li>
					<li><a href="bet05.html">경마</a></li>
				</ul>
			</div>
        </div>
	</div>
</div><!-- header_wrap -->


<div id="contents_wrap">
	<div class="contents">
		<ul class="tabs">
			<li><a href="#tab1">충전신청</a></li>
			<li><a href="#tab2">환전신청</a></li>
			<li><a href="#tab3">포인트전환</a></li>
			<li><a href="#tab4">머니전환</a></li>
			<li><a href="#tab5">포인트 사용 내역</a></li>
			<li><a href="#tab6">머니 사용 내역</a></li>
		</ul>
		<div class="tab_container">
			<div id="tab1" class="tab_content">
				<ul class="smk_accordion">
					<li>
						<div class="acc_head"><h3>충전신청</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
								<div class="blue_wrap">
									<div class="cash_box">
										<div class="cash_in">
											<div class="cash_1"><p style="float:left">보유금액</p><p style="float:right"><span  class="font_002">10,000,000</span> 원</p></div>
											<div class="cash_2">
												<input class="input_style03"  placeholder="비밀번호 입력 후 “전용계좌확인” 버튼을 클릭해주세요">
											</div>
											<div class="cash_3">
												<a href="#"><span class="btn5">전용계좌확인</span></a>
											</div>
										</div>
										<div class="cash_in">
											<div class="cash_4">
												<input class="input_style03"  placeholder="입금자명">		
											</div>
											<div class="cash_4">
												<input class="input_style03"  placeholder="충전금액">		
											</div>	
											<div class="cash_5">
												최소 충전 가능 금액은 1만원 입니다.
											</div>
										</div>
										<div class="cash_in">
											<a href="#"><span class="btn1">1만원</span></a> <a href="#"><span class="btn1">5만원</span></a> <a href="#"><span class="btn1">10만원</span></a> <a href="#"><span class="btn1">100만원</span></a> <a href="#"><span class="btn1">정정</span></a> <a href="#"><span class="btn3c">충전신청</span></a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</li>
					<li>
						<div class="acc_head"><h3>충전신청 리스트</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
								<table class="list_table" cellspacing="0" cellpadding="0" width="100%">
									<tr>
										<td class="list_table_t" width="10%">번호</td>
										<td class="list_table_t" width="40%">신청일시</td>
										<td class="list_table_t" width="25%">금액</td>
										<td class="list_table_t" width="25%">상태</td>
									</tr>
									<tr>
										<td class="list_table_center">123</td>
										<td class="list_table_center">2017-02-02</td>
										<td class="list_table_center"><span class="font_002">100,000</span>원</td>
										<td class="list_table_center font_009">신청</td>
									</tr>
									<tr>
										<td class="list_table_center">123</td>
										<td class="list_table_center">2017-02-02</td>
										<td class="list_table_center"><span class="font_002">100,000</span>원</td>
										<td class="list_table_center font_010">대기</td>
									</tr>
									<tr>
										<td class="list_table_center">123</td>
										<td class="list_table_center">2017-02-02</td>
										<td class="list_table_center"><span class="font_002">100,000</span>원</td>
										<td class="list_table_center">완료</td>
									</tr>
								</table>
								<div class="acc_btn_wrap"><a href="#"><div class="page"> >> </div></a> <a href="#"><span class="page"> > </span></a> <a href="#"><div class="page_on">1</div></a> <a href="#"><div class="page">2</div></a> <a href="#"><div class="page">3</div></a> <a href="#"><div class="page">4</div></a> <a href="#"><div class="page">5</div></a> <a href="#"><div class="page"> > </div></a> <a href="#"><div class="page"> >> </div></a></div>
							</div>			
						</div>
					</li>
					<li>
						<div class="acc_head"><h3>충전신청 관련 유의사항</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
								<ul class="cash_warning">
									<li>· 수표 입금 불가</li>
									<li>· 입금자명과 신청 금액이 입금 내용과 동일 해야 함 (상이 할 경우 환전 처리 불가)</li>
									<li>· 의도적인 부정 환전 신청이 중복 될 경우 즉시 회원 자격이 상실 됩니다.</li>
									<li>· 환전은 입금 후 5분 이내에 완료가 됩니다.</li>
									<li>· 단, 해당 은행의 평일 점검, 서버 점검, 전산 장애가 있을 경우 환전이 지연 되오니 양해바랍니다.</li>
								</ul>
								<div class="cash_bank">
									<span class="font_006">은행 점검 시간</span>	
									<table cellspacing="0" cellpadding="0" class="back_table">
										<tr>
											<td class="bank_name b_left">국민은행</td>
											<td class="bank_time">00 : 00 ~ 00 : 00</td>
											<td class="bank_name">우리은행</td>
											<td class="bank_time">00 : 00 ~ 00 : 00</td>
										</tr>
										<tr>
											<td class="bank_name b_left">국민은행</td>
											<td class="bank_time">00 : 00 ~ 00 : 00</td>
											<td class="bank_name">우리은행</td>
											<td class="bank_time">00 : 00 ~ 00 : 00</td>
										</tr>
										<tr>
											<td class="bank_name b_left">국민은행</td>
											<td class="bank_time">00 : 00 ~ 00 : 00</td>
											<td class="bank_name">우리은행</td>
											<td class="bank_time">00 : 00 ~ 00 : 00</td>
										</tr>
										<tr>
											<td class="bank_name b_left">국민은행</td>
											<td class="bank_time">00 : 00 ~ 00 : 00</td>
											<td class="bank_name">우리은행</td>	
											<td class="bank_time">00 : 00 ~ 00 : 00</td>
										</tr>
									</table>	
								</div>
							</div>
						</div>
					</li>
				</ul>
			</div>
			<div id="tab2" class="tab_content">
				<ul class="smk_accordion">
					<li>
					<%
						String mid="01";
						String money = bm.getFromDB(mid);
					%>
						<div class="acc_head"><h3>환전신청 </h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
							<form name="form1" id="form1" method="post">
								<div class="blue_wrap">
									<div class="cash_box">
										<div class="cash_in">
											<div class="cash_1"><p style="float:left">보유금액</p><p style="float:right"><span  class="font_002" id="money"><%=money%></span>원 </p></div>
										</div>
										<div class="cash_in">
											<div class="cash_4">
												<input class="input_style03"  placeholder="환전금액  MONEY!" id="withdraw" name="withdraw">		
											</div>	
											<div class="cash_5">
												<span id="err-msg"></span>
											</div>
										</div>
										<div class="cash_in">
											<input class="btn1" type="button" value = "10000원" id="button1"> 
	   	 									<input class="btn1" type="button" value = "50000원" id="button2"> 
	   	 									<input class="btn1" type="button" value = "100000원" id="button3"> 
	   	 									<input class="btn1" type="button" value = "1000000원" id="button4">
	   	 									<input class="btn1" type="button" value = "정정" id="button5">
											<span><button type="submit" class="btn3c">환전신청</button></span>
										</div>
									</div>
								</div>
								</form>
							</div>
						</div>
					</li>
					<li>
						<div class="acc_head"><h3>환전신청 리스트</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
								<table class="list_table" cellspacing="0" cellpadding="0" width="100%">
									<tr>
										<td class="list_table_t" width="10%">번호</td>
										<td class="list_table_t" width="40%">신청일시</td>
										<td class="list_table_t" width="25%">금액</td>
										<td class="list_table_t" width="25%">상태</td>
									</tr>
									<tr> 
										<td class="list_table_center">123</td>
										<td class="list_table_center">2017-02-02</td>
										<td class="list_table_center"><span class="font_002">100,000</span>원</td>
										<td class="list_table_center font_009">신청</td>
									</tr>
									<tr>
										<td class="list_table_center">123</td>
										<td class="list_table_center">2017-02-02</td>
										<td class="list_table_center"><span class="font_002">100,000</span>원</td>
										<td class="list_table_center font_010">대기</td>
									</tr>
									<tr>
										<td class="list_table_center">123</td>
										<td class="list_table_center">2017-02-02</td>
										<td class="list_table_center"><span class="font_002">100,000</span>원</td>
										<td class="list_table_center">완료</td>
									</tr>
								</table>
								<div class="acc_btn_wrap"><a href="#"><div class="page"> >> </div></a> <a href="#"><span class="page"> > </span></a> <a href="#"><div class="page_on">1</div></a> <a href="#"><div class="page">2</div></a> <a href="#"><div class="page">3</div></a> <a href="#"><div class="page">4</div></a> <a href="#"><div class="page">5</div></a> <a href="#"><div class="page"> > </div></a> <a href="#"><div class="page"> >> </div></a></div>
							</div>			
						</div>
					</li>
					<li>
						<div class="acc_head"><h3>환전신청 관련 유의사항</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
								<ul class="cash_warning">
									<li>· 수표 입금 불가</li>
									<li>· 입금자명과 신청 금액이 입금 내용과 동일 해야 함 (상이 할 경우 환전 처리 불가)</li>
									<li>· 의도적인 부정 환전 신청이 중복 될 경우 즉시 회원 자격이 상실 됩니다.</li>
									<li>· 환전은 입금 후 5분 이내에 완료가 됩니다.</li>
									<li>· 단, 해당 은행의 평일 점검, 서버 점검, 전산 장애가 있을 경우 환전이 지연 되오니 양해바랍니다.</li>
								</ul>
								<div class="cash_bank">
									<span class="font_006">은행 점검 시간</span>	
									<table cellspacing="0" cellpadding="0" class="back_table">
										<tr>
											<td class="bank_name b_left">국민은행</td>
											<td class="bank_time">00 : 00 ~ 00 : 00</td>
											<td class="bank_name">우리은행</td>
											<td class="bank_time">00 : 00 ~ 00 : 00</td>
										</tr>
										<tr>
											<td class="bank_name b_left">국민은행</td>
											<td class="bank_time">00 : 00 ~ 00 : 00</td>
											<td class="bank_name">우리은행</td>
											<td class="bank_time">00 : 00 ~ 00 : 00</td>
										</tr>
										<tr>
											<td class="bank_name b_left">국민은행</td>
											<td class="bank_time">00 : 00 ~ 00 : 00</td>
											<td class="bank_name">우리은행</td>
											<td class="bank_time">00 : 00 ~ 00 : 00</td>
										</tr>
										<tr>
											<td class="bank_name b_left">국민은행</td>
											<td class="bank_time">00 : 00 ~ 00 : 00</td>
											<td class="bank_name">우리은행</td>
											<td class="bank_time">00 : 00 ~ 00 : 00</td>
										</tr>
									</table>	
								</div>
							</div>
						</div>
					</li>
				</ul>	
			</div>
			<div id="tab3" class="tab_content">
				<ul class="smk_accordion">
					<li> 
						<div class="accordion_title"><h3>포인트전환</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
								<div class="blue_wrap">
									<div class="float_inline">
										<div class="point_box">
											<div class="cash_in">
												<div class="cash_1"><p style="float:left">보유포인트</p><p style="float:right" class="font_002">10,000,000</p></div>
											</div>
											<div class="cash_in">
												<div class="cash_6">
													<input class="input_style03"  placeholder="입금자명">		
												</div>
												<div class="cash_3">
													<a href="#"><span class="btn5">정정</span></a>	
												</div>	
												
											</div>
											<div class="cash_in">
												<div class="cash_7">
													 최소 전환 가능 포인트는 1,000 포인트입니다.
												</div>
											</div>
											<div class="cash_in">
												<a href="#"><span class="btn3c">전환신청</span></a>	
											</div>

										</div>
										<div class="point_banner">
											배너배너배너
										</div>
									</div>
								</div>
							</div>
						</div>
					</li>
				</ul>
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
				<ul class="smk_accordion">
					<li>
						<div class="accordion_title"><h3>포인트사용내역</h3></div>
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
												<td><input class="input_style04"  placeholder="기간" value="2017-00-00 ~ 2017-00-00"><a href="#" onClick="show_over(this);show_layer('depth1');"><img src="images/car_icon.jpg"></a>
													<div id="depth1" style="display:none; width:; position:absolute; z-index:100000000; left:530px;top:130px;">
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
																						<td><a href="#"><img src="images/arrow_left.png"></a></td>
																						<td height="30" align="center"><a href="#"><span class="font_style01">2017년 00월</span></a></td>
																						<td align="right"><a href="#"><img src="images/arrow_right.png"></a></td>
																					</tr>
																					<tr>
																						<td colspan="3"><img src="images/cale.jpg" width="100%"></td>
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
																						<td><a href="#"><img src="images/arrow_left.png"></a></td>
																						<td height="30" align="center"><a href="#"><span class="font_style01">2017년 00월</span></a></td>
																						<td align="right"><a href="#"><img src="images/arrow_right.png"></a></td>
																					</tr>
																					<tr>
																						<td colspan="3"><img src="images/cale.jpg" width="100%"></td>
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
														<div style="float:right; padding:7px 2px 7px 10px;"><a href="#" onClick="show_layer('depth1','hidden');"><img src="images/car_close.png"></a></div>
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
												<td class="list_table_t" width="25%">일시</td>
												<td class="list_table_t" width="15%">구분</td>
												<td class="list_table_t" width="20%">차감포인트</td>
												<td class="list_table_t" width="20%">가산포인트</td>
												<td class="list_table_t" width="20%">잔여포인트</td>
											</tr>
											<tr>
												<td class="list_table_center">2017-00-00 00:00:00</td>
												<td class="list_table_center">머니전환</td>
												<td class="list_table_center"><span class="font_008">-123,456,780</span>원</td>
												<td class="list_table_center"></td>
												<td class="list_table_center"><span class="font_002">123,456,780</span>원</td>
											</tr>
											<tr>
												<td class="list_table_center">2017-00-00 00:00:00</td>
												<td class="list_table_center">보너스</td>
												<td class="list_table_center"></td>
												<td class="list_table_center"><span class="font_004">123,456,780</span>원</td>
												<td class="list_table_center"><span class="font_002">123,456,780</span>원</td>
											</tr>
											<tr>
												<td class="list_table_center">2017-00-00 00:00:00</td>
												<td class="list_table_center">머니전환</td>
												<td class="list_table_center"><span class="font_008">-123,456,780</span>원</td>
												<td class="list_table_center"></td>
												<td class="list_table_center"><span class="font_002">123,456,780</span>원</td>
											</tr>
											<tr>
												<td class="list_table_center">2017-00-00 00:00:00</td>
												<td class="list_table_center">보너스</td>
												<td class="list_table_center"></td>
												<td class="list_table_center"><span class="font_004">123,456,780</span>원</td>
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
						<div class="accordion_title"><h3>포인트사용내역</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
									<p style="text-align:center">포인트사용내역이 없습니다.</p>
							</div>
						</div>
					</li>
				</ul>
			</div>
			<div id="tab6" class="tab_content">
				<ul class="smk_accordion">
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
												<td><input class="input_style04"  placeholder="기간" value="2017-00-00 ~ 2017-00-00"><a href="#" onClick="show_over(this);show_layer('depth2');"><img src="images/car_icon.jpg"></a>
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
																						<td align="left" height="30" ><a href="#"><img src="images/arrow_left.png"></a></td>
																						<td align="center">2017년 01월</td>
																						<td align="right"><a href="#"><img src="images/arrow_right.png"></a></td>
																					</tr>
																					<tr>
																						<td colspan="3"><img src="images/cale.jpg" width="100%"></td>
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
																						<td><a href="#"><img src="images/arrow_left.png"></a></td>
																						<td height="30" align="center"><a href="#"><span class="font_style01">2017년 00월</span></a></td>
																						<td align="right"><a href="#"><img src="images/arrow_right.png"></a></td>
																					</tr>
																					<tr>
																						<td colspan="3"><img src="images/cale.jpg" width="100%"></td>
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
														<div style="float:right; padding:7px 2px 7px 10px;"><a href="#" onClick="show_layer('depth2','hidden');"><img src="images/car_close.png"></a></div>
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
				</ul>
			</div>

		</div>


	</div>
</div><!-- contents -->

<div id="footer_wrap">
	<div class="f_site_map_wrap">
    	<div class="f_site_map">
			<div class="f_site_map_left_wrap">
				<div class="f_site_map_left">
					<div class="f_site_map_left_t">
						ABOUT
					</div>
					<ul class="f_site_map_left_list">
						<li><a href="#">베팅 규정</a></li>
						<li><a href="#">공지/이벤트</a></li>
						<li><a href="#">이용약관</a></li>
					</ul>
				</div>
				<div class="f_site_map_left">
					<div class="f_site_map_left_t">
						HELP
					</div>
					<ul class="f_site_map_left_list">
						<li><a href="#">베팅 가이드</a></li>
						<li><a href="#">게임 가이드</a></li>
						<li><a href="#">자주 묻는 질문</a></li>
					</ul>
				</div>
				<div class="f_site_map_left">
					<div class="f_site_map_left_t">
						GAMES
					</div>
					<ul class="f_site_map_left_list">
						<li><a href="#">스포츠북</a></li>
						<li><a href="#">가상게임</a></li>
						<li><a href="#">라이브 카지노</a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="f_site_partner_wrap">
			<div class="f_site_partner_t">
				PARTNER
			</div>
			<div class="f_site_partner">
				<ul>
					<li><img src="images/partner_1.jpg"></li>
					<li><img src="images/partner_2.jpg"></li>
					<li><img src="images/partner_3.jpg"></li>
					<li><img src="images/partner_4.jpg"></li>
				</ul>
				<ul>
					<li><img src="images/partner_1.jpg"></li>
					<li><img src="images/partner_2.jpg"></li>
					<li><img src="images/partner_3.jpg"></li>
					<li><img src="images/partner_4.jpg"></li>
				</ul>
			</div>
		</div>
	</div>
    <div class="f_copy_wrap">
		Gambling can be addictive. Play responsibly.           www.gamblingtherapy.org & www.gamblersanonymous.org<br>
		© 2017 IBET25.COM. ALL RIGHTS RESERVED. | +18  <br>
		<img src="images/f_logo.jpg" style="margin:20px 0 0 0">
	</div>
</div>

</div><!-- wrap -->
<script language="javascript">

	$('.acc_content').on('submit', '#form1', function(){
		console.log('aww');
		validateForm();
		return false;
	});
	
	function validateForm()
	{	
		var numbers = /^[0-9]+$/;
		var withdraw = document.form1.withdraw.value;
	    if(withdraw=="")
	    {
	    	$( "#err-msg" ).text( "Enter Money" ).show();
	    	event.preventDefault();
	      return false;
	    }
	    if(withdraw.match(numbers))
	    {
	    	
	    	if(withdraw <= 9999)
		    {
		    	$( "#err-msg" ).text( "Minimum exchangeable amount is 10,000 won" ).show();
		    	event.preventDefault();
		      return false;
		    }
	    	
	    	else {
	    	alert(withdraw);
	    	var withdraw = {withdraw : withdraw};
	    	submitForm(withdraw);
	      	return true;
	    	}
	    }
	    
	    else  
	      {  
	    	$( "#err-msg" ).text( "Numbers Only" ).show();
	    	event.preventDefault();
	      return false; 
	      }
	    
	}
	
function submitForm(withdraw){
	$.ajax({
		url : 'withdrawprocess.jsp',
		data : withdraw,
		method: 'POST',
	}).done(function(data){ 
		//var mmm = parseInt($('#money').text());
		//var newmmmm = mmm - parseInt($('#withdraw').val());
		//$('#money').text(newmmmm);
		//console.log(newmmmm)
	});
}
$('#button1').click(function(){
	 $("#withdraw").val("10000");
});
$('#button2').click(function(){
	$("#withdraw").val("50000");
});
$('#button3').click(function(){
	$("#withdraw").val("100000");
});
$('#button4').click(function(){
	$("#withdraw").val("1000000");
});
$('#button5').click(function(){
	$("#withdraw").val("0");
});
</script>   
</body>
</html>