<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- login -->
<div id="fade_3" class="bg_mask_pop3">
	<div id="fd3_spn" style="display: none">
		
	</div>
	<div id="fd3_cont">
		<div class="bg_mask_pop_title">
			<span class="popup_logo"><img src="/images/popup_logo.png"></span>
			<span class="popup_close fade_3_close"><img src="/images/popup_close.png"></span>
		</div>
		<div class="bg_mask_pop3_in">
			<form id="login_modal_form">
				<p class="pop_text_title">로그인</p>
				<table  width="100%" cellpadding="0" cellspacing="0" class="popup_table01">
					<tr>
						<td width="370"><input class="input_style02 login_input" id="userid-input" name="userid" placeholder="아이디"></td>
						<!-- <td><img class="login-img-validator" id="userid-img" src="images/input_mark2.jpg"></td> -->
					</tr>
					<tr>
						<td width="370"><input class="input_style02 login_input password" id="passwd-input" name="passwd" type="password"  placeholder="비밀번호"></td>
						<!-- <td><img class="login-img-validator" id="passwd-img" src="images/input_mark2.jpg"></td> -->
					</tr>
					<tr>
						<td style="padding:5px 0 15px 0" colspan="2">
							<div class="input_warning login-warn">조건에 맞는 아이디를 입력해주세요.</div>
						</td>
					</tr>
				</table>
				<div class="btn_wrap">
					<!-- <a href="#"><span class="btn3c">로그인</span></a> -->
					<input type="submit" class="btn3c" value="로그인">
				</div>
				<div class="text_center">아직 회원이 아니시라면 회원가입 후 이용해 주시기 바랍니다.</div>
				<div class="btn_wrap"><a href="#" id="signupBtn"><span class="btn3">회원가입</span></a></div>
			</form>
		</div>	
	</div>
</div>


<!-- login success modal -->
<div id="lgInMdl2" class="bg_mask_pop2">
	<div class="bg_mask_pop_title">
		<span class="popup_logo"><img src="/images/popup_logo.png"></span>
		<span class="popup_close cMLgIn2"><img src="/images/popup_close.png"></span>
	</div>
	<div class="bg_mask_pop2_in">
		<div class="pop_icon_center">
			<img src="/images/check_icon.png">
		</div>
		<div class="pop_text">
			로그인 성공!<br>
			IBET25에 오신것을 환영합니다. <br>
			IBET25에서 다양한 베팅의 세계를 마음껏 경험하세요!<br>
		</div>
		<div class="btn_wrap">
			<span class="btn3 cMLgIn2">확인</span>
		</div>
	</div>
</div>

<script>
	$(document).ready(function () {
		
		$("#signinBtn").on("click",function(e){
			e.preventDefault();
			$('#fade_3').popup('show');
		});

		$('#signupBtn').on('click',function(e){
			e.preventDefault();
			$('#fade_3').popup("hide");
			$('#fade_1').popup("show");
		});


		$('#lgInMdl2').popup({
	      	transition: 'all 0.3s',
	      	scrolllock: true,
	      	onclose:function(){
	    		$("#login_modal_form")[0].reset();
	    		$('.input_warning').hide();
	    		// location.reload();
	    		$("#passwd-input").removeClass("password");
	    		// alert("closing");
	    	}
	    });

		$(".cMLgIn2").on("click",function(e){
			e.preventDefault();
			$("#lgInMdl2").popup("hide");
		
		});

		$("#login_modal_form").on("submit",function(e){
			e.preventDefault();

			toastr.clear();
			

			var validator = $( "#login_modal_form" ).validate(); 
			var vUser = validator.element("#userid-input");
			var vPass = validator.element("#passwd-input");
			// console.log(!vUser);
			// console.log(!vPass);
			if(!vUser && !vPass){
				toastr.success("아이디와 비밀번호를 입력해 주세요.");
			}else if (vUser && !vPass){
				toastr.success("비밀번호를 입력해 주세요.");
			}else if (!vUser && vPass){
				toastr.success("아이디를 입력해 주세요.");
			}else{

				var data = $(this).serializeJSON();
				submitLoginModalForm(data);
			}

			
			
		});

		$('#fade_3').popup({
	      	transition: 'all 0.3s',
	      	scrolllock: true,
	      	onclose:function(){
	    		$("#login_modal_form")[0].reset();
	    		$('.input_warning').hide();
	    		toastr.clear();
	    	}
	    });	

	    $("#login_modal_form").validate({
	  		errorClass: 'form1-invalid',
	    	validClass: 'header-login-valid',
		    onfocusout: false,
		    onkeyup :false,
		    onclick : false,
		    groups: {
			    username: "userid passwd"
			},
	  		rules: {
			    userid :{
			    	required:true,
	      		},
				
				passwd :{
					required:true,
				},
			},
			messages: {
			    userid :{
					required:"아이디를 입력해 주세요.",
					remote:"이미 사용중인 아이디 입니다.",
				},
				passwd :{
					required:"비밀번호를 입력해 주세요.",
					minlength:"비밀번호를 6자리 이상 입력해 주세요.",
					maxlength:"비밀번호를 20자리 이하로 입력해 주세요",
				},

			},
			errorPlacement: function(error, element) {
				
			}
		  	
		});


	});


	function submitLoginModalForm(data){
		var fd3 = $("#fade_3").html();
		// console.log(lgSpin);
		// console.log(fd3);

		$("#fd3_spn").html(lgSpin);
		$("#fd3_spn").show();
		$("#fd3_cont").hide();

		
		$.ajax({
			url : '/login/jsp/login_process.jsp', //jsp				
			data : data,
			method: 'POST',
		}).done(function(data){
			var obj = JSON.parse(data);
			// console.log(obj);
			if(obj.result == 0 ){

				$.ajax({
					url : '/login/jsp/get_header.jsp', //jsp				
					data : data,
					method: 'GET',
				}).done(function(data){
					console.log(data);
					$("#uhead").html(data);
					$("#fade_3").popup("hide");
					$("#lgInMdl2").popup("show");	

				});
				// toastr.success('Login Successful');
				// $("#fade_3").popup("hide");
				// $("#loginModal").popup("show");
				

			}else if(obj.result == 1 ){
				
				setTimeout(function(){
					toastr.success('비밀번호가 일치하지 않습니다.');
					$("#fd3_spn").hide();
					$("#fd3_cont").show();
					$("#passwd-input").focus();

					
				}, 2000);

			}else if(obj.result == 2){

				setTimeout(function(){
					toastr.success('존재하지 않는 아이디 입니다.');
					$("#fd3_spn").hide();
					$("#fd3_cont").show();
					$("#userid-input").focus();
					
				}, 2000);

			}else{

				toastr.success('죄송합니다. 다시 시도해 주세요.');
				$("#fd3_spn").hide();
				$("#fd3_cont").show();
			}
		});
		
	}




</script>
