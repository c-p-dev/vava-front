<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/inc/session.jsp"%>

<%
String cp = request.getRequestURI();
%>

<style>
	#toast-container.toast-top-full-width > div, #toast-container.toast-bottom-full-width > div {
		width: 30%!important;
		text-align: center;
		top: 15px;
	}
	#toast-container > .toast-success{
		background-image :none!important;

	}
	.toast-success {
	    background-color: #191a1b;
	}
	.toast-title {
    	font-weight: bold;
    	font-size: 18px;
	}
	.toast-message {
    	font-size: 16px;
	}


	.mCSB_inside>.mCSB_container {
    	margin-right: 15px!important;
	}
	.login-img-validator{
		cursor: pointer;
	}
	a.top_btn1,a.top_btn3{
		color:#fff;
	}

	.popup_modal.bg_mask_pop2{
		
	    width: 500px!important;
	    height: 600px!important;
	}


	.popup_modal .bg_mask_pop2_in{

	    width: 100%!important;
	    padding:0px!important;

	}

	.popup_modal .bg_mask_pop2_in img{
	    width: 500px!important;
    	height: 600px!important;
		
	}

</style>

<%=checkSession%>


<!-- top버튼 -->
<a href="#myAnchor" class="go-top">▲</a>
<script>
	
	//console.log(location.pathname.substring(location.pathname.lastIndexOf("/") + 1);
	
	console.log("<%=IP%>");
	console.log("<%=checkSession%>");
	console.log("<%=NICK%>");
/*Add class when scroll down*/
var lgMsg = '<div class="bg_mask_pop_title">'
	lgMsg += '	<span class="popup_logo"><img src="/images/popup_logo.png"></span>';
	lgMsg += '	<span class="popup_close closeloginModalBtn"><img src="/images/popup_close.png" class="closeloginModalBtn"></span>';
	lgMsg += '</div>';
	lgMsg += '<div class="bg_mask_pop2_in">';
	lgMsg += '	<div class="pop_icon_center">';
	lgMsg += '		<img src="/images/check_icon.png">';
	lgMsg += '	</div>';
	lgMsg += '	<div class="pop_text">';
	lgMsg += '		로그인 성공!<br>';
	lgMsg += '		IBET25에 오신것을 환영합니다. <br>';
	lgMsg += '		IBET25에서 다양한 베팅의 세계를 마음껏 경험하세요!<br>';
	lgMsg += '	</div>';
	lgMsg += '	<div class="btn_wrap">';
	lgMsg += '		<span class="btn3 closeloginModalBtn">확인</span>';
	lgMsg += '	</div>';
	lgMsg += '</div>';

