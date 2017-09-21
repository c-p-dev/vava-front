<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            <li><a href="sub02.jsp"><span class="util_btn">공지/이벤트</span></a></li>
            <li><a href="sub03.jsp"><span class="util_btn">도움말</span></a></li>
            <li><a href="sub06.jsp"><span class="util_btn">경기결과</span></a></li>
        </ul>
		<div class="top_wrap">
            <div class="top">
                <span class="logo"><a href="index.jsp"><img src="images/logo.png"></a></span>
                <ul class="top_right">
                    <li><input type="text" class="input_style01 input_blue" placeholder="ID"><a href="sub01.jsp"><img src="images/input_mark.png"></a></li><!-- input_blue 인풋활성화 -->
                    <li><input type="text" class="input_style01 input_red" placeholder="PW"><a href="sub01.jsp"><img src="images/input_mark.png"></a></li><!-- input_red 인풋조건미충족 -->
                    <li><a href="#"><span class="top_btn1">로그인</span></a></li>
                    <li><a href="#"><span class="top_btn2">회원가입</span></a></li>
                </ul>
            </div>
        </div>
        <div class="nav_wrap">
			<div class="stroke">
				<ul>
					<li><a href="realtime/bet01.jsp">실시간</a></li>
					<li><a href="sports/bet02.jsp">스포츠</a></li>
					<li><a href="virtual/bet03.jsp">가상게임</a></li>
					<li><a href="casino/bet04.jsp">카지노</a></li>
					<li><a href="racing/bet05.jsp">경마</a></li>
				</ul>
			</div>
        </div>
	</div>
</div><!-- header_wrap -->

<!--회원가입-->

<script>
$(document).ready(function () {

    $('#fade_1').popup({
      transition: 'all 0.3s',
      scrolllock: true
    });

	 $('#fade_2').popup({
      transition: 'all 0.3s',
      scrolllock: true
    });

	 $('#fade_3').popup({
      transition: 'all 0.3s',
      scrolllock: true
    });

	 $('#fade_4').popup({
      transition: 'all 0.3s',
      scrolllock: true
    });

	 $('#fade_5').popup({
      transition: 'all 0.3s',
      scrolllock: true
    });

	 $('#fade_6').popup({
      transition: 'all 0.3s',
      scrolllock: true
    });

	 $('#fade_7').popup({
      transition: 'all 0.3s',
      scrolllock: true
    });

	 $('#fade_8').popup({
      transition: 'all 0.3s',
      scrolllock: true
    });
	 
	 $('#fade_9').popup({
      transition: 'all 0.3s',
      scrolllock: true
    });
});
</script>


