<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="dao.GameDao"%> 
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.*"%>
<%@page import="dao.UserDao"%>
<%@page import="bean.UserBean"%>

<%@ include file="/inc/session.jsp"%>

<%
//	UserDao user_db			= new UserDao();	
//	UserBean currentUser 	= user_db.getUserByUserId(UID);
	
%>

<style>
.input_hidden
{
  display:none
}
.incp
{
	display:none
}
.incpw{
	background-color: #424c4e!important;
	color: #404654!important;
	padding: 8px!important;
	border-radius: 20px!important;
	position: absolute;
	top: 120px;
	left: -108px; 
}
.incpwf{
	vertical-align: inherit; 
	color: white;
}
</style>
	
<ul class="smk_accordion">
	<li>
		<div class="acc_head"><h3>충전신청</h3></div>
		<div class="acc_content">
			<div class="acc_content_in_2" id="acc_content_in_chargetb">
				<div class="blue_wrap">
					<div class="cash_box">
						
						<form name="chargeForm" id="chargeForm">
							
						<div class="cash_in">
							<div class="row cash_13">
								<input class="input_style03 pd" id="bankInfoTxt" name="bank_acct" placeholder="비밀번호 입력 후 전용계좌확인 버튼을 클릭해주세요">
								<span id='inc' class="incpw incp"><font class="incpwf">비밀번호가 일치하지 않습니다. </font></span>
							</div>
							<div class="cash_3">
								<button class="btn5" id="bankInfoBtn" DISABLE>전용계좌확인 </button>
							</div>
						</div>
						
						<div class="cash_in">
							<div class="cash_10"><p style="float:left">보유금액</p><p style="float:right"><span class="font_002 money_dsp"><%=dfrmt.format(UBAL)%></span> 원</p></div>
							<div class="cash_9">
									<input class="input_style03" type="text" style="text-align: right;padding-right: 5%;" type="number" id="money" name="money"  placeholder="충전금액">	
							</div>	
						</div>
						
							<div class="cash_in">
								<!--
								<div class="cash_4">
									<select class="input_style02" id="ct_bank_name" name="bank_name">
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
										    <option value="카카오뱅크">카카오뱅크</option>
									</select>
								</div>
								
								-->
								
								<div class="cash_11_1">
									<input class="input_style03" readonly id="ct_bank_owner" name="bank_owner" placeholder="입금자명">		
								</div>
