<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="dao.UserDao" %>
<%@ page import="java.text.DecimalFormat" %>


	<%
	boolean checkSession=false;
	String SITEID=null; 
	String UID=null;
	String NICK=null;
	String UCLEVEL=null;
	int UGRADE=0;
	int UBAL=0;
	int UPOINT=0;
	String IP=null;

	SITEID = "1";	
	
	HttpSession sess = request.getSession(false);		
	 
	// out.print(sess);
	 
	if((String) sess.getAttribute("UID") != null){			
		checkSession = true;			
	 	UID = (String)sess.getAttribute("UID");		
		NICK  = (String)sess.getAttribute("NICK");
		UCLEVEL = (String)sess.getAttribute("UCLEVEL");
		UGRADE = (Integer)sess.getAttribute("UGRADE");
		UBAL = (Integer)sess.getAttribute("UBAL");
		UPOINT = (Integer)sess.getAttribute("UPOINT");
	}
	
	IP = request.getRemoteAddr();
	DecimalFormat dfrmt_h	= new DecimalFormat("#,###,###,###,###");	
%>



<%
String cp = request.getRequestURI();
%>

<script>
var checkSession = <%=checkSession%>;
var UID = '<%=UID%>';
var UBAL = <%=UBAL%>;
</script>

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
	.msg-notif{
		font-size: 30px;
    	padding: 5px;
   		margin-right: 10px;
   		color: #3d4142;
	}
	.msg-cont{
		position: relative;
	}
	.msg-notif-count{
		width: 15px;
	    height: 15px;
	    border-radius: 50%;
	    border: 3px solid #0c841b;
	    box-shadow: 0 0 0 2px #2d3f35, 0 0 0 3px #0c841b;
	    text-align: center;
	    position: absolute;
	    top: -44px;
	    left: 23px;
	}		

</style>