var lgSpin = '<div id="spin_clive" class="sk-circle ng-scope" style="">';
	lgSpin += '<div class="sk-circle1 sk-child"></div>';
	lgSpin += '<div class="sk-circle2 sk-child"></div>';
	lgSpin += '<div class="sk-circle3 sk-child"></div>';
	lgSpin += '<div class="sk-circle4 sk-child"></div>';
	lgSpin += '<div class="sk-circle5 sk-child"></div>';
	lgSpin += '<div class="sk-circle6 sk-child"></div>';
	lgSpin += '<div class="sk-circle7 sk-child"></div>';
	lgSpin += '<div class="sk-circle8 sk-child"></div>';
	lgSpin += '<div class="sk-circle9 sk-child"></div>';
	lgSpin += '<div class="sk-circle10 sk-child"></div>';
	lgSpin += '<div class="sk-circle11 sk-child"></div>';
	lgSpin += '<div class="sk-circle12 sk-child"></div>';
	lgSpin += '</div>';



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
		console.log(navigator.userAgent);
		if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
			window.location = "http://www.vava21.com";
		}
		sTime();


		$('#loginModal').popup({
	      	transition: 'all 0.3s',
	      	// scrolllock: true,
      		escape: false,
      		blur:false,
	      	onclose:function(){
	    		// $("#login_header")[0].reset();
	    		$('.input_warning').hide();
	    		$(".popup_modal").popup("show");
	    		// location.reload();
	    		// $("#passwd-header-input").removeClass("password");
	    	}
	    });

	    $('#logoutModal').popup({
	      	transition: 'all 0.3s',
	      	// scrolllock: true,
	      	escape: false,
	      	blur:false,
	    });	

	    $('.popup_modal').popup({
	      	transition: 'all 0.3s',
	      	// scrolllock: true,
	      	escape: false,
	      	blur:false,

	    });


	    $('#user_invalid_modal').popup({
	      	transition: 'all 0.3s',
	      	escape: false,
	      	blur:false,
	      	onclose: function(){
	      		
	      		window.location = "/login/jsp/logout_process.jsp";
	      	}
	    });	

		$("body").on("submit","#login_header",function(e){
			e.preventDefault();
			toastr.clear();
			
			var validator = $( "#login_header" ).validate(); 
			var vUser = validator.element("#userid-header-input");
			var vPass = validator.element("#passwd-header-input");
			//console.log(!vUser);
			//console.log(!vPass);
			if(!vUser && !vPass){
				toastr.success("아이디와 비밀번호를 입력해 주세요.");
			}else if (vUser && !vPass){
				toastr.success("비밀번호를 입력해 주세요.");
			}else if (!vUser && vPass){
				toastr.success("아이디를 입력해 주세요.");
			}else{

				var data = $("#login_header").serializeJSON();
			    submitLoginHeader(data);
			}


	
		});


		$(".closeLogoutBtn").on("click",function(e){
			e.preventDefault();
			$("#logoutModal").popup("hide");
		});

		$("body").on("click",".showLogoutModal",function(e){
			e.preventDefault();
			$("#logoutModal").popup("show");
		});

		$("body").on("click",".closeloginModalBtn",function(e){
			e.preventDefault();
			var u = window.location.href;
			if(u.indexOf("/account/account.jsp") == -1 ){
				$("#loginModal").popup("hide");
			}else{
				location.reload();
			} 
		});

		$("body").on("focus","#passwd-header-input",function(){
			$(this).addClass("password");
		});

		$("body").on("blur","#passwd-header-input",function(){
			if($(this).val() == ""){
				$(this).removeClass("password");	
			}
		});




		toastr.options = {
			closeButton: true,
			debug: false,
			newestOnTop: false,
			progressBar: false,
			positionClass: "toast-top-full-width",
			preventDuplicates: true,
			onclick: null,
			showDuration: "3000",
			hideDuration: "1000",
			timeOut: "5000",
			extendedTimeOut: "1000",
			showEasing: "swing",
			hideEasing: "linear",
			showMethod: "fadeIn",
			hideMethod: "fadeOut",
			onHidden: function() {
				
				$('#userid-header-input').css("border-color","#505455");
				$('#passwd-header-input').css("border-color","#505455");

			}
		}

		$("body").on("click",".login-img-validator",function(){
			var tab = $(this).attr('data-tab');
			$("#ftb input[name=pge]").val("acc");
			$("#ftb input[name=tb]").val(tab);
			$("#ftb").submit();
		});

		$("body").on("click","#user_menu_lst li a",function(e){
			e.preventDefault();
			
			var tab = $(this).attr('data-tab');
			var pg = $(this).attr('data-pg');

			if(tab =="" && pg ==""){

				$("#logoutModal").popup("show");

			}else{
				
				$("#ftb input[name=pge]").val(pg);
				$("#ftb input[name=tb]").val(tab);
				$("#ftb").submit();
			
			}
		});

		$("body").on("click","#user_popup_menu div a",function(e){
			e.preventDefault();
			var tab = $(this).attr('data-tab');
			var pg = $(this).attr('data-pg');
			$("#ftb input[name=pge]").val(pg);
			$("#ftb input[name=tb]").val(tab);
			$("#ftb").submit();

		});

		$("body").on("click",".logOutBn",function(e){
			e.preventDefault();
			$("#logoutModal").html(lgSpin);
			window.location.replace("/login/jsp/logout_process.jsp");
		});

	
		$("#login_header").validate({
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
					minlength:"비밀번호를 6자리 이상 입력 해 주세요.",
					maxlength:"비밀번호를 20자리 이하로 입력 해 주세요",
				},

			},
			errorPlacement: function(error, element) {
				
			}
		  	
		});

		$("body").on("click",".popup_modal .popup_close",function(e){
			$(this).parent().parent().popup("hide");
		});

		// show invalid user
		
		$(".uIM_close").on("click",function(e){
			e.preventDefault();
			$("#user_invalid_modal").html(lgSpin);
			window.location = "/login/jsp/logout_process.jsp";
		})

	});

	function submitLoginHeader(data){
		$("#loginModal").html(lgSpin);
		$("#loginModal").popup("show");

		$.ajax({
			url : '/login/jsp/login_process.jsp',
			data : data,
			method: 'POST',
		}).done(function(data){
			var obj = JSON.parse(data);
			if(obj.result == 0 ){

				// toastr.success('Login Successful');
				// $("#loginModal").html(lgMsg);

				//cValU();

				$.ajax({
					url : '/login/jsp/get_header.jsp', //jsp				
					data : {},
					method: 'GET',
				}).done(function(data){

					var obj = JSON.parse(data);
					$("#uhead").html(obj.header);
					createPopup(obj.popup);
					$("#loginModal").html(lgMsg);	
					$("#fade_3").popup("hide");
					$('a.get-vbet-hist').parent().show();
					
				});

			}else if(obj.result == 1 ){
				
				setTimeout(function(){
					toastr.success('비밀번호가 일치하지 않습니다.');
					$("#passwd-header-input").focus();

					$("#loginModal").popup("hide");
				}, 2000);

			}else if(obj.result == 2){

				setTimeout(function(){
					toastr.success('존재하지 않는 아이디 입니다.');
					$("#userid-header-input").focus();

					$("#loginModal").popup("hide");
				}, 2000);

			}else{

				toastr.success('죄송합니다. 다시 시도해 주세요.');
				$("#loginModal").popup("hide");
			}
		});

	}

	function sTime(){

		$.ajax({
			url : '../SystemDate',
			data : {},
			method: 'GET',
		}).done(function(data){
			// console.log(data);
			var obj = JSON.parse(data);
			var t = moment(obj.t,"MMM DD, YYYY hh:mm:ss A");
			// console.log(t);
		
			var i = setInterval(function(){
		
				t.add(1, 's');
		
			    $("#sTime").html(t.format("HH:mm:ss"));
			}, 1000);

		});
	
		
	}

	function createPopup(data){
		console.log(data);
		var html = "";
		
		$.each(data,function(x,y){

			html += '<div id="popup_'+x+'" class="bg_mask_pop2 popup_modal">'
			html += '	<div class="bg_mask_pop_title">';
			html += '		<span class="popup_logo"><img src="/images/popup_logo.png"></span>';
			html += '		<span class="popup_close cMLgIn2"><img src="/images/popup_close.png"></span>';
			html += '	</div>';
			html += '	<div class="bg_mask_pop2_in" style="text-align:center;">';
			html += '		<img src="http://admin.vava21.com:88/contents/popup/'+y.img+'">';
			html += '	</div>';
			html += '</div>';

		});

		$(html).insertAfter('#logoutModal');


	}

	

</script>


