<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.vavasoft.bean.UserBean, net.vavasoft.dao.UserDao, java.text.DecimalFormat"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%
	String url = request.getRequestURL().toString(); 
	String baseUrl = url.substring(0, url.length() - request.getRequestURI().length()) + request.getContextPath() + "/";
	DecimalFormat dfrmt				= new DecimalFormat("#,###,###,###,###.00");
%>
<base href="<%=baseUrl%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>무제 문서</title>
<meta name="viewport" content="width=1400,minimum-scale=0,maximum-scale=5,target-densitydpi=device-dpi">
<script src="http://code.jquery.com/jquery-1.12.1.min.js"></script><!--공통-->
<script type="text/javascript" src="/js/header.js" charset="utf-8"></script><!-- header -->
<script type="text/javascript" src="/js/select.js" charset="utf-8"></script><!-- util_select -->
<script type="text/javascript" src="/js/my_select.js"></script><!-- 내정보,스포츠,실시간,경기결과 select -->
<script type="text/javascript" src="/js/visual_slider.js"></script><!-- VisualBanner, CasinoBanner -->
<script type="text/javascript" src="/js/script.js"></script><!-- VisualBanner, CasinoBanner -->
<script type="text/javascript" src="/js/multislider.js"></script><!-- contents_slider -->
<script type="text/javascript" src="/js/tabulous.js"></script><!-- MainTab -->
<script type="text/javascript" src="/js/accordion.js"></script><!-- sub_아코디언 -->
<script type="text/javascript" src="/js/sub_tab.js"></script><!-- sub_tab -->
<script type="text/javascript" src="/js/jquery-popover.js"></script><!-- point_popup -->
<script type="text/javascript" src="/js/popup.js"></script><!-- popup -->
<script type="text/javascript" src="/js/left_menu.js"></script><!-- left_menu -->
<script type="text/javascript" src="/js/gallery.js"></script><!-- 갤러리게시판 view 팝업 -->
<script type="text/javascript" src="/js/showid.js"></script><!-- 달력 -->
<script type="text/javascript" src="/js/sports_acc.js"></script><!-- 스포츠아코디언, 베팅내역 아코디언 -->
<script type="text/javascript" src="/js/vertical_tab.js"></script><!-- 세로탭 -->
<script type="text/javascript" src="/js/over.js"></script><!-- 말풍선 -->
<script type="text/javascript" src="/js/over_script.js"></script><!-- 말풍선 -->
<script type="text/javascript" src="/js/table.js"></script><!-- main_table_slide -->
<script type="text/javascript" src="/js/gateway.js"></script><!-- gateway -->
<script type="text/javascript" src="/js/img_hover.js"></script><!-- casino_hover -->
<script type="text/javascript" src="/js/text_slide.js"></script><!-- text_slide -->
<script type="text/javascript" src="/js/switch.js"></script><!-- switch -->

<script type="text/javascript" src="/js/jquery.validate.js"></script> 
<script type="text/javascript" src="/js/jqueryRemote.js"></script> 
<script type="text/javascript" src="/js/additional-methods.js"></script>
<script type="text/javascript" src="/js/jquery.serializejson.js"></script><!-- json serializer -->


<link href="/css/nice-select.css" rel="stylesheet" type="text/css"><!-- select -->
<script type="text/javascript" src="/js/jquery.nice-select.js"></script><!-- select -->

<link href="/css/common.css" rel="stylesheet" type="text/css"><!--공통-->
<link href="/css/layout.css" rel="stylesheet" type="text/css"><!--공통-->
<link href="/css/main.css" rel="stylesheet" type="text/css"><!-- main -->
<link href="/css/sub.css" rel="stylesheet" type="text/css"><!-- sub -->
<link href="/css/game.css" rel="stylesheet" type="text/css"><!-- game -->
<link href="/css/gateway.css" rel="stylesheet" type="text/css"><!-- gateway -->
<link href="/css/common2.css" rel="stylesheet" type="text/css"><!--공통-->
<link href="/css/point_tab.css" rel="stylesheet" type="text/css"><!--공통-->

