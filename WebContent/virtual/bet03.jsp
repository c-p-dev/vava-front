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
	List<GameBean> vgame_list	= game_dao.getVirtualGames();
	List<GameBean> igame_list	= game_dao.getRacingGames();
%>

<div id="contents_wrap">
	<div class="contents">
		<div class="casino_visual_wrap">
			<div id="jssor_1" style="position:relative;width:750px;height:250px;overflow:hidden;visibility:hidden;">
				<div data-u="slides" style="cursor:default;position:relative;top:0px;left:0px;width:723px;height:250px;overflow:hidden;">
					<div>
						<img src="/images/spincube/racing-banner.jpg" style = 'width: 100%; height: 100%;'/>
					</div>
					<div>
						<img src="/images/spincube/racing-banner3.jpg" style = 'width: 100%; height: 100%;'/>
					</div>
					<div>
						<img src="/images/spincube/racing-banner4.png" style = 'width: 100%; height: 100%;'/>
					</div>
					<div>
						<img src="/images/spincube/racing-banner5.jpg" style = 'width: 100%; height: 100%;'/>
					</div>
					<div>
						<img src="/images/spincube/racing-banner6.jpg" style = 'width: 100%; height: 100%;'/>
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
		
		<div class="casino_right" style = 'width: 100%;'>
			<div id="l-tab1" class="left_tab_con">
				
				<div class="tab_container">
					<div id="tab1" class="tab_content">
						<div class="casino_board_wrap">
							<span>  </span>
							<ul class="racing_board_list">
								
								<%
									for (int i = 0; i < igame_list.size(); i++) {
										GameBean cur_igame = igame_list.get(i);
								%>
								<li>
									<a href="#" data-gm-provdr = '<%=cur_igame.getGame_provider()%>' data-link-dsp = '<%=cur_igame.getLink_dsp()%>'>
										<div class="img racing_board_img">
											<img src="/images/<%=cur_igame.getGame_img()%>" style = 'width: 290px; height: 195px;'>
											<div class="overlay">
												 <span class="expand">Play now</span>
											</div>
										</div>
									</a>
									<div class="casino_board_text">
										<p class="casino_name"><%=cur_igame.getGame_name()%></p>
									</div>
								</li>
								<%
									}
								%>
							
							</ul>
						</div>
						
						<div class="casino_board_wrap">
							<span> </span>
							<ul class="racing_board_list">
							
								<%
									for (int i = 0; i < vgame_list.size(); i++) {
										GameBean cur_vgame = vgame_list.get(i);
								%>
								<li>
									<a href="#" data-gm-provdr = '<%=cur_vgame.getGame_provider()%>' data-link-dsp = '<%=cur_vgame.getLink_dsp()%>'>
										<div class="img racing_board_img">
											<img src="/images/<%=cur_vgame.getGame_img()%>" style = 'width: 290px; height: 195px;'>
											<div class="overlay">
												 <span class="expand">Play now</span>
											</div>
										</div>
									</a>
									<div class="casino_board_text">
										<p class="casino_name"><%=cur_vgame.getGame_name()%></p>
									</div>
								</li>
								<%
									}
								%>
								
							</ul>
							
						</div>
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
					
				</div>
			</div>

		</div>
	</div>
</div><!-- contents -->

<script>
	$(document).ready(function () {
		$(".racing_board_list li a").on("click",function(e) {
			
			var session 	= "<%=checkSession%>";
			var gm_provdr	= $(this).data('gm-provdr');
			var lnk_dsp		= $(this).data('link-dsp');
			
			if ((!session)
			|| (false == session)
			|| ("false" == session)) {
				$('#fade_3').popup('show');
			}
			else {
				$('.hdr-money-row').hide();
				$('#fade_9').popup('show');
				
				$.get("TegServlet?method=1&gm_provdr="+gm_provdr+"&lnk_dsp="+lnk_dsp, function(srv_resp) {
					
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