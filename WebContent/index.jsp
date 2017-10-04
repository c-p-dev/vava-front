<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />
<jsp:useBean id="bean" class="net.vavasoft.bean.UserBean" />
<%
	boolean checkSession = false;
	// UserBean currentUser = (UserBean) session.getAttribute("currentSessionUser");
	bean = (net.vavasoft.bean.UserBean) session.getAttribute("currentSessionUser");
	if(session.getAttribute("currentSessionUser") != null){
		checkSession = true;
		out.print(bean.getNick());  
	}
%>
<script src="js/video.js"> </script>
<!-- header_wrap -->
<div id="contents_wrap">
	<div class="contents">
    	<div class="contents_in_m20">
			<div class="main_visual">
				<div id="jssor_1" style="position:relative;width:930px;height:225px;overflow:hidden;visibility:hidden;">
					<div data-u="slides" style="cursor:default;position:relative;top:0px;left:0px;width:930px;height:225px;overflow:hidden;">
						<div>
							<a class='<%=(!checkSession) ? "fade_1_open" : ""  %>' href="#fade_1"><img src="/images/visual001.jpg"/></a> 
						</div>
						<div>
							<a class='<%=(!checkSession) ? "fade_1_open" : ""  %>' href="#fade_1"><img src="/images/visual001.jpg"/></a>
						</div>
						<div>
							<a class='<%=(!checkSession) ? "fade_1_open" : ""  %>' href="#fade_1"><img src="/images/visual001.jpg"/></a>
						</div>
					</div>
					<!-- Bullet Navigator -->
					<div data-u="navigator" class="jssorb051" style="position:absolute;bottom:14px;right:12px;" data-autocenter="1" data-scale="0.5" data-scale-bottom="0.75">
						<div data-u="prototype" class="i" style="width:18px;height:18px;">
							<svg viewbox="0 0 16000 16000" style="position:absolute;top:0;left:0;width:100%;height:100%;">
								<circle class="b" cx="8000" cy="8000" r="5800"></circle>
							</svg>
						</div>
					</div>
				</div>
				<script type="text/javascript">jssor_1_slider_init();</script>
			</div>
			<div class="video_wrap" id="random_player">
			</div>
		</div>
        <div class="contents_in_m20">
        	<div class="main_title_1">인기베팅경기</div>
			<div id="third" class="carouseller"> 
				<a href="javascript:void(0)" class="carouseller__left"> <img src="/images/arrow_left.png"> </a> 
				<a href="javascript:void(0)" class="carouseller__right"> <img src="/images/arrow_right.png"> </a>
				<div class="carouseller__wrap"> 
					<div class="carouseller__list">
						<div class="car__4">
							<a href="#">
								<div class="main_bet_time">
									<p class="main_bet_time_icon"><img src="/images/bet_icon.png"></p>
									<p class="main_bet_time_text">2017년00월00일<br>00:00</p>
								</div>
								<div class="main_bet_game">
									<div class="main_bet_name">
										<img src="/images/main_bet_name01.jpg">
										<div class="main_bet_name_text">
											<span>레알마드리드</span><br><span>FC 바르셀로나123456</span>
										</div>
									</div>
									<span class="main_bet_btn">베팅하기</span>
								</div>
							</a>
						</div>
						<div class="car__4">
							<a href="#">
								<div class="main_bet_time">
									<p class="main_bet_time_icon"><img src="/images/bet_icon.png"></p>
									<p class="main_bet_time_text">2017년00월00일<br>00:00</p>
								</div>
								<div class="main_bet_game">
									<div class="main_bet_name">
										<img src="/images/main_bet_name02.jpg">
										<div class="main_bet_name_text">
											<span>레알마드리드</span><br><span>FC 바르셀로나123456</span>
										</div>
									</div>
									<span class="main_bet_btn">베팅하기</span>
								</div>
							</a>
						</div>
						<div class="car__4">
							<a href="#">
								<div class="main_bet_time">
									<p class="main_bet_time_icon"><img src="/images/bet_icon.png"></p>
									<p class="main_bet_time_text">2017년00월00일<br>00:00</p>
								</div>
								<div class="main_bet_game">
									<div class="main_bet_name">
										<img src="/images/main_bet_name03.jpg">
										<div class="main_bet_name_text">
											<span>레알마드리드</span><br><span>FC 바르셀로나123456</span>
										</div>
										
									</div>
									<span class="main_bet_btn">베팅하기</span>
								</div>
							</a>
						</div>
						<div class="car__4">
							<a href="#">
								<div class="main_bet_time">
									<p class="main_bet_time_icon"><img src="/images/bet_icon.png"></p>
									<p class="main_bet_time_text">2017년00월00일<br>00:00</p>
								</div>
								<div class="main_bet_game">
									<div class="main_bet_name">
										<img src="/images/main_bet_name04.jpg">
										<div class="main_bet_name_text">
											<span>레알마드리드</span><br><span>FC 바르셀로나123456</span>
										</div>
									</div>
									<span class="main_bet_btn">베팅하기</span>
								</div>
							</a>
						</div>
						<div class="car__4">
							<a href="#">
								<div class="main_bet_time">
									<p class="main_bet_time_icon"><img src="/images/bet_icon.png"></p>
									<p class="main_bet_time_text">2017년00월00일<br>00:00</p>
								</div>
								<div class="main_bet_game">
									<div class="main_bet_name">
										<img src="/images/main_bet_name05.jpg">
										<div class="main_bet_name_text">
											<span>레알마드리드</span><br><span>FC 바르셀로나123456</span>
										</div>
									</div>
									<span class="main_bet_btn">베팅하기</span>
								</div>
							</a>
						</div>
						<div class="car__4">
							<a href="#">
								<div class="main_bet_time">
									<p class="main_bet_time_icon"><img src="/images/bet_icon.png"></p>
									<p class="main_bet_time_text">2017년00월00일<br>00:00</p>
								</div>
								<div class="main_bet_game">
									<div class="main_bet_name">
										<img src="/images/main_bet_name06.jpg">
										<div class="main_bet_name_text">
											<span>레알마드리드</span><br><span>FC 바르셀로나123456</span>
										</div>
									</div>
									<span class="main_bet_btn">베팅하기</span>
								</div>
							</a>
						</div>
						<script type="text/javascript">
							$(function() {
								$('#third').carouseller({ 
									scrollSpeed: 500,
									autoScrollDelay: 6000,
									easing: 'linear'
								});
							});
						</script>
					</div>
				</div>
			</div>
		</div>

        <div class="contents_in_m20">
			<div class="main_board_wrap">
				<div class="main_title_2">실시간 환전현황</div>
				<div class="main_board">
					<table width="100%" cellpadding="0" cellspacing="0" class="myTable">
						<tbody>
							<tr>
								<td>
									<table width="100%" cellpadding="0" cellspacing="0" class="board_table_1">
										<tr>
											<td class="board_time">2017년00월00일 00:00</td>
											<td class="board_name">*****fdsaf</td>
											<td class="board_money">10,000,000</td>
										</tr>
									</table>									
								</td>
							</tr>
							<tr>
								<td>
									<table width="100%" cellpadding="0" cellspacing="0" class="board_table_1">
										<tr>
											<td class="board_time">2017년00월00일 00:00</td>
											<td class="board_name">*****fdsaf</td>
											<td class="board_money">10,000,000</td>
										</tr>
									</table>									
								</td>
							</tr>
							<tr>
								<td>
									<table width="100%" cellpadding="0" cellspacing="0" class="board_table_1">
										<tr>
											<td class="board_time">2017년00월00일 00:00</td>
											<td class="board_name">*****fdsaf</td>
											<td class="board_money">10,000,000</td>
										</tr>
									</table>									
								</td>
							</tr>
							<tr>
								<td>
									<table width="100%" cellpadding="0" cellspacing="0" class="board_table_1">
										<tr>
											<td class="board_time">2017년00월00일 00:00</td>
											<td class="board_name">*****fdsaf</td>
											<td class="board_money">10,000,000</td>
										</tr>
									</table>									
								</td>
							</tr>
							<tr>
								<td>
									<table width="100%" cellpadding="0" cellspacing="0" class="board_table_1">
										<tr>
											<td class="board_time">2017년00월00일 00:00</td>
											<td class="board_name">*****fdsaf</td>
											<td class="board_money">10,000,000</td>
										</tr>
									</table>									
								</td>
							</tr>
							<tr>
								<td>
									<table width="100%" cellpadding="0" cellspacing="0" class="board_table_1">
										<tr>
											<td class="board_time">2017년00월00일 00:00</td>
											<td class="board_name">*****fdsaf</td>
											<td class="board_money">10,000,000</td>
										</tr>
									</table>									
								</td>
							</tr>
							<tr>
								<td>
									<table width="100%" cellpadding="0" cellspacing="0" class="board_table_1">
										<tr>
											<td class="board_time">2017년00월00일 00:00</td>
											<td class="board_name">*****fdsaf</td>
											<td class="board_money">10,000,000</td>
										</tr>
									</table>									
								</td>
							</tr>
							<tr>
								<td>
									<table width="100%" cellpadding="0" cellspacing="0" class="board_table_1">
										<tr>
											<td class="board_time">2017년00월00일 00:00</td>
											<td class="board_name">*****fdsaf</td>
											<td class="board_money">10,000,000</td>
										</tr>
									</table>									
								</td>
							</tr>
							<tr>
								<td>
									<table width="100%" cellpadding="0" cellspacing="0" class="board_table_1">
										<tr>
											<td class="board_time">2017년00월00일 00:00</td>
											<td class="board_name">*****fdsaf</td>
											<td class="board_money">10,000,000</td>
										</tr>
									</table>									
								</td>
							</tr>
							<tr>
								<td>
									<table width="100%" cellpadding="0" cellspacing="0" class="board_table_1">
										<tr>
											<td class="board_time">2017년00월00일 00:00</td>
											<td class="board_name">*****fdsaf</td>
											<td class="board_money">10,000,000</td>
										</tr>
									</table>									
								</td>
							</tr>
						</tbody>
					</table>

				
					
				</div>
			</div>
			<div class="main_board_wrap">
				<!-- tab -->
				<script type="text/javascript">
					$(document).ready(function($) {
						 $('#tabs').tabulous({
							effect: 'scale'
						});
						 $('#tabs2').tabulous({
							effect: 'scale'
						});
					});
				</script>
				<div class="main_title_2">실시간 경기목록</div>
				<div id="tabs">
					<ul>
						<li><a href="#tabs-1" title=""><img src="/images/main_icon_game01.png"> 축구</a></li>
						<li><a href="#tabs-2" title=""><img src="/images/main_icon_game02.png"> 농구</a></li>
						<li><a href="#tabs-3" title=""><img src="/images/main_icon_game03.png"> 야구</a></li>
						<li><a href="#tabs-4" title=""><img src="/images/main_icon_game04.png"> 배구</a></li>
						<li><a href="#tabs-5" title=""><img src="/images/main_icon_game05.png"> 하키</a></li>
						<li><a href="#tabs-6" title=""><img src="/images/main_icon_game06.png"> 테니스</a></li>
					</ul>
					<div id="tabs_container">
						<div id="tabs-1">
							<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
								<tr>
									<td width="13%" class="board_table_2_t">시간</td>
									<td width="22%" class="board_table_2_t">홈</td>
									<td width="22%" class="board_table_2_t">원정</td>
									<td width="12%" class="board_table_2_t">승</td>
									<td width="12%" class="board_table_2_t">무</td>
									<td width="12%" class="board_table_2_t">패</td>
									<td width="7%" class="board_table_2_t"></td>
								</tr>
							</table>
							<a href="#">	
								<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
									<tr>
										<td class="board_bet_time">00:00</td>
										<td class="board_bet_home">바르셀로나</td>
										<td class="board_bet_expedition">레알마드리드</td>
										<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
										<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_score">+1</td>
									</tr>
								</table>
							</a>
							<a href="#">	
								<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
									<tr>
										<td class="board_bet_time">00:00</td>
										<td class="board_bet_home">바르셀로나</td>
										<td class="board_bet_expedition">레알마드리드</td>
										<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
										<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_score">+1</td>
									</tr>
								</table>
							</a>
							<a href="#">	
								<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
									<tr>
										<td class="board_bet_time">00:00</td>
										<td class="board_bet_home">바르셀로나</td>
										<td class="board_bet_expedition">레알마드리드</td>
										<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
										<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_score">+1</td>
									</tr>
								</table>
							</a>
							<a href="#">	
								<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
									<tr>
										<td class="board_bet_time">00:00</td>
										<td class="board_bet_home">바르셀로나</td>
										<td class="board_bet_expedition">레알마드리드</td>
										<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
										<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_score">+1</td>
									</tr>
								</table>
							</a>
						</div>
						<div id="tabs-2">
							<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
								<tr>
									<td width="13%" class="board_table_2_t">시간</td>
									<td width="22%" class="board_table_2_t">홈</td>
									<td width="22%" class="board_table_2_t">원정</td>
									<td width="12%" class="board_table_2_t">승</td>
									<td width="12%" class="board_table_2_t">무</td>
									<td width="12%" class="board_table_2_t">패</td>
									<td width="7%" class="board_table_2_t"></td>
								</tr>
							</table>
							<a href="#">	
								<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
									<tr>
										<td class="board_bet_time">00:00</td>
										<td class="board_bet_home">바르셀로나</td>
										<td class="board_bet_expedition">레알마드리드</td>
										<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
										<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_score">+1</td>
									</tr>
								</table>
							</a>
							<a href="#">	
								<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
									<tr>
										<td class="board_bet_time">00:00</td>
										<td class="board_bet_home">바르셀로나</td>
										<td class="board_bet_expedition">레알마드리드</td>
										<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
										<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_score">+1</td>
									</tr>
								</table>
							</a>
							<a href="#">	
								<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
									<tr>
										<td class="board_bet_time">00:00</td>
										<td class="board_bet_home">바르셀로나</td>
										<td class="board_bet_expedition">레알마드리드</td>
										<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
										<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_score">+1</td>
									</tr>
								</table>
							</a>
							<a href="#">	
								<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
									<tr>
										<td class="board_bet_time">00:00</td>
										<td class="board_bet_home">바르셀로나</td>
										<td class="board_bet_expedition">레알마드리드</td>
										<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
										<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_score">+1</td>
									</tr>
								</table>
							</a>
						</div>
						<div id="tabs-3">
							<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
								<tr>
									<td width="13%" class="board_table_2_t">시간</td>
									<td width="22%" class="board_table_2_t">홈</td>
									<td width="22%" class="board_table_2_t">원정</td>
									<td width="12%" class="board_table_2_t">승</td>
									<td width="12%" class="board_table_2_t">무</td>
									<td width="12%" class="board_table_2_t">패</td>
									<td width="7%" class="board_table_2_t"></td>
								</tr>
							</table>
							<a href="#">	
								<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
									<tr>
										<td class="board_bet_time">00:00</td>
										<td class="board_bet_home">바르셀로나</td>
										<td class="board_bet_expedition">레알마드리드</td>
										<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
										<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_score">+1</td>
									</tr>
								</table>
							</a>
							<a href="#">	
								<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
									<tr>
										<td class="board_bet_time">00:00</td>
										<td class="board_bet_home">바르셀로나</td>
										<td class="board_bet_expedition">레알마드리드</td>
										<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
										<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_score">+1</td>
									</tr>
								</table>
							</a>
							<a href="#">	
								<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
									<tr>
										<td class="board_bet_time">00:00</td>
										<td class="board_bet_home">바르셀로나</td>
										<td class="board_bet_expedition">레알마드리드</td>
										<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
										<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_score">+1</td>
									</tr>
								</table>
							</a>
							<a href="#">	
								<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
									<tr>
										<td class="board_bet_time">00:00</td>
										<td class="board_bet_home">바르셀로나</td>
										<td class="board_bet_expedition">레알마드리드</td>
										<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
										<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_score">+1</td>
									</tr>
								</table>
							</a>
						</div>
						<div id="tabs-4">
							소스가 길어져 생략합니다.
						</div>
						<div id="tabs-5">
							소스가 길어져 생략합니다.
						</div>
						<div id="tabs-6">
							소스가 길어져 생략합니다.
						</div>
					</div>
				</div>
			</div>
			<div class="main_board_wrap" style="margin:0px">
				<div class="main_title_2">
					<p style="float:left;">마감임박경기</p>
					<ul class="deadline">
						<li class="time_on"><a href="#">15분전</a></li>
						<li><a href="#">30분전</a></li>
						<li><a href="#">60분전</a></li>
					</ul>
				</div>
				<div id="tabs2">
					<ul>
						<li><a href="#tabs-1" title=""><img src="/images/main_icon_game01.png"> 축구</a></li>
						<li><a href="#tabs-2" title=""><img src="/images/main_icon_game02.png"> 농구</a></li>
						<li><a href="#tabs-3" title=""><img src="/images/main_icon_game03.png"> 야구</a></li>
						<li><a href="#tabs-4" title=""><img src="/images/main_icon_game04.png"> 배구</a></li>
						<li><a href="#tabs-5" title=""><img src="/images/main_icon_game05.png"> 하키</a></li>
						<li><a href="#tabs-6" title=""><img src="/images/main_icon_game06.png"> 테니스</a></li>
					</ul>
					<div id="tabs_container">
						<div id="tabs-1">
							<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
								<tr>
									<td width="13%" class="board_table_2_t">시간</td>
									<td width="22%" class="board_table_2_t">홈</td>
									<td width="22%" class="board_table_2_t">원정</td>
									<td width="12%" class="board_table_2_t">승</td>
									<td width="12%" class="board_table_2_t">무</td>
									<td width="12%" class="board_table_2_t">패</td>
									<td width="7%" class="board_table_2_t"></td>
								</tr>
							</table>
							<a href="#">	
								<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
									<tr>
										<td class="board_bet_time">00:00</td>
										<td class="board_bet_home">바르셀로나</td>
										<td class="board_bet_expedition">레알마드리드</td>
										<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
										<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_score">+1</td>
									</tr>
								</table>
							</a>
							<a href="#">	
								<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
									<tr>
										<td class="board_bet_time">00:00</td>
										<td class="board_bet_home">바르셀로나</td>
										<td class="board_bet_expedition">레알마드리드</td>
										<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
										<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_score">+1</td>
									</tr>
								</table>
							</a>
							<a href="#">	
								<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
									<tr>
										<td class="board_bet_time">00:00</td>
										<td class="board_bet_home">바르셀로나</td>
										<td class="board_bet_expedition">레알마드리드</td>
										<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
										<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_score">+1</td>
									</tr>
								</table>
							</a>
							<a href="#">	
								<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
									<tr>
										<td class="board_bet_time">00:00</td>
										<td class="board_bet_home">바르셀로나</td>
										<td class="board_bet_expedition">레알마드리드</td>
										<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
										<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_score">+1</td>
									</tr>
								</table>
							</a>
						</div>
						<div id="tabs-2">
							<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
								<tr>
									<td width="13%" class="board_table_2_t">시간</td>
									<td width="22%" class="board_table_2_t">홈</td>
									<td width="22%" class="board_table_2_t">원정</td>
									<td width="12%" class="board_table_2_t">승</td>
									<td width="12%" class="board_table_2_t">무</td>
									<td width="12%" class="board_table_2_t">패</td>
									<td width="7%" class="board_table_2_t"></td>
								</tr>
							</table>
							<a href="#">	
								<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
									<tr>
										<td class="board_bet_time">00:00</td>
										<td class="board_bet_home">바르셀로나</td>
										<td class="board_bet_expedition">레알마드리드</td>
										<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
										<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_score">+1</td>
									</tr>
								</table>
							</a>
							<a href="#">	
								<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
									<tr>
										<td class="board_bet_time">00:00</td>
										<td class="board_bet_home">바르셀로나</td>
										<td class="board_bet_expedition">레알마드리드</td>
										<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
										<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_score">+1</td>
									</tr>
								</table>
							</a>
							<a href="#">	
								<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
									<tr>
										<td class="board_bet_time">00:00</td>
										<td class="board_bet_home">바르셀로나</td>
										<td class="board_bet_expedition">레알마드리드</td>
										<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
										<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_score">+1</td>
									</tr>
								</table>
							</a>
							<a href="#">	
								<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
									<tr>
										<td class="board_bet_time">00:00</td>
										<td class="board_bet_home">바르셀로나</td>
										<td class="board_bet_expedition">레알마드리드</td>
										<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
										<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_score">+1</td>
									</tr>
								</table>
							</a>
						</div>
						<div id="tabs-3">
							<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
								<tr>
									<td width="13%" class="board_table_2_t">시간</td>
									<td width="22%" class="board_table_2_t">홈</td>
									<td width="22%" class="board_table_2_t">원정</td>
									<td width="12%" class="board_table_2_t">승</td>
									<td width="12%" class="board_table_2_t">무</td>
									<td width="12%" class="board_table_2_t">패</td>
									<td width="7%" class="board_table_2_t"></td>
								</tr>
							</table>
							<a href="#">	
								<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
									<tr>
										<td class="board_bet_time">00:00</td>
										<td class="board_bet_home">바르셀로나</td>
										<td class="board_bet_expedition">레알마드리드</td>
										<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
										<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_score">+1</td>
									</tr>
								</table>
							</a>
							<a href="#">	
								<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
									<tr>
										<td class="board_bet_time">00:00</td>
										<td class="board_bet_home">바르셀로나</td>
										<td class="board_bet_expedition">레알마드리드</td>
										<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
										<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_score">+1</td>
									</tr>
								</table>
							</a>
							<a href="#">	
								<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
									<tr>
										<td class="board_bet_time">00:00</td>
										<td class="board_bet_home">바르셀로나</td>
										<td class="board_bet_expedition">레알마드리드</td>
										<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
										<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_score">+1</td>
									</tr>
								</table>
							</a>
							<a href="#">	
								<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
									<tr>
										<td class="board_bet_time">00:00</td>
										<td class="board_bet_home">바르셀로나</td>
										<td class="board_bet_expedition">레알마드리드</td>
										<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
										<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
										<td class="board_bet_score">+1</td>
									</tr>
								</table>
							</a>
						</div>
						<div id="tabs-4">
							소스가 길어져 생략합니다.
						</div>
						<div id="tabs-5">
							소스가 길어져 생략합니다.
						</div>
						<div id="tabs-6">
							소스가 길어져 생략합니다.
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div><!-- main_contents -->


<jsp:include page="footer.jsp" />