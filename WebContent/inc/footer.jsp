<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="footer_wrap">
	<div class="f_site_map_wrap">
    	<div class="f_site_map">
			<div class="f_site_map_left_wrap">
				<div class="f_site_map_left">
					<div class="f_site_map_left_t">
						ABOUT
					</div>
					<ul class="f_site_map_left_list">
						<li><a href="/about/help.jsp?page=br">베팅 규정</a></li>
						<li><a href="">공지/이벤트</a></li>
						<li><a href="/about/help.jsp?page=tou">이용약관</a></li>
					</ul>
				</div>
				<div class="f_site_map_left">
					<div class="f_site_map_left_t">
						HELP
					</div>
					<ul class="f_site_map_left_list">
						<li><a href="/about/help.jsp?page=bg">베팅 가이드</a></li>
						<li><a href="/about/help.jsp?page=gg">게임 가이드</a></li>
						<li><a href="/about/help.jsp?page=faq">자주 묻는 질문</a></li>
					</ul>
				</div>
				<div class="f_site_map_left">
					<div class="f_site_map_left_t">
						GAMES
					</div>
					<ul class="f_site_map_left_list">
						<li>스포츠북</li>
						<li><a href="/virtual/vgaming.jsp">가상게임</a></li>
						<li><a href="/casino/casino.jsp">라이브 카지노</a></li>
					</ul>
				</div>
			</div>
		</div>
		
		<div class="f_site_partner_wrap">
			<div class="f_site_partner_t">
				PARTNER
			</div>
			<div class="f_site_partner">
				<img src="/images/partner_1.jpg">
			</div>
		</div>
		
	</div>
    <div class="f_copy_wrap">
		Gambling can be addictive. Play responsibly.           www.gamblingtherapy.org & www.gamblersanonymous.org<br>
		© 2017 IBET25.COM. ALL RIGHTS RESERVED. | +18  <br>
		<img src="/images/f_logo.jpg" style="margin:20px 0 0 0">
	</div>
</div>

<script type="text/javascript" src="/js/refresh-money.js"></script>
<script>

var lgCheck;
var loggedIn = <%=checkSession%>; 

$(document).ready(function(){	
	if(loggedIn){
		cValU();
	}		
});

function cValU(){
	clearInterval(lgCheck);
	lgCheck = setInterval(function(){
		
		console.log("check validity user");
		$.ajax({
			url : '/login/jsp/get_session.jsp',
			data : {},
			method: 'GET',
			cache: false,
		}).done(function(data){
			
			var obj = JSON.parse(data);
			console.log(obj);
			var valid = obj.validUser;
			//var loggedIn = obj.result; 
					
			if(!valid && loggedIn){
					
				$('#fade_9').popup('hide');				
				$("#user_invalid_modal").popup("show");	
			}	
			
		});

	}, 60000); //1 min
}
</script>
<!--

//-->
