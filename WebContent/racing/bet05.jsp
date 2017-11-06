<%@ include file="/inc/main_header.jsp"%>
<%@ include file="/inc/session.jsp"%>
<%@ include file="/inc/header.jsp"%>
<%
	
	GameDao game_dao			= new GameDao();
	List<GameBean> game_list	= game_dao.getRacingGames();
%>

<div id="contents_wrap">
	<div class="contents">
		
	</div>
</div>

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
		})
	});
</script>
<%@ include file="/inc/footer.jsp"%>
</body>
</html>