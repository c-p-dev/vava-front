<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.vavasoft.bean.UserBean"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%
	String url = request.getRequestURL().toString(); 
	String baseUrl = url.substring(0, url.length() - request.getRequestURI().length()) + request.getContextPath() + "/";
%>
<base href="<%=baseUrl%>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>무제 문서</title>
<meta name="viewport" content="width=1400,minimum-scale=0,maximum-scale=5,target-densitydpi=device-dpi">
<script src="http://code.jquery.com/jquery-1.12.1.min.js"></script><!--공통-->
<script type="text/javascript" src="<%=baseUrl%>js/header.js" charset="utf-8"></script><!-- header -->
<script type="text/javascript" src="<%=baseUrl%>js/select.js" charset="utf-8"></script><!-- util_select -->
<script type="text/javascript" src="<%=baseUrl%>js/my_select.js"></script><!-- 내정보,스포츠,실시간,경기결과 select -->
<script type="text/javascript" src="<%=baseUrl%>js/visual_slider.js"></script><!-- VisualBanner, CasinoBanner -->
<script type="text/javascript" src="<%=baseUrl%>js/script.js"></script><!-- VisualBanner, CasinoBanner -->
<script type="text/javascript" src="<%=baseUrl%>js/multislider.js"></script><!-- contents_slider -->
<script type="text/javascript" src="<%=baseUrl%>js/tabulous.js"></script><!-- MainTab -->
<script type="text/javascript" src="<%=baseUrl%>js/accordion.js"></script><!-- sub_아코디언 -->
<script type="text/javascript" src="<%=baseUrl%>js/sub_tab.js"></script><!-- sub_tab -->
<script type="text/javascript" src="<%=baseUrl%>js/jquery-popover.js"></script><!-- point_popup -->
<script type="text/javascript" src="<%=baseUrl%>js/popup.js"></script><!-- popup -->
<script type="text/javascript" src="<%=baseUrl%>js/left_menu.js"></script><!-- left_menu -->
<script type="text/javascript" src="<%=baseUrl%>js/gallery.js"></script><!-- 갤러리게시판 view 팝업 -->
<script type="text/javascript" src="<%=baseUrl%>js/showid.js"></script><!-- 달력 -->
<script type="text/javascript" src="<%=baseUrl%>js/sports_acc.js"></script><!-- 스포츠아코디언, 베팅내역 아코디언 -->
<script type="text/javascript" src="<%=baseUrl%>js/vertical_tab.js"></script><!-- 세로탭 -->
<script type="text/javascript" src="<%=baseUrl%>js/over.js"></script><!-- 말풍선 -->
<script type="text/javascript" src="<%=baseUrl%>js/over_script.js"></script><!-- 말풍선 -->
<script type="text/javascript" src="<%=baseUrl%>js/table.js"></script><!-- main_table_slide -->
<script type="text/javascript" src="<%=baseUrl%>js/gateway.js"></script><!-- gateway -->
<script type="text/javascript" src="<%=baseUrl%>js/img_hover.js"></script><!-- casino_hover -->
<script type="text/javascript" src="<%=baseUrl%>js/text_slide.js"></script><!-- text_slide -->
<script type="text/javascript" src="<%=baseUrl%>js/switch.js"></script><!-- switch -->

<script type="text/javascript" src="<%=baseUrl%>js/jquery.validate.js"></script> 
<script type="text/javascript" src="<%=baseUrl%>js/additional-methods.js"></script>
<script type="text/javascript" src="<%=baseUrl%>js/jquery.serializejson.js"></script><!-- json serializer -->

<link href="<%=baseUrl%>css/common.css" rel="stylesheet" type="text/css"><!--공통-->
<link href="<%=baseUrl%>css/layout.css" rel="stylesheet" type="text/css"><!--공통-->
<link href="<%=baseUrl%>css/main.css" rel="stylesheet" type="text/css"><!-- main -->
<link href="<%=baseUrl%>css/sub.css" rel="stylesheet" type="text/css"><!-- sub -->
<link href="<%=baseUrl%>css/game.css" rel="stylesheet" type="text/css"><!-- game -->
<link href="<%=baseUrl%>css/gateway.css" rel="stylesheet" type="text/css"><!-- gateway -->

