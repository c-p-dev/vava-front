<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="dao.NoticeEventDao"%>
<%@page import="bean.NoticeEventBean"%>
<%@page import="java.util.*"%>
<%
	NoticeEventDao ne_dao			= new NoticeEventDao();
	List<NoticeEventBean> all_list	= ne_dao.getAllNoticeEvents();
	List<NoticeEventBean> all_notice	= ne_dao.getAllNotice();
	List<NoticeEventBean> all_events	= ne_dao.getAllEvent();
	// List<NoticeEventBean> all_list	= ne_dao.getAllNoticeEvents();
	System.out.println("size: " + all_list.size());
	System.out.println("all notice size: " + all_notice.size());
	System.out.println("all event size: " + all_events.size());
	

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
.picflex .resultitem{
	max-width: 308px!important;
}

.view_c_in_img img{
    width: 300px;
    height: 180px;
}
</style>

<div id="contents_wrap" class="notice_tab">
	<div class="contents">
		<ul class="tabs">
			<li><a href="#tab1">전체</a></li>
			<li><a href="#tab2">공지사항</a></li>
			<li><a href="#tab3">이벤트</a></li>
		</ul>
		<div class="tab_container">
			<div id="tab1" class="tab_content">
				<div class="pictureView viewchange picflex">
					
					<%
						for (int i = 0; i < all_list.size(); i++) {
							NoticeEventBean ne = all_list.get(i);
							
							String img_path = "http://admin.vava21.com:88/contents/";
							String img_folder = (ne.getGubun().toString().equals("NOTICE") ? "notice/" : "event/");
							String img = img = img_path + img_folder + ne.getImg();
							
						
							if(ne.getImg() == null){
								img = "images/notice_ready.jpg";
							}
							
							
					%>
						
						<div class="resultitem <%=ne.getGubun()%>">
							<div class="box thumbnailurl">
								<a href="javascript:void(0);" class="clickevent "></a>
								<div class="notice_img"><img src="<%=img%>"></div>
								<div class="notice_text">
									<p class="notice_text_t"><%=ne.getTitle()%></p>
									<p class="notice_text_c"><%=ne.getRegdate()%></p>
								</div>
							</div>
							<div class="detailview container-fluid">
								<div class="resulttitle">
									<div class="view_center">
										<div class="view_c_in_t">
											<div class="view_title">
												<p class="view_t"><%=ne.getTitle()%></p>
												<p class="view_date"><%=ne.getRegdate()%></p>
											</div>
											<div class="controllers">
												<a href="#detailClose" class="detailClose remove"><img src="images/popup_close.png"></a>
											</div>
										</div>
										<div class="view_c_in">
											<div class="view_c_in_img"><img src="<%=img%>"></div>
											<div class="view_c_in_text"><%=ne.getTxt()%></div>
											
										</div>
									</div>
									
								</div>
							</div>
						</div>


					<%
						}
					%>
				
				  	
	
				</div><!--공지1줄-->
				
			</div>
			<div id="tab2" class="tab_content">
				<div class="pictureView viewchange picflex">
					<%
						for (int i = 0; i < all_notice.size(); i++) {
							NoticeEventBean ne = all_notice.get(i);
							
							String img_path = "http://admin.vava21.com:88/contents/";
							String img_folder = "notice/";
							String img = img = img_path + img_folder + ne.getImg();
							
							if(ne.getImg() == null){
								img = "images/notice_ready.jpg";
							}
								
							
					%>
						
						<div class="resultitem <%=ne.getGubun()%>">
							<div class="box thumbnailurl">
								<a href="javascript:void(0);" class="clickevent "></a>
								<div class="notice_img"><img src="<%=img%>"></div>
								<div class="notice_text">
									<p class="notice_text_t"><%=ne.getTitle()%></p>
									<p class="notice_text_c"><%=ne.getRegdate()%></p>
								</div>
							</div>
							<div class="detailview container-fluid">
								<div class="resulttitle">
									<div class="view_center">
										<div class="view_c_in_t">
											<div class="view_title">
												<p class="view_t"><%=ne.getTitle()%></p>
												<p class="view_date"><%=ne.getRegdate()%></p>
											</div>
											<div class="controllers">
												<a href="#detailClose" class="detailClose remove"><img src="images/popup_close.png"></a>
											</div>
										</div>
										<div class="view_c_in">
											<div class="view_c_in_img"><img src="<%=img%>"></div>
											<div class="view_c_in_text"><%=ne.getTxt()%></div>
											
										</div>
									</div>
									
								</div>
							</div>
						</div>


					<%
						}
					%>
				</div>
			</div>
			<div id="tab3" class="tab_content">
				<div class="pictureView viewchange picflex">
					<%
						for (int i = 0; i < all_events.size(); i++) {
							NoticeEventBean ne = all_events.get(i);
							String img_path = "http://admin.vava21.com:88/contents/";
							String img_folder = "event/";
							String img = img = img_path + img_folder + ne.getImg();
							
							if(ne.getImg() == null){
								img = "images/notice_ready.jpg";
							}
								
							
					%>
						
						<div class="resultitem <%=ne.getGubun()%>">
							<div class="box thumbnailurl">
								<a href="javascript:void(0);" class="clickevent "></a>
								<div class="notice_img"><img src="<%=img%>"></div>
								<div class="notice_text">
									<p class="notice_text_t"><%=ne.getTitle()%></p>
									<p class="notice_text_c"><%=ne.getRegdate()%></p>
								</div>
							</div>
							<div class="detailview container-fluid">
								<div class="resulttitle">
									<div class="view_center">
										<div class="view_c_in_t">
											<div class="view_title">
												<p class="view_t"><%=ne.getTitle()%></p>
												<p class="view_date"><%=ne.getRegdate()%></p>
											</div>
											<div class="controllers">
												<a href="#detailClose" class="detailClose remove"><img src="images/popup_close.png"></a>
											</div>
										</div>
										<div class="view_c_in">
											<div class="view_c_in_img"><img src="<%=img%>"></div>
											<div class="view_c_in_text"><%=ne.getTxt()%></div>
											
										</div>
									</div>
									
								</div>
							</div>
						</div>


					<%
						}
					%>
				</div>	
			</div>
		</div>
		
	</div>
</div><!-- contents -->
<script>
	$(document).ready(function(){

	});


</script>
<%@ include file="/inc/footer.jsp"%>
</div>
</body>
</html>

