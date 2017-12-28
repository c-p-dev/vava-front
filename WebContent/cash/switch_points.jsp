<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="dao.GameDao, java.util.*, bean.UserBean"%>		

<%@ include file="/inc/session.jsp"%>


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

			
			<ul class="smk_accordion">
					<li>
						<div class="accordion_title"><h3>포인트 전환</h3></div>
						<div class="acc_content" id="acc_content_in_pointtb">
							<div class="acc_content_in_2">
								<div class="blue_wrap">
								<form id="pointform">
									<div class="float_inline">
										<div class="cash_in">
											<div class="cash_10"><p style="float:left">보유 포인트</p><p style="float:right" class="font_002 pointavail" id="showpoint"><%=dfrmt.format(UPOINT)%></p></div>
											<div class="cash_9">
												<input class="input_style03" id="point" name="point" style="text-align: right; padding-right:10px;" placeholder="전환할 포인트">		
											</div>
										</div>
										<div class="cash_in">
											<span class="ebtn btn1" id="p1">100포인트</span>
		 									<span class="ebtn btn1" id="p2">300포인트</span>
		 									<span class="ebtn btn1" id="p3">500포인트</span>
		 									<span class="ebtn btn1" id="p5">1000포인트</span>
		 									<span class="ebtn btn1" id="p4">5000포인트</span>
		 									<span class="ebtn btn1" id="reset">정정</span>
										</div>
										<div class="cash_in exbtn">
											<span><button type="submit" id="pointBtnSbmit" class="btn3c">전환신청</button></span>
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
							포인트 전환 신청이 접수 되었습니다.<br>			
						</div>
						<div class="btn_wrap">
							<span class="btn3c cs_close">닫기</span></a>
						</div>
					</div>
				</div>

				<!-- confirm2 -->
				<div id="conf_modal2" class="bg_mask_pop2 conf_modal">
					<div class="bg_mask_pop_title">
						<span class="popup_logo"><img src="/images/popup_logo.png"></span>
						<span class="popup_close conf_modal_close"><img src="/images/popup_close.png"></span>
					</div>
					<div class="bg_mask_pop2_in">
						<div class="pop_icon_center">
							<img src="/images/question_icon.png">
						</div>
						<div class="pop_text">
							포인트 전환 신청 하시겠습니까?
						</div>
						<div class="btn_wrap">
							<span class="btn3 conf_modal_yes ">확인</span>
							<span class="btn3 conf_modal_close">취소</span>
							
						</div>
					</div>
				</div>
<script>
$(document).ready(function(){
	
	var p = <%=UPOINT%>;
	
	
	$("#pointform").validate({
		errorClass: 'form1-invalid',
		validClass: 'form1-valid',
		errorContainer: ".error_cash_in",
			rules: {
				point :{
				required:true,
				money_number:true,
				//money_min: false,
				max_point:p,
				// digits: true,
				// min: 1000,
				 //max: p,
			},
		},
			
		messages: {
			point :{
				required:"전환할 포인트를 입력해 주세요.",
				money_number: "전환할 포인트를 숫자로 입력해 주세요.",
				money_min:"전환 가능한 최소 포인트는 천(1000) 포인트입니다.",
				max_point:"전환할 포인트가 충분하지 않습니다."
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
				        tooltipanchor: $(this)
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
				        at: 'right center ',
				        my: 'left center', 
				        adjust : {
				        	method : 'shift none',
				        }
				    }
				});
		    
			}else{
				element.qtip("hide");
			}

		},
		// submitHandler: function(form) {
		// 	var data = $("#pointform").serializeJSON();
		//     submitPoint(data);
	 //  	}
	});

	submitPoint();	 
});