</head>
<style>
	#toast-container.toast-top-full-width > div, #toast-container.toast-bottom-full-width > div {
		width: 30%!important;
		text-align: center;
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

</style>

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

	$(document).ready(function(){

		$('#loginModal').popup({
	      	transition: 'all 0.3s',
	      	scrolllock: true,
	      	onclose:function(){
	    		$("#login_header")[0].reset();
	    		$('.input_warning').hide();
	    		location.reload();
	    	}
	    });

	    $('#logoutModal').popup({
	      	transition: 'all 0.3s',
	      	scrolllock: true,
	    });	

		$("#login_header").on("submit", function(e){
			e.preventDefault();
			var data = $(this).serializeJSON();
			submitLoginHeader(data);
		});

		$(".closeLogoutBtn").on("click",function(e){
			e.preventDefault();
			$("#logoutModal").popup("hide");
		});

		$("#showLogoutModal").on("click",function(e){
			$("#logoutModal").popup("show");
		});

		$(".closeloginModalBtn").on("click",function(e){
			e.preventDefault();
			$("#loginModal").popup("hide");
		});

		$("#passwd-header-input").on("focus",function(){
			$(this).addClass("password");
		});

		$("#passwd-header-input").on("blur",function(){
			if($(this).val() == ""){
				$(this).removeClass("password");	
			}
		});

	});

	function submitLoginHeader(data){
		if(loginheaderValid()){
			$.ajax({
				url : '${baseUrl}process/login_process.jsp',
				data : data,
				method: 'POST',
			}).done(function(data){
				$("#login-header-warn").hide();
				$('#login_header input').css("border-color","#505455");
				console.log(data);
				if(data == 0 ){
					$("#login-header-warn").html("Login Successful").show();
					$("#loginModal").popup("show");
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


</script>
<%
	boolean checkSession = false;
	UserDao user_db			= new UserDao();
	UserBean user_data		= (UserBean)session.getAttribute("currentSessionUser");
	UserBean currentUser 	= user_data;
	if(session.getAttribute("currentSessionUser") != null) {
		currentUser 		= user_db.getUserByUserId(user_data.getUserid());
		checkSession = true;
	}
%>
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
            <li><a href="/notice/sub02.jsp"><span class="util_btn">공지/이벤트</span></a></li>
            <li><a href="/help/sub03.jsp"><span class="util_btn">도움말</span></a></li>
            <li><a href="/match/sub06.jsp"><span class="util_btn">경기결과</span></a></li>
        </ul>
        <% 
        	if(checkSession){
        %>
		<ul class="util_right">
			<li>머니 <span class="util_money money_dsp"><%=dfrmt.format(currentUser.getMoney())%></span></li>
            <li>포인트 <span class="util_point"><%=currentUser.getPoint()%></span></li>
            <li>
				<span class="popover-wrapper right">
					<a href="#" data-role="popover" data-target="example-popover-2"><img src="/images/select_mark.png"></a>
					<div class="popover-modal example-popover-2">
						<div class="popover-body">
							<a href="#" data-toggle-role="close" style="position:absolute; right:20px; top:0px">×</a>
							<div class="popover-body-in">
								<!-- <span class="popover_t">보유머니</span> <span class="popover_money">10,000,000</span> -->
								<span class="popover_t">보유머니</span> <span class="popover_money"><%=currentUser.getMoney()%></span>

							</div>
							<div class="popover-body-in">
								<!-- <span class="popover_t">보유포인트</span> <span class="popover_money">100,000</span> -->
								<span class="popover_t">보유포인트</span> <span class="popover_money"><%=currentUser.getPoint()%></span>

							</div>
							<div class="popover-body-btn">
								<div class="popover-body-btn_in"><a href="#"><span class="popover_btn">충전신청</span></a> <a href="#"><span class="popover_btn">환전신청</span></a></div>
								<div class="popover-body-btn_in"><a href="#"><span class="popover_btn">포인트전환</span></a> <a href="#"><span class="popover_btn">포인트사용내역</span></a></div>
								<div class="popover-body-btn_in"><a href="#"><span class="popover_btn">머니전환</span></a> <a href="#"><span class="popover_btn">머니사용내역</span></a></div>
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
            <div class="top">
                <span class="logo"><a href="/"><img src="/images/logo.png"></a></span>
             		<% 
               			if(checkSession){
      				%>
	                <ul class="top_right">
	                    <li>
							<div class="select open">
								<button type="button" class="myValue top_value">LV.3   <%=currentUser.getNick()%></button>
								<ul class="aList top_alist">
									<li style="height:11px; width:152px; background:url(/images/select_top_bg.png) no-repeat"></li>
									<li><a>내 정보 <span class="select_arrow"> > </span></a></li>
									<li><a>베팅내역 <span class="select_arrow"> > </span></a></li>
									<li><a>1:1문의 <span class="select_arrow"> > </span></a></li>
									<li><a>쪽지함 <span class="select_arrow"> > </span></a></li>
									<!-- signout -->
									<li><span id="showLogoutModal" >로그아웃 </span> </li> 
								</ul>
							</div>				
						</li>
						<li><a href="/app/sub04.jsp"><span class="top_btn1">충전신청</span></a></li>
	                    <li><a href="/app/sub04.jsp"><span class="top_btn1">환전신청</span></a></li>
						<li><a href="/app/sub04.jsp"><span class="top_btn3">머니전환</span></a></li>
						<li><a href="/info/sub05.jsp"><span class="top_btn2">내정보</span></a></li>
	                </ul>
               	<% } else{  %>
					<ul class="top_right">
						<form id="login_header">
							<li><input id="userid-header-input" type="text" class="input_style01" name="userid" placeholder="ID"><img class="login-img-validator" id="userid-img" src="images/input_mark.png"></li>
							<!-- input_blue 인풋활성화 -->
		                    <li><input id="passwd-header-input" type="password" class="input_style01" name="passwd" placeholder="PW"><img class="login-img-validator" id="passwd-img" src="images/input_mark.png"></li>
		                     <li><div class="input_warning login-warn" id="login-header-warn" >조건에 맞는 아이디를 입력해주세요.</div></li>
		                    <!-- input_red 인풋조건미충족 -->
		                    <li>
		                    	<input type="submit" class="top_btn1" value="로그인" >
		                    </li>
		                    <li><span class="top_btn2 fade_1_open" >회원가입</span></li>

	                    </form>

	                    <div class="error" style="position: inherit;margin-top: 29px;">
	                    	<!-- <div class="input_warning login-warn" id="login-header-warn" >조건에 맞는 아이디를 입력해주세요.</div> -->
	                    </div>
					</ul>

               	<% }%>

            </div>
        </div>
        <div class="nav_wrap">
			<div class="stroke">
				<ul>
					<li><a href="/realtime/bet01.jsp">실시간</a></li>
					<li><a href="/sports/bet02.jsp">스포츠</a></li>
					<li><a href="/virtual/bet03.jsp">가상게임</a></li>
					<li><a href="/casino/bet04.jsp">카지노</a></li>
					<li><a href="/racing/bet05.jsp">경마</a></li>
				</ul>
			</div>
        </div>
	</div>
</div><!-- header_wrap -->

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
			<a href="${baeUrl}"><span class="btn3">확인</span></a>
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
			<img src="/images/exclamation_icon.png">
		</div>
		<div class="pop_text">
			로그인 성공!<br>
			IBET25에 오신것을 환영합니다. <br>
			IBET25에서 다양한 베팅의 세계를 마음껏 경험하세요!<br>
		</div>
		<div class="btn_wrap">
			<a href="" class="closeLogoutBtn"><span class="btn3">취소</span></a>
			<a href="/process/logout_process.jsp"><span class="btn3">확인</span></a>
		</div>
	</div>
</div>


<!-- jsp include -->
<jsp:include page="login.jsp" />
<jsp:include page="register.jsp" />
<jsp:include page="game-pop.jsp" />
