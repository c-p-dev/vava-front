<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../header.jsp" />

<style>
	#pwmodal .pop_text{
		padding:0px!important;
	}
</style>
<div id="contents_wrap">
	<div class="contents">
		<ul class="tabs">
			<li><a href="#tab1">아이디찾기</a></li>
			<li><a href="#tab2">비밀번호찾기</a></li>
		</ul>
		<div class="tab_container">
			<div id="tab1" class="tab_content">
				<ul class="smk_accordion">
					<li>
						<div class="acc_head"><h3>회원가입시 등록한 휴대폰 번호로 찾기</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_1">
								<div class="login_center">
									<form id="fid1">
										<input type="hidden" name="method" value="by_phone">
										<table cellpadding="0" cellspacing="0" class="login_table">
											<tr>
												<td><input class="input_style02" id="fid1nk" name="nk" placeholder="Name" placeholder="이름"></td>
											</tr>
											<tr>
												<td><div class="input_warning" id="nk-fid1-warn">입력하신 번호로 인증번호가 발송되었습니다.</div></td>
											</tr>
											<tr>
												<td>
													<table  width="100%" cellpadding="0" cellspacing="0" class="login_table_in">
														<tr>
															<td width="112" style="padding:0 10px 0 0">
																<select class="input_style02" id="fid1cp" name="cp">
																	<option value="+63" selected>+63</option>
																	<option value="+82">+82</option>
																</select>
															</td>
															<td width="158" style="padding:0 10px 0 0">
																<input class="input_style02" id="fidcll" name="cll" placeholder="Mobile Phone Number" placeholder="휴대폰번호">
															</td>
															<td>
														
																<span id="fSndBtn" class="btn5">인증</span>
															</td>
														</tr>
														<tr>
															<td colspan="3"><div class="input_warning" id="cll-fid1-warn">입력하신 번호로 인증번호가 발송되었습니다.</div></td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td>
													<table  width="100%" cellpadding="0" cellspacing="0" class="login_table_in">
														<tr>
															<td width="280" style="padding:0 10px 0 0">
																<input class="input_style02" id="findIdCert" name="ac" placeholder="Certification Number"  maxlength="6" placeholder="인증번호">
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
											<input type="submit" class="btn3c" value="아이디확인">
										</div>
									</form>
								</div>
							</div>
						</div>
					</li>
					<li>
						<div class="acc_head"><h3>회원가입시 등록한 계좌 정보로 찾기</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_1">
								<div class="login_center">
									<form id="fid2">
										<input type="hidden" name="method" value="by_bank">
										<table cellpadding="0" cellspacing="0" class="login_table">
											<tr>
												<td><input class="input_style02" id="findIdBank_owner" name="bo"  placeholder="Name (Account Holder)" placeholder="이름(예금주)"></td>
											</tr>
											<tr>
												<td>
													<div class="input_warning"  id="bo-findId-warn">- 를 제외하고 입력해주세요</div>
												</td>
											</tr>
											<tr>
												<td>
													<table  width="100%" cellpadding="0" cellspacing="0" class="login_table_in">
														<tr>
															<td width="112" style="padding:0 10px 0 0">
																<select class="input_style02"  id="findIdBank_name" name="bn" placeholder="name of bank" placeholder="은행명">
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
																</select>
															</td>
															<td width="158" style="padding:0 10px 0 0"><input class="input_style02" name="bnn"  placeholder="Account number entered at the time of registration" placeholder="가입시 입력한 계좌번호"></td>
															
														</tr>
														<tr>
															<td colspan="2">
																<div class="input_warning"  id="bnn-findId-warn">- 를 제외하고 입력해주세요</div>
															</td>
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
																	<option value="+63" selected>+63</option>
																	<option value="+82">+82</option>
																</select>
															</td>
															<td width="158" style="padding:0 10px 0 0">
																<input class="input_style02" id="fidcll2" name="cll" placeholder="휴대폰번호">
															</td>
														</tr>
														<tr>
															<td>
																<div class="input_warning"  id="cll-findId-warn">- 를 제외하고 입력해주세요</div>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
										<div class="acc_btn_wrap">
											<input type="submit" value="아이디문의" class="btn3c">
										</div>

									</form>
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
							<div class="acc_content_in_1">
								<div class="login_center">
									<form id="fp1">
										<input type="hidden" name="method" value="by_phone">
										<table cellpadding="0" cellspacing="0" class="login_table">
											<tr>
												<td><input class="input_style02" id="fp1ud" name="ud"  placeholder="아이디"></td>
											</tr>
											<tr>
												<td><div class="input_warning" id="ud-fp1-warn">조건에 맞는 아이디를 입력해주세요.</div></td>
											</tr>
											<tr>
												<td><input class="input_style02" id="fp1nk" name="nk"  placeholder="이름"></td>
											</tr>
											<tr>
												<td><div class="input_warning" id="nk-fp1-warn">조건에 맞는 아이디를 입력해주세요.</div></td>
											</tr>
											<tr>
												<td>
													<table  width="100%" cellpadding="0" cellspacing="0" class="login_table_in">
														<tr>
															<td width="112" style="padding:0 10px 0 0">
																<select class="input_style02"  id="fp1cp" name="cp">
																	<option value="+63">+63</option>
																	<option value="+82">+82</option>
																</select>
															</td>
															<td width="158" style="padding:0 10px 0 0"><input class="input_style02" id="fp1cll" name="cll" maxlength="15" placeholder="휴대폰번호"></td>
															<td><span class="btn5" id="fSndBtn2">인증</span></td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td><div class="input_warning" id="cll-fp1-warn">조건에 맞는 아이디를 입력해주세요.</div></td>
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
											<tr>
												<td>
													<div class="input_warning" id="ac-fp1-warn">조건에 맞는 아이디를 입력해주세요.</div>
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
					</li>
					<li>
						<div class="acc_head"><h3>회원가입시 등록한 계좌 정보로 찾기</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_1">
								<div class="login_center">
									<form id="fp3">
										<input type="hidden" name="method" value="by_bank">
										<table cellpadding="0" cellspacing="0" class="login_table">
											<tr>
												<td><input class="input_style02"  id="fp3bo" name="bo"  placeholder="이름(예금주)"></td>
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
																</select>
															</td>
															<td width="158" style="padding:0 0px 0 0"><input class="input_style02"  id="fp3bnn" name="bnn"  placeholder="가입시 입력한 계좌번호"></td>
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
																	<option value="+63">+63</option>
																	<option value="+82">+82</option>
																</select>
															</td>
															<td width="158" style="padding:0 0px 0 0"><input class="input_style02"  id="fp3cll" name="cll"  placeholder="휴대폰번호"></td>
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
						<table cellpadding="0" cellspacing="0" class="login_table">
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
									<input type="password" class="input_style02 pd" id="fp2pd2" name="newpd2"  placeholder="비밀번호확인">
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
	$(document).ready(function(){
		var tab = '<%=session.getAttribute("account_tab")%>';

		if(tab != "tab1"){
			$("ul.tabs li a[href='#tab2']").click();
		}

		$("#fid1").on("submit",function(e){
			e.preventDefault();
			if($("#fid1").valid()){
				var data = $(this).serializeJSON();
				$.ajax({
					url : '/process/account/find_id.jsp',
					data : data,
					method: 'POST',
				}).done(function(data){
					var obj = JSON.parse(data);
					if(obj.userid == null || obj.userid == "null"){
						toastr.success('Incorrect Authenication Code');
					}else{
						toastr.clear();
						$("#findIdUserid").html(obj.userid);
						$("#modalShowUserId").popup("show");
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
					required:"Nickname is required",
				},
				cll :{
					required:"Mobile Number is required",
					minlength:"Minimum length is 10",
				},
				ac :{
					required:"Certificate is required",
					minlength:"Minimun Length is 6",
				},

			},
			errorPlacement: function(error, element) {
				var error_label = element.attr("name");
			    if (element.attr("name") == error_label ){
			    	$("#"+error_label+"-fid1-warn").html(error).show();	
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

				$("#fSndBtn").prop("disabled",true);
				
				$.ajax({
					url : '/process/account/send_code.jsp',
					data : {nk:nk,cp:cp,cll:cll,method:frm},
					method: 'POST',
				}).done(function(data){
					var obj = JSON.parse(data);
					if(!obj.result){
						toastr.success("Unknown Account");
						$("#fid1nk").focus();
					}
					$("#fSndBtn").prop("disabled",false);
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
					required:"Bank name is required",
				},
				bnn :{
					required:"Bank number is required",
					digits: "Please enter only digits on Bank Number",
				},
				bo :{
					required:"Bank owner is required",
				},
				cll :{
					required:"Mobile Number is required",
					minlength:"Minimum length is 10",
				}
			},
			errorPlacement: function(error, element) {
				var error_label = element.attr("name");
			    if (element.attr("name") == error_label ){
			    	$("#"+error_label+"-findId-warn").html(error).show();
			    	
			    }
			}
	    });

	    $("#fid2").on("submit",function(e){
	    	e.preventDefault();
	    	if($("#fid2").valid()){
	    		var data = $(this).serializeJSON();
	    		$.ajax({
					url: '/process/account/find_id.jsp',
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
					required:"User Id is required",
				},
				nk :{
					required:"Nick name is required",
				},
				ac :{
					required:"Certificate is required",
					minlength:"Minimun Length is 6",
				},
				cll :{
					required:"Mobile Number is required",
					minlength:"Minimum length is 10",
				}
			},
			errorPlacement: function(error, element) {
				var error_label = element.attr("name");
			    if (element.attr("name") == error_label ){
			    	$("#"+error_label+"-fp1-warn").html(error).show();
			    }
			},
		});

		$('#fp1').on("submit",function(e){
			e.preventDefault();
			if($(this).valid()){
				var data = $(this).serializeJSON();
				$.ajax({
					url : '/process/account/verify_pd.jsp',
					data : data,
					method: 'POST',
				}).done(function(data){
					var obj = JSON.parse(data);
					if(obj.result){
						$("#pwmodal").popup("show");
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
						url : 'process/account/update_pd.jsp',
						data : data,
						method: 'POST',
					}).done(function(data){ 
						var obj = JSON.parse(data);
						if(obj.result){
							$("#pwmodal").popup("hide");
							$("#modalPdSs").popup("show");
						}else{
							$("#pwmodal").popup("hide");
							toastr.success("Something went wrong try again");
						}
					});
				}else if(data['form'] == 'f2'){
					var fp2data = $("#fp3").serializeJSON();
					$.extend(data,fp2data);
					$.ajax({
						url : 'process/account/update_pd.jsp',
						data : data,
						method: 'POST',
					}).done(function(data){ 
						var obj = JSON.parse(data);
						if(obj.result){
							$("#pwmodal").popup("hide");
							$("#modalPdSs").popup("show");
						}else{
							$("#pwmodal").popup("hide");
							toastr.success("Something went wrong try again");
						}
					});
				}
				else{

					$("#pwmodal").popup("hide");
					toastr.success("Something went wrong try again");

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
					required:"Password is required",
					minlength:"Minimum length is 6",
					maxlength:"Maximum length is 20",
				},
				newpd2 :{
					required:"Confirm Password is required",
					minlength:"Minimum length is 6",
					maxlength:"Maximum length is 20",
					equalTo: "Confirm Password must be equal to New Password",
				},
				
			},
			errorPlacement: function(error, element) {
				var error_label = element.attr("name");
			    if (element.attr("name") == error_label ){
			    	$("#"+error_label+"-fp2-warn").html(error).show();
			    	
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
					required:"Bank name is required",
				},
				bnn :{
					required:"Bank number is required",
					digits: "Please enter only digits on Bank Number",
				},
				bo :{
					required:"Bank owner is required",
				},
				cll :{
					required:"Mobile Number is required",
					minlength:"Minimum length is 10",
				}
			},
			errorPlacement: function(error, element) {
				var error_label = element.attr("name");
			    if (element.attr("name") == error_label ){
			    	$("#"+error_label+"-fp3-warn").html(error).show();
			    	
			    }
			}
		});

		$("#fp3").on("submit",function(e){
			e.preventDefault();
			if($(this).valid()){
				var data = $(this).serializeJSON();
				$.ajax({
					url : '/process/account/verify_pd.jsp',
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

				$("#fSndBtn2").prop("disabled",true);
				
				$.ajax({
					url : '/process/account/send_code.jsp',
					data : {nk:nk,cp:cp,cll:cll,ud:ud,method:frm},
					method: 'POST',
				}).done(function(data){
					var obj = JSON.parse(data);
					if(!obj.result){
						toastr.success("Unknown Account");
						$("#fp1ud").focus();
					}

					$("#fSndBtn2").prop("disabled",false);
				});	
			} 
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


</script>
<jsp:include page="../footer.jsp" />
