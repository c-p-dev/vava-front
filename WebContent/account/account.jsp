<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/inc/session.jsp"%>
<%@ include file="/inc/session_checker2.jsp"%>




<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>iBET25(TEST WEB)</title>

<meta name="viewport" content="width=1400,minimum-scale=0,maximum-scale=5,target-densitydpi=device-dpi">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">		
<link href="/images/favicon.ico" rel="icon">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.1.min.js"></script>
<script type="text/javascript" src="/js/header.js" charset="utf-8"></script><!-- header -->
<script type="text/javascript" src="/js/select.js" charset="utf-8"></script><!-- util_select -->
<script type="text/javascript" src="/js/my_select.js"></script>
<script type="text/javascript" src="/js/visual_slider.js"></script><!-- VisualBanner, CasinoBanner -->
<script type="text/javascript" src="/js/script.js"></script><!-- VisualBanner, CasinoBanner -->
<script type="text/javascript" src="/js/multislider.js"></script><!-- contents_slider -->
<script type="text/javascript" src="/js/tabulous.js"></script><!-- MainTab -->
<script type="text/javascript" src="/js/sub_tab.js"></script><!-- sub_tab -->
<script type="text/javascript" src="/js/jquery-popover.js"></script><!-- point_popup -->
<script type="text/javascript" src="/js/popup.js"></script><!-- popup -->
<script type="text/javascript" src="/js/left_menu.js"></script><!-- left_menu -->
<script type="text/javascript" src="/js/gallery.js"></script>
<script type="text/javascript" src="/js/showid.js"></script>
<script type="text/javascript" src="/js/vertical_tab.js"></script>
<script type="text/javascript" src="/js/over.js"></script>
<script type="text/javascript" src="/js/over_script.js"></script>
<script type="text/javascript" src="/js/table.js"></script><!-- main_table_slide -->
<script type="text/javascript" src="/js/gateway.js"></script><!-- gateway -->
<script type="text/javascript" src="/js/img_hover.js"></script><!-- casino_hover -->
<script type="text/javascript" src="/js/text_slide.js"></script><!-- text_slide -->
<script type="text/javascript" src="/js/switch.js"></script><!-- switch -->
<script type="text/javascript" src="/js/sports_acc.js"></script><!-- 스포츠아코디언, 베팅내역 아코디언-->
<script type="text/javascript" src="/js/fade.js"></script><!-- switch -->
<script type="text/javascript" src="/js/jquery.serializejson.js"></script><!-- json serializer -->
<script type="text/javascript" src="/js/accordion.js"></script><!-- sub_아코디언 -->
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript" src="/js/jquery.validate.js"></script> 
<script type="text/javascript" src="/js/jquery.nice-select.js"></script><!-- select -->
<script type="text/javascript" src="/js/jqueryRemote.js"></script> 
<script type="text/javascript" src="/js/additional-methods.js"></script>

<script src="//cdnjs.cloudflare.com/ajax/libs/list.js/1.5.0/list.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/list.pagination.js/0.1.1/list.pagination.min.js"></script>
<script type="text/javascript" src="/js/datatables/jquery.dataTables.js"></script><!-- datatable -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.js"></script><!-- custom scrollbar -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/qtip2/3.0.3/jquery.qtip.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.js"></script><!-- moment js -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pikaday/1.6.1/pikaday.js"></script><!-- pickaday -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.js"></script>


<link href="/css/common.css" rel="stylesheet" type="text/css">
<link href="/css/layout.css" rel="stylesheet" type="text/css">
<link href="/css/main.css" rel="stylesheet" type="text/css"><!-- main -->
<link href="/css/sub.css" rel="stylesheet" type="text/css"><!-- sub -->
<link href="/css/game.css" rel="stylesheet" type="text/css"><!-- game -->
<link href="/css/gateway.css" rel="stylesheet" type="text/css"><!-- gateway -->
<link href="/css/customize.css" rel="stylesheet" type="text/css">
<link href="/css/font-awesome.css" rel="stylesheet" type="text/css">
<link href="/css/spin.css" rel="stylesheet" type="text/css">
<link href="/css/nice-select.css" rel="stylesheet" type="text/css"><!-- select -->
<link href="/css/common2.css" rel="stylesheet" type="text/css">
<link href="/css/manual.css" rel="stylesheet" type="text/css"><!--slide-->
<link href="/css/custom.css" rel="stylesheet" type="text/css"><!--공통-->

<link rel="stylesheet" href="/css/datatables.net-bs/css/bootstrap-simple.css" /> 
<link rel="stylesheet" href="/css/datatables.net-bs/css/dataTables.bootstrap.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.css" rel="stylesheet" type="text/css"><!-- toaster test  -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/qtip2/3.0.3/jquery.qtip.css" /><!-- tooltip -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/pikaday/1.6.1/css/pikaday.css" rel="stylesheet" type="text/css">
<!-- custom scrollbar test -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css" />