<div id="fade_1" class="bg_mask_pop1">
	<div class="bg_mask_pop_title">
		<span class="popup_logo"><img src="images/popup_logo.png"></span>
		<span class="popup_close fade_1_close"><img src="images/popup_close.png"></span>
	</div>
	<div class="bg_mask_pop1_in">
		<p class="pop_text_title">회원가입</p>
		<div class="pop_text">IBET25에 오신것을 환영합니다.<br>회원가입을 하시면 보다 폭넓은 서비스 이용이 가능합니다.</div>
		<table  width="100%" cellpadding="0" cellspacing="0" class="popup_table01">
			<tr>
				<td>
					<table  cellpadding="0" cellspacing="0" class="popup_table01_1">
						<tr>
							<td width="370"><input class="input_style02"  placeholder="아이디"></td>
							<td><a href="#"><img src="images/input_mark3.jpg"></a></td>
						</tr>
						<tr>
							<td colspan="2"><div class="input_warning">조건에 맞는 아이디를 입력해주세요.</div></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<table  cellpadding="0" cellspacing="0" class="popup_table01_1">
						<tr>
							<td width="370"><input class="input_style02"  placeholder="아이디"></td>
							<td><a href="#"><img src="images/input_mark3.jpg"></a></td>
						</tr>
						<tr>
							<td colspan="2"><div class="input_warning"> 만족 조건 충족 여부</div></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<table  cellpadding="0" cellspacing="0" class="popup_table01_1">
						<tr>
							<td width="370"><input class="input_style02"  placeholder="아이디"></td>
							<td><a href="#"><img src="images/input_mark3.jpg"></a></td>
						</tr>
						<tr>
							<td colspan="2"><div class="input_warning"> 만족 조건 충족 여부</div></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<table  cellpadding="0" cellspacing="0" class="popup_table01_1">
						<tr>
							<td width="370"><input class="input_style02"  placeholder="아이디"></td>
							<td><a href="#"><img src="images/input_mark3.jpg"></a></td>
						</tr>
						<tr>
							<td colspan="2"><div class="input_warning">만족 조건 충족 여부</div></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<table  width="100%" cellpadding="0" cellspacing="0" class="popup_table01_1">
						<tr>
							<td width="80" align="left" style="padding:0 5px 0 0"><input class="input_style02"  placeholder="예금주"></td>
							<td width="100" align="left" style="padding:0 5px 0 0">
								<select class="input_style02">
									<option>은행명</option>
								</select>
							</td>
							<td align="left" style="padding:0 5px 0 0"><input class="input_style02"  placeholder="계좌번호입력(-없이 입력)"></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<table  width="100%" cellpadding="0" cellspacing="0" class="popup_table01_1">
						<tr>
							<td width="80" align="left" style="padding:0 5px 0 0"><input class="input_style02"  placeholder="예금주"></td>
							<td width="100" align="left" style="padding:0 5px 0 0">
								<select class="input_style02">
									<option>+82(한국)</option>
								</select>
							</td>
							<td width="145" align="left" style="padding:0 5px 0 0"><input class="input_style02"  placeholder="휴대폰번호"></td>
							<td><a href="#"><span class="btn5">인증</span></a></td>
						</tr>
					</table>
					<div class="input_warning">입력하신 번호로 인증번호가 발송되었습니다.</div>
				</td>
			</tr>
			<tr>
				<td>
					<table  width="100%" cellpadding="0" cellspacing="0" class="popup_table01_1">
						<tr>
							<td width="335" align="left" style="padding:0 5px 0 0"><input class="input_style02"  placeholder="인증번호"></td>

							<td><a href="#"><span class="btn5">확인</span></a></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td><input class="input_style02"  placeholder="추천인아이디"></td>
			</tr>
			<tr>
				<td><input class="input_style02"  placeholder="추천인코드"></td>
			</tr>
		</table>
		<div class="text_center">모든 항목은 필수 입력 사항 입니다.</div>
		<div class="btn_wrap"><a href="#"><span class="btn3c">회원가입</span></a></div>
		<div class="text_center">이미 회원이라면? 로그인 후 이용해 주시기 바랍니다.</div>
		<div class="btn_wrap"><a href="#"><span class="btn3">로그인</span></a></div>
	</div>
</div>

<!--회원가입완료-->
<div id="fade_2" class="bg_mask_pop2">
	<div class="bg_mask_pop_title">
		<span class="popup_logo"><img src="images/popup_logo.png"></span>
		<span class="popup_close fade_2_close"><img src="images/popup_close.png"></span>
	</div>
	<div class="bg_mask_pop2_in">
		<div class="pop_icon_center">
			<img src="images/check_icon.png">
		</div>
		<div class="pop_text">
			회원 가입 완료!<br>
			IBET25에 오신것을 환영합니다. <br>
			IBET25에서 다양한 베팅의 세계를 마음껏 경험하세요!<br>
		</div>
		<div class="btn_wrap">
			<a href="#"><span class="btn3c">충전하기</span></a> <a href="#"><span class="btn3">확인</span></a>
		</div>
	</div>
</div>