function submitPoint(){

	$("#conf_modal2 .conf_modal_yes").on("click",function(){
		
		var data = $("#pointform").serializeJSON();
		
		if(data != null){
			var p = data.point;
			data.point = numberParser(p);
		} 
		
		$.ajax({
			url : '/cash/jsp/switchPoints.jsp',
			data : data,
			dataType: 'JSON',
			method: 'POST',
		}).done(function(data){ 
			
			if(data){
				
				//var obj = JSON.parse(data);
				
			 
			 
			 
			 
			 if(data.isValid){
				updateInstBal();		
				$("#showpoint").text(numberWithCommas(data.point));		
				$("#PointSuccesModal").popup("show");
				
			}
			 
			 /*
			 if(data.isValid){

				$.ajax({
					url : '/login/jsp/get_header.jsp', //jsp				
					data : {},
					method: 'GET',
					error: function(){
						toastr.success("처리중 오류가 발생했습니다.");
					}
				}).done(function(data){
					var obj = JSON.parse(data);
					$("#uhead").html(obj.header);
					$("#fade_3").popup("hide");
					$("#lgInMdl2").popup("show");
					createPopup(obj.popup);
					$('a.get-vbet-hist').parent().show();
				});
				// toastr.success('Login Successful');
				// $("#fade_3").popup("hide");
				// $("#loginModal").popup("show");
				

			}
			*/
			
			
			
			//getheader
			
			//$('.money_dsp').text(number_format(data.money,0));
			//$('.point_dsp').text(number_format(data.point,0));
			//$('.pointavail').text(number_format(data.point,0));
			//$("#pointform").validate().settings.rules.point.max = data.point;
			
			
			
			
		}
		});
		// alert("switch true");
		$("#conf_modal1").popup("hide")
	});
}

$("#pointform input").on("blur",function(e){
	e.preventDefault();
	var validator = $( "#pointform" ).validate(); 
	var id = $(this).attr("id");
	var valid = validator.element("#"+id);
	$(this).qtip("hide");

	if(!valid && !valid){
		$(this).focusin();
	}			
});

$("#point").on("change",function(e){
	e.preventDefault();
	var data = $(this).val();
	$(this).val(numberWithCommas(data));
});

$("#pointBtnSbmit").on("click",function(e){
	e.preventDefault();
	if($("#pointform").valid()){
		$("#point").qtip("hide");
		$("#conf_modal2").popup("show");
	    
	}
});


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
	// $( "#err-msg1" ).hide();
}



$('#reset').click(function(){
	$("#point").val("0");
});

$('#p1').click(function(){
	// var num = + $("#point").val() + 10000;
	// $("#point").val(numberWithCommas(num));
	addVal(100);
});

$('#p2').click(function(){
	// var num = + $("#point").val() + 50000;
	// $("#point").val(numberWithCommas(num));
	addVal(300);
});

$('#p3').click(function(){
	// var num = + $("#point").val() + 100000;
	// $("#point").val(numberWithCommas(num));
	addVal(500);
});

$('#p4').click(function(){
	// var num = + $("#point").val() + 1000000;
	// $("#point").val(numberWithCommas(num));
	addVal(5000);
});
$('#p5').click(function(){
	// var num = + $("#point").val() + 1000000;
	// $("#point").val(numberWithCommas(num));
	addVal(1000);
});


function addVal(point){
	var amount = parseInt($("#point").val()) || 0;
	if(isNaN(parseInt($("#point").val()))){
		amount = 0;

	}else{
		amount = parseInt(numberParser($("#point").val()));
	}

	var sum = amount + point;
	$("#point").val(numberWithCommas(sum));

	var validator = $( "#pointform" ).validate(); 
	var valid = validator.element("#point");
	if(valid){
		$("#point").qtip("hide");
	}
}


	function updateInstBal() {	
			
	 		$.ajax({
				url: '/inc/UpdateBal.jsp',
				data : {},
				method: 'GET',
				cache: false,
			}).done(function(data){				
				
				var obj = JSON.parse(data);
											
				if(obj.R){
				
					$.ajax({
						url : '/login/jsp/get_header.jsp', //jsp				
						data : {},
						method: 'GET',
					}).done(function(data){					
						var obj = JSON.parse(data);
						$("#uhead").html(obj.header);
						
						
						//$("#balmoney").text(numberWithCommas(obj.bal));
						
						
						
						

			  	
						//$("#withdraw").val(obj.bal);
						
					});				
					
				} else {
					
				}
				
				data=null;
			}).error(function(data, status, headers, config) {

				data=null;
			});
		
	}
	
</script>