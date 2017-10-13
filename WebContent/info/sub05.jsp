<%@ include file = "../process/session_checker.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" />
<%
	UserBean user_data	= (UserBean)session.getAttribute("currentSessionUser");
%>

<div id="contents_wrap">
	<div class="contents">
		<ul class="tabs">
			<li><a href="#tab1"  >내정보</a></li>
			<li><a href="#tab2"  class="dt-bet-div">베팅내역</a></li>
			<li><a href="#tab3" >1:1문의</a></li>
			<li><a href="#tab4" >쪽지함</a></li>
		</ul>
		<div class="tab_container">
			<div id="tab1" class="tab_content">
				<jsp:include page="profile.jsp" />
			</div>
			<div id="tab2" class="tab_content">
				<jsp:include page="betting_history.jsp" />
			</div>
			<div id="tab3" class="tab_content">
				<!-- <ul class="smk_accordion">
					<li>
						<div class="acc_head"><h3>1:1문의</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
								<div class="inquiry_wrap">
									<div class="inquiry">
										<div class="inquiry_user">
											<span class="user_tag"><img src="../images/user_tag.jpg"></span>
											<div class="inquiry_text">
											안녕하세요 안녕하세요 안녕하세요안녕하세요 안녕하세요 안녕하세요안녕하세요 안녕하세요 안녕하세요안녕하세요 안녕하세요 안녕하세요안녕하세요 안녕하세요 안녕하세요안녕하세요 안녕하세요 안녕하세요안녕하세요 안녕하세요 안녕하세요안녕하세요 안녕하세요 안녕하세요안녕하세요 안녕하세요 안녕하세요안녕하세요 안녕하세요 안녕하세요안녕하세요 안녕하세요 안녕하세요안녕하세요 안녕하세요 안녕하세요
											</div>
											<div class="user_date">2017-00-00 00:00:00</div>
										</div>
									</div>
									<div class="inquiry">
										<div class="inquiry_admin">
											<span class="admin_tag"><img src="../images/admin_tag.jpg"></span>
											<div class="inquiry_text">
											안녕하세요 안녕하세요 안녕하세요안녕하세요 
											</div>
											<div class="admin_date">2017-00-00 00:00:00</div>
										</div>
									</div>
									<div class="inquiry">
										<div class="inquiry_user">
											<span class="user_tag"><img src="../images/user_tag.jpg"></span>
											<div class="inquiry_text">
											물어볼께있어요
											</div>
											<div class="user_date">2017-00-00 00:00:00</div>
										</div>
									</div>
									<div class="inquiry">
										<div class="inquiry_admin">
											<span class="admin_tag"><img src="../images/admin_tag.jpg"></span>
											<div class="inquiry_text">
											말씀하세요
											</div>
											<div class="admin_date">2017-00-00 00:00:00</div>
										</div>
									</div>
								</div>
								<div class="inquiry_select_wrap">
									<table  width="100%" cellpadding="0" cellspacing="0">
										<tr>
											<td width="300" style="padding:0 10px 0 0">
												<select class="inquiry_select">
													<option>분류</option>
													<option>분류</option>
												</select>
											</td>
											<td width="700" style="padding:0 10px 0 0"><input class="inquiry_input"></td>
											<td><a href="#"><span class="btn5">전송</span></a></td>
										</tr>
									</table>
								</div>
								<div class="acc_btn_wrap">
									<a href="#"><span class="btn3c">확인</span></a> 
								</div>
							</div>
						</div>
					</li>
				</ul> -->
				<jsp:include page="contact.jsp" />
			</div>
			<div id="tab4" class="tab_content">
				<ul class="smk_accordion">
					<li>
						<div class="acc_head"><h3>쪽지함</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
								<table  width="100%" cellpadding="0" cellspacing="0" class="memo_table_title">
									<tr>
										<td width="55%">제목</td>
										<td>보낸이</td>
										<td width="15%">수신일시</td>
										<td width="15%">확인일시</td>
									</tr>
								</table>
								<ul class="popup_accordion">
									<li>
										<a>
											<table width="100%" cellpadding="0" cellspacing="0" class="meno_table">
												<tr>
													<td  width="55%" class="meno_table_left">제목입니다.</td>
													<td class="list_table_center">홍길동</td>
													<td  width="15%" class="meno_table_center">07.07.17</td>
													<td  width="15%" class="meno_table_center">07.07.17</td>
												</tr>
											</table>
										</a>
										<div>
											<table width="100%" cellpadding="0" cellspacing="0" class="meno_table_in">
												<tr>
													<td>제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.니다. 제목입니다.제목입니다. 제목입니다. 제목</td>
												</tr>
											</table>
										</div>
									</li>
									<li>
										<a>
											<table width="100%" cellpadding="0" cellspacing="0" class="meno_table">
												<tr>
													<td  width="55%" class="meno_table_left">제목입니다.</td>
													<td class="list_table_center">홍길동</td>
													<td  width="15%" class="meno_table_center">07.07.17</td>
													<td  width="15%" class="meno_table_center">07.07.17</td>
												</tr>
											</table>
										</a>
										<div>
											<table width="100%" cellpadding="0" cellspacing="0" class="meno_table_in">
												<tr>
													<td>제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제</td>
												</tr>
											</table>
										</div>
									</li>
									<li>
										<a>
											<table width="100%" cellpadding="0" cellspacing="0" class="meno_table">
												<tr>
													<td  width="55%" class="meno_table_left">제목입니다.</td>
													<td class="list_table_center">홍길동</td>
													<td  width="15%" class="meno_table_center">07.07.17</td>
													<td  width="15%" class="meno_table_center">07.07.17</td>
												</tr>
											</table>
										</a>
										<div>
											<table width="100%" cellpadding="0" cellspacing="0" class="meno_table_in">
												<tr>
													<td>제목입니다. </td>
												</tr>
											</table>
										</div>
									</li>
								</ul>
								<script><!--아코디언-->
									(function($) {
										$('.popup_accordion > li:eq(0) a').addClass('active').next().slideDown();

										$('.popup_accordion a').click(function(j) {
											var dropDown = $(this).closest('li').find('div');

											$(this).closest('.popup_accordion').find('div').not(dropDown).slideUp();

											if ($(this).hasClass('active')) {
												$(this).removeClass('active');
											} else {
												$(this).closest('.popup_accordion').find('a.active').removeClass('active');
												$(this).addClass('active');
											}

											dropDown.stop(false, true).slideToggle();

											j.preventDefault();
										});
									})(jQuery);
								</script>
								<div class="acc_btn_wrap_m">
									<a href="#" onClick="layer_pop_mask('close','bg_mask_pop6');return false;"><span class="btn2c">확인</span></a> <a href="#"><span class="btn2">삭제</span></a>
								</div>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div><!-- contents -->
<script>
	$(document).ready(function(){
		setTabActive($.urlParam("tab"));
	});
</script>
<jsp:include page="../footer.jsp" />