<!--로그인-->
<div id="fade_3" class="bg_mask_pop3">
	<div class="bg_mask_pop_title">
		<span class="popup_logo"><img src="images/popup_logo.png"></span>
		<span class="popup_close fade_3_close"><img src="images/popup_close.png"></span>
	</div>
	<div class="bg_mask_pop3_in">
		<p class="pop_text_title">멤버로그인</p>
		<table  width="100%" cellpadding="0" cellspacing="0" class="popup_table01">
			<tr>
				<td width="370"><input class="input_style02"  placeholder="아이디"></td>
				<td><a href="sub01.jsp"><img src="images/input_mark2.jpg"></a></td>
			</tr>
			<tr>
				<td width="370"><input class="input_style02"  placeholder="패스워드"></td>
				<td><a href="sub01.jsp"><img src="images/input_mark2.jpg"></a></td>
			</tr>
			<tr>
				<td style="padding:10px 0 0 0" colspan="2"></td>
			</tr>
		</table>
		<div class="btn_wrap"><a href="#"><span class="btn3c">로그인</span></a></div>
		<div class="text_center">아직 회원이 아니시라면 회원가입 후 이용해 주시기 바랍니다.</div>
		<div class="btn_wrap"><a href="#"><span class="btn3">회원가입</span></a></div>
	</div>
</div>


<!--안내-->
<div id="fade_4" class="bg_mask_pop4">
	<div class="bg_mask_pop_title">
		<span class="popup_logo"><img src="images/popup_logo.png"></span>
		<span class="popup_close fade_4_close"><img src="images/popup_close.png"></span>
	</div>
	<div class="bg_mask_pop4_in">
		<p class="pop_text_title">안내</p>
		<div class="pop_icon_center">
			<img src="images/exclamation_icon.png">
		</div>
		<div class="text_center">
			<p class="font_007">확인하지 않은 1:1 문의가 <span class="font_004">1</span>건 있습니다.<br>
			확인을 누르면 해당 페이지로 이동합니다.</p>
		</div>
		<div class="btn_wrap">
			<a href="#"><span class="btn3c">확인</span></a> 
		</div>
	</div>
</div>


<!-- 1:1문의하기 -->
<div id="fade_5" class="bg_mask_pop5">
	<div class="bg_mask_pop_title">
		<span class="popup_logo"><img src="images/popup_logo.png"></span>
		<span class="popup_close fade_5_close"><img src="images/popup_close.png"></span>
	</div>
	
	<div class="bg_mask_pop5_in">
		<p class="pop_text_title">1:1문의하기</p>
		<div class="inquiry_wrap">
			<div class="inquiry">
				<div class="inquiry_user">
					<span class="user_tag"><img src="images/user_tag.jpg"></span>
					<div class="inquiry_text">
					안녕하세요 안녕하세요 안녕하세요안녕하세요 안녕하세요 안녕하세요안녕하세요 안녕하세요 안녕하세요안녕하세요 안녕하세요 안녕하세요안녕하세요 안녕하세요 안녕하세요안녕하세요 안녕하세요 안녕하세요안녕하세요 안녕하세요 안녕하세요안녕하세요 안녕하세요 안녕하세요안녕하세요 안녕하세요 안녕하세요안녕하세요 안녕하세요 안녕하세요안녕하세요 안녕하세요 안녕하세요안녕하세요 안녕하세요 안녕하세요
					</div>
					<div class="user_date">2017-00-00 00:00:00</div>
				</div>
			</div>
			<div class="inquiry">
				<div class="inquiry_admin">
					<span class="admin_tag"><img src="images/admin_tag.jpg"></span>
					<div class="inquiry_text">
					안녕하세요 안녕하세요 안녕하세요안녕하세요 
					</div>
					<div class="admin_date">2017-00-00 00:00:00</div>
				</div>
			</div>
			<div class="inquiry">
				<div class="inquiry_user">
					<span class="user_tag"><img src="images/user_tag.jpg"></span>
					<div class="inquiry_text">
					물어볼께있어요
					</div>
					<div class="user_date">2017-00-00 00:00:00</div>
				</div>
			</div>
			<div class="inquiry">
				<div class="inquiry_admin">
					<span class="admin_tag"><img src="images/admin_tag.jpg"></span>
					<div class="inquiry_text">
					말씀하세요
					</div>
					<div class="admin_date">2017-00-00 00:00:00</div>
				</div>
			</div>
		</div>
		<div class="inquiry_select_wrap">
			<table  width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="172" style="padding:0 10px 0 0">
						<select class="inquiry_select">
							<option>분류</option>
							<option>분류</option>
						</select>
					</td>
					<td width="588" style="padding:0 10px 0 0"><input class="inquiry_input"></td>
					<td><a href="#"><span class="btn5">전송</span></a></td>
				</tr>
			</table>
		</div>
		<div class="acc_btn_wrap">
			<a href="#"><span class="btn3c">확인</span></a> 
		</div>
	</div>
