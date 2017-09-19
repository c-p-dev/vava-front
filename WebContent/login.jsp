<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- login -->
<div id="fade_3" class="bg_mask_pop3">
	<div class="bg_mask_pop_title">
		<span class="popup_logo"><img src="images/popup_logo.png"></span>
		<span class="popup_close fade_3_close"><img src="images/popup_close.png"></span>
	</div>
	<div class="bg_mask_pop3_in">
		<form id="login_modal_form">
			<p class="pop_text_title">멤버로그인</p>
			<table  width="100%" cellpadding="0" cellspacing="0" class="popup_table01">
				<tr>
					<td width="370"><input class="input_style02 login_input" id="userid-input" name="userid" placeholder="Id" placeholder="아이디"></td>
					<!-- <td><img class="login-img-validator" id="userid-img" src="images/input_mark2.jpg"></td> -->
				</tr>
				<tr>
					<td width="370"><input class="input_style02 login_input" id="passwd-input" name="passwd" type="password"  placeholder="Password" placeholder="패스워드"></td>
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

		$("#login_modal_form").on("submit",function(e){
			e.preventDefault();
			var data = $(this).serializeJSON();
			submitLoginModalForm(data);
			
		});

		$('#fade_3').popup({
	      	transition: 'all 0.3s',
	      	scrolllock: true,
	      	onclose:function(){
	    		$("#login_modal_form")[0].reset();
	    		$('.input_warning').hide();
	    	}
	    });	


	});


	function submitLoginModalForm(data){
		if(loginValid()){
			$.ajax({
				url : '${baseUrl}process/login_process.jsp', //jsp				
				data : data,
				method: 'POST',
			}).done(function(data){
				$('#login_modal_form input').css("border-color","#2e3032");
				if(data == 0 ){
					$("#login_modal_form .login-warn").html("Login Successful").show();
					location.reload();
				}else if(data == 1 ){
					$("#login_modal_form .login-warn").html("Incorrect Password").show();
					$("#passwd-input").focus();
				}else if(data == 2){
					$("#login_modal_form .login-warn").html("Unknown User Id").show();
					$("#userid-input").focus();
				}
			});
		}
	}

	function loginValid(){
		var valid = false;
		var useridTxt = $.trim($("#userid-input").val());
		var passwordTxt = $.trim($("#passwd-input").val());
		$("#login_modal_form .login-warn").hide();
		$('#login_modal_form input').css("border-color","#2e3032");

		if(useridTxt == "" || useridTxt == null){
			$("#login_modal_form .login-warn").html("User Id is required").show();
			$("#userid-input").css("border-color","#d50000").focus();
		}
		else if(passwordTxt == "" || passwordTxt == null){
			$("#login_modal_form .login-warn").html("Password is required").show();
			$("#passwd-input").css("border-color","#d50000").focus();
		}
		else if((useridTxt == "" || useridTxt == null) && ((passwordTxt == "" || passwordTxt == null))) {
			$("#login_modal_form .login-warn").html("User Id and Password is required").show();
			$("#userid-input").css("border-color","#d50000").focus();
		}else{
			valid = true;
		}
		return valid;
	}

</script>