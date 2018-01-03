<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%@ page import ="dao.GameDao"%>
<%@ page import ="bean.GameBean"%>
<%@ page import ="bean.UserBean"%>
<%@ page import ="java.util.*" %>

<%	
	GameDao game_dao			= new GameDao();
	List<GameBean> game_list	= game_dao.getAllGames();
	List<GameBean> game_providers = game_dao.getGameProviders();
	List<GameBean> game_type = game_dao.getGameType();
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
<style>

ul.pagination li{
	display: inline;
	margin-left: 5px;
}

ul.pagination li a {
	padding: 8px 12px 8px 12px;
    font-size: 12px;
    border-radius: 3px;
    display: inline-block;
    background: #2b2d2e;
    color: #8a8c8d;
}
ul.pagination li.active a {
    padding: 8px 12px 8px 12px;
    color: #ffffff;
    font-size: 12px;
    border-radius: 3px;
    display: inline-block;
    background: #0792c4;
}

ul.casino_board_list  + .btn_wrap{
	margin-top:30px;
}


.left_tab_con ul.tabs  {
	display: flex;
}
.left_tab_con ul.tabs li{
	width: 100%;
	white-space: nowrap;
	border: 1px solid #2d3232!important;
    border-bottom: none!important;
}

.left_tab_con ul.tabs li:active{
	/*border: 1px solid #2d3232;
    border-bottom: none;*/
}

.left_tab_con ul.tabs li a {
	width: 100%;
	text-overflow: ellipsis;  
	overflow: hidden!important;

}

.left_tab_con ul.tabs li.active a {
	width: 100%;
	border: none;
    border-bottom: none;
}

.left_tab_con ul.tabs li.active a:hover {
    width: 100%!important;
}

li.subm-manual,
li.pcheck-lnk {
	display: none;
	background-color: #000000;
    border-bottom: solid 1px rgba(255,255,255,0.1);
}

div.chevy-cntr {
    float: right;
    margin-right: 12px;
}

.l_tabs li {
	cursor: pointer;
}

#wait-warn-cntr {
	display: none;
	color: red;
   	padding: 10px;
   	font-size: 20px;
}
</style>



</head>
<body>


<%@ include file="/inc/header.jsp"%>


<div id="contents_wrap">
	<div class="contents">
		<div class="casino_visual_wrap">
			<div id="jssor_1" style="position:relative;width:1330px;height:270px;overflow:hidden;visibility:hidden;">
				<div data-u="slides" style="cursor:default;position:relative;top:0px;left:0px;width:1330px;height:270px;overflow:hidden;">
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
		
		<div class="casino_left">
			<div class="left_search_wrap">
				<div class="left_search">
					<input class="input_style05 search" placeholder="게임찾기"><a href="#"><img src="/images/search_icon.jpg"></a>
				</div>
			</div>
			<ul class="l_tabs" id="game-cat">
				<li><a href="#l-tab1" class="get-game"  data-val="0">전체</a></li>
				<%
					for (int i = 0; i < game_providers.size(); i++) {
						GameBean providers = game_providers.get(i);
						int tab = i + 2;
						
						String html = "<li><a href=#l-tab"+tab+" class=get-game data-val="+providers.getGame_provider()+">"+providers.getProvider_name()+" <div class = 'chevy-cntr'><i class = 'chevy fa fa-chevron-down'></i></div></a></li>";

						if( providers.getGame_provider() == 2){
							
							html +=("<li id = 'agmanual-lnk' class = 'subm-manual'><a href='#l-tab3' class='get-manual agtab' data-val='manual'>아시안게임 이용안내</a></li>");
						
						}
						else if(providers.getGame_provider() == 1 ){
							
							html +=("<li id = 'mgmanual-lnk' class = 'subm-manual'><a href='#l-tab5' class='get-manual mgtab' data-val='manual2'>마이크로게임 이용안내</a></li>");
							html +=("<li id = 'get-mgpcheck-li' class = 'pcheck-lnk'><a href='#l-tab6' id = 'get-mgpcheck-lnk'>베팅내역 확인하기</a></li>");
						
						}
						else if(providers.getGame_provider() == 3){
							
							html +=("<li id = 'bcmanual-lnk' class = 'subm-manual'><a href='#l-tab=7' class='get-manual' data-val=''>벳컨 카지노 이용안내</a></li>");
						
						}

						out.print(html);

				%>
					
					<!-- <li><a href="#l-tab<%=tab%>" data-val='<%=providers.getGame_provider()%>'><%=providers.getProvider_name()%></a></li> -->
					
				<%
					}
				%>
			</ul>
			

		</div>

		<div class="casino_right" id="casino_right">
		
		</div>
		
		<div class="pcheck-frame-cntr" id="pcheck-frame-cntr" style = 'display: none; width: 1040px; float: left;'>
			<div id = 'wait-warn-cntr'> <span id = 'wait-warn'> Please wait. Fetching bet data...</span> </div>
			<iframe id = 'playcheck-frm' src = '' style = 'width:100%; height: 720px;'></iframe>
		</div>
		
	</div>
