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
				<img src="/images/partner_1.png">
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
var bal;

$(document).ready(function(){	
	if (loggedIn) {
		cValU();
		refreshMoney();
		updateBal();
	}
	else {
		$('.casino-spinner').hide();
		$(".casino_right").fadeIn();
	}
});

function IntervalloadMsgCount(){
	setInterval(function(){
		$.ajax({
			url : '/login/jsp/get_msgcount.jsp',
			data : {},
			method: 'GET',
		}).done(function(data){
			var obj = JSON.parse(data);
			var html = "";
			if(obj.count > 0){
				html  = "<span class='msg-notif-count'>"+obj.count+"</span>";
			}
			$(".msg-cont").html(html);
		});
	}, 60000); //1 min
}

function cValU(){
	clearInterval(lgCheck);
	lgCheck = setInterval(function(){
		
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

	function updateBal() {	
		clearInterval(bal);		
		bal = setInterval(function(){
			
	 		$.ajax({
				url: '/inc/UpdateBal.jsp',
				data : {},
				method: 'GET',
				cache: false,
			}).done(function(data){				
				
				
				var obj = JSON.parse(data);
				console.log(obj);
				console.log(obj.R);
							
				if(obj.R){
					
					var cp = '<%=cp%>';	
					if(cp == '/sport/prematch.jsp' || cp == '/sport/livematch.jsp'){
						ISLOGIN.a = obj.uid;
						console.log("UPDATED BAL");
					}	
					
					
					$.ajax({
						url : '/login/jsp/get_header.jsp', //jsp				
						data : {},
						method: 'GET',
					}).done(function(data){					
					//	console.log(data);		
						var obj = JSON.parse(data);
						$("#uhead").html(obj.header);
						//createPopup(obj.popup);
						//$("#loginModal").html(lgMsg);	
						//$("#fade_3").popup("hide");
						//$('a.get-vbet-hist').parent().show();
						
					});
				
					console.log("UPDATED BAL");
					
				} else {
					console.log("NOT UPDATED BAL");
				}
				
				data=null;
			}).error(function(data, status, headers, config) {
				console.log(status);
				data=null;
			});
		}, 10*1000); //1 min
	}
 	
</script>
<!--

//-->
