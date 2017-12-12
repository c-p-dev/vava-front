<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/session.jsp"%>
<%@ include file="/inc/session_checker.jsp" %>
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
<link href="/css/common3.css" rel="stylesheet" type="text/css">


<link href="/css/custom.css" rel="stylesheet" type="text/css"><!--공통-->
<link rel="stylesheet" href="/css/datatables.net-bs/css/bootstrap-simple.css" /> 
<link rel="stylesheet" href="/css/datatables.net-bs/css/dataTables.bootstrap.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.css" rel="stylesheet" type="text/css"><!-- toaster test  -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/qtip2/3.0.3/jquery.qtip.css" /><!-- tooltip -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/pikaday/1.6.1/css/pikaday.css" rel="stylesheet" type="text/css">
<!-- custom scrollbar test -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css" />

<script type="text/javascript" src="/js/angular.js"></script> 
<script type="text/javascript" src="/js/angular-animate.min.js"></script> 
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/angular-filter/0.5.16/angular-filter.js"></script>    
<script type="text/javascript" src="/js/v-accordion.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.28//angular-route.min.js"></script>
<link href="/css/v-accordion.css" rel="stylesheet" type="text/css">


</head>

<body onLoad="clive_load()"> 
	
<%@ include file="/inc/header.jsp"%>


<div id="contents_wrap">

	<div class="contents">
			
<div id="spin_clive" class="sk-fading-circle_s">
  <div class="sk-circle1 sk-circle"></div>
  <div class="sk-circle2 sk-circle"></div>
  <div class="sk-circle3 sk-circle"></div>
  <div class="sk-circle4 sk-circle"></div>
  <div class="sk-circle5 sk-circle"></div>
  <div class="sk-circle6 sk-circle"></div>
  <div class="sk-circle7 sk-circle"></div>
  <div class="sk-circle8 sk-circle"></div>
  <div class="sk-circle9 sk-circle"></div>
  <div class="sk-circle10 sk-circle"></div>
  <div class="sk-circle11 sk-circle"></div>
  <div class="sk-circle12 sk-circle"></div>
</div>


<div  style="display:none;" id="clive" class="animate-bottom">
	

		<ul class="tabs">
			<li><a href="#tab1"  >내정보</a></li>
			<li><a href="#tab2"  class="dt-bet-div">베팅내역</a></li>
			<li><a href="#tab3" >1:1문의</a></li>
			<li class="dt-qna-tab"><a href="#tab4" class="dt-qna-tab" >쪽지함</a></li>
		</ul>
		
		<div class="tab_container">
			
			<div id="tab1" class="tab_content">
				<jsp:include page="profile.jsp" />
			</div>
			
			<div id="tab2" class="tab_content">
				<jsp:include page="bet_history.jsp" />
			</div>
			
			<div id="tab3" class="tab_content">
				<jsp:include page="contact.jsp" />
			</div>
			<div id="tab4" class="tab_content">
				<jsp:include page="qna.jsp" />
			</div>
			
		</div>
		
	</div>
</div><!-- contents -->

</div>

<script>
	
	$(document).ready(function(){
		// setTabActive($.urlParam("tab"));

		var tab = '<%=session.getAttribute("tb")%>';
		if(tab != ""){
			$("ul.tabs li a[href='#"+tab+"']").click();
		}
	});
	
	function clive_load() {
		console.log("clive_load");
	    var myVar = setTimeout(showPage_clive, 1000);
	};
	
	function showPage_clive() {
	  document.getElementById("spin_clive").style.display  = "none";
	  document.getElementById("clive").style.display = "block";
	  $("#tab4").trigger("fadeInComplete");
	  $("#tab3").trigger("fadeInComplete");

	}
	
</script>

<%@ include file="/inc/footer.jsp"%>

</div>
</body>
</html>