</div><!-- contents -->

<script>
	var spin = '<div id="spin_clive" class="sk-circle ng-scope" style="">';
	spin += '<div class="sk-circle1 sk-child"></div>';
	spin += '<div class="sk-circle2 sk-child"></div>';
	spin += '<div class="sk-circle3 sk-child"></div>';
	spin += '<div class="sk-circle4 sk-child"></div>';
	spin += '<div class="sk-circle5 sk-child"></div>';
	spin += '<div class="sk-circle6 sk-child"></div>';
	spin += '<div class="sk-circle7 sk-child"></div>';
	spin += '<div class="sk-circle8 sk-child"></div>';
	spin += '<div class="sk-circle9 sk-child"></div>';
	spin += '<div class="sk-circle10 sk-child"></div>';
	spin += '<div class="sk-circle11 sk-child"></div>';
	spin += '<div class="sk-circle12 sk-child"></div>';
	spin += '</div>';
	$(document).ready(function () {

		$('#fade_3').popup({
	      	transition: 'all 0.3s',
	      	// scrolllock: true,
	      	escape: false,
	      	blur:false,
	    });	
		
		// $(".casino_board_list li a").on("click",function(e) {
		$(".casino_right").html(spin);
		setTimeout(function(){
			// $(".l_tabs li:first a ").click();
			$.ajax({
				url : 'jsp/get_game.jsp',
				data : {gp:"0"},
				method: 'GET',
				error: function(){
					toaster.success("Failed to load games. Please try again.");
					$(".l_tabs li:first a ").click();
				}
			}).done(function(data){
				var obj = JSON.parse(data);
				doList(obj,data);
			});
			
		}, 100);
		
		$("body").on("click",".casino_board_list li a",function(e) {
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
					
					$.get("../TegServlet?method=1&gm_provdr="+gm_provdr+"&lnk_dsp="+lnk_dsp, function(srv_resp) {
						
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

		$("#game-cat li").on("click", 'a', function(e) {
			
			var lnk_clicked	= $(this);
			
			$('#casino_right').show();
			$('#pcheck-frame-cntr').hide();
			
			if (lnk_clicked.parent().hasClass('active') == false) {
				
				$.get('/login/jsp/get_session.jsp', function(sess_check) {
					
					var game_prvdr = lnk_clicked.attr("data-val");
					
					if (lnk_clicked.hasClass('get-game')) {
						
						var chev_mark	= lnk_clicked.find('.chevy-cntr .chevy');
						
						/*	Intializes all manuals to hidden display	*/
						$(".casino_right").html(spin);
						$('.subm-manual').hide();
						$('.pcheck-lnk').hide();
						
						$('.chevy').removeClass('fa-chevron-up');
						$('.chevy').addClass('fa-chevron-down');
						
						/*	Asian Gaming	*/
						if (2 == game_prvdr) {
							$('#agmanual-lnk').slideDown();
						}
						/*	Microgaming		*/
						else if (1 == game_prvdr) {
							$('#mgmanual-lnk').slideDown();
							
							if (sess_check.validUser) {
								$('#get-mgpcheck-li').slideDown();
							}
						}
						/*	Betconstruct	*/
						else if (3 == game_prvdr) {
							$('#bcmanual-lnk').slideDown();
						}
						else {
							/* Default. Do nothing	*/
						}
						
						chev_mark.removeClass('fa-chevron-down');
						chev_mark.addClass('fa-chevron-up');
						
						//get Game
						$.ajax({
								url : 'jsp/get_game.jsp',
								data : {gp:game_prvdr},
								method: 'GET',
								error: function(){
									toaster.success("Failed to load games. Please try again.");
									$(".l_tabs li:first a ").click();
								}
							}).done(function(data){
								var obj = JSON.parse(data);
								doList(obj, data);
						});
						
						lnk_clicked.parent().click();
					}
					else if (lnk_clicked.hasClass('get-manual')) {
						$(".casino_right").html(spin);
						// get Manual
						$.ajax({
							url : 'jsp/get_manual.jsp',
							data : {man:game_prvdr},
							method: 'GET',
						}).done(function(data){
							setTimeout(function(){
								loadManual(data);
							}, 1000);
						});
						
						lnk_clicked.parent().click();
					}
					else {
						/*	Do nothing	*/
					}
					
				}, 'json');
			}
			
			return false;
		});
		
		$('#game-cat li').on('click', 'a#get-mgpcheck-lnk', function() {
			var lnk_clicked = $(this);
			
			$('#playcheck-frm').attr('src', '');
			$('#wait-warn-cntr').show();
			$('#casino_right').hide();
			
			$.get('/TegServlet?method=6', function(srv_resp) {
				
				if (false === $('#casino_right').is(':visible')) {
					$('#pcheck-frame-cntr').show();
					
					$('#playcheck-frm').attr('src', srv_resp);
					
					setTimeout(function() {
						$('#wait-warn-cntr').fadeOut();
					}, '2000');
				}
			});
			
			lnk_clicked.parent().click();
		});
		
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

			$("body").on("mouseenter",".img",function(){
				$(this).addClass("hover");
			})

			.on("mouseleave",".img",function(){
				$(this).removeClass("hover");
			});
		}


		$(".input_style05 .search").on("change",function(){
			if($('.casino_board_list').children().length === 0) { // Checking if list is empty

				$('.not-found').css('display', 'block'); // Display the Not Found message

			}else{

			    $('.not-found').css('display', 'none'); // Hide the Not Found message
			}
		});
	});

	function doList(obj,gp){
		

		var ul_tabs = ""; 
		var div_tab = "";
		var tab_num = 1;
		$.each(obj.games,function(index, el) {

			tab_num =  tab_num + 1;
			
			var tab_name = el.game_type_name.toLowerCase();
			tab_name = tab_name.split(' ').join('_'); 

			ul_tabs += '<li class="'+(index == 0 ? "active": "" )+'"><a href="#'+ tab_name+tab_num + '">'+el.game_type_name+'</a></li>';	
			ul_casino_brd_list = "";

			$.each(el.data,function(i, e) {
				var li = '<li>';
					li += ' <a href="#" class="game_link" data-gm-provdr = "'+ e.game_provider +'" data-link-dsp = "'+ e.link_dsp+'">';
					li += '		<div class="img casino_board_img"> ';
					li += '			<img src="/images/'+e.game_img+'" class="game-img" style = "width: 320px; height: 195px;"> ';
					li += '			<div class="overlay"> ';
					li += '				 <span class="expand" style = "width: 125px; font-size: 20px;">Play now</span> ';
					li += '			</div> ';
					li += '		</div> ';
					li += '	</a> ';
					li += '	<div class="casino_board_text"> ';
					li += '		<p class="casino_name">'+e.game_name+'</p> ';
					li += '	</div> ';
					li += '</li>';

				ul_casino_brd_list += li;


			});

				div_tab += '	<div id="'+ tab_name + tab_num + '" class="tab_content" style="'+(index == 0 ? 'display: block;' : 'display: none;' )+'">';
				div_tab += '		<div class="casino_board_wrap">';
				div_tab += '        	<div class="not-found" style="display:none">Not Found</div>';
				div_tab += '			<ul class="casino_board_list" id="games_ul">';
				div_tab +=                ul_casino_brd_list;
				div_tab += '			</ul>';
				div_tab += '            <div class="btn_wrap"><ul class="pagination"></ul></div>';
				div_tab += '		</div>';
				div_tab += '	</div>';
		});


		
		var final_ul = '<ul class="tabs" style = "height:auto;">';
			final_ul += ul_tabs;
			final_ul += '</ul>';

		var div_default = '<div id="tab1" class="tab_content"> <div class="casino_board_wrap"> <ul class="casino_board_list"> </ul> </div> </div>';

		var tab_container = '<div class="tab_container"> '+div_tab+'</div>';

		var final_div = '<div id="l-tab1" class="left_tab_con">'+ final_ul + tab_container+ '</div>';
		

		setTimeout(function(){
			$(".casino_right").html(final_div).fadeIn();
			makeList();
			$('#pcheck-frame-cntr').hide();
		}, 600);	
	}

	function makeList(){
		var options = {
		  	valueNames: ['casino_name'],
		  	listClass: 'casino_board_list',
		  	page: 1000,
  			
		};

		var hackerList = new List('contents_wrap', options);

		
	}

	function addPgBtn(){
		var prev = '<li class=""><a class="page prev_pg"><</a></li>';
		var next = '<li class=""><a class="page prev_pg">></a></li>';
		$('ul.pagination').prepend(prev);
		$('ul.pagination').append(next);
	}

	function getSess(){
		var session = false;
		$.ajax({
			url : '/login/jsp/get_session.jsp',
			data : {},
			method: 'GET',
		}).done(function(data){
			var obj = JSON.parse(data);
			
			session = obj.result;

		});

		return session;
	}


</script>
<script type="text/javascript" src="/js/manual.js"></script>

<%@ include file="/inc/footer.jsp"%>

</div>
</body>
</html>