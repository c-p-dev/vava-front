<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.GameDao, java.text.DecimalFormat, java.util.*,dao.UserDao,bean.UserBean;"%>		
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
						<div class="acc_content" id="acc_content_in_pointtb">
							<div class="acc_content_in_2">
								<div class="blue_wrap">
								<form id="pointform">
									<div class="float_inline">
										<div class="cash_in">
											<div class="cash_1"><p style="float:left">보유포인트</p><p style="float:right" class="font_002 pointavail" id="showpoint"><%=dfrmt.format(currentUser.getPoint())%></p></div>
										</div>
										<div class="cash_in">
											<div class="cash_6">
												<input class="input_style03" id="point" name="point" placeholder="입금자명">		
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
											<span class="btn1" id="p1">1만원</span>
		 									<span class="btn1" id="p2">5만원</span>
		 									<span class="btn1" id="p3">10만원</span>
		 									<span class="btn1" id="p4">100만원</span>
											<span><button type="submit" class="btn3c">전환신청</button></span>
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
$(document).ready(function(){
	var p = <%=currentUser.getPoint()%>;
	$("#pointform").validate({
		errorClass: 'form1-invalid',
		validClass: 'form1-valid',
		errorContainer: ".error_cash_in",
			rules: {
				point :{
				required:true,
				digits: true,
				min: 10000,
				max: p,
			},
		},
			
		messages: {
			point :{
				required:"입력이 필요합니다.",
				digits: "입력은 숫자 여야합니다.",
				min:"교환 가능한 최소 금액은 10000입니다.",
				max:"불충분 한 포인트"
			},
		},
		errorPlacement: function(error, element) {

			var error_label = element.attr("name");
			var id = element.attr("id");

			
		    if(error.text() != ""){
		    	element.qtip({ 
				    overwrite: true,
				    content: {
				        text: error,
				        tooltipanchor: $(this),
				        button: 'Close',
				    },
				    show: {
			            when: false,
			            ready: true, 
			            event:false,
			        },
			        hide:{
			        	fixed:true,
			        	event:false,
			        },
			        position: {
				        container: $("#acc_content_in_pointtb"),
				        at: 'top center ',
				        my: 'bottom center', 
				        adjust : {
				        	method : 'shift none',
				        }
				    }
				});
		    
			}else{
				element.qtip("hide");
			}

		},
		submitHandler: function(form) {
			var data = $("#pointform").serializeJSON();
		    submitPoint(data);
	  	}
	});	 
});

function submitPoint(data){
	$.ajax({
		url : '/cash/jsp/switchPoints.jsp',
		data : data,
		dataType: 'JSON',
		method: 'POST',
	}).done(function(data){ 
		// console.log(data);
		// console.log(data.money);
		$('.money_dsp').text(number_format(data.money, 2));
		$('.point_dsp').text(number_format(data.point, 2));
		$('.pointavail').text(number_format(data.point, 2));
		$("#pointform").validate().settings.rules.point.max = data.point;
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
$('#p1').click(function(){
	 var num = +$("#point").val() + 10000;
	 $("#point").val(num);
});
$('#p2').click(function(){
	var num = +$("#point").val() + 50000;
	 $("#point").val(num);
});
$('#p3').click(function(){
	var num = +$("#point").val() + 100000;
	 $("#point").val(num);
});
$('#p4').click(function(){
	var num = +$("#point").val() + 1000000;
	 $("#point").val(num);
});
</script>