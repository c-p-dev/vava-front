<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" />
<jsp:useBean id="bean" class="net.vavasoft.bean.UserBean" />
<%@page import="net.vavasoft.dao.GameDao, net.vavasoft.bean.GameBean, java.util.*"%>

<%
	boolean checkSession = false;
	// UserBean currentUser = (UserBean) session.getAttribute("currentSessionUser");
	bean = (net.vavasoft.bean.UserBean) session.getAttribute("currentSessionUser");
	if(session.getAttribute("currentSessionUser") != null){
		checkSession = true;
		out.print(bean.getNick());  
	}
	
	GameDao game_dao			= new GameDao();
	List<GameBean> game_list	= game_dao.getAllGames();
%>

<div id="contents_wrap">
	<div class="contents">
		<div class="casino_visual_wrap">
			<div id="jssor_1" style="position:relative;width:1330px;height:270px;overflow:hidden;visibility:hidden;">
				<div data-u="slides" style="cursor:default;position:relative;top:0px;left:0px;width:1330px;height:270px;overflow:hidden;">
					<div>
						<img src="images/casino_visual001.jpg" />
					</div>
					<div>
						<img src="images/casino_visual001.jpg" />
					</div>
					<div>
						<img src="images/casino_visual001.jpg" />
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
				<script type="text/javascript">jssor_1_slider_init();</script>
			</div>
		</div>
		<div class="casino_left">
			<div class="left_search_wrap">
				<div class="left_search">
					<input class="input_style05" placeholder="게임찾기"><a href="#"><img src="images/search_icon.jpg"></a>
				</div>
			</div>
			<ul class="l_tabs">
				<li><a href="#l-tab1">전체</a></li>
				<li><a href="#l-tab2">타이샨</a></li>
				<li><a href="#l-tab3">에볼루션 카지노</a></li>
				<li><a href="#l-tab4">벳컨스트럭트</a></li>
				<li><a href="#l-tab4">오리엔탈 게임</a></li>
			</ul>
		</div>

		<div class="casino_right">
			<div id="l-tab1" class="left_tab_con">
				<ul class="tabs">
					<li><a href="#tab1">전체</a></li>
					<li><a href="#tab2">드래곤타이거</a></li>
					<li><a href="#tab3">바카라</a></li>
					<li><a href="#tab4">룰렛</a></li>
					<li><a href="#tab5">식보</a></li>
					<li><a href="#tab6">블랙잭</a></li>
				</ul>
				<div class="tab_container">
					<div id="tab1" class="tab_content">
						<div class="casino_board_wrap">
							<ul class="casino_board_list">
							
								<%
									for (int i = 0; i < game_list.size(); i++) {
										GameBean cur_game = game_list.get(i);
								%>
								<li>
									<a href="#" data-gm_provdr = '<%=cur_game.getGame_provider()%>'>
										<div class="img casino_board_img">
											<img src="images/<%=cur_game.getGame_img()%>" style = 'width: 320px; height: 195px;'>
											<div class="overlay">
												 <span class="expand">Play now</span>
											</div>
										</div>
									</a>
									<div class="casino_board_text">
										<p class="casino_name"><%=cur_game.getGame_name()%></p>
									</div>
								</li>
								<%
									}
								%>
								
							</ul>
							<script>
								$(document).ready(function(){
								if (Modernizr.touch) {
									// show the close overlay button
									$(".close-overlay").removeClass("hidden");
									// handle the adding of hover class when clicked
									$(".img").click(function(e){
										if (!$(this).hasClass("hover")) {
											$(this).addClass("hover");
										}
									});
									// handle the closing of the overlay
									$(".close-overlay").click(function(e){
										e.preventDefault();
										e.stopPropagation();
										if ($(this).closest(".img").hasClass("hover")) {
											$(this).closest(".img").removeClass("hover");
										}
									});
								} else {
									// handle the mouseenter functionality
									$(".img").mouseenter(function(){
										$(this).addClass("hover");
									})
									// handle the mouseleave functionality
									.mouseleave(function(){
										$(this).removeClass("hover");
									});
								}
							});
							</script>
						</div>
						
						<div class="btn_wrap"><a href="#"><div class="page"> >> </div></a> <a href="#"><span class="page"> > </span></a> <a href="#"><div class="page_on">1</div></a> <a href="#"><div class="page">2</div></a> <a href="#"><div class="page">3</div></a> <a href="#"><div class="page">4</div></a> <a href="#"><div class="page">5</div></a> <a href="#"><div class="page"> > </div></a> <a href="#"><div class="page"> >> </div></a></div>
					</div>
					<div id="tab2" class="tab_content">
						2
					</div>
					<div id="tab3" class="tab_content">
						3
					</div>
					<div id="tab4" class="tab_content">
						4
					</div>
					<div id="tab5" class="tab_content">
						5
					</div>
					<div id="tab6" class="tab_content">
						6
					</div>
				</div>
			</div>
			<div id="l-tab2" class="left_tab_con">
				업체명
			</div>
			<div id="l-tab3" class="left_tab_con">
				업체명
			</div>
			<div id="l-tab4" class="left_tab_con">
				업체명
			</div>
			<div id="l-tab5" class="left_tab_con">
				업체명
			</div>
		</div>
	</div>
</div><!-- contents -->

<script>
	$(document).ready(function () {
		$(".casino_board_list li a").on("click",function(e) {
			
			var session 	= "<%=checkSession%>";
			var gm_provdr	= $(this).data('gm_provdr');
			
			if ((!session)
			|| (false == session)
			|| ("false" == session)) {
				$('#fade_3').popup('show');
			}
			else {
				$('#fade_9').popup('show');
				
				$.get("TegServlet?method=1&gm_provdr="+gm_provdr, function(srv_resp) {
					
					if ("" != srv_resp) {
						$('#game-pop-frame').attr('src', srv_resp);
						
						if (1 == gm_provdr) {
							$('.money_dsp').text('0.00');
						}
					}
					else {
						$('#gm-pop-errmsg').html("An error occured. Please reload the game.");
					}
				});
			}

			return false;
		})
	});
</script>

<jsp:include page="../footer.jsp" />