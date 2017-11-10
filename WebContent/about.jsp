<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>무제 문서</title>
<meta name="viewport" content="width=1400,minimum-scale=0,maximum-scale=5,target-densitydpi=device-dpi">
<script src="http://code.jquery.com/jquery-1.12.1.min.js"></script><!--공통-->
<script type="text/javascript" src="js/header.js" charset="utf-8"></script><!-- header -->
<script type="text/javascript" src="js/select.js" charset="utf-8"></script><!-- util_select -->
<script type="text/javascript" src="js/my_select.js"></script><!-- 내정보,스포츠,실시간,경기결과 select -->
<script type="text/javascript" src="js/visual_slider.js"></script><!-- VisualBanner, CasinoBanner -->
<script type="text/javascript" src="js/script.js"></script><!-- VisualBanner, CasinoBanner -->
<script type="text/javascript" src="js/multislider.js"></script><!-- contents_slider -->
<script type="text/javascript" src="js/tabulous.js"></script><!-- MainTab -->
<script type="text/javascript" src="js/accordion.js"></script><!-- sub_아코디언 -->
<script type="text/javascript" src="js/sub_tab.js"></script><!-- sub_tab -->
<script type="text/javascript" src="js/jquery-popover.js"></script><!-- point_popup -->
<script type="text/javascript" src="js/popup.js"></script><!-- popup -->
<script type="text/javascript" src="js/left_menu.js"></script><!-- left_menu -->
<script type="text/javascript" src="js/gallery.js"></script><!-- 갤러리게시판 view 팝업 -->
<script type="text/javascript" src="js/showid.js"></script><!-- 달력 -->
<script type="text/javascript" src="js/sports_acc.js"></script><!-- 스포츠아코디언, 베팅내역 아코디언 -->
<script type="text/javascript" src="js/vertical_tab.js"></script><!-- 세로탭 -->
<script type="text/javascript" src="js/over.js"></script><!-- 말풍선 -->
<script type="text/javascript" src="js/over_script.js"></script><!-- 말풍선 -->
<script type="text/javascript" src="js/table.js"></script><!-- main_table_slide -->
<script type="text/javascript" src="js/gateway.js"></script><!-- gateway -->
<script type="text/javascript" src="js/img_hover.js"></script><!-- casino_hover -->
<script type="text/javascript" src="js/text_slide.js"></script><!-- text_slide -->
<script type="text/javascript" src="js/switch.js"></script><!-- switch -->
<link href="css/common.css" rel="stylesheet" type="text/css"><!--공통-->
<link href="css/layout.css" rel="stylesheet" type="text/css"><!--공통-->
<link href="css/main.css" rel="stylesheet" type="text/css"><!-- main -->
<link href="css/sub.css" rel="stylesheet" type="text/css"><!-- sub -->
<link href="css/game.css" rel="stylesheet" type="text/css"><!-- game -->
<link href="css/gateway.css" rel="stylesheet" type="text/css"><!-- gateway -->
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
            <li><a href="sub02.html"><span class="util_btn">공지/이벤트</span></a></li>
            <li><a href="sub03.html"><span class="util_btn">도움말</span></a></li>
            <li><a href="sub06.html"><span class="util_btn">경기결과</span></a></li>
        </ul>
		<div class="top_wrap">
            <div class="top">
                <span class="logo"><a href="index.html"><img src="images/logo.png"></a></span>
                <ul class="top_right">
                    <li><input type="text" class="input_style01 input_blue" placeholder="ID"><a href="sub01.html"><img src="images/input_mark.png"></a></li><!-- input_blue 인풋활성화 -->
                    <li><input type="text" class="input_style01 input_red" placeholder="PW"><a href="sub01.html"><img src="images/input_mark.png"></a></li><!-- input_red 인풋조건미충족 -->
                    <li><a href="#"><span class="top_btn1">로그인</span></a></li>
                    <li><a href="#"><span class="top_btn2">회원가입</span></a></li>
                </ul>
            </div>
        </div>
        <div class="nav_wrap">
			<div class="stroke">
				<ul>
					<li><a href="bet01.html">실시간</a></li>
					<li><a href="bet02.html">스포츠</a></li>
					<li><a href="bet03.html">가상게임</a></li>
					<li><a href="bet04.html">카지노</a></li>
					<li><a href="bet05.html">경마</a></li>
				</ul>
			</div>
        </div>
	</div>
</div><!-- header_wrap -->


