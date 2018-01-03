<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="dao.GameDao, bean.GameBean, java.util.*"%>

<%
	GameDao game_dao			= new GameDao();
	List<GameBean> vgame_list	= game_dao.getVirtualGames();
	List<GameBean> igame_list	= game_dao.getRacingGames();
%>



<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>iBET25(TEST WEB)</title>


<meta name="viewport" content="width=1400,minimum-scale=0,maximum-scale=5,target-densitydpi=device-dpi">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">		
<link href="/images/favicon.ico" rel="icon">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.1.min.js"></script>
<script type="text/javascript" src="/js/header.js" charset="utf-8"></script><!-- header -->
<script type="text/javascript" src="/js/select.js" charset="utf-8"></script><!-- util_select -->
<script type="text/javascript" src="/js/my_select.js"></script>
<script type="text/javascript" src="/js/visual_slider.js"></script><!-- VisualBanner, CasinoBanner -->
<script type="text/javascript" src="/js/script.js"></script><!-- VisualBanner, CasinoBanner -->
<script type="text/javascript" src="/js/multislider.js"></script><!-- contents_slider -->
<script type="text/javascript" src="/js/tabulous.js"></script><!-- MainTab -->
<script type="text/javascript" src="/js/sub_tab.js"></script><!-- sub_tab -->
<script type="text/javascript" src="/js/jquery-popover.js"></script><!-- point_popup -->
<script type="text/javascript" src="/js/popup.js"></script><!-- popup -->
<script type="text/javascript" src="/js/left_menu.js"></script><!-- left_menu -->
<script type="text/javascript" src="/js/gallery.js"></script>
<script type="text/javascript" src="/js/showid.js"></script>
<script type="text/javascript" src="/js/vertical_tab.js"></script>
<script type="text/javascript" src="/js/over.js"></script>
<script type="text/javascript" src="/js/over_script.js"></script>
<script type="text/javascript" src="/js/table.js"></script><!-- main_table_slide -->
<script type="text/javascript" src="/js/gateway.js"></script><!-- gateway -->
<script type="text/javascript" src="/js/img_hover.js"></script><!-- casino_hover -->
<script type="text/javascript" src="/js/text_slide.js"></script><!-- text_slide -->
<script type="text/javascript" src="/js/switch.js"></script><!-- switch -->
<script type="text/javascript" src="/js/sports_acc.js"></script><!-- 스포츠아코디언, 베팅내역 아코디언-->
<script type="text/javascript" src="/js/fade.js"></script><!-- switch -->
<script type="text/javascript" src="/js/jquery.serializejson.js"></script><!-- json serializer -->
<script type="text/javascript" src="/js/accordion.js"></script><!-- sub_아코디언 -->
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript" src="/js/jquery.validate.js"></script> 
<script type="text/javascript" src="/js/jquery.nice-select.js"></script><!-- select -->
<script type="text/javascript" src="/js/jqueryRemote.js"></script> 
<script type="text/javascript" src="/js/additional-methods.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/list.js/1.5.0/list.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/list.pagination.js/0.1.1/list.pagination.min.js"></script>
<script type="text/javascript" src="/js/datatables/jquery.dataTables.js"></script><!-- datatable -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.js"></script><!-- custom scrollbar -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/qtip2/3.0.3/jquery.qtip.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.js"></script><!-- moment js -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pikaday/1.6.1/pikaday.js"></script><!-- pickaday -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.js"></script>


<link href="/css/common.css" rel="stylesheet" type="text/css">
<link href="/css/layout.css" rel="stylesheet" type="text/css">
<link href="/css/main.css" rel="stylesheet" type="text/css"><!-- main -->
<link href="/css/sub.css" rel="stylesheet" type="text/css"><!-- sub -->
<link href="/css/game.css" rel="stylesheet" type="text/css"><!-- game -->
<link href="/css/gateway.css" rel="stylesheet" type="text/css"><!-- gateway -->
<link href="/css/customize.css" rel="stylesheet" type="text/css">
<link href="/css/font-awesome.css" rel="stylesheet" type="text/css">
<link href="/css/spin.css" rel="stylesheet" type="text/css">
<link href="/css/nice-select.css" rel="stylesheet" type="text/css"><!-- select -->
<link href="/css/common2.css" rel="stylesheet" type="text/css">
<link href="/css/manual.css" rel="stylesheet" type="text/css"><!--slide-->
<link href="/css/custom.css" rel="stylesheet" type="text/css"><!--공통-->
<link rel="stylesheet" href="/css/datatables.net-bs/css/bootstrap-simple.css" /> 
<link rel="stylesheet" href="/css/datatables.net-bs/css/dataTables.bootstrap.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.css" rel="stylesheet" type="text/css"><!-- toaster test  -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/qtip2/3.0.3/jquery.qtip.css" /><!-- tooltip -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/pikaday/1.6.1/css/pikaday.css" rel="stylesheet" type="text/css">
<!-- custom scrollbar test -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css" />

</head>
<body>


<%@ include file="/inc/header.jsp"%>
<style>
	#wait-warn-cntr {
		display: none;
		color: red;
    	padding: 10px;
    	font-size: 20px;
	}
