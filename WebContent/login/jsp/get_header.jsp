<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="bean.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import = "com.google.gson.Gson" %>

<%@ include file="/inc/session.jsp"%>

<%
	
	NoticeEventDao ne_dao = new NoticeEventDao();
	List<NoticeEventBean> ne_bean = ne_dao.getAllPopup();
	
		
	String html = "<ul class='util_right'>\n" + 
			"	<li class = 'hdr-money-row'>머니 <span class='util_money money_dsp'>" + dfrmt.format(UBAL)+ "</span></li>\n" + 
			"	<li>포인트 <span class=\"util_point point_dsp\">" + dfrmt.format(UPOINT)+ "</span></li>\n" + 
			"    <li>\n" + 
			"		<span class=\"popover-wrapper right\">\n" + 
			"			<a href=\"#\" data-role=\"popover\" data-target=\"example-popover-2\"><img src=\"/images/select_mark.png\"></a>\n" + 
			"			<div class=\"popover-modal example-popover-2\">\n" + 
			"				<div class=\"popover-body\" >\n" + 
			"					<a href=\"#\" data-toggle-role=\"close\" style=\"position:absolute; right:20px; top:0px\">×</a>\n" + 
			"					<div class=\"popover-body-in\">\n" + 
			"						<span class=\"popover_t\">보유머니</span> <span class=\"popover_money\"> " + dfrmt.format(UBAL) + " </span>\n" + 
			"					</div>\n" + 
			"					<div class=\"popover-body-in\">\n" + 
			"						<span class=\"popover_t\">보유포인트</span> <span class=\"popover_money\">" + dfrmt.format(UPOINT) + " </span>\n" + 
			"					</div>\n" + 
			"					<div class=\"popover-body-btn\" id=\"user_popup_menu\">\n" + 
			"						<div class=\"popover-body-btn_in\">\n" + 
			"							<a href=\"/cash/cash.jsp\" data-pg=\"sb4\" data-tab=\"tab1\" ><span class=\"popover_btn\">충전신청</span></a> \n" + 
			"							<a href=\"/cash/cash.jsp\"  data-pg=\"sb4\" data-tab=\"tab2\" ><span class=\"popover_btn\">환전신청</span></a>\n" + 
			"						</div>\n" + 
			"						<div class=\"popover-body-btn_in\">\n" + 
			"							<a href=\"/cash/cash.jsp\" data-pg=\"sb4\" data-tab=\"tab3\" ><span class=\"popover_btn\">포인트전환</span></a> \n" + 
			"							<a href=\"/cash/cash.jsp\" data-pg=\"sb4\" data-tab=\"tab3\"><span class=\"popover_btn\">포인트사용내역</span></a>\n" + 
			"						</div>\n" + 
			"						<div class=\"popover-body-btn_in\">\n" + 
			"						<!--	<a href=\"/cash/cash.jsp\" data-pg=\"sb4\" data-tab=\"tab4\" ><span class=\"popover_btn\">머니전환</span></a> -->\n" + 
			"							\n" + 
			"							<a href=\"/cash/cash.jsp\" data-pg=\"sb4\" data-tab=\"tab6\"><span class=\"popover_btn\">머니사용내역</span></a>\n" + 
			"							<span class=\"showLogoutModal popover_btn\" style=\"color: #8a8c8d!important; cursor: pointer;\">로그아웃 </span>\n" + 
			"						</div>\n" + 
			"					</div>\n" + 
			"				</div>\n" + 
			"				<script>\n" + 
			"					$('[data-role=\"popover\"]').popover();\n" + 
			"					$('[data-role=\"popover2\"]').popover({trigger: 'hover'});\n" + 
			"				</script>\n" + 
			"			</div>\n" + 
			"		</span>\n" + 
			"	</li>\n" + 
			"</ul>\n" + 
			"<div class=\"top_wrap\">\n" + 
			"    <div class=\"top\" id=\"user-header\">\n" + 
			"        <span class=\"logo\"><a href=\"/\"><img src=\"/images/logo.png\"></a></span>\n" + 
			"            <ul class=\"top_right\" id=\"user_menu_lst\">\n " + 
			"                <li><img src = \"/images/level/"+ UGRADE+".png\" style=\"position: relative; top: -11px; left: -1px; height: 45px;\" ></li> " +
			"				<li><a href=\"/info/info.jsp\" data-pg=\"sb5\" data-tab=\"tab4\" ><i class=\"fa fa-envelope msg-notif\" aria-hidden=\"true\"></i></a>"+
            "					<div class=\"msg-cont\"></div>" + 
            "				</li>\n" +
			"                <li>\n" + 
			"					<div class=\"select open\">\n" + 
			"						<button type=\"button\" class=\"myValue top_value\"> "+ NICK + " </button>\n" + 
			"						<ul class=\"aList top_alist\">\n" + 
			"							<li style=\"height:11px; width:152px; background:url(/images/select_top_bg.png) no-repeat\"></li>\n" + 
			"							<li>\n" + 
			"								<a href=\"/info/info.jsp\" data-pg=\"sb5\" data-tab=\"tab1\" >내 정보 </a>\n" + 
			"							</li>\n" + 
			"							<li>\n" + 
			"								<a href=\"/info/info.jsp\" data-pg=\"sb5\" data-tab=\"tab2\" >베팅내역 </a>\n" + 
			"							</li>\n" + 
			"							<li>\n" + 
			"								<a href=\"/info/info.jsp\" data-pg=\"sb5\" data-tab=\"tab3\" >1:1문의 </a>\n" + 
			"							</li>\n" + 
			"							<li>\n" + 
			"								<a href=\"/info/info.jsp\" data-pg=\"sb5\" data-tab=\"tab4\" >쪽지함 </a>\n" + 
			"							</li>\n" + 
			"							\n" + 
			"							<li><a href=\"#\" data-pg=\"\" data-tab=\"\" >로그아웃 </a>\n \n" + 
			"						</ul>\n" + 
			"					</div>				\n" + 
			"				</li>\n" + 
			"				<li><a href=\"/cash/cash.jsp\" data-pg=\"sb4\" data-tab=\"tab1\" class=\"top_btn1\" >  충전신청  </a></li>\n" + 
			"                <li><a href=\"/cash/cash.jsp\" data-pg=\"sb4\" data-tab=\"tab2\" class=\"top_btn1\" > 환전신청  </a></li>\n" + 
			"				<li><a href=\"/info/info.jsp\" data-pg=\"sb5\" data-tab=\"tab1\" ><span class=\"top_btn2\">내정보</span></a></li>\n" + 
			"            </ul>\n" + 
			"    </div>\n" + 
			"</div>";
		
	html += "<script>jQuery(function($){\n" + 
			"	\n" + 
			"	// Common\n" + 
			"	var select_root = $('div.select');\n" + 
			"	var select_value = $('.myValue');\n" + 
			"	var select_a = $('div.select>ul>li>a');\n" + 
			"	var select_input = $('div.select>ul>li>input[type=radio]');\n" + 
			"	var select_label = $('div.select>ul>li>label');\n" + 
			"	\n" + 
			"	// Radio Default Value\n" + 
			"	$('div.myValue').each(function(){\n" + 
			"		var default_value = $(this).next('.iList').find('input[checked]').next('label').text();\n" + 
			"		$(this).append(default_value);\n" + 
			"	});\n" + 
			"	\n" + 
			"	// Line\n" + 
			"	select_value.bind('focusin',function(){$(this).addClass('outLine');});\n" + 
			"	select_value.bind('focusout',function(){$(this).removeClass('outLine');});\n" + 
			"	select_input.bind('focusin',function(){$(this).parents('div.select').children('div.myValue').addClass('outLine');});\n" + 
			"	select_input.bind('focusout',function(){$(this).parents('div.select').children('div.myValue').removeClass('outLine');});\n" + 
			"	\n" + 
			"	// Show\n" + 
			"	function show_option(){\n" + 
			"		$(this).parents('div.select:first').toggleClass('open');\n" + 
			"	}\n" + 
			"	\n" + 
			"	// Hover\n" + 
			"	function i_hover(){\n" + 
			"		$(this).parents('ul:first').children('li').removeClass('hover');\n" + 
			"		$(this).parents('li:first').toggleClass('hover');\n" + 
			"	}\n" + 
			"	\n" + 
			"	// Hide\n" + 
			"	function hide_option(){\n" + 
			"		var t = $(this);\n" + 
			"		setTimeout(function(){\n" + 
			"			t.parents('div.select:first').removeClass('open');\n" + 
			"		}, 1);\n" + 
			"	}\n" + 
			"	\n" + 
			"	// Set Input\n" + 
			"	function set_label(){\n" + 
			"		var v = $(this).next('label').text();\n" + 
			"		$(this).parents('ul:first').prev('.myValue').text('').append(v);\n" + 
			"		$(this).parents('ul:first').prev('.myValue').addClass('selected');\n" + 
			"	}\n" + 
			"	\n" + 
			"	// Set Anchor\n" + 
			"	function set_anchor(){\n" + 
			"		var v = $(this).text();\n" + 
			"		$(this).parents('ul:first').prev('.myValue').text('').append(v);\n" + 
			"		$(this).parents('ul:first').prev('.myValue').addClass('selected');\n" + 
			"	}\n" + 
			"\n" + 
			"	// Anchor Focus Out\n" + 
			"	$('*:not(\"div.select a\")').focus(function(){\n" + 
			"		$('.aList').parent('.select').removeClass('open');\n" + 
			"	});\n" + 
			"	\n" + 
			"	select_value.click(show_option);\n" + 
			"	select_root.removeClass('open');\n" + 
			"	select_root.mouseleave(function(){$(this).removeClass('open');});\n" + 
			"	select_a.click(set_anchor).click(hide_option).focus(i_hover).hover(i_hover);\n" + 
			"	select_input.change(set_label).focus(set_label);\n" + 
			"	select_label.hover(i_hover).click(hide_option);\n" + 
			"	\n" + 
			"	// Form Reset\n" + 
			"	$('input[type=\"reset\"], button[type=\"reset\"]').click(function(){\n" + 
			"		$(this).parents('form:first').find('.myValue').each(function(){\n" + 
			"			var origin = $(this).next('ul:first').find('li:first label').text();\n" + 
			"			$(this).text(origin).removeClass('selected');\n" + 
			"		});\n" + 
			"	});\n" + 
			"	\n" + 
			"});</script>";
	
	
	String popup = "";

	if(ne_bean.size() > 0){
		
		for (int k=0; k < ne_bean.size() ; k++){
			//System.out.println("popup count: " +  k);
			NoticeEventBean b = (NoticeEventBean) ne_bean.get(k);

			popup += "<div id=\"popup_"+k+" \" class=\"bg_mask_pop2 popup_modal\">\r\n" + 
					"	<div class=\"bg_mask_pop_title\">\r\n" + 
					"		<span class=\"popup_logo\"><img src=\"/images/popup_logo.png\"></span>\r\n" + 
					"		<span class=\"popup_close123 \"><img src=\"/images/popup_close.png\"></span>\r\n" + 
					"	</div>\r\n" + 
					"	<div class=\"bg_mask_pop2_in\">\r\n" + 
					"		<img src=\"http://admin.vava21.com:88/contents/event/10.jpg\">\r\n" + 
					"	</div>\r\n" + 
					"</div>";
		}
	}

	
	Gson gson = new Gson();
	HashMap<String, Object> hsm = new HashMap<String, Object>();
	
	
	hsm.put("header", html);
	hsm.put("popup", ne_bean);
	hsm.put("bal", UBAL);
	out.println(gson.toJson(hsm).toString());

%>