</head>

<style>
	.input_warning{
		display: none;
	}
	.btn3c {
	    border-radius: 5px!important;
	    border: none;
	}
	.btn3,.top_btn1 {
		border:none!important;
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
				url : '${baseUrl}process/login_process.jsp',
				data : data,
				method: 'POST',
			}).done(function(data){
				$("#login-header-warn").hide();
				$('#login_header input').css("border-color","#505455");
				console.log(data);
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


</script>
<%
	boolean checkSession = false;
	UserBean currentUser = (UserBean) session.getAttribute("currentSessionUser");
	if(session.getAttribute("currentSessionUser") != null){
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
            <li><a href="<%=baseUrl%>notice/sub02.jsp"><span class="util_btn">공지/이벤트</span></a></li>
            <li><a href="<%=baseUrl%>help/sub03.jsp"><span class="util_btn">도움말</span></a></li>
            <li><a href="<%=baseUrl%>match/sub06.jsp"><span class="util_btn">경기결과</span></a></li>
        </ul>
        <% 
        	if(checkSession){
        %>
		<ul class="util_right">
			<li>머니 <span class="util_money"><%=currentUser.getMoney()%></span></li>
            <li>포인트 <span class="util_point"><%=currentUser.getPoint()%></span></li>
            <li>
				<span class="popover-wrapper right">
					<a href="#" data-role="popover" data-target="example-popover-2"><img src="<%=baseUrl%>images/select_mark.png"></a>
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
                <span class="logo"><a href="<%=baseUrl%>"><img src="<%=baseUrl%>images/logo.png"></a></span>
             		<% 
               			if(checkSession){
      				%>
	                <ul class="top_right">
	                    <li>
							<div class="select open">
								<button type="button" class="myValue top_value">LV.3   <%=currentUser.getNick()%></button>
								<ul class="aList top_alist">
									<li style="height:11px; width:152px; background:url(<%=baseUrl%>images/select_top_bg.png) no-repeat"></li>
									<li><a>내 정보 <span class="select_arrow"> > </span></a></li>
									<li><a>베팅내역 <span class="select_arrow"> > </span></a></li>
									<li><a>1:1문의 <span class="select_arrow"> > </span></a></li>
									<li><a>쪽지함 <span class="select_arrow"> > </span></a></li>
									<!-- signout -->
									<li><a href="<%=baseUrl%>process/logout_process.jsp" >로그아웃 </a></li> 
								</ul>
							</div>				
						</li>
						<li><a href="<%=baseUrl%>app/sub04.jsp"><span class="top_btn1">충전신청</span></a></li>
	                    <li><a href="<%=baseUrl%>app/sub04.jsp"><span class="top_btn1">환전신청</span></a></li>
						<li><a href="<%=baseUrl%>app/sub04.jsp"><span class="top_btn3">머니전환</span></a></li>
						<li><a href="<%=baseUrl%>info/sub05.jsp"><span class="top_btn2">내정보</span></a></li>
	                </ul>
               	<% } else{  %>
					<ul class="top_right">
						<form id="login_header">
							<li><input id="userid-header-input" type="text" class="input_style01" name="userid" placeholder="ID"><img class="login-img-validator" id="userid-img" src="images/input_mark.png"></li>
							<!-- input_blue 인풋활성화 -->
		                    <li><input id="passwd-header-input" type="password" class="input_style01 " name="passwd" placeholder="PW"><img class="login-img-validator" id="passwd-img" src="images/input_mark.png"></li>
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
					<li><a href="<%=baseUrl%>realtime/bet01.jsp">실시간</a></li>
					<li><a href="<%=baseUrl%>sports/bet02.jsp">스포츠</a></li>
					<li><a href="<%=baseUrl%>virtual/bet03.jsp">가상게임</a></li>
					<li><a href="<%=baseUrl%>casino/bet04.jsp">카지노</a></li>
					<li><a href="<%=baseUrl%>racing/bet05.jsp">경마</a></li>
				</ul>
			</div>
        </div>
	</div>
</div><!-- header_wrap -->


<!-- jsp include -->
<jsp:include page="login.jsp" />
<jsp:include page="register.jsp" />
