<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.vavasoft.bean.UserBean"%>
<%! String baseUrl = "http://103.1.249.79:9090/"; %>

<!DOCTYPE html>
<html lang="ko">
<head>
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

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.serializeJSON/2.8.1/jquery.serializejson.js"></script><!-- json serializer -->

<link href="<%=baseUrl%>css/common.css" rel="stylesheet" type="text/css"><!--공통-->
<link href="<%=baseUrl%>css/layout.css" rel="stylesheet" type="text/css"><!--공통-->
<link href="<%=baseUrl%>css/main.css" rel="stylesheet" type="text/css"><!-- main -->
<link href="<%=baseUrl%>css/sub.css" rel="stylesheet" type="text/css"><!-- sub -->
<link href="<%=baseUrl%>css/game.css" rel="stylesheet" type="text/css"><!-- game -->
<link href="<%=baseUrl%>css/gateway.css" rel="stylesheet" type="text/css"><!-- gateway -->
</head>



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
									<li><a href="http://localhost:8080/ibet23/UserLogoutServlets" >로그아웃 </a></li> 
								</ul>
							</div>				
						</li>
						<li><a href="<%=baseUrl%>app/sub04.jsp"><span class="top_btn1">충전신청</span></a></li>
	                    <li><a href="<%=baseUrl%>app/sub04.jsp"><span class="top_btn1">환전신청</span></a></li>
						<li><a href="<%=baseUrl%>app/sub04.jsp"><span class="top_btn3">머니전환</span></a></li>
						<li><a href="<%=baseUrl%>info/sub05.jsp"><span class="top_btn2">내정보</span></a></li>
	                </ul>
               	<% } else{  %>
					<div class="top_right">
						<button class="top_btn1" id="signinBtn" style="border:none!important;">Sign In</button>
					</div>
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