<!-- 								<div class="cash_4">
									<input class="input_style03"  id="ct_bank_num" name="bank_num"  placeholder="계좌번호">		
								</div> -->								
							</div>
							<div class="cash_in">
								<span class="ebtn btn1 add-money" data-am="1" >1만원</span> 
								<span class="ebtn btn1 add-money" data-am="5" >5만원</span> 
								<span class="ebtn btn1 add-money" data-am="10" >10만원</span>
								<span class="ebtn btn1 add-money" data-am="50" >50만원</span> 
								<span class="ebtn btn1 add-money" data-am="100" >100만원</span> 
								<span class="ebtn btn1 add-money" data-am="0" >정정</span>
								<!-- <span class="btn3c">충전신청</span></a> -->
								
							</div>
							<div class="cash_in exbtn">
								<input type="submit" id="ct_submit" value="충전신청" class="btn3c">
							</div>
							
						</form>
					</div>
				</div>
			</div>
		</div>
	</li>
	<li>
		<div class="acc_head dt_div_cash"><h3>충전신청 리스트</h3></div>
		<div class="acc_content">
			<div class="acc_content_in_2">
				<table id="dataTable1_charge" cellspacing="0" cellpadding="0" data-scroll-x="true" style="width: 100%!important;">
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
								<td class="bank_time">23 : 30 ~ 00 : 30</td>
								<td class="bank_name">광주은행</td>
								<td class="bank_time">23 : 50 ~ 00 : 20</td>
							</tr>
							<tr>
								<td class="bank_name b_left">기업은행	</td>
								<td class="bank_time">00 : 00 ~ 00 : 30</td>
								<td class="bank_name">경남은행	</td>
								<td class="bank_time">23 : 30 ~ 01 : 00</td>
							</tr>
							<tr>
								<td class="bank_name b_left">농협	</td>
								<td class="bank_time">23 : 30 ~ 00 : 30</td>
								<td class="bank_name">대구은행	</td>
								<td class="bank_time">23 : 50 ~ 01 : 00</td>
							</tr>
							<tr>
								<td class="bank_name b_left">부산은행	</td>
								<td class="bank_time">00 : 00 ~ 00 : 30</td>
								<td class="bank_name">삼성증권	</td>
								<td class="bank_time">23 : 50 ~ 00 : 10</td>
							</tr>
							<tr>
								<td class="bank_name b_left">수협	</td>
								<td class="bank_time">23 : 30 ~ 00 : 30</td>
								<td class="bank_name">씨티은행	</td>
								<td class="bank_time">23 : 30 ~ 00 : 10</td>
							</tr>
							<tr>
								<td class="bank_name b_left">신한은행	</td>
								<td class="bank_time">23 : 50 ~ 00 : 10</td>
								<td class="bank_name">신협	</td>
								<td class="bank_time">00 : 00 ~ 00 : 30</td>
							</tr>
							<tr>
								<td class="bank_name b_left">새마을금고	</td>
								<td class="bank_time">23 : 00 ~ 00 : 30</td>
								<td class="bank_name">산업은행	</td>
								<td class="bank_time">23 : 00 ~ 01 : 00</td>
							</tr>
							<tr>
								<td class="bank_name b_left">우체국	</td>
								<td class="bank_time">23 : 40 ~ 00 : 30</td>
								<td class="bank_name">외환은행	</td>
								<td class="bank_time">23 : 55 ~ 00 : 05</td>
							</tr>
							<tr>
								<td class="bank_name b_left">우리은행	</td>
								<td class="bank_time">23 : 30 ~ 01 : 00</td>
								<td class="bank_name">전북은행	</td>
								<td class="bank_time">23 : 30 ~ 01 : 00</td>
							</tr>
							<tr>
								<td class="bank_name b_left">제주은행	</td>
								<td class="bank_time">23 : 50 ~ 00 : 20</td>
								<td class="bank_name">제일은행	</td>
								<td class="bank_time">23 : 40 ~ 00 : 30</td>
							</tr>
							<tr>
								<td class="bank_name b_left">하나은행	</td>
								<td class="bank_time">23 : 30 ~ 01 : 00</td>
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
		<span class="popup_close fade_2_close cs_close_charge"><img src="/images/popup_close.png"></span>
	</div>
	<div class="bg_mask_pop2_in">
		<div class="pop_icon_center">
			<img src="/images/check_icon.png">
		</div>
		<div class="pop_text">
			충전 신청이 접수 되었습니다.<br>			
		</div>
		<div class="btn_wrap">
			<span class="btn3c cs_close_charge" style="cursor: pointer;">닫기</span>
		</div>
	</div>
</div>

<!-- confirm1 -->
<div id="conf_modal1" class="bg_mask_pop2 conf_modal">
	<div class="bg_mask_pop_title">
		<span class="popup_logo"><img src="/images/popup_logo.png"></span>
		<span class="popup_close conf_modal_close"><img src="/images/popup_close.png"></span>
	</div>
	<div class="bg_mask_pop2_in">
		<div class="pop_icon_center">
			<img src="/images/question_icon.png">
		</div>
		<div class="pop_text">
			충전 신청 하시겠습니까?
		</div>
		<div class="btn_wrap">			
			<span class="btn3 conf_modal_yes ">확인</span>
			<span class="btn3 conf_modal_close">취소</span>
		</div>
	</div>
</div>

