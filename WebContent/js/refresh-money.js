var refreshMoney = function() {
	var url = '/TegServlet?method=5';
	
	$('.casino-spinner').show();
	
	$.ajax({
		url : url,
		dataType: 'json',
		method: 'GET',
		error: function() {
			$('.casino-spinner').hide();
			$(".casino_right").fadeIn();
		},
		success: function(srv_resp) {
			$('.money_dsp').text(number_format(srv_resp.money, 0));
			$('.casino-spinner').hide();
			$(".casino_right").fadeIn();
		}
	});
}