</div>


<!-- 쪽지함 -->
<div id="fade_6" class="bg_mask_pop6">
	<div class="bg_mask_pop_title">
		<span class="popup_logo"><img src="images/popup_logo.png"></span>
		<span class="popup_close fade_6_close"><img src="images/popup_close.png"></span>
	</div>
	<div class="bg_mask_pop6_in">
		<p class="pop_text_title">쪽지함</p>
		<table  width="100%" cellpadding="0" cellspacing="0" class="memo_table_title">
			<tr>
				<td width="55%">제목</td>
				<td>보낸이</td>
				<td width="15%">수신일시</td>
				<td width="15%">확인일시</td>
			</tr>
		</table>
		<ul class="popup_accordion">
			<li>
				<a>
					<table width="100%" cellpadding="0" cellspacing="0" class="meno_table">
						<tr>
							<td  width="55%" class="meno_table_left">제목입니다.</td>
							<td class="list_table_center">홍길동</td>
							<td  width="15%" class="meno_table_center">07.07.17</td>
							<td  width="15%" class="meno_table_center">07.07.17</td>
						</tr>
					</table>
				</a>
				<div>
					<table width="100%" cellpadding="0" cellspacing="0" class="meno_table_in">
						<tr>
							<td>제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.니다. 제목입니다.제목입니다. 제목입니다. 제목</td>
						</tr>
					</table>
				</div>
			</li>
			<li>
				<a>
					<table width="100%" cellpadding="0" cellspacing="0" class="meno_table">
						<tr>
							<td  width="55%" class="meno_table_left">제목입니다.</td>
							<td class="list_table_center">홍길동</td>
							<td  width="15%" class="meno_table_center">07.07.17</td>
							<td  width="15%" class="meno_table_center">07.07.17</td>
						</tr>
					</table>
				</a>
				<div>
					<table width="100%" cellpadding="0" cellspacing="0" class="meno_table_in">
						<tr>
							<td>제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제</td>
						</tr>
					</table>
				</div>
			</li>
			<li>
				<a>
					<table width="100%" cellpadding="0" cellspacing="0" class="meno_table">
						<tr>
							<td  width="55%" class="meno_table_left">제목입니다.</td>
							<td class="list_table_center">홍길동</td>
							<td  width="15%" class="meno_table_center">07.07.17</td>
							<td  width="15%" class="meno_table_center">07.07.17</td>
						</tr>
					</table>
				</a>
				<div>
					<table width="100%" cellpadding="0" cellspacing="0" class="meno_table_in">
						<tr>
							<td>제목입니다. </td>
						</tr>
					</table>
				</div>
			</li>
		</ul>
		<script>
			(function($) {
				$('.popup_accordion > li:eq(0) a').addClass('active').next().slideDown();

				$('.popup_accordion a').click(function(j) {
					var dropDown = $(this).closest('li').find('div');

					$(this).closest('.popup_accordion').find('div').not(dropDown).slideUp();

					if ($(this).hasClass('active')) {
						$(this).removeClass('active');
					} else {
						$(this).closest('.popup_accordion').find('a.active').removeClass('active');
						$(this).addClass('active');
					}

					dropDown.stop(false, true).slideToggle();

					j.preventDefault();
				});
			})(jQuery);
		</script>
		<div class="left_btn_wrap"><a href="#"><span class="btn7">확인</span></a> <a href="#"><span class="btn8">삭제</span></a></div>
		<div class="btn_wrap_m">
			<a href="#"><div class="page"> >> </div></a> <a href="#"><span class="page"> > </span></a> <a href="#"><div class="page_on">1</div></a> <a href="#"><div class="page">2</div></a> <a href="#"><div class="page">3</div></a> <a href="#"><div class="page">4</div></a> <a href="#"><div class="page">5</div></a> <a href="#"><div class="page"> > </div></a> <a href="#"><div class="page"> >> </div></a>
		</div>
	</div>