<script type="text/javascript" src="/js/angular.js"></script> 
<script type="text/javascript" src="/js/angular-animate.min.js"></script> 
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/angular-filter/0.5.16/angular-filter.js"></script>    
<script type="text/javascript" src="/js/v-accordion.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.28//angular-route.min.js"></script>
<link href="/css/v-accordion.css" rel="stylesheet" type="text/css">

<style>
	#pwmodal .pop_text{
		padding:0px!important;
	}
	.hidden_cntdwn{
		padding-top: 8px;
    	padding-bottom: 8px;
    	display: none;
	}

	form div.acc_btn_wrap{
		width: 30%;
	}

	.accnt_pg .popup_table01{
		width: 30%;
	}
</style>


</head>
<body>
	
	<%@ include file="/inc/header.jsp"%>
	
<div id="contents_wrap" class="accnt_pg">
	<div class="contents">
		<ul class="tabs">
			<li><a href="#tab1">아이디 찾기</a></li>
			<li><a href="#tab2">비밀번호 찾기</a></li>
		</ul>
		<div class="tab_container">
			<div id="tab1" class="tab_content">
				<ul class="smk_accordion">
					<li>
						<div class="acc_head"><h3>회원가입시 등록한 휴대폰 번호로 찾기</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2  " id="acc_content_in_1_fid1">
								<div class="blue_wrap">
									<div class="my_box">
										<form id="fid1">
											<input type="hidden" name="method" value="by_phone">
											<table cellpadding="0" cellspacing="0" class="popup_table01">
												<tr>
													<td><input class="input_style02" id="fid1nk" name="nk" placeholder="예금주"></td>
												</tr>
												<tr>
													<td>
														<table  width="100%" cellpadding="0" cellspacing="0" class="login_table_in">
															<tr>
																<td width="112" style="padding:0 10px 0 0">
																	<select class="input_style02" id="fid1cp" name="cp">
																		<option value="+82">+82(한국)</option>
																		<option value="+63">+63(필리핀)</option>
																	</select>
																</td>
																<td width="158" style="padding:0 10px 0 0">
																	<input class="input_style02" id="fidcll" name="cll" placeholder="휴대폰 번호">
																</td>
																<td>
																	<button id="fSndBtn" class="btn5">인증</button>
																</td>
															</tr>
															<tr>
																<td colspan="3">
																	<div id="f1cdt" class="hidden_cntdwn"></div>
																</td>
															</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td>
														<table  width="100%" cellpadding="0" cellspacing="0" class="login_table_in">
															<tr>
																<td width="280" style="padding:0 0px 0 0">
																	<input class="input_style02" id="findIdCert" name="ac" maxlength="6" placeholder="인증번호">
																</td>
															</tr>
															<tr>
																<td ><div class="input_warning" id="ac-fid1-warn">인증이 완료되었습니다.</div></td>
															</tr>
														</table>
													</td>
												</tr>
											</table>
											<div class="acc_btn_wrap">
												<input type="submit" class="btn3c" value="아이디 확인">
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</li>
					<li>
						<div class="acc_head"><h3>회원가입시 등록한 계좌 정보로 찾기</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2" id="acc_content_in_1_fid2">
								<div class="blue_wrap">
									<div class="my_box">
										<form id="fid2">
											<input type="hidden" name="method" value="by_bank">
											<table cellpadding="0" cellspacing="0" class="popup_table01">
												<tr>
													<td><input class="input_style02" id="findIdBank_owner" name="bo" placeholder="예금주"></td>
												</tr>
												<tr>
													<td>
														<table  width="100%" cellpadding="0" cellspacing="0" class="login_table_in">
															<tr>
																<td width="112" style="padding:0 10px 0 0">
																	<select class="input_style02"  id="findIdBank_name" name="bn" placeholder="은행명">
																		<option value="국민은행" selected>국민은행</option>
																	    <option value="기업은행">기업은행</option>
																	    <option value="경남은행">경남은행</option>
																	    <option value="광주은행">광주은행</option>
																	    <option value="동부증권">동부증권</option>
																	    <option value="대구은행">대구은행</option>
																	    <option value="부산은행">부산은행</option>
																	    <option value="산업은행">산업은행</option>
																	    <option value="삼성증권">삼성증권</option>
																	    <option value="삼성증권">신영증권</option>
																	    <option value="신한은행">신한은행</option>
																	    <option value="우리은행">우리은행</option>
																	    <option value="외환은행">외환은행</option>
																	    <option value="저축은행">저축은행</option>
																	    <option value="전북은행">전북은행</option>
																	    <option value="제주은행">제주은행</option>
																	    <option value="하나은행">하나은행</option>
																	    <option value="CITI은행">CITI은행</option>
																	    <option value="HSBC은행">HSBC은행</option>
																	    <option value="SC제일">SC제일</option>
																	    <option value="새마을금고">새마을금고</option>
																	    <option value="우체국">우체국</option>
																	    <option value="농협중앙회">농협중앙회</option>
																	    <option value="단위농협">단위농협</option>
																	    <option value="신협">신협</option>
																	    <option value="수협">수협</option>
																	    <option value="동양증권">동양증권</option>
																	    <option value="유진투자증권">유진투자증권</option>
																	    <option value="한국투자은행">한국투자은행</option>
																	    <option value="HMC투자증권">HMC투자증권</option>
																	    <option value="IBK투자증권">IBK투자증권</option>
																	    <option value="카카오뱅크">카카오뱅크</option>
																	</select>
																</td>
																<td width="158" style="padding:0 0px 0 0"><input class="input_style02" name="bnn"  placeholder="계좌번호"></td>
																
															</tr>	
														</table>
													</td>
												</tr>
												<tr>
													<td>
														<table  width="100%" cellpadding="0" cellspacing="0" class="login_table_in">
															<tr>
																<td width="112" style="padding:0 10px 0 0">
																	<select class="input_style02" id="fid1cp2" name="cp">
																		<option value="+82">+82(한국)</option>
																		<option value="+63">+63(필리핀)</option>
																	</select>
																</td>
																<td width="158" style="padding:0 0px 0 0">
																	<input class="input_style02" id="fidcll2" name="cll" placeholder="휴대폰 번호">
																</td>
															</tr>
														</table>
													</td>
												</tr>
											</table>
											<div class="acc_btn_wrap">
												<input type="submit" value="아이디 문의" class="btn3c">
											</div>
										</form>
									</div>
								</div>
								
							</div>
						</div>
					</li>
				</ul>
			</div>
			<div id="tab2" class="tab_content">
				<ul class="smk_accordion">
					<li>
						<div class="acc_head"><h3>회원가입시 등록한 휴대폰 번호로 찾기</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2" id="acc_content_in_fp1">
								<div class="blue_wrap">
									<div class="my_box">
										<form id="fp1">
											<input type="hidden" name="method" value="by_phone">
											<table cellpadding="0" cellspacing="0" class="popup_table01">
												<tr>
													<td><input class="input_style02" id="fp1ud" name="ud"  placeholder="아이디"></td>
												</tr>
												<tr>
													<td><input class="input_style02" id="fp1nk" name="nk"  placeholder="예금주"></td>
												</tr>
												<tr>
													<td>
														<table  width="100%" cellpadding="0" cellspacing="0" class="login_table_in">
															<tr>
																<td width="112" style="padding:0 10px 0 0">
																	<select class="input_style02"  id="fp1cp" name="cp">
																		<option value="+82">+82(한국)</option>
																		<option value="+63">+63(필리핀)</option>
																	</select>
																</td>
																<td width="158" style="padding:0 10px 0 0"><input class="input_style02" id="fp1cll" name="cll" maxlength="15" placeholder="휴대폰 번호"></td>
																<td>
																	<button class="btn5" id="fSndBtn2">인증</button>
																</td>
															</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td>
														<div id="fcdt" class="hidden_cntdwn"></div>
													</td>
												</tr>
												<tr>
													<td>
														<table  width="100%" cellpadding="0" cellspacing="0" class="login_table_in">
															<tr>
																<td width="280" style="padding:0 0px 0 0"><input class="input_style02" id="fp1ac" name="ac" maxlength="6" placeholder="인증번호"></td>
															</tr>
														</table>
													</td>
												</tr>

											</table>
											<div class="acc_btn_wrap">
												<input type="submit" class="btn3c" value="비밀번호 설정">
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</li>
					<li>
						<div class="acc_head"><h3>회원가입시 등록한 계좌 정보로 찾기</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2" id ="acc_content_in_fp3">
								<div class="blue_wrap">
									<div class="my_box">
										<form id="fp3">
											<input type="hidden" name="method" value="by_bank">
											<table cellpadding="0" cellspacing="0" class="popup_table01">
												<tr>
													<td><input class="input_style02"  id="fp3bo" name="bo"  placeholder="예금주"></td>
												</tr>
												<tr>
													<td><div class="input_warning" id="bo-fp3-warn">- 를 제외하고 입력해주세요</div></td>
												</tr>
												<tr>
													<td>
														<table  width="100%" cellpadding="0" cellspacing="0" class="login_table_in">
															<tr>
																<td width="112" style="padding:0 10px 0 0">
																	<select class="input_style02"  id="fp3bn" name="bn"  placeholder="은행명">
																		<option value="국민은행" selected>국민은행</option>
																	    <option value="기업은행">기업은행</option>
																	    <option value="경남은행">경남은행</option>
																	    <option value="광주은행">광주은행</option>
																	    <option value="동부증권">동부증권</option>
																	    <option value="대구은행">대구은행</option>
																	    <option value="부산은행">부산은행</option>
																	    <option value="산업은행">산업은행</option>
																	    <option value="삼성증권">삼성증권</option>
																	    <option value="삼성증권">신영증권</option>
																	    <option value="신한은행">신한은행</option>
																	    <option value="우리은행">우리은행</option>
																	    <option value="외환은행">외환은행</option>
																	    <option value="저축은행">저축은행</option>
																	    <option value="전북은행">전북은행</option>
																	    <option value="제주은행">제주은행</option>
																	    <option value="하나은행">하나은행</option>
																	    <option value="CITI은행">CITI은행</option>
																	    <option value="HSBC은행">HSBC은행</option>
																	    <option value="SC제일">SC제일</option>
																	    <option value="새마을금고">새마을금고</option>
																	    <option value="우체국">우체국</option>
																	    <option value="농협중앙회">농협중앙회</option>
																	    <option value="단위농협">단위농협</option>
																	    <option value="신협">신협</option>
																	    <option value="수협">수협</option>
																	    <option value="동양증권">동양증권</option>
																	    <option value="유진투자증권">유진투자증권</option>
																	    <option value="한국투자은행">한국투자은행</option>
																	    <option value="HMC투자증권">HMC투자증권</option>
																	    <option value="IBK투자증권">IBK투자증권</option>
																	    <option value="카카오뱅크">카카오뱅크</option>
																	</select>
																</td>
																<td width="158" style="padding:0 0px 0 0"><input class="input_style02"  id="fp3bnn" name="bnn"  placeholder="계좌번호"></td>
															</tr>
															<tr>
																<td colspan="2" ><div class="input_warning" id="bnn-fp3-warn">- 를 제외하고 입력해주세요</div></td>
															</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td>
														<table  width="100%" cellpadding="0" cellspacing="0" class="login_table_in">
															<tr>
																<td width="112" style="padding:0 10px 0 0">
																	<select class="input_style02"  id="fp3cp" name="cp" >
																		<option value="+82">+82(한국)</option>
																		<option value="+63">+63(필리핀)</option>
																	</select>
																</td>
																<td width="158" style="padding:0 0px 0 0"><input class="input_style02"  id="fp3cll" name="cll"  placeholder="휴대폰 번호"></td>
															</tr>
															<tr>
																<td colspan="2"><div class="input_warning" id="cll-fp3-warn">- 를 제외하고 입력해주세요</div></td>
															</tr>
														</table>
													</td>
												</tr>
											</table>
											<div class="acc_btn_wrap">
												<input type="submit" class="btn3c" value="비밀번호 문의">
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>

