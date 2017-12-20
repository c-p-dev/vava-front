$(document).ready(function(){
	
	var url = '/TegServlet?method=5';
	
	$.get(url, function(srv_resp){
		$('.money_dsp').text(number_format(srv_resp.money, 0));
	}, 'json');
	
});