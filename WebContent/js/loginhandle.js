﻿/*Add class when scroll down*/
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
	
	$(document).ready(function(){
		$("#login_header").on("submit", function(e){
			e.preventDefault();
			var data = $(this).serializeJSON();
			data["action"] = "submit";
			submitLoginHeader(data);
		});
	});

	function submitLoginHeader(data){
		if(loginheaderValid()){
			$.ajax({
				url : '/login/login_process.jsp',
				data : data,
				method: 'POST',
			}).done(function(data){
				$("#login-header-warn").hide();
				$('#login_header input').css("border-color","#505455");
				if(data == 0 ){
					$("#login-header-warn").html("Login Successful").show();
					location.reload();
				}else if(data == 1 ){
					$("#login-header-warn").html("Incorrect Password").show();
					$("#passwd-header-input").focus();
				}else if(data == 2){
					$("#login-header-warn").html("Unknown User Id").show();
					$("#userid-header-input").focus();
				}
			});
		}
		
	}

	function loginheaderValid(){
		var valid = false;
		var useridTxt = $.trim($("#userid-header-input").val());
		var passwordTxt = $.trim($("#passwd-header-input").val());
		$("#login-header-warn").hide();
		$('#login_modal_form input').css("border-color","#2e3032");

		if(useridTxt == "" || useridTxt == null){
			$("#login-header-warn").html("User Id is required").show();
			$("#userid-header-input").css("border-color","#d50000").focus();
		}
		else if(passwordTxt == "" || passwordTxt == null){
			$("#login-header-warn").html("Password is required").show();
			$("#passwd-header-input").css("border-color","#d50000").focus();
		}
		else if((useridTxt == "" || useridTxt == null) && ((passwordTxt == "" || passwordTxt == null))) {
			$("#login-header-warn").html("User Id and Password is required").show();
			$("#userid-header-input").css("border-color","#d50000").focus();
		}else{
			valid = true;
		}
		return valid;
	}