<!-- show userid modal -->
<div id="modalShowUserId" class="bg_mask_pop2">
	<div class="bg_mask_pop_title">
		<span class="popup_logo"><img src="/images/popup_logo.png"></span>
		<span class="popup_close fade_2_close"><img src="/images/popup_close.png"></span>
	</div>
	<div class="bg_mask_pop2_in">
		<div class="pop_icon_center">
			<img src="/images/check_icon.png">
		</div>
		<div class="pop_text">
			<p class="login_text01">회원님의 아이디는 <span class="font_004" id="findIdUserid">000000</span>입니다.</p>
			<div class="acc_btn_wrap">
				<a href="/"><span class="btn3c">확인</span></a>
			</div>
		</div>
		
	</div>
</div>

<!-- password modal -->
<div id="pwmodal" class="bg_mask_pop2">
	<div class="bg_mask_pop_title">
		<span class="popup_logo"><img src="/images/popup_logo.png"></span>
		<span class="popup_close fade_2_close"><img src="/images/popup_close.png"></span>
	</div>
	<div class="bg_mask_pop2_in">
		<div class="pop_text">
			<p class="login_text01">Change Password</p>
			<div class="acc_btn_wrap">
				<form id="fp2">
					<input type="hidden" name="form" value="f1">
					<div class="login_center">
						<table cellpadding="0" cellspacing="0" class="popup_table01">
							<tr>
								<td><input type="password" class="input_style02 pd " id="fp2pd" name="newpd"  placeholder="비밀번호"></td>
							</tr>
							<tr>
								<td>
									<div class="input_warning " id="newpd-fp2-warn">비밀번호가 일치합니다.</div>
								</td>
							</tr>
							<tr>
								<td>
									<input type="password" class="input_style02 pd" id="fp2pd2" name="newpd2"  placeholder="비밀번호 확인">
								</td>
							</tr>
							<tr>
								<td><div class="input_warning" id="newpd2-fp2-warn">비밀번호가 일치합니다.</div></td>
							</tr>
						</table>
					</div>
					<div class="acc_btn_wrap">
						<input type="submit" class="btn3c" value="비밀번호 설정">
					</div>
				</form>
			</div>
		</div>
		<div class="btn_wrap">
		</div>
	</div>
