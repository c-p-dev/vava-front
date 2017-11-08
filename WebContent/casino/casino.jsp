<%@ include file="/inc/main_header.jsp"%>
<%@ include file="/inc/session.jsp"%>
<%@ include file="/inc/header.jsp"%>

<%@ page import ="net.vavasoft.dao.GameDao"%>
<%@ page import ="net.vavasoft.bean.GameBean"%>
<%@ page import ="net.vavasoft.bean.UserBean"%>
<%@ page import ="java.util.*" %>
<%	
	GameDao game_dao			= new GameDao();
	List<GameBean> game_list	= game_dao.getAllGames();
	List<GameBean> game_providers = game_dao.getGameProviders();
	List<GameBean> game_type = game_dao.getGameType();
%>
<style>
.casino_board_list li {
	margin: 0 25px 0px 0!important;
}
.casino_board_text {
    margin: 15px 0 15px 0!important; 
}
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

/*#l-tab1 ul.tabs li {
	width: 14%!important;
}*/

</style>
<script src="//cdnjs.cloudflare.com/ajax/libs/list.js/1.5.0/list.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/list.pagination.js/0.1.1/list.pagination.min.js"></script>
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
						
						String html = "<li><a href=#l-tab"+tab+" class=get-game data-val="+providers.getGame_provider()+">"+providers.getProvider_name()+"</a></li>";

						if(providers.getProvider_name().equals("AG Casino")){
							
							html +=("<li><a href='#l-tab3' class='get-manual agtab' data-val='manual'  >AG Manual</a></li>");
						
						}else if(providers.getProvider_name().equals("MG Casino")){
							
							html +=("<li><a href='#l-tab5' class='get-manual mgtab' data-val='manual2'  >MG Manual</a></li>");
						
						}else if(providers.getProvider_name().equals("Betconstruct Casino")){
							
							html +=("<li><a href='#l-tab=7' class='get-manual' data-val=''  >Betconstruct Manual</a></li>");
						
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


		// $(".casino_board_list li a").on("click",function(e) {
		$(".casino_right").html(spin);
		setTimeout(function(){
			$(".l_tabs li:first a ").click();
		}, 100);
		
		$("body").on("click",".casino_board_list li a",function(e) {
			
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
				});
			}

			return false;
		});

		$("#game-cat li a.get-game").on("click",function(e){
			e.preventDefault();
			var gp = $(this).attr("data-val");
			$.ajax({
				url : 'jsp/get_game.jsp',
				data : {gp:gp},
				method: 'GET',
			}).done(function(data){
				var obj = JSON.parse(data);
				// console.log(obj);
				doList(obj,gp);
			});

			
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
			// handle the mouseleave functionality
			// .mouseleave(function(){
			// 	$(this).removeClass("hover");
			// });
			.on("mouseleave",".img",function(){
				$(this).removeClass("hover");
			});
		}

		// $("body").on("click","ul.tabs li",function(){
		// 	var container = $("#contents_wrap");

		// 	var options = {
		// 	  	valueNames: ['casino_name'],
		// 	  	listClass: 'casino_board_list',
		// 	  	page: 3,
	 //  			pagination: true
		// 	};

		// 	var hackerList = new List(container, options);

		// 	console.log(hackerList);
		// });

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
					li += '				 <span class="expand">Play now</span> ';
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


		
		var final_ul = '<ul class="tabs">';
			final_ul += ul_tabs;
			final_ul += '</ul>';

		var div_default = '<div id="tab1" class="tab_content"> <div class="casino_board_wrap"> <ul class="casino_board_list"> </ul> </div> </div>';

		var tab_container = '<div class="tab_container"> '+div_tab+'</div>';

		var final_div = '<div id="l-tab1" class="left_tab_con">'+ final_ul + tab_container+ '</div>';
		$(".casino_right").html(spin);

		setTimeout(function(){
			$(".casino_right").hide().html(final_div).fadeIn();
			makeList();
			
		}, 600);	
	}

	function makeList(){
		var options = {
		  	valueNames: ['casino_name'],
		  	listClass: 'casino_board_list',
		  	page: 6,
  			pagination: [{
		      outerWindow: 100,
		      innerWindow: 100,
		      left:100,
		      right:100,
		    }],
		};

		var hackerList = new List('contents_wrap', options);

		//console.log(hackerList);
	}

	function addPgBtn(){
		var prev = '<li class=""><a class="page prev_pg"><</a></li>';
		var next = '<li class=""><a class="page prev_pg">></a></li>';
		$('ul.pagination').prepend(prev);
		$('ul.pagination').append(next);
	}


</script>
<script type="text/javascript" src="/js/manual.js"></script>
<%@ include file="/inc/footer.jsp"%>

</body>
</html>