<script>
	$(document).ready(function(){
		
		var $dataTable1_charge;
		$(".add-money").on("click",function(e){
			var am = $(this).attr("data-am");
			addAmount(am);
		});

		$("#bankInfoBtn").on("click",function(){
			
						
			var s = $("#bankInfoTxt").val();
			
			$.ajax({
				url:'/cash/jsp/getBankAccount.jsp',
				data:{'pw':s},
				type:'POST'
			}).done(function(data){
				
				var obj = JSON.parse(data);
				
				console.log(obj.BN);
				
				if(obj.BN =="-1"){
					$("#bankInfoTxt").val();
					$("#inc").removeClass('incp');
					 
				}	else if(data !="" || data !=null){
					$("#inc").addClass("incp");
					$('#bankInfoTxt').val(' ');
					$('#bankInfoTxt').removeClass('pd');
					// data = bank_name - bank_owner - bank_number
					$("#bankInfoTxt").val(obj.BN); 
					$("#ct_bank_owner").val(obj.BO); 
					$('#bankInfoTxt').attr('readonly', true);
					$("#bankInfoBtn").attr("disabled", true);

				}else{
					alert("처리중 오류가 발생하였습니다.");
				}
			});
		});

		$('#chargeSuccesModal').popup({
	      	transition: 'all 0.3s',
	      	scrolllock: true,
	      	onclose:function(){
	      		$('#bankInfoTxt').attr('readonly', false);
				$("#bankInfoBtn").attr("disabled", false);
	      		resetChargeForm();
	    	}
	    });

		$(".cs_close_charge").on("click",function(e){
			e.preventDefault();
			$dataTable1_charge.ajax.reload();
	    	$dataTable1_charge.columns.adjust().draw();
			$("#chargeSuccesModal").popup("hide");

		});

		$dataTable1_charge = $('#dataTable1_charge').DataTable({
			ajax : '/cash/jsp/getChargeList.jsp',
			bProcessing: true,
			sAjaxDataProp:"",
			searching: false,
			bInfo : false,
			lengthChange: false,
			autowWidth:true,
			pageLength: 10,
			aaSorting: [[1,'desc']],
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
                        	var html = '<span class="font_002">'+comma(data)+'</span> 원';
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
			    },
			    emptyTable: "결과가 없습니다.",
			},
            rowCallback : function(row , data , index) {
                
            },
            drawCallback: function( settings ) {
                
            }
    });


      $(".dt_div_cash").on("click",function(){
        	setTimeout(function() {
			  	$dataTable1_charge.columns.adjust().draw();
			}, 100);
      });


     $("#ct_submit").on("click",function(e){
			e.preventDefault();
			
			if($("#chargeForm").valid()){
				$("#bankInfoTxt").qtip("hide");
				$("#money").qtip("hide");
				$("#ct_bank_owner").qtip("hide");
				$("#conf_modal1").popup("show");
				// var data = $("#chargeForm").serializeJSON();
				//submitCharge(data);
			}		
				//$("#conf_modal1").popup("show");
		});

		$("#chargeForm input").on("blur",function(e){
			e.preventDefault();
			var validator = $( "#chargeForm" ).validate(); 
			var id = $(this).attr("id");
			var valid = validator.element("#"+id);
			$(this).qtip("hide");
			// console.log(valid);
			if(!valid && !valid){
				$(this).focusin();
			}			
		});
		
		submitCharge();

	});

	function uncomma(str) {
	    str = String(str);
	    return str.replace(/[^\d]+/g, '');
	}

	$("#chargeForm").validate({
  		errorClass: 'form1-invalid',
    	validClass: 'form1-valid',
    	errorContainer: ".error_cash_in",
  		rules: {			
			bank_acct:{
				required:true,
			},
			money:{
				required:true,
				money_number:true,
				money_min: true,
			}
		},
		messages: {
			bank_acct :{
					required:"비밀번호 입력후 전용계좌를 확인해 주세요.",
			},
			money:{
				required:"금액을 입력해 주세요.",
				money_number: "금액을 숫자로 입력해 주세요.",
				money_min:"최소 만원 이상으로 입력해 주세요.",				
			}

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
				    },
				    show: {
			            when: true,
			            ready: true, 
			            event:false,
			        },
			        hide:{
			        	fixed:true,
			        	event:true,
			        },
			        position: {
				        container: $("#acc_content_in_chargetb"),
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

		}
	});

	
	function comma(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}
	
	function addAmount(amount){
		
		var current_am = parseInt($("#money").val()) || 0;
		if(isNaN(parseInt($("#money").val()))){
			current_am = 0;

		}else{
			current_am = parseInt(numberParser($("#money").val()));
		}

		console.log(current_am);

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
		else if(amount == "50"){
			am = 500000;
			sum = am + current_am;
		}
		else if(amount == "100"){
			am = 1000000;
			sum = am + current_am;
		}else{

		}

		$("#money").val(numberWithCommas(sum));
	}

	function submitCharge(){
		
		$("#conf_modal1 .conf_modal_yes").on("click",function(){
			
		//var sss = $("#money").val(); //$(this).attr("#money"); //$("#money").val;
		$("#money").val(uncomma($("#money").val()));
			
			var data = $("#chargeForm").serializeJSON();
			
			$.ajax({
				url:'/cash/jsp/setChargeApplication.jsp',
				data:data,
				type:'POST'
			}).done(function(data){
				// console.log(data);
				if(data){
					
					console.log("data:" + data);
					
					$("#chargeSuccesModal").popup("show");
					
					/*
					$.get("TegServlet?method=3", function(srv_resp) {
						if ('null' != srv_resp.money) {
							$('.money_dsp').text(number_format(srv_resp.money, 2));
						}
					});
					*/
				}
			});
			// alert("charge_true");
			$("#conf_modal1").popup("hide");
		});
		
	}

	function resetChargeForm(){
		$('#chargeForm input').css("border-color","#2e3032");
		$("#chargeForm")[0].reset();
		$("#chargeForm").validate().resetForm();
	}

	function chargeConfirm(){

	}


</script>