</div>

<!-- password success modal -->
<div id="modalPdSs" class="bg_mask_pop2">
	<div class="bg_mask_pop_title">
		<span class="popup_logo"><img src="/images/popup_logo.png"></span>
		<span class="popup_close fade_2_close"><img src="/images/popup_close.png"></span>
	</div>
	<div class="bg_mask_pop2_in">
		<div class="pop_icon_center">
			<img src="/images/check_icon.png">
		</div>
		<div class="pop_text">
			<p class="login_text01">Password Change Successfully.</p>
			<div class="btn_wrap">
				<a href="/" class=""><span class="btn3c">확인</span></a>
			</div>
		</div>
	</div>	
</div>


<script>
	var f1cntr; 
	var f1rSnd = false;
	
	var f2cntr; 
	var f2rSnd = false;


	$(document).ready(function(){
		var tab = '<%=session.getAttribute("tb")%>';

		if(tab != "tab1"){
			$("ul.tabs li a[href='#tab2']").click();
		}

		$("#fid1 input").on("blur",function(e){
			var validator = $( "#fid1" ).validate();
			var valid = validator.element($(this));
			if(!valid && !valid){
				$(this).focusin();
			}else{
				$(this).qtip("hide");
			}
		});

		$("#fid1").on("submit",function(e){
			e.preventDefault();
			if($("#fid1").valid()){
				var data = $(this).serializeJSON();
				data['sd'] = "<%=SITEID%>";
				$.ajax({
					url : '/account/jsp/find_id.jsp',
					data : data,
					method: 'POST',
				}).done(function(data){
					var obj = JSON.parse(data);
					if(obj.userid == null || obj.userid == "null"){
						toastr.success('인증번호를 다시 확인해 주세요.');
					}else{
						toastr.clear();

						$("#findIdUserid").html(obj.userid);
						$("#modalShowUserId").popup("show");
						f1cntdwnStop();
					}
				});
			}
		});

		$("#fid1").validate({
	  		errorClass: 'form1-invalid',
	    	validClass: 'form1-valid',
		    onfocusout: false,
		    onkeyup :false,
		    onclick : false,
	  		rules: {
			    nk :{
					required:true,
					minlength:4,
					nowhitespace:true,
	      		},
				cll :{
					required:true,
					digits: true,
					minlength:10,
					maxlength:13,
					nowhitespace:true,
					
				},
				ac :{
					required:true,
					minlength:6,
					nowhitespace:true,
				},
				
			},
			messages: {
			    nk :{
					required:"별명을 입력해 주세요.",
				},
				cll :{
					required:"휴대폰 번호를 입력해 주세요.",
					minlength:"휴대폰 번호를 확인 후 다시 입력해 주세요.",
				},
				ac :{
					required:"인증번호를 입력해 주세요.",
					minlength:"인증번호를 다시 확인해 주세요.",
				},

			},
			errorPlacement: function(error, element) {
				var error_label = element.attr("name");
				var id = element.attr("id");
				
			    if(error.text() != ""){
			    	element.qtip({ 
					    overwrite: true,
					    content: {
					        text: error,
					        tooltipanchor: $(this),
					        // button: 'Close',
					    },
					    show: {
				            when: false,
				            ready: true, 
				            event:false,
				        },
				        hide:{
				        	fixed:true,
				        	event:false,
				        },
				        position: {
					        container: $("#acc_content_in_1_fid1"),
					        at: 'right center ',
					        my: 'left center', 
					        adjust : {
					        	method : 'shift none',
					        }
					    }
					});
			    
				}else{
					element.qtip("hide");
				}
			},
		  	invalidHandler: function() {
				var error = $("#fid1").validate().numberOfInvalids();
			}
		});

		$("#fSndBtn").on("click",function(e){

			var validator = $( "#fid1" ).validate();
			var validNickname = validator.element("#fid1nk");
			var validCell = validator.element("#fidcll");
			var validCp = validator.element("#fid1cp");
			if(validNickname && validCell && validCp ){

				var nk = $.trim($("#fid1nk").val());
				var cp = $.trim($("#fid1cp").val());
				var cll = $.trim($("#fidcll").val());
				var frm = 'f1';

				$.ajax({
					url : '/account/jsp/send_code.jsp',
					data : {nk:nk,cp:cp,cll:cll,method:frm,rSend:f1rSnd},
					method: 'POST',
				}).done(function(data){
					var obj = JSON.parse(data);
					if(obj.result){
						f1cntdwn();
					}else{
						toastr.success("Unknown Account");
						$("#fid1nk").focus();
					}
					
				});	


				
			} 
		});

		$("#modalShowUserId").popup({
	      	transition: 'all 0.3s',
	      	scrolllock: true,
	      	escape: false,
	      	blur: false,
	      	onclose:function(){
	      		resetfid1();
	      		resetfid2();

	    	}
	    });

	    $("#pwmodal").popup({
	    	transition: 'all 0.3s',
	      	scrolllock: true,
	      	escape: false,
	      	blur: false,
	      	onclose:function(){
	      		resetfp1();
	      		resetfp2();
	      		resetfp3();
	    	}
	    });

	    $("#modalPdSs").popup({
	    	transition: 'all 0.3s',
	      	scrolllock: true,
	      	escape: false,
	      	blur: false,
	      	onclose:function(){
	      		resetfp1();
	      		resetfp2();
	    	}
	    });

	    $("#modalShowUserId a.popup_close, #modalShowUserId span.popup_close").on("click",function(e){
	    	e.preventDefault();
	    	$("#modalShowUserId").popup("hide");
	    });

	    $("#pwmodal a.popup_close, #pwmodal span.popup_close").on("click",function(e){
	    	$("#pwmodal").popup("hide");
		});

		$("#modalPdSs a.popup_close, #modalPdSs span.popup_close").on("click",function(e){
	    	$("#modalPdSs").popup("hide");
		});

	    $("#fid2").validate({
	    	errorClass: 'form1-invalid',
	    	validClass: 'form1-valid',
		    onfocusout: false,
		    onkeyup :false,
		    onclick : false,
	  		rules: {
				bn :{
					required:true,
					nowhitespace:true,
				},
				bnn :{
					required:true,
					digits: true,
					nowhitespace:true,
				},
				bo :{
					required:true,
					nowhitespace:true,
				},
				cll :{
					required:true,
					digits: true,
					minlength:10,
					maxlength:13,
					nowhitespace:true,
				},
				cp:{
					required:true,
				}
			},
			messages: {
				bn :{
					required:"은행을 선택해 주세요.",
				},
				bnn :{
					required:"계좌번호를 입력해 주세요.",
					digits: "계좌번호를 숫자로 입력해 주세요.",
				},
				bo :{
					required:"예금주를 입력해 주세요.",
				},
				cll :{
					required:"휴대폰 번호를 입력해 주세요.",
					minlength:"휴대폰 번호를 확인 후 다시 입력해 주세요.",
				}
			},
			errorPlacement: function(error, element) {
				var error_label = element.attr("name");
				var id = element.attr("id");
				
			    if(error.text() != ""){
			    	element.qtip({ 
					    overwrite: true,
					    content: {
					        text: error,
					        tooltipanchor: $(this),
					        // button: 'Close',
					    },
					    show: {
				            when: false,
				            ready: true, 
				            event:false,
				        },
				        hide:{
				        	fixed:true,
				        	event:false,
				        },
				        position: {
					        container: $("#acc_content_in_1_fid2"),
					        at: 'right center ',
					        my: 'left center', 
					        adjust : {
					        	method : 'shift none',
					        }
					    }
					});
			    
				}else{
					element.qtip("hide");
				}
			}
	    });

	    $("#fid2").on("submit",function(e){
	    	e.preventDefault();
	    	if($("#fid2").valid()){
	    		var data = $(this).serializeJSON();
	    		data['sd'] = "<%=SITEID%>";
	    		$.ajax({
					url: '/account/jsp/find_id.jsp',
					data : data,
					method: 'POST',
				}).done(function(data){
					var obj = JSON.parse(data);
					if(obj.userid == null || obj.userid == "null"){
						toastr.success('No UserId Found ');
					}else{
						toastr.clear();
						$("#findIdUserid").html(obj.userid);
						$("#modalShowUserId").popup("show");
					}					
					
				});
	    	}
	    });
		
		$("#fp1").validate({
			errorClass: 'form1-invalid',
	    	validClass: 'form1-valid',
		    onfocusout: false,
		    onkeyup :false,
		    onclick : false,
	  		rules: {
				ud :{
					required:true,
					minlength:4,
					nowhitespace:true,
				},
				nk :{
					required:true,
					nowhitespace:true,
				},
				ac :{
					required:true,
					minlength:6,
					nowhitespace:true,
				},
				cll :{
					required:true,
					digits: true,
					minlength:10,
					maxlength:13,
					nowhitespace:true,
				},
				cp:{
					required:true,
				}
			},
			messages: {
				ud :{
					required:"아이디를 입력해 주세요.",
				},
				nk :{
					required:"별명울 입력해 주세요.",
				},
				ac :{
					required:"인증번호를 입력해 주세요.",
					minlength:"인증번호를 다시 확인해 주세요.",
				},
				cll :{
					required:"휴대폰 번호를 입력해 주세요.",
					minlength:"휴대폰 번호를 확인 후 다시 입력해 주세요.",
				}
			},
			errorPlacement: function(error, element) {
				var error_label = element.attr("name");
				var id = element.attr("id");
				
			    if(error.text() != ""){
			    	element.qtip({ 
					    overwrite: true,
					    content: {
					        text: error,
					        tooltipanchor: $(this),
					        // button: 'Close',
					    },
					    show: {
				            when: false,
				            ready: true, 
				            event:false,
				        },
				        hide:{
				        	fixed:true,
				        	event:false,
				        },
				        position: {
					        container: $("#acc_content_in_fp1"),
					        at: 'right center ',
					        my: 'left center', 
					        adjust : {
					        	method : 'shift none',
					        }
					    }
					});
			    
				}else{
					element.qtip("hide");
				}
			},
		});

		$('#fp1').on("submit",function(e){
			e.preventDefault();
			if($(this).valid()){
				var data = $(this).serializeJSON();
				data['sd'] = "<%=SITEID%>";
				$.ajax({
					url : '/account/jsp/verify_pd.jsp',
					data : data,
					method: 'POST',
				}).done(function(data){
					var obj = JSON.parse(data);
					if(obj.result){
						$("#pwmodal").popup("show");
						f2cntdwnStop();
					}else{
						toastr.success('Incorrect Authenication Code');
					}
				});
			}			
		});

		$("#fp2").on("submit",function(e){
			e.preventDefault();
			if($(this).valid()){
				var data = $(this).serializeJSON();
				if(data['form'] == 'f1'){
					var fp1data = $("#fp1").serializeJSON();
					$.extend(data,fp1data);
					$.ajax({
						url : '/account/jsp/update_pd.jsp',
						data : data,
						method: 'POST',
					}).done(function(data){ 
						var obj = JSON.parse(data);
						if(obj.result){
							$("#pwmodal").popup("hide");
							$("#modalPdSs").popup("show");
						}else{
							$("#pwmodal").popup("hide");
							toastr.success("죄송합니다. 다시 시도해 주세요.");
						}
					});
				}else if(data['form'] == 'f2'){
					var fp2data = $("#fp3").serializeJSON();
					$.extend(data,fp2data);
					$.ajax({
						url : '/account/jsp/update_pd.jsp',
						data : data,
						method: 'POST',
					}).done(function(data){ 
						var obj = JSON.parse(data);
						if(obj.result){
							$("#pwmodal").popup("hide");
							$("#modalPdSs").popup("show");
						}else{
							$("#pwmodal").popup("hide");
							toastr.success("죄송합니다. 다시 시도해 주세요.");
						}
					});
				}
				else{

					$("#pwmodal").popup("hide");
					toastr.success("죄송합니다. 다시 시도해 주세요.");

				}
			}
		});

		$("#fp2").validate({
			errorClass: 'form1-invalid',
	    	validClass: 'form1-valid',
		    onfocusout: false,
		    onkeyup :false,
		    onclick : false,
	  		rules: {
				newpd :{
					required:true,
					minlength:6,
					maxlength:20,
					nowhitespace:true,
				},
				newpd2 :{
					required:true,
					minlength:6,
					maxlength:20,
					nowhitespace:true,
					equalTo: "#fp2pd",
				},
			},
			messages: {
				newpd :{
					required:"비밀번호를 입력해 주세요.",
					minlength:"비밀번호를 6자리 이상 입력해 주세요.",
					maxlength:"비밀번호를 20자리 이하로 입력해 주세요.",
				},
				newpd2 :{
					required:"비밀번호를 다시 한번 확인해 주세요.",
					minlength:"비밀번호를 6자리 이상 입력해 주세요.",
					maxlength:"비밀번호를 20자리 이하로 입력해 주세요.",
					equalTo: "비밀번호가 일치하지 않습니다. 다시 입력해 주세요.",
				},
				
			},
			errorPlacement: function(error, element) {
				var error_label = element.attr("name");
				var id = element.attr("id");
				
			    if(error.text() != ""){
			    	element.qtip({ 
					    overwrite: true,
					    content: {
					        text: error,
					        tooltipanchor: $(this),
					        // button: 'Close',
					    },
					    show: {
				            when: false,
				            ready: true, 
				            event:false,
				        },
				        hide:{
				        	fixed:true,
				        	event:false,
				        },
				        position: {
					        container: $(".acc_section .acc_active"),
					        at: 'right center ',
					        my: 'left center', 
					        adjust : {
					        	method : 'shift none',
					        }
					    }
					});
			    
				}else{
					element.qtip("hide");
				}
			}
		});

		$("#fp3").validate({
			errorClass: 'form1-invalid',
	    	validClass: 'form1-valid',
		    onfocusout: false,
		    onkeyup :false,
		    onclick : false,
	  		rules: {
				bn :{
					required:true,
					nowhitespace:true,
				},
				bnn :{
					required:true,
					digits: true,
					nowhitespace:true,
				},
				bo :{
					required:true,
					nowhitespace:true,
				},
				cll :{
					required:true,
					digits: true,
					minlength:10,
					maxlength:13,
					nowhitespace:true,
				},
				cp:{
					required:true,
				}
			},
				
			messages: {
				bn :{
					required:"은행을 선택해 주세요.",
				},
				bnn :{
					required:"계좌번호를 입력해 주세요.",
					digits: "계좌번호를 숫자로 입력해 주세요.",
				},
				bo :{
					required:"예금주를 입력해 주세요.",
				},
				cll :{
					required:"휴대폰 번호를 입력해 주세요.",
					minlength:"휴대폰 번호를 확인 후 다시 입력해 주세요.",
				}
			},
			errorPlacement: function(error, element) {
				var error_label = element.attr("name");
				var id = element.attr("id");
				
			    if(error.text() != ""){
			    	element.qtip({ 
					    overwrite: true,
					    content: {
					        text: error,
					        tooltipanchor: $(this),
					        // button: 'Close',
					    },
					    show: {
				            when: false,
				            ready: true, 
				            event:false,
				        },
				        hide:{
				        	fixed:true,
				        	event:false,
				        },
				        position: {
					        container: $("#acc_content_in_fp3"),
					        at: 'right center ',
					        my: 'left center', 
					        adjust : {
					        	method : 'shift none',
					        }
					    }
					});
			    
				}else{
					element.qtip("hide");
				}
			}
		});

		$("#fp3").on("submit",function(e){
			e.preventDefault();
			if($(this).valid()){
				var data = $(this).serializeJSON();
				data['sd'] = "<%=SITEID%>";
				$.ajax({
					url : '/account/jsp/verify_pd.jsp',
					data : data,
					method: 'POST',
				}).done(function(data){
					toastr.clear();
					var obj = JSON.parse(data);
					if(obj.result){
						$("#fp2 input[name=form]").val("f2");
						$("#pwmodal").popup("show");
					}else{
						toastr.success("No Account Found");
					}					
					
				});
	    	
			}
		});

		$("#fSndBtn2").on("click",function(e){
			
			var validator = $( "#fp1" ).validate();
			var vU = validator.element("#fp1ud");
			var vNk = validator.element("#fp1nk");
			var vCll = validator.element("#fp1cll");
			var vCp = validator.element("#fp1cp");

			if(vU && vNk && vCll && vCp){

				var nk = $.trim($("#fp1nk").val());
				var cp = $.trim($("#fp1cp").val());
				var cll = $.trim($("#fp1cll").val());
				var ud = $.trim($("#fp1ud").val());
				var frm = 'f2';


				
				$.ajax({
					url : '/account/jsp/send_code.jsp',
					data : {nk:nk,cp:cp,cll:cll,ud:ud,method:frm,rSend:f2rSnd},
					method: 'POST',
				}).done(function(data){
					var obj = JSON.parse(data);
					if(obj.result){
						f2cntdwn();
					}else{
						toastr.success("Unknown Account");
						$("#fp1ud").focus();
					}
				});

		

				
			} 
		});

		$(".accnt_pg ul.tabs li a").on("click",function(){
			resetfid1();
			resetfid2();
			resetfp1();
			resetfp2();
			resetfp3();

			clearInterval(f1cntr);
			clearInterval(f2cntr);

			f1rSnd = false;
			f2rSnd = false;

			$("#fSndBtn").html("인증");
			$("#fSndBtn2").html("인증");

			$('*').qtip('hide');

		});
	});

	function resetfid1(){
		$("#fid1")[0].reset();
		$("#fid1").validate().resetForm();
	}

	function resetfid2(){
		$("#fid2")[0].reset();
		$("#fid2").validate().resetForm();
	}

	function resetfp1(){
		$("#fp1")[0].reset();
		$("#fp1").validate().resetForm();
	}

	function resetfp2(){
 
  		$("#fp2")[0].reset();
  		$("#fp2").validate().resetForm();
	}

	function resetfp3(){
		$("#fp3")[0].reset();
  		$("#fp3").validate().resetForm();
	}

	function f1cntdwn(){
	

		var tc = 180;
		var td = moment.duration(tc * 1000, 'milliseconds');
		var ti = 1000;

		$("#f1cdt").text("Time Left to Verify : " + moment(td.asMilliseconds()).format('mm:ss')).show();
		$("#fSndBtn").prop("disabled",true);

		f1cntr = setInterval(function(){
			td = moment.duration(td.asMilliseconds() - ti, 'milliseconds');
    		if(td >= 0){
				$("#f1cdt").text("Time Left to Verify : " + moment(td.asMilliseconds()).format('mm:ss'));
			}else{
				
		    	$("#f1cdt").text(" ").hide();
		    	clearInterval(f1cntr);
		    	toastr.success("인증 시간이 초과했습니다. 다시 시도해 주세요.");
		    	$("#fSndBtn").html("재전송");
		    	f1rSnd = true;
		    	$("#fSndBtn").prop("disabled",false);		
		    	// $("#fade_1").popup("hide");
    		}
		},ti);
	}

	function f1cntdwnStop(){
		$("#f1cdt").text(" ").hide();
    	clearInterval(f1cntr);
    	$("#fSndBtn").html("인증");
    	f1rSnd = false;
    	$("#fSndBtn").prop("disabled",false);	
	}

	


	function f2cntdwn(){
		
		var tc = 180;
		var td = moment.duration(tc * 1000, 'milliseconds');
		var ti = 1000;

		$("#fSndBtn2").prop("disabled",true);
		$("#fcdt").text("인증 남은 시간 : " + moment(td.asMilliseconds()).format('mm:ss ')).show();

		f2cntr = setInterval(function(){
			td = moment.duration(td.asMilliseconds() - ti, 'milliseconds');
    		if(td >= 0){
				$("#fcdt").text("인증 남은 시간 : " + moment(td.asMilliseconds()).format('mm:ss '));
			}else{
				
		    	$("#fcdt").text(" ").hide();
		    	clearInterval(f2cntr);
		    	toastr.success("Verification Timed Out. Try Again");
		    	$("#fSndBtn2").html("재전송");
		    	f2rSnd = true;
		    	$("#fSndBtn2").prop("disabled",false);		
		    	// $("#fade_1").popup("hide");
    		}
		},ti);
	}


	function f2cntdwnStop(){
		$("#fcdt").text(" ").hide();
    	clearInterval(f2cntr);
    	$("#fSndBtn2").html("인증");
    	f2rSnd = false;
    	$("#fSndBtn2").prop("disabled",false);
	}


</script>
<%@ include file="/inc/footer.jsp"%>

</div>
</body>
</html>
