<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script><!-- switch -->
<link href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css"><!-- gateway -->
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
		<div class="acc_head"><h3>충전신청</h3></div>
		<div class="acc_content">
			<div class="acc_content_in_2">
				<div class="blue_wrap">
					<div class="cash_box">
						<div class="cash_in">
							<div class="cash_1"><p style="float:left">보유금액</p><p style="float:right"><span class="font_002 money_dsp"><%=dfrmt.format(currentUser.getMoney())%></span> 원</p></div>
							<div class="cash_2">
								<input class="input_style03" id="bankInfoTxt" placeholder="비밀번호 입력 후 “전용계좌확인” 버튼을 클릭해주세요">
							</div>
							<div class="cash_3">
								<span class="btn5" id="bankInfoBtn">전용계좌확인</span>
							</div>
						</div>
						<form name="chargeForm" id="chargeForm">
							<div class="cash_in">
								<div class="cash_4">
									<select class="input_style02" name="bank_name">
										 	<option value="국민은행" selected>국민은행</option>
										    <option value="기업은행">기업은행</option>
										    <option value="경남은행">경남은행</option>
										    <option value="광주은행">광주은행</option>
										    <option value="동부증권">동부증권</option>
										    <option value="대구은행">대구은행</option>
										    <option value="부산은행">부산은행</option>
										    <option value="산업은행">산업은행</option>
										    <option value="삼성증권">삼성증권</option>
										    <option value="삼성증권">신영증권</option>
										    <option value="신한은행">신한은행</option>
										    <option value="우리은행">우리은행</option>
										    <option value="외환은행">외환은행</option>
										    <option value="저축은행">저축은행</option>
										    <option value="전북은행">전북은행</option>
										    <option value="제주은행">제주은행</option>
										    <option value="하나은행">하나은행</option>
										    <option value="CITI은행">CITI은행</option>
										    <option value="HSBC은행">HSBC은행</option>
										    <option value="SC제일">SC제일</option>
										    <option value="새마을금고">새마을금고</option>
										    <option value="우체국">우체국</option>
										    <option value="농협중앙회">농협중앙회</option>
										    <option value="단위농협">단위농협</option>
										    <option value="신협">신협</option>
										    <option value="수협">수협</option>
										    <option value="동양증권">동양증권</option>
										    <option value="유진투자증권">유진투자증권</option>
										    <option value="한국투자은행">한국투자은행</option>
										    <option value="HMC투자증권">HMC투자증권</option>
										    <option value="IBK투자증권">IBK투자증권</option>
									</select>
								</div>
								<div class="cash_4">
									<input class="input_style03"  name="bank_owner" placeholder="Name of depositor" placeholder="입금자명">		
								</div>
								<div class="cash_4">
									<input class="input_style03"  name="bank_num" placeholder="Enter your account number" placeholder="입금자명">		
								</div>
								<div class="cash_4">
									<input class="input_style03" type="text" style="text-align: right;padding-right: 5%;" type="number" id="money" name="money" placeholder="Charge amount" placeholder="충전금액">		
								</div>	
								
							</div>
							<div class="cash_in error_cash_in">
								<div class="cash_4">
									<div class="input_warning" id="bank_name-charge-warn">입력하신 번호로 인증번호가 발송되었습니다.</div>
								</div>
								<div class="cash_4">
									<div class="input_warning" id="bank_owner-charge-warn">입력하신 번호로 인증번호가 발송되었습니다.</div>
								</div>
								<div class="cash_4">
									<div class="input_warning" id="bank_num-charge-warn">입력하신 번호로 인증번호가 발송되었습니다.</div>
								</div>
								<div class="cash_4">
									<div class="input_warning" id="money-charge-warn">입력하신 번호로 인증번호가 발송되었습니다.</div>
								</div>	
							</div>
							<div class="cash_in">
								<span class="btn1 add-money" data-am="1" >1만원</span> 
								<span class="btn1 add-money" data-am="5" >5만원</span> 
								<span class="btn1 add-money" data-am="10" >10만원</span> 
								<span class="btn1 add-money" data-am="100" >100만원</span> 
								<span class="btn1 add-money" data-am="0" >정정</span>
								<!-- <span class="btn3c">충전신청</span></a> -->
								<input type="submit" value="충전신청" class="btn3c">
							</div>
							
						</form>
					</div>
				</div>
			</div>
		</div>
	</li>
	<li>
		<div class="acc_head dt_div"><h3>충전신청 리스트</h3></div>
		<div class="acc_content">
			<div class="acc_content_in_2">
				<table id="dataTable1" cellspacing="0" cellpadding="0" data-scroll-x="true" style="width: 100%!important;">
            	</table>
			</div>
		</div>
	</li>
	<li>
		<div class="acc_head"><h3>충전신청 관련 유의사항</h3></div>
		<div class="acc_content">
			<div class="acc_content_in_2">
				<ul class="cash_warning">
					<li>· 수표 입금 불가</li>
					<li>· 입금자명과 신청 금액이 입금 내용과 동일 해야 함 (상이 할 경우 환전 처리 불가)</li>
					<li>· 의도적인 부정 환전 신청이 중복 될 경우 즉시 회원 자격이 상실 됩니다.</li>
					<li>· 환전은 입금 후 5분 이내에 완료가 됩니다.</li>
					<li>· 단, 해당 은행의 평일 점검, 서버 점검, 전산 장애가 있을 경우 환전이 지연 되오니 양해바랍니다.</li>
				</ul>
				<div class="cash_bank">
					<span class="font_006">은행 점검 시간</span>	
					<table cellspacing="0" cellpadding="0" class="back_table">
						<tr>
							<td class="bank_name b_left">국민은행</td>
							<td class="bank_time">00 : 00 ~ 00 : 00</td>
							<td class="bank_name">우리은행</td>
							<td class="bank_time">00 : 00 ~ 00 : 00</td>
						</tr>
						<tr>
							<td class="bank_name b_left">국민은행</td>
							<td class="bank_time">00 : 00 ~ 00 : 00</td>
							<td class="bank_name">우리은행</td>
							<td class="bank_time">00 : 00 ~ 00 : 00</td>
						</tr>
						<tr>
							<td class="bank_name b_left">국민은행</td>
							<td class="bank_time">00 : 00 ~ 00 : 00</td>
							<td class="bank_name">우리은행</td>
							<td class="bank_time">00 : 00 ~ 00 : 00</td>
						</tr>
						<tr>
							<td class="bank_name b_left">국민은행</td>
							<td class="bank_time">00 : 00 ~ 00 : 00</td>
							<td class="bank_name">우리은행</td>
							<td class="bank_time">00 : 00 ~ 00 : 00</td>
						</tr>
					</table>	
				</div>
			</div>
		</div>
	</li>
