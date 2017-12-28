<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<style>
	#cdt{
		color:#5f6060;
		padding: 7px 0 0 5px;
	}
</style>

<!-- member registration form -->
<div id="fade_1" class="bg_mask_pop1">
	<div class="bg_mask_pop_title">
		<span class="popup_logo"><img src="/images/popup_logo.png"></span>
		<span class="popup_close fade_1_close"><img src="/images/popup_close.png"></span>
	</div>
	<form  id="form1" name="form1" >
		<div class="bg_mask_pop1_in">
			<p class="pop_text_title">회원가입</p>
			<div class="pop_text">IBET25에 오신것을 환영합니다.<br>회원가입을 하시면 보다 폭넓은 서비스 이용이 가능합니다.</div>
			<table  width="100%" cellpadding="0" cellspacing="0" class="popup_table01">
				<tr>
					<td>
						<table  cellpadding="0" width="100%" cellspacing="0" class="popup_table01_1">
							<tr>
								<td><input class="input_style02 input_required" id="userid" name="userid"  maxlength="12" placeholder="아이디(영문과 숫자 조합으로 최소 6자 이상, 최대 12자 이하)" data-warn="userid-warn" tabindex="1"></td>
							</tr>
							<tr>
								<td colspan="2"><div class="input_warning" id="userid-warn">조건에 맞는 아이디를 입력해주세요.</div></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table  cellpadding="0" width="100%" cellspacing="0" class="popup_table01_1">
							<tr>
								<td><input class="input_style02 input_required" id="nick" name="nick" maxlength="20" data-warn="nickname-warn" placeholder="닉네임(한글 또는 한글+숫자 조합으로 2자 이상, 최대 10자 이하)" tabindex="2"></td>
								
							</tr>
							<tr>
								<td colspan="2"><div class="input_warning" id="nick-warn">만족 조건 충족 여부</div></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table  cellpadding="0" width="100%" cellspacing="0" class="popup_table01_1">
							<tr>
								<td><input class="input_style02 input_required" type="password" maxlength="20" id="passwd" name="passwd" data-warn="pd-warn" placeholder="비밀번호(4자 이상)" tabindex="3"></td>
							</tr>
							<tr>
								<td ><div class="input_warning" id="passwd-warn"> 만족 조건 충족 여부</div></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table  cellpadding="0" width="100%" cellspacing="0" class="popup_table01_1">
							<tr>
								<td><input class="input_style02 input_required" type="password" maxlength="20" id="conf_passwd" name="conf_passwd" data-warn="pd-warn" placeholder="비밀번호 확인" tabindex="4"></td>
							</tr>
							<tr>
								<td ><div class="input_warning" id="conf_passwd-warn"> 만족 조건 충족 여부</div></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table  width="100%" cellpadding="0" cellspacing="0" class="popup_table01_1">
							<tr>
								<td width="100" align="left" style="padding:0 5px 0 0">
									<select class="input_style02" id="form1bank_name" name="bank_name">
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
								<td width="120" align="left" style="padding:0 0px 0 0"><input class="input_style02" id="form1bank_owner" name="bank_owner" maxlength="20"  placeholder="예금주" tabindex="5" ></td>
							</tr>
						</table>
					</td>
				</tr>
				
				<tr>
					<td>
						<table  width="100%" cellpadding="0" cellspacing="0" class="popup_table01_1">
							<tr>

								<td align="left" style="padding:0 0px 0 0"><input class="input_style02 input_required" id="form1bank_num" name="bank_num" maxlength="20" data-warn="bank-warn" placeholder="계좌번호 입력(- 없이 숫자만 입력)" tabindex="6" ></td>
							</tr>
							<tr>
								<td colspan="3">
									<div class="input_warning" id="bank_owner-warn"></div>
									<div class="input_warning" id="bank_num-warn"></div>	
								</td>
							</tr>
						</table>
					</td>
				</tr>
				
				<tr>
					<td>
						<table  width="100%" cellpadding="0" cellspacing="0" class="popup_table01_1">
							<tr>
								<!--
								<td width="150" align="left" style="padding:0 5px 0 0">
									<select class="input_style02" name="cell_prefix" id="cell_prefix">
										<option value="+82">+82(한국)</option>
										<option value="+63">+63(필리핀)</option>										
									</select>
								</td>
								</-->
								<td width="330" align="left" style="padding:0 5px 0 0"><input class="input_style02 input_required" id="cell" name="cell" maxlength="15" data-warn="cell-warn"  placeholder="휴대폰 번호(- 없이 숫자만 입력)" tabindex="7" ></td>
								<td>
									<button id="mobileVerBtn" class="btn5" style="cursor:pointer">인증</button>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<div class="input_warning" id="cell-warn"></div>	
								</td>
								<input type="hidden" name="cell_prefix" id="cell_prefix" value="+63">
							</tr>
						</table>
						
					</td>
				</tr>
				<tr>
					<td>
						<table  width="100%" cellpadding="0" cellspacing="0" class="popup_table01_1">
							<tr>
								<td width="335" align="left" style="padding:0 5px 0 0"><input class="input_style02 input_required" maxlength="6" id="cert" name="cert" maxlength="20" data-warn="cert-warn"  placeholder="인증번호"  tabindex="8" ></td>
								<td><a href="#" id="certBtn"><span class="btn5">확인</span></a></td>
							</tr>
							<tr>
								<td colspan="2">
									<div class="input_warning" id="cert-warn"></div>	
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<input class="input_style02 input_required" id="referrer" name="referrer"  maxlength="20" placeholder="추천인아이디" value="" data-warn="referrer-warn" tabindex="9">
						<div class="input_warning" id="referrer-warn"></div>
					</td>
				</tr>
				<tr>
					<td>
						<table  width="100%" cellpadding="0" cellspacing="0" class="popup_table01_1">
							<tr>
								<td width="335" align="left" style="padding:0 5px 0 0">
									<input class="input_style02 input_required" id="recommend" name="recommend" data-warn='recommend-warn' maxlength="6"  placeholder="추천인코드" tabindex="10" >
								</td>
								<td><a href="#" id="recoVerifyBtn"><span class="btn5">확인</span></a></td>
							</tr>
							<tr>
								<td colspan="2">
									<div class="input_warning" id="recommend-warn"></div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<div class="text_center">모든 항목은 필수 입력 사항 입니다.</div>
			<!-- <div class="btn_wrap"><a href="#"><span class="btn3c">회원가입</span></a></div> -->
			<div class="btn_wrap">
				<input type="submit" id="registerBtn" class="btn3c" style="cursor:pointer" value="회원가입" >
			</div>

			<div class="text_center">이미 회원이라면? 로그인 후 이용해 주시기 바랍니다.</div>
			<div class="btn_wrap">
				<a href="#" id="loginBtn"><span class="btn3">로그인</span></a>
				<!-- <button type="button" class="btn3" id="loginBtn">로그인</button> -->
			</div>
		</div>
	</form>