</div>

<!--전용계좌확인-->
<div id="fade_7" class="bg_mask_pop7">
	<div class="bg_mask_pop_title">
		<span class="popup_logo"><img src="images/popup_logo.png"></span>
		<span class="popup_close fade_7_close"><img src="images/popup_close.png"></span>
	</div>
	<div class="bg_mask_pop7_in">
		<p class="pop_text_title">안내</p>
		<div class="pop_icon_center">
			<img src="images/bank_1.png">
		</div>
		<div class="text_center">
			<p class="pop_text">12345678<br><br>
			예금주 : 홍길동</p>
		</div>
		<div class="btn_wrap">
			<a href="#"><span class="btn3c">전용계좌확인</span></a> 
		</div>
	</div>
</div>



<!--강제팝업-->
<div id="fade_8" class="bg_mask_pop8">
	<div class="bg_mask_pop8_in">
		강제팝업입니다.
	</div>
	<div class="fade_8_text_wrap">
		<span class="fade_8_text"><input type="checkbox">오늘하루 보지않기</span>
		<span class="popup_close_2 fade_8_close"><img src="images/car_close.png"></span>
	</div>
</div>

<div id="fade_9" class="bg_mask_pop9">
	<div class="bg_mask_pop_title">
		<span class="popup_logo"><img src="images/popup_logo.png"></span>
		<span class="popup_close fade_9_close"><img src="images/popup_close.png"></span>
	</div>
	
	<div class="bg_mask_pop9_in">
		<p class="pop_text_title">1:1문의하기</p>
		<div class="inquiry_wrap">
			<iframe id = 'game-pop-frame' src = '' width = "100%" height = "650px" allowFullscreen = 1></iframe>
		</div>
	</div>
</div>


<div id="contents_wrap">
	<div class="contents">
		<a class="fade_1_open" href="#fade_1"><span class="btn3c">회원가입</span></a> 
		<a class="fade_2_open" href="#fade_2"><span class="btn3c">회원가입완료</span></a> 
		<a class="fade_3_open" href="#fade_3"><span class="btn3c">멤버로그인</span></a>
		<a class="fade_4_open" href="#fade_4"><span class="btn3c">안내</span></a> 
		<a class="fade_5_open" href="#fade_5"><span class="btn3c">1:1문의하기</span></a> 
		<a class="fade_6_open" href="#fade_6"><span class="btn3c">쪽지함</span></a>
		<a class="fade_7_open" href="#fade_7"><span class="btn3c">전용계좌확인</span></a>
		<a class="fade_8_open" href="#fade_8"><span class="btn3c">강제팝업</span></a>
		<a class="fade_9_open" href="#fade_9"><span class="btn3c">Game Popup</span></a>
	</div>
</div>


<div id="footer_wrap">
	<div class="f_site_map_wrap">
    	<div class="f_site_map">
			<div class="f_site_map_left_wrap">
				<div class="f_site_map_left">
					<div class="f_site_map_left_t">
						ABOUT
					</div>
					<ul class="f_site_map_left_list">
						<li><a href="#">베팅 규정</a></li>
						<li><a href="#">공지/이벤트</a></li>
						<li><a href="#">이용약관</a></li>
					</ul>
				</div>
				<div class="f_site_map_left">
					<div class="f_site_map_left_t">
						HELP
					</div>
					<ul class="f_site_map_left_list">
						<li><a href="#">베팅 가이드</a></li>
						<li><a href="#">게임 가이드</a></li>
						<li><a href="#">자주 묻는 질문</a></li>
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
				<ul>
					<li><img src="images/partner_1.jpg"></li>
					<li><img src="images/partner_2.jpg"></li>
					<li><img src="images/partner_3.jpg"></li>
					<li><img src="images/partner_4.jpg"></li>
				</ul>
				<ul>
					<li><img src="images/partner_1.jpg"></li>
					<li><img src="images/partner_2.jpg"></li>
					<li><img src="images/partner_3.jpg"></li>
					<li><img src="images/partner_4.jpg"></li>
				</ul>
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