<div id="contents_wrap">
	<div class="contents">
		<div class="sub_left">
			<ul class="l_tabs">
				<li><a href="#l-tab1">베팅 가이드</a></li>
				<li><a href="#l-tab2">게임 가이드</a></li>
				<li><a href="#l-tab3">자주 묻는 질문</a></li>
				<li><a href="#l-tab4">이용약관</a></li>
			</ul>
		</div>

		<div class="sub_right">
			<div id="l-tab1" class="left_tab_con">
				<ul class="smk_accordion">
					<li>
						<div class="acc_head"><h3>베팅내역제목</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
								<div class="container">
									<div class="demo2">
										<div class="quotes">
											<ul>
												<li>
												  <blockquote>
													123456123456123456123456123456<br><br>
													123456123456123456123456123456123456123456123456123456123456
												  </blockquote>
												</li>
												<li>
												  <blockquote>
													1234562313546546546546546<br>sfsdlfkjsdlkfjlnbsjlkjdslkjflksjflkjdslfkjlsdkjflksjldfkjsdlfkjlsdjflsdkjflskjdflkjsldfkj
												  </blockquote>
												</li>
												<li>
												  <blockquote>
													123456123456123456123456123456<br><br>
													123456123456123456123456123456123456123456123456123456123456
												  </blockquote>
												</li>
												<li>
												  <blockquote>
													1234562313546546546546546<br>sfsdlfkjsdlkfjlnbsjlkjdslkjflksjflkjdslfkjlsdkjflksjldfkjsdlfkjlsdjflsdkjflskjdflkjsldfkj
												  </blockquote>
												</li>
											</ul>
										</div>
									</div>
									<script>
										$(document).ready(function() {
										  $(document).ready(function() {
										  $('.demo2 .quotes').quovolver({
										  children : 'li',
										  transitionSpeed : 600,
										  autoPlay : false,
										  equalHeight : false,
										  navPosition : 'above',
										  navPrev     : true,
										  navNext     : true,
										  navNum      : true,
										  navText     : true,
										  navTextContent : 'Quote @a of @b'
										  });
										});
										});
									</script>
								</div>
							</div>
						</div>
					</li>
					<li>
						<div class="acc_head"><h3>베팅내역제목</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
								베팅내역내용
							</div>
						</div>
					</li>
					<li>
						<div class="acc_head"><h3>베팅내역제목</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
								베팅내역내용
							</div>
						</div>
					</li>
					<li>
						<div class="acc_head"><h3>베팅내역제목</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
								베팅내역내용
							</div>
						</div>
					</li>
				</ul>
			</div>
			<div id="l-tab2" class="left_tab_con">
				<ul class="smk_accordion">
					<li>
						<div class="acc_head"><h3>베팅내역제목</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
								베팅내역내용
							</div>
						</div>
					</li>
					<li>
						<div class="acc_head"><h3>베팅내역제목</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
								베팅내역내용
							</div>
						</div>
					</li>
					<li>
						<div class="acc_head"><h3>베팅내역제목</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
								베팅내역내용
							</div>
						</div>
					</li>
					<li>
						<div class="acc_head"><h3>베팅내역제목</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
								베팅내역내용
							</div>
						</div>
					</li>
				</ul>
			</div>
			<div id="l-tab3" class="left_tab_con">
				<ul class="smk_accordion">
					<li>
						<div class="acc_head"><h3>베팅내역제목</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
								베팅내역내용
							</div>
						</div>
					</li>
					<li>
						<div class="acc_head"><h3>베팅내역제목</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
								베팅내역내용
							</div>
						</div>
					</li>
					<li>
						<div class="acc_head"><h3>베팅내역제목</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
								베팅내역내용
							</div>
						</div>
					</li>
					<li>
						<div class="acc_head"><h3>베팅내역제목</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
								베팅내역내용
							</div>
						</div>
					</li>
				</ul>
			</div>
			<div id="l-tab4" class="left_tab_con">
				<ul class="smk_accordion">
					<li>
						<div class="acc_head"><h3>베팅내역제목</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
								베팅내역내용
							</div>
						</div>
					</li>
					<li>
						<div class="acc_head"><h3>베팅내역제목</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
								베팅내역내용
							</div>
						</div>
					</li>
					<li>
						<div class="acc_head"><h3>베팅내역제목</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
								베팅내역내용
							</div>
						</div>
					</li>
					<li>
						<div class="acc_head"><h3>베팅내역제목</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
								베팅내역내용
							</div>
						</div>
					</li>
				</ul>
			</div>


			
		</div>
	</div>
</div><!-- main_contents -->
<div id="footer_wrap">
	<div class="f_site_map_wrap">
    	<div class="f_site_map">
			<div class="f_site_map_left_wrap">
				<div class="f_site_map_left">
					<div class="f_site_map_left_t">
						ABOUT
					</div>
					<ul class="f_site_map_left_list">
						<li><a href="#">스포츠 베팅 규정(sport bet rule)</a></li>
						<li><a href="#">아이벳 규정(ibet rule)</a></li>
						<li><a href="#">공지/이벤트</a></li>
					</ul>
				</div>
				<div class="f_site_map_left">
					<div class="f_site_map_left_t">
						HELP
					</div>
					<ul class="f_site_map_left_list">
						<li><a href="#">스포츠 이용 가이드(sport guide)</a></li>
						<li><a href="#">카지노 이용 가이드(casino guide)</a></li>
						<li><a href="#">자주 묻는 질문(help_faq)</a></li>
					</ul>
				</div>
				<div class="f_site_map_left">
					<div class="f_site_map_left_t">
						GAMES
					</div>
					<ul class="f_site_map_left_list">
						<li><a href="#">스포츠북</a></li>
						<li><a href="#">가상게임</a></li>
						<li><a href="#">라이브 카지노</a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="f_site_partner_wrap">
			<div class="f_site_partner_t">
				PARTNER
			</div>
			<div class="f_site_partner">
				<img src="images/partner_1.jpg">
			</div>
		</div>
	</div>
    <div class="f_copy_wrap">
		Gambling can be addictive. Play responsibly.           www.gamblingtherapy.org & www.gamblersanonymous.org<br>
		© 2017 IBET25.COM. ALL RIGHTS RESERVED. | +18  <br>
		<img src="images/f_logo.jpg" style="margin:20px 0 0 0">
	</div>
</div>

</div><!-- wrap -->
</body>
</html>