</div>

<!-- member success info -->
<div id="fade_2" class="bg_mask_pop2">
	<div class="bg_mask_pop_title">
		<span class="popup_logo"><img src="/images/popup_logo.png"></span>
		<span class="popup_close fade_2_close"><img src="/images/popup_close.png"></span>
	</div>
	<div class="bg_mask_pop2_in">
		<div class="pop_icon_center">
			<img src="/images/check_icon.png">
		</div>
		<div class="pop_text">
			회원 가입 완료!<br>
			IBET25에 오신것을 환영합니다. <br>
			IBET25에서 다양한 베팅의 세계를 마음껏 경험하세요!<br>
		</div>
		<div class="btn_wrap">
			<a href="app/sub04.jsp"><span class="btn3c">충전하기</span></a> 
			<a href="/"><span class="btn3">확인</span></a>
		</div>
	</div>
</div>

<script>

	var SmsCounter; 
	var rSnd = false;
	$(document).ready(function () {

	    $('#fade_1').popup({
	      	transition: 'all 0.3s',
	      	scrolllock: true,
	      	escape: false,
	      	blur: false,
	      	onclose:function(){
	      		resetForm1();
	      		$("#form1 input").qtip("hide");
	    	},
	    	onopen: function(){
	    		toastr.clear();
	    		resetForm1();
	    		$("#form1 input").qtip("hide");
	    	}
	    });

	    $('#fade_2').popup({
			transition: 'all 0.3s',
			scrolllock: true,
			onclose:function(){
	      		location.reload();
	    	},
	    	onopen : function(){
				var oldHtml  =  $("#fade_2 .bg_mask_pop2_in").html();
	    		var spin = '<div id="spin_clive" class="sk-circle ng-scope" style="">';
					spin += '<div class="sk-circle1 sk-child"></div>';
					spin += '<div class="sk-circle2 sk-child"></div>';
					spin += '<div class="sk-circle3 sk-child"></div>';
					spin += '<div class="sk-circle4 sk-child"></div>';
					spin += '<div class="sk-circle5 sk-child"></div>';
					spin += '<div class="sk-circle6 sk-child"></div>';
					spin += '<div class="sk-circle7 sk-child"></div>';
					spin += '<div class="sk-circle8 sk-child"></div>';
					spin += '<div class="sk-circle9 sk-child"></div>';
					spin += '<div class="sk-circle10 sk-child"></div>';
					spin += '<div class="sk-circle11 sk-child"></div>';
					spin += '<div class="sk-circle12 sk-child"></div>';
					spin += '</div>';

				$("#fade_2 .bg_mask_pop2_in").html(spin);
		  		setTimeout(function(){
			  		$("#fade_2 .bg_mask_pop2_in").html(oldHtml);
				}, 1500);
	    	},
		});

	    $('#fade_3').popup({
			transition: 'all 0.3s',
			scrolllock: true
		});

		$("#loginBtn").on("click",function(e){
	    	e.preventDefault();
	    	$('#fade_1').popup("hide");
	    	$('#fade_3').popup("show");
	    });

		$("#registerBtn").on("click",function(e){
			e.preventDefault();
			if($("#form1").valid()){
				var data = $("#form1").serializeJSON();
			    submitForm(data);
			}
		});

		$("#form1 input").on("blur",function(e){
			e.preventDefault();
			var validator = $( "#form1" ).validate(); 
			var id = $(this).attr("id");
			var valid = validator.element("#"+id);
			$(this).qtip("hide");
			// console.log(valid);
			if(!valid && !valid){
				$(this).focusin();
			}			
		});

		$('select').niceSelect();
		$("ul.list").mCustomScrollbar();

		jQuery.validator.addMethod("alphanumeric", function(value, element) {
			return this.optional(element) || /^\w+$/i.test(value);
		}, "아이디를 특수 문자를 제외한 영문과 숫자 조합으로 입력해 주세요.");  


		$.validator.addMethod("checkReferrer", function(value, element) {
	    	var x = $.ajax({
		        url:'/login/jsp/referrence_checker.jsp',
		        async: false,
		        type: 'post',
		        data: {
		          	referrer: function() {
		            	return $( "#referrer" ).val();
		          	}
		        },
	    	}).responseText;
	    	if(x.trim() =="true") return true;
	    	else return false;
	    });

	    $.validator.addMethod("verify_nickname", function(value, element) {
	    	var x = $.ajax({
		        url:'/login/jsp/verify_nickname.jsp',
		        async: false,
		        type: 'post',
		        data: {
		          	nickname: function() {
		            	return $( "#nick" ).val();
		          	}
		        },
	    	}).responseText;
	    	if(x.trim() =="true") return false;
	    	else return true;
	    });
	    
		$.validator.addMethod( "nowhitespace", function( value, element ) {
			return value.indexOf(" ") < 0 && value != ""; 
		}, "공백없이 입력해 주세요." );

		$.validator.addMethod( "noHangul", function( value, element ) {
			var hangul = new RegExp("[\u1100-\u11FF|\u3130-\u318F|\uA960-\uA97F|\uAC00-\uD7AF|\uD7B0-\uD7FF]"); 
			// console.log(hangul.test(value));
			return   this.optional( element ) || !hangul.test(value);
		}, "사용자 아이디를 영문과 숫자 조합으로 만들어 주세요." );
	
	
	
		$.validator.addMethod( "onlyHangul", function( value, element ) {
			var hangul = /^[ㄱ-ㅎ|가-힣|0-9|\*]+$/ //new RegExp("[\u1100-\u11FF|\u3130-\u318F|\uA960-\uA97F|\uAC00-\uD7AF|\uD7B0-\uD7FF]"); 
			// console.log(hangul.test(value));
			return   this.optional( element ) || hangul.test(value);
		}, "닉네임을 한글과 숫자 조합으로 만들어 주세요." );




		$("#form1").validate({
	  		errorClass: 'form1-invalid',
	    	validClass: 'form1-valid',
		    onfocusout: false,
		    onkeyup :false,
		    onclick : false,
	  		rules: {
			    userid :{
			    	required:true,
			    	noHangul: true,
			    	nowhitespace:true,
	          alphanumeric:true,
						minlength:6,
						remote: {
							url: "/login/jsp/userid_checker.jsp",
							async: false,
					        type: "post",
					       	data: {
					          	userid: function() {
					            	return $( "#userid" ).val();
					          	}
					        }
             },
	      		},
				bank_name :{
					required:true,
					nowhitespace:true,
				},
				bank_num :{
					required:true,
					digits: true,
					nowhitespace:true,
				},
				bank_owner :{
					required:true,
					nowhitespace:true,
				},
				cell :{
					required:true,
					digits: true,
					minlength:10,
					maxlength:11,
			  		synchronousRemote: {
		            url: "/login/jsp/verify_cellnum.jsp",
				        type: "post",
				        async: false,
				       	data: {
				          	cell_prefix: function (){
				          		return $.trim($("#cell_prefix").val());
				          	},
				          	cell: function (){
				          		return $.trim($("#cell").val());
				          	},
				        },
		            },
		            nowhitespace:true,
				},
				cert :{
					required:true,
					minlength:6,
					remote: {
						url: "/login/jsp/verify_cert_num.jsp",
				        type: "post",
				       	data: {
				          	cert: function (){
				          		return $("#cert").val();
				          	},
				          	cell_prefix:function(){
				          		return $("#cell_prefix").val();	
				          	},
				          	cell: function(){
				          		return $("#cell").val();	
				          	},
				          	rSnd:rSnd,
				        },
			      	},
			      	nowhitespace:true,

				},
				passwd :{
					required:true,
					minlength:4,
					maxlength:20,
					nowhitespace:true,
				},
				conf_passwd :{
					required:true,
					minlength:4,
					maxlength:20,
					nowhitespace:true,
					equalTo: "#passwd",					
				},
				referrer :{
			    required:true,
			  	checkReferrer:true,
			  	nowhitespace:true,
				},
				recommend :{
					required:true,
					minlength: 6,
					remote: {
					url: "/login/jsp/joincode_checker.jsp",
				        type: "post",
				        async: true,
				       	data: {
				          	recommend: function() {
				            	return $.trim($( "#recommend" ).val());
				          	},
				          	referrer : function(){
				          		return $.trim($( "#referrer" ).val());
				          	},
				        },
			      	},
			      	nowhitespace:true,
				},
				nick :{
					required:true,
					nowhitespace:true,
					verify_nickname: true,
					onlyHangul:true,
				},
			},
			messages: {
			    userid :{
					required:"아이디를 입력해 주세요",
					remote:"이미 사용중인 아이디 입니다.",  
					minlength:"아이디를 최소 6자 이상 입력해 주세요.",
				},
				bank_name :{
					required:"은행을 선택해 주세요.",
				},
				bank_num :{
					required:"계좌번호를 입력해 주세요.",
					digits: "계좌번호를 숫자로 입력해 주세요.",
				},
				bank_owner :{
					required:"예금주를 입력해 주세요.",
				},
				cell :{
					required:"핸드폰 번호를 입력해 주세요",
					minlength:"핸드폰 번호를 확인 후 다시 입력해 주세요.",
					digits: "핸드폰 번호를 숫자로 입력해 주세요.",
					maxlength:"핸드폰 번호를 확인 후 다시 입력해 주세요.",
					synchronousRemote : "이미 사용중인 핸드폰 번호 입니다.",
				},
				cert :{
					required:"인증번호를 입력해 주세요",
					minlength:"인증번호를 확인 후 다시 입력해 주세요",
					remote:"잘못된 인증번호 입니다.",
				},
				passwd :{
					required:"비밀번호를 입력 해 주세요.",
					minlength:"비밀번호를 4자 이상 입력해 주세요.",
					maxlength:"비밀번호를 20자 이하로 입력해 주세요",
				},
				conf_passwd :{
					required:"비밀번호를 입력 해 주세요.",
					minlength:"비밀번호를 4자 이상 입력해 주세요.",
					maxlength:"비밀번호를 20자 이하로 입력해 주세요",
					equalTo: "비밀번호가 일치하지 않습니다.",

				},
				recommend :{
					required:"추천 코드를 입력해 주세요.",
					minlength: "추천 코드를 확인 후 다시 입력해 주세요.",
					remote: "잘못된 추천 코드 입니다.",
				},
				referrer :{
					required:"추천인 아이디를 입력해 주세요.",
					checkReferrer: "존재하지 않는 추천인 아이디 입니다.",
				},
				nick :{
					required:"닉네임을 입력해 주세요.",
					verify_nickname:"이미 사용중인 닉네임입니다.",
					onlyHangul:"닉네임은 한글과 숫자 조합만 가능합니다.",
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
					        //button: 'Close',
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
					        container: $("#fade_1_wrapper"),
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
		  	invalidHandler: function(event, validator) {
				var error = $("#form1").validate().numberOfInvalids();
			}
		});

		$("#certBtn").on("click",function(e){
			e.preventDefault();
			var validator = $( "#form1" ).validate();
			var validCell = validator.element( "#cell" );
			validator.element( "#cert" );
		});

		$("#mobileVerBtn").on("click",function(e){
			e.preventDefault();
			var validator = $( "#form1" ).validate();
			valid = validator.element("#cell");
			if(valid){
				countdown();
				verifyNumber();
			}
		});

		$("#recoVerifyBtn").on("click",function(e){
			e.preventDefault();
			var validator = $( "#form1" ).validate();
			var validReferrer = validator.element( "#referrer");
			if(validReferrer){
				var validRecommend = validator.element( "#recommend" );	
			}
		});

		$('#form1').on('keyup keypress', function(e) {
			var keyCode = e.keyCode || e.which;
				if (keyCode === 13) { 
				e.preventDefault();
				//alert("no entering");
				return false;
			}
		});

	});

	function resetForm1(){
		$('#form1 input').css("border-color","#2e3032");
		$("#form1 .img-validator").attr("src","/images/input_mark3.jpg");
		$("#form1")[0].reset();
		// $('#form1 .input_warning').hide();
		$("#mobileVerBtn").html('인증');
		$("#cdt").remove();
    	clearInterval(SmsCounter);
    	$("#mobileVerBtn").prop('disabled', false);
    	rSnd = false;
		$("#form1").validate().resetForm();
	}

	function submitForm(data){
		$.ajax({
			url : '/login/jsp/register_process.jsp',
			data : data,
			method: 'POST',
		}).done(function(data){ 
			data = $.trim(data);
			if(data == 'true'){
				$('#fade_1').popup('hide');
				$("#fade_2").popup('show');
				resetForm1();
				$("#form1 input").qtip("hide");
			}else{
				toastr.success("회원가입 중 오류가 발생했습니다.");
			}
		});
	}

	function verifyNumber(){
		var userid = $.trim($("#userid").val());
		var cell_prefix = $.trim($("#cell_prefix").val());
		var cell = $.trim($("#cell").val());
	
		
		$.ajax({
			url : '/login/jsp/send_sms.jsp',
			data : {userid:userid,cell_prefix:cell_prefix,cell:cell,rSnd:rSnd},
			method: 'POST',
		}).done(function(data){ 

		});
	}

	function countdown(){
		
		var time = 180;
		var duration = moment.duration(time * 1000, 'milliseconds');
		var interval = 1000;

		$("#mobileVerBtn").prop("disabled",true);
		$('#cell-warn').after('<div id="cdt"></div>');

		SmsCounter = setInterval(function(){
			duration = moment.duration(duration.asMilliseconds() - interval, 'milliseconds');
    		if(duration >= 0){
				$("#cdt").text("남은 시각 : " + moment(duration.asMilliseconds()).format('mm:ss '));
			}else{
				
		    	$("#cdt").remove();
		    	clearInterval(SmsCounter);
		    	toastr.success("Verification Timed Out. Try Again");
		    	$("#mobileVerBtn").html("Resend");
		    	rSnd = true;
		    	$("#mobileVerBtn").prop("disabled",false);		
		    	// $("#fade_1").popup("hide");
    		}
		},interval);
	}

	function sLog(){
		var validator = $( "#form1" ).validate();
		valid = validator.element("#cell");
		if(valid){
			var cp = $("#cell_prefix").val();
			var cll = $("#cell").val();
			$.ajax({
				url : '/login/jsp/sms_log.jsp',
				data : {cp:cp,cll:cll},
				method: 'POST',
			})

		}
		
	}

</script>