</ul>

<!-- success -->
<div id="chargeSuccesModal" class="bg_mask_pop2">
	<div class="bg_mask_pop_title">
		<span class="popup_logo"><img src="/images/popup_logo.png"></span>
		<span class="popup_close fade_2_close cs_close"><img src="/images/popup_close.png"></span>
	</div>
	<div class="bg_mask_pop2_in">
		<div class="pop_icon_center">
			<img src="/images/check_icon.png">
		</div>
		<div class="pop_text">
			Charge Application Submited<br>			
		</div>
		<div class="btn_wrap">
			<span class="btn3c cs_close">충전하기</span></a>
		</div>
	</div>
</div>
<script>
	$(document).ready(function(){
		
		var $dataTable1;
		$(".add-money").on("click",function(e){
			var am = $(this).attr("data-am");
			addAmount(am);
		});

		$("#bankInfoBtn").on("click",function(){
			$.ajax({
				url:'process/application/charge/getBankAccount.jsp',
				data:{},
				type:'POST'
			}).done(function(data){
				if(data !="" || data !=null){
					// data = bank_name - bank_owner - bank_number
					$("#bankInfoTxt").val(data); 

				}else{
					alert("something went wrong");
				}
			});
		});

		$('#chargeSuccesModal').popup({
	      	transition: 'all 0.3s',
	      	scrolllock: true,
	      	onclose:function(){
	      		resetChargeForm();
	    	}
	    });

		$(".cs_close").on("click",function(e){
			e.preventDefault();
			$dataTable1.ajax.reload();
	    	$dataTable1.columns.adjust().draw();
			$("#chargeSuccesModal").popup("hide");

		});

		$dataTable1 = $('#dataTable1').DataTable({
			ajax : 'process/application/charge/getChargeList.jsp',
			bProcessing: true,
			sAjaxDataProp:"",
			searching: false,
			bInfo : false,
			lengthChange: false,
			autowWidth:true,
			pageLength: 10,
            columns : [
                	{ 
                        data   : 'chid',
                        title  : '번호',

                    },
                    { 
                        data   : 'regdate',
                        title  : '신청일시',
                    },
                    { 
                        data   : 'money',
                        title  : '금액',
                        render : function(data,type,row,meta){
                        	var html = '<span class="font_002">'+data+'</span> 원';
                        	return html;
                        }
                    },
                    { 
                        data   : 'chstate',
                        title  : '상태',
                       	render : function(data,type,row,meta){
                        	var html = '<span class="font_009">신청<span>'; // pending
                        	if(data == "DONE"){
                        		html = '<span>완료</span>'; // complete
                        	}else if(data=="WAIT"){
                        		html = '<span class="font_010">대기</span>';
                        	}
                        	return html;
                        }
                       
                    },
                ],
        	pagingType: "full_numbers",
            language: {
			    paginate: {
			      	previous: "<",
			      	next: ">",
			      	first: "<<",
			      	last: ">>",
			    }
			},
            rowCallback : function(row , data , index) {
                
            },
            drawCallback: function( settings ) {
                
            }
        });


        $(".dt_div").on("click",function(){
        	
        	setTimeout(function() {
			  	$dataTable1.columns.adjust().draw();
			}, 100);
        });

	});

	$("#chargeForm").validate({
  		errorClass: 'form1-invalid',
    	validClass: 'form1-valid',
    	errorContainer: ".error_cash_in",
  		rules: {
			bank_name :{
				required:true,
			},
			bank_num :{
				required:true,
				digits: true,
			},
			bank_owner :{
				required:true,
				alphanumeric: true,
			},
			money:{
				required:true,
				digits: true,
				min:10,
				range: [10, 9999999999]
			}
		},
		messages: {
		    bank_name :{
				required:"Bank Name is required.",
			},
			bank_num :{
				required:"Bank Account Number is required",
				digits: "Bank Number must be numbers",
			},
			bank_owner :{
				required:"Depositor Name is required",
			},
			money:{
				required:"Money is required",
				digits: "Money should be money",
				min:"The minimum charge is $10.",
				range:"The minimum charge is $10.",
			}

		},
		errorPlacement: function(error, element) {
			$('#chargeForm input').css("border-color","#2e3032");
			var error_label = element.attr("name");
		    if (element.attr("name") == error_label ){
		    	$("#"+error_label+"-charge-warn").html(error).show();
		    	$('#'+error_label).css("border-color","#d50000");
		    }
		},
		submitHandler: function(form) {
			var data = $("#chargeForm").serializeJSON();
		    submitCharge(data);
		

	  	}
	});

	function addAmount(amount){
		
		var current_am = parseInt($("#money").val()) || 0;
		var am = 0;
		var sum = 0;
		if(amount == "1"){
			am = 10000;
			sum = am + current_am;
		}
		else if(amount == "5"){
			am = 50000;
			sum = am + current_am;
		}
		else if(amount == "10"){
			am = 100000;
			sum = am + current_am;
		}
		else if(amount == "100"){
			am = 1000000;
			sum = am + current_am;
		}

		$("#money").val(sum);
	}

	function submitCharge(data){
		console.log(data);
		$.ajax({
			url:'process/application/charge/setChargeApplication.jsp',
			data:data,
			type:'POST'
		}).done(function(data){
			console.log(data);
			if(data){
				$("#chargeSuccesModal").popup("show");
				
				$.get("TegServlet?method=3", function(srv_resp) {
					if ('null' != srv_resp.money) {
						$('.money_dsp').text(number_format(srv_resp.money, 2));
					}
				});
			}
		});
		
	}

	function resetChargeForm(){
		$('#chargeForm input').css("border-color","#2e3032");
		$("#chargeForm")[0].reset();
		$("#chargeForm").validate().resetForm();
	}

</script>