</style>
<div id="contents_wrap">
	<div class="contents">
		<div class="casino_visual_wrap">
			<!-- <div id="jssor_1" style="position:relative;width:750px;height:250px;overflow:hidden;visibility:hidden;">
				<div data-u="slides" style="cursor:default;position:relative;top:0px;left:0px;width:723px;height:250px;overflow:hidden;"> -->
			<div id="jssor_1" style="position:relative;width:1330px;height:270px;overflow:hidden;visibility:hidden;">
				<div data-u="slides" style="cursor:default;position:relative;top:0px;left:0px;width:1330px;height:270px;overflow:hidden;">
					<!-- <div>
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
					</div> -->
					<div>
						<img src="/images/casino_visual001.jpg" />
					</div>
					<div>
						<img src="/images/casino_visual001.jpg" />
					</div>
					<div>
						<img src="/images/casino_visual001.jpg" />
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
		
        <div class="casino_left" style = 'padding-top: 20px;'>

			<ul class="l_tabs" id="game-cat">
				<li><a href="#l-tab1" class="get-game">전체</a></li>
				<li><a href="#l-tab3" class="get-game">가상 게임</a></li>
				<li style = 'display: none;'><a href="#l-tab4" class="get-vbet-hist">베팅내역 확인하기</a></li>
			</ul>
			
		</div>
        
        <div class = 'casino-spinner' style = 'width: 1040px; float: left; display: none;'>
	        <div id="spin_clive" class="sk-circle ng-scope" style=""> 
	        	<div class="sk-circle1 sk-child"></div>
				<div class="sk-circle2 sk-child"></div>
				<div class="sk-circle3 sk-child"></div>
				<div class="sk-circle4 sk-child"></div>
				<div class="sk-circle5 sk-child"></div>
				<div class="sk-circle6 sk-child"></div>
				<div class="sk-circle7 sk-child"></div>
				<div class="sk-circle8 sk-child"></div>
				<div class="sk-circle9 sk-child"></div>
				<div class="sk-circle10 sk-child"></div>
				<div class="sk-circle11 sk-child"></div>
				<div class="sk-circle12 sk-child"></div>
	        </div>
        </div>
        
		<div class="casino_right" style = 'display: none;'>
			<div id="l-tab1" class="left_tab_con">
				
				<div class="tab_container">
					<div id="tab1" class="tab_content">
						
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
											<img src="/images/<%=cur_vgame.getGame_img()%>" style = 'width: 320px; height: 195px;'>
											<div class="overlay">
												 <span class="expand" style = "width: 125px; font-size: 20px;">Play now</span>
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
						
					</div>
					
				</div>
			</div>
            
            <div id="l-tab3" class="left_tab_con">
				
				<div class="tab_container">
					<div id="tab1" class="tab_content">
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
											<img src="/images/<%=cur_vgame.getGame_img()%>" style = 'width: 320px; height: 195px;'>
											<div class="overlay">
												 <span class="expand" style = "width: 125px; font-size: 20px;">Play now</span>
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
					</div>
					
				</div>

			</div>
            
            <div id="l-tab4" class="left_tab_con">
				
				<div class="tab_container">
					<div id="tab1" class="tab_content" style = 'background-color:#FFFFFF;'>
						<div id = 'wait-warn-cntr'> <span id = 'wait-warn'> 데이타를 불러오고 있습니다. 잠시만 기다려 주세요.</span> </div>
						<iframe id = 'playcheck-frm' src = '' style = 'width:100%; height: 720px;'></iframe>
					</div>
					
				</div>
				
			</div>
		</div>
	</div>
</div><!-- contents -->

<script>
	$(document).ready(function () {
		$('#fade_3').popup({
	      	transition: 'all 0.3s',
	      	// scrolllock: true,
	      	escape: false,
	      	blur:false,
	    });	
	    
		$(".racing_board_list li a").on("click",function(e) {
				
			var gm_provdr	= $(this).data('gm-provdr');
			var lnk_dsp		= $(this).data('link-dsp');

			$.ajax({
				url : '/login/jsp/get_session.jsp',
				data : {},
				dataType: 'json',
				method: 'GET',
				cache: false,
			}).done(function(data){
				var session = data.validUser;

				if ((!session)
				|| (false == session)
				|| ("false" == session)) {
					$('#fade_3').popup('show');
				}
				else {
					$('.hdr-money-row').hide();
					$('#fade_9').popup('show');
					
					$.get("/TegServlet?method=1&gm_provdr="+gm_provdr+"&lnk_dsp="+lnk_dsp, function(srv_resp) {
						
						if ("" != srv_resp) {
							$('#game-pop-frame').attr('src', srv_resp);
							
							if (1 == gm_provdr) {
								$('.money_dsp').text('0.00');
							}
						}
						else {
							$('#gm-pop-errmsg').html("An error occured. Please reload the game.");
						}
						
						$('.fade_9_close').fadeIn();
					});
				}

			});

			return false;
		});
		
		function bindPlaycheckClick() {
			$('#game-cat li').on('click', 'a.get-vbet-hist', function() {
				
				$('#playcheck-frm').attr('src', '');
				$('#wait-warn-cntr').fadeIn();
				
				$.get('/spincube-api/GetBetPlaycheck', function(srv_resp) {
					
					$('#playcheck-frm').attr('src', srv_resp.url);
					
					setTimeout(function() {
						$('#wait-warn-cntr').fadeOut();	
					}, '7000');
					
				}, 'json');
				
			});
		}
		
		bindPlaycheckClick();
        
		$.get('/login/jsp/get_session.jsp', function(srv_resp) {
			
			if (!srv_resp.validUser) {
				$('a.get-vbet-hist').parent().hide();
			}
			else {
				$('a.get-vbet-hist').parent().show();
			}
		}, 'json');
		
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

<%@ include file="/inc/footer.jsp"%>

</div>

</body>
</html>