<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="net.vavasoft.dao.GameDao, java.text.DecimalFormat, java.util.*,net.vavasoft.dao.UserDao,net.vavasoft.bean.UserBean;"%>		
<style>
	.add-money{
		cursor: pointer;
	}
	.error_cash_in{
		margin:0px;
		display: none;
	}
	input[type="text"]:-ms-input-placeholder {
    text-align: left;
	}
	input[type="text"]::-webkit-input-placeholder {
	    text-align: left;
	}
	input::-moz-placeholder {
	 text-align: left;
	}	

</style>
<%
	DecimalFormat dfrmt				= new DecimalFormat("#,###,###,###,###.00");
	boolean checkSession = false;
	UserDao user_db			= new UserDao();
	UserBean user_data		= (UserBean)session.getAttribute("currentSessionUser");
	UserBean currentUser 	= user_data;
	if(session.getAttribute("currentSessionUser") != null) {
		currentUser 		= user_db.getUserByUserId(user_data.getUserid());
		checkSession = true;
	}
%>	
			
			<ul class="smk_accordion">
					<li>
						<div class="accordion_title"><h3>포인트전환</h3></div>
						<div class="acc_content">
							<div class="acc_content_in_2">
								<div class="blue_wrap">
								<form id="pointform">
									<div class="float_inline">
											<div class="point_box">
												<div class="cash_in">
													<div class="cash_1"><p style="float:left">보유포인트</p><p style="float:right" class="font_002 pointavail" id="showpoint"><%=dfrmt.format(currentUser.getPoint())%></p></div>
												</div>
												<div class="cash_in">
													<div class="cash_6">
														<input class="input_style03" id="point" placeholder="입금자명">		
													</div>
													<div class="cash_3">
														<span class="btn5" id="reset">정정</span>
													</div>	
													
												</div>
												<div class="cash_in">
													<div class="cash_7">
														<span id="err-msg1" style="color:orange;"></span>
													</div>
												</div>
												<div class="cash_in">
													<span><button type="submit" class="btn3c">전환신청</button></span>
												</div>
											</div>
										<div class="point_banner">
											배너배너배너
										</div>
									</div>
								</form>
								</div>
							</div>
						</div>
					</li>
				</ul>
				<!-- success -->
				<div id="PointSuccesModal" class="bg_mask_pop2">
					<div class="bg_mask_pop_title">
						<span class="popup_logo"><img src="/images/popup_logo.png"></span>
						<span class="popup_close fade_2_close cs_close"><img src="/images/popup_close.png"></span>
					</div>
					<div class="bg_mask_pop2_in">
						<div class="pop_icon_center">
							<img src="/images/check_icon.png">
						</div>
						<div class="pop_text">
							Point Switch Success<br>			
						</div>
						<div class="btn_wrap">
							<span class="btn3c cs_close">충전하기</span></a>
						</div>
					</div>
				</div>
<script>
$( "#pointform" ).submit(function( event ) {
	  validateForm();
	  return false;
	});
function validateForm()
{	
	
	var numbers = /^[0-9]+$/;
	var point = $('#point').val();
	var avail_point = $('#showpoint').val();
	
    if(point=="")
    {
    	$( "#err-msg1" ).text( "Enter Point" ).show();
    	event.preventDefault();
    	 $('#point').css('border-color', 'red');
      return false;
    }
    if(point.match(numbers))
    {	    	
    	if(point <= 999)
	    {
	    	$( "#err-msg1" ).text( "최소 전환 가능 포인트는 1,000 포인트입니다" ).show();
	    	event.preventDefault();
	    	 $('#point').css('border-color', 'red');
	      return false;
	    }
    	else {
    		console.log(point);
    		var point = {point : point};
	    	submitForm(point);
	      	return true;
    	}
    }
    
    else  
      {  
    	$( "#err-msg1" ).text( "Numbers Only" ).show();
    	event.preventDefault();
    	 $('#point').css('border-color', 'red');
      return false; 
      }
}
function submitForm(point){
	$.ajax({
		url : 'process/application/switch_points/switchPoints.jsp',
		data : point,
		dataType: 'JSON',
		method: 'POST',
	}).done(function(data){ 
		console.log(data);
		console.log(data.money);
		$('.money_dsp').text(number_format(data.money, 2));
		$('.point_dsp').text(number_format(data.point, 2));
		$('.pointavail').text(number_format(data.point, 2));
		$("#PointSuccesModal").popup("show");
		
	});
}
$('#PointSuccesModal').popup({
  	transition: 'all 0.3s',
  	scrolllock: true,
  	onclose:function(){
  		resetpointform();
	}
});

$(".cs_close").on("click",function(e){
	e.preventDefault();
	$("#PointSuccesModal").popup("hide");

});
function resetpointform(){
	$("#pointform")[0].reset();
	$('#point').css('border-color', '#373332');
	$( "#err-msg1" ).hide();
}
$('#reset').click(function(){
	$("#point").val("0");
});
</script>