<!-- top버튼 -->
<a href="#myAnchor" class="go-top">▲</a>
<script>
	
	//console.log(location.pathname.substring(location.pathname.lastIndexOf("/") + 1);
	
	
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
			window.location = "http://m.vava21.com";
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

		if(checkSession){
			console.log('counting msgs...');
			loadMsgCount();
		}

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
				
				var cp = '<%=cp%>';				
				
				if(cp == '/sport/prematch.jsp' || cp == '/sport/livematch.jsp'){
					ISLOGIN.a = obj.uid;
				}
				

				$.ajax({
					url : '/login/jsp/get_header.jsp', //jsp				
					data : {},
					method: 'GET',
				}).done(function(data){					
				//	console.log(data);		
					var obj = JSON.parse(data);
					$("#uhead").html(obj.header);
					createPopup(obj.popup);
					$("#loginModal").html(lgMsg);	
					$("#fade_3").popup("hide");
					$('a.get-vbet-hist').parent().show();
					loadMsgCount();

					
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

	function loadMsgCount(){
		$.ajax({
			url : '/login/jsp/get_msgcount.jsp',
			data : {},
			method: 'GET',
		}).done(function(data){
			var obj = JSON.parse(data);
			var html = "";
			if(obj.count > 0){
				html  = "<span class='msg-notif-count'>"+obj.count+"</span>";
			}

			$(".msg-cont").html(html);

		});
	}

	

</script>

<div style="display:none"> <%=checkSession%></div>

<div id="wrap">
<div id="header_wrap">
	<div class="nav">
		<div class="util_wrap"></div>
        <ul class="util_left">
            <li><span class="util_time" id="sTime">00:00:00</span></li>
            <li>
                <select id="language" name="language" class="diff-select select-button">
                  <option value="0" selected>한국어</option>
                </select> 
            </li>
            <li><a href="/notice_event.jsp"><span class="util_btn">공지/이벤트</span></a></li>
            <li><a href="/about/help.jsp"><span class="util_btn">도움말</span></a></li>
            <li><a href="/match/result.jsp"><span class="util_btn">경기결과</span></a></li>
        </ul>
        <div id="uhead">
        	<% 
	        	if(checkSession){
	       	%>
			<ul class="util_right">
	        	<li class = 'hdr-money-row'>머니 <span class="util_money money_dsp"><%=dfrmt_h.format(UBAL)%></span></li>
	        	<li>포인트 <span class="util_point point_dsp"><%=dfrmt_h.format(UPOINT)%></span></li>
	            <li>
					<span class="popover-wrapper right">
						<a href="#" data-role="popover" data-target="example-popover-2"><img src="/images/select_mark.png"></a>
						<div class="popover-modal example-popover-2">
							<div class="popover-body" >
								<a href="#" data-toggle-role="close" style="position:absolute; right:20px; top:0px">×</a>
								<div class="popover-body-in">
									<span class="popover_t">보유머니</span> <span class="popover_money"><%=dfrmt_h.format(UBAL)%></span>
								</div>
								<div class="popover-body-in">
									<span class="popover_t">보유포인트</span> <span class="popover_money"><%=dfrmt_h.format(UPOINT)%></span>
								</div>
								<div class="popover-body-btn" id="user_popup_menu">
									<div class="popover-body-btn_in">
										<a href="/cash/cash.jsp" data-pg="sb4" data-tab="tab1" ><span class="popover_btn">충전신청</span></a> 
										<a href="/cash/cash.jsp"  data-pg="sb4" data-tab="tab2" ><span class="popover_btn">환전신청</span></a>
									</div>
									<div class="popover-body-btn_in">
										<a href="/cash/cash.jsp" data-pg="sb4" data-tab="tab3" ><span class="popover_btn">포인트전환</span></a> 
										<a href="/cash/cash.jsp" data-pg="sb4" data-tab="tab3"><span class="popover_btn">포인트사용내역</span></a>
									</div>
									<div class="popover-body-btn_in">
									<!--	<a href="/cash/cash.jsp" data-pg="sb4" data-tab="tab4" ><span class="popover_btn">머니전환</span></a> -->
										
										<a href="/cash/cash.jsp" data-pg="sb4" data-tab="tab6"><span class="popover_btn">머니사용내역</span></a>
										<span class="showLogoutModal popover_btn" style="color: #8a8c8d!important; cursor: pointer;">로그아웃 </span>
									</div>
								</div>
							</div>
							<script>
								$('[data-role="popover"]').popover();
								$('[data-role="popover2"]').popover({trigger: 'hover'});
							</script>
						</div>
					</span>
				</li>
			</ul>
			<% } %>
			<div class="top_wrap">
	            <div class="top" id="user-header">
	                <span class="logo"><a href="/"><img src="/images/logo.png"></a></span>
	             		<% 
	               			if(checkSession){
	      				%>
		                <ul class="top_right" id="user_menu_lst">
		                	<li><img src = "/images/level/<%=UGRADE%>.png" style="position: relative; top: -11px; left: -1px; height: 45px;"></li>
		                	<li>
            					<a href="/info/info.jsp" data-pg="sb5" data-tab="tab4" > <i class="fa fa-envelope msg-notif" aria-hidden="true"></i> </a>
            					<div class="msg-cont"></div>
            					
            				</li>
		                    <li>
								<div class="select open">
									<button type="button" class="myValue top_value"><%=NICK%></button>
									<ul class="aList top_alist">
										<li style="height:11px; width:152px; background:url(/images/select_top_bg.png) no-repeat"></li>
										<li>
											<a href="/info/info.jsp" data-pg="sb5" data-tab="tab1" >내 정보 </a>
										</li>
										<li>
											<a href="/info/info.jsp" data-pg="sb5" data-tab="tab2" >베팅내역 </a>
										</li>
										<li>
											<a href="/info/info.jsp" data-pg="sb5" data-tab="tab3" >1:1문의 </a>
										</li>
										<li>
											<a href="/info/info.jsp" data-pg="sb5" data-tab="tab4" >쪽지함 </a>
										</li>
										<li>
											<a href="#" data-pg="" data-tab="" >로그아웃 </a>
										</li> 
									</ul>
								</div>				
							</li>
							<li><a href="/cash/cash.jsp" data-pg="sb4" data-tab="tab1" class="top_btn1" >  충전신청  </a></li>
		                    <li><a href="/cash/cash.jsp" data-pg="sb4" data-tab="tab2" class="top_btn1" > 환전신청  </a></li>
							<!--<li><a href="/cash/cash.jsp" data-pg="sb4" data-tab="tab4" class="top_btn3" > 머니전환  </a></li>-->
							<li><a href="/info/info.jsp" data-pg="sb5" data-tab="tab1" ><span class="top_btn2">내정보</span></a></li>
		                </ul>
	               	<% } else{  %>
						<ul class="top_right">
							<form id="login_header">
								<li><input id="userid-header-input" type="text" class="input_style01" name="userid" placeholder="아이디"><img class="login-img-validator" data-tab="tab1" id="userid-img" src="/images/input_mark.png"></li>
								<!-- input_blue 인풋활성화 -->
			                    <li>
			                    	<input id="passwd-header-input" type="password" class="input_style01" name="passwd" placeholder="비밀번호" style="width: 158px;"><img class="login-img-validator" data-tab="tab2" id="passwd-img" src="/images/input_mark.png">
			                    </li>
			                     <li><div class="input_warning login-warn" id="login-header-warn" >조건에 맞는 아이디를 입력해주세요.</div></li>
			                    <!-- input_red 인풋조건미충족 -->
			                    <li>
			                    	<input type="submit" class="top_btn1" id="lginHderBtn" value="로그인" >
			                    </li>
			                    <li><span class="top_btn2 fade_1_open" >회원가입</span></li>
		                    </form>
						</ul>

	               	<% }%>

	            </div>
	        </div>
        </div>
       	
        <div class="nav_wrap">
			<div class="stroke">
				<ul>
					<li><a href="/sport/livematch.jsp?m=<%=System.currentTimeMillis()%>"><%if(cp.equals("/sport/livematch.jsp")){%><span style="color:00afed"><%}%> 실시간</span></a></li>
					<li><a href="/sport/prematch.jsp?p=<%=System.currentTimeMillis()%>"><%if(cp.equals("/sport/prematch.jsp")){%><span style="color:00afed"><%}%>스포츠</a></li>
					<li><a href="/virtual/vgaming.jsp"><%if(cp.equals("/virtual/vgaming.jsp")){%><span style="color:00afed"><%}%>가상게임</a></li>
					<li><a href="/casino/casino.jsp"><%if(cp.equals("/casino/casino.jsp")){%><span style="color:00afed"><%}%>카지노</a></li>
					<li><a href="/minigame/list.jsp"><%if(cp.equals("/minigame/list.jsp")){%><span style="color:00afed"><%}%>미니게임</a></li>
				</ul>
			</div>
        </div>
	</div>
</div><!-- header_wrap -->


<div class="hidden" id="tb_redirect">
	<form action="/tab_route.jsp" method="post" accept-charset="utf-8" id="ftb">
		<input type="hidden" name="tb" value="">
		<input type="hidden" name="pge" value="">
	</form>	
</div>
<!-- login success modal -->
<div id="loginModal" class="bg_mask_pop2">
	<div class="bg_mask_pop_title">
		<span class="popup_logo"><img src="/images/popup_logo.png"></span>
		<span class="popup_close closeloginModalBtn"><img src="/images/popup_close.png"></span>
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
			<a href="/"><span class="btn3">확인</span></a>
		</div>
	</div>
</div>

<!-- logout modal -->
<div id="logoutModal" class="bg_mask_pop2">
	<div class="bg_mask_pop_title">
		<span class="popup_logo"><img src="/images/popup_logo.png"></span>
		<span class="popup_close closeLogoutBtn"><img src="/images/popup_close.png"></span>
	</div>
	<div class="bg_mask_pop2_in">
		<div class="pop_icon_center">
			<img src="/images/check_icon.png">
		</div>
		<div class="pop_text">
			IBET25를 찾아 주셔서 감사합니다.<br>
			로그아웃 하시겠습니까?<br>			
		</div>
		<div class="btn_wrap">
			<a href="/login/jsp/logout_process.jsp"><span class="btn3 logOutBn ">확인</span></a>
			<a href="" class="closeLogoutBtn"><span class="btn3">취소</span></a>			
		</div>
	</div>
</div>

<!-- show invalid user -->
<div id="user_invalid_modal" class="bg_mask_pop2">
	<div class="bg_mask_pop_title">
		<span class="popup_logo"><img src="/images/popup_logo.png"></span>
		<span  class="popup_close uIM_close"><img src="/images/popup_close.png"></span>
	</div>
	<div class="bg_mask_pop2_in">
		<div class="pop_icon_center">
			<img src="/images/exclamation_icon.png">
		</div>
		<div class="pop_text">
			사용자가 다른 PC나 모바일로 접속하여 로그 아웃 되었습니다. 
		</div>
		<div class="btn_wrap">
			<a href="/login/jsp/logout_process.jsp"><span class="btn3 logOutBn ">확인</span></a>
			<!-- <a href="" class="closeLogoutBtn"><span class="btn3">취소</span></a>			 -->
		</div>
	</div>
</div>



<!-- jsp include -->
<jsp:include page="/login/login.jsp" />
<jsp:include page="/login/register.jsp" />
<jsp:include page="/casino/game-pop.jsp" />

