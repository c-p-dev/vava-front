<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="fade_9" class="bg_mask_pop9">
	<div class="bg_mask_pop_title">
		<span class="popup_logo"><img src="../images/popup_logo.png"></span>
		<span class="popup_close fade_9_close"><img src="../images/popup_close.png"></span>
	</div>
	
	<div class="bg_mask_pop9_in">
		<div class="inquiry_wrap">
			<div id = 'gm-pop-errmsg'></div>
			<iframe id = 'game-pop-frame' src = '' width = "100%" height = "100%" allowFullscreen = 1></iframe>
		</div>
	</div>
</div>

<script>
	$(document).ready(function () {

	    $('#fade_9').popup({
			transition: 'all 0.3s',
	      	scrolllock: true,
	      	escape: false,
	      	blur: false,
	      	onclose: function(){
	      		
	      		$('.hdr-money-row').show();
	      		$('#game-pop-frame').attr('src', '');
	      		$('#gm-pop-errmsg').html("");
				$.get("/TegServlet?method=2", function(srv_resp) {
					if ('null' != srv_resp.money) {
						$('.money_dsp').text(number_format(srv_resp.money, 0));
					}
				});
	    	}
	    });
	    
	    $('#game-pop-frame').load(function(){
	    	console.log($(this));
	    });
	});
</script>