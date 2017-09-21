<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.add-money{
		cursor: pointer;
	}
	.error_cash_in{
		margin:0px;
		display: none;
	}
</style>
<jsp:useBean id="bean" class="net.vavasoft.bean.UserBean" />
<%
	java.util.Formatter formatter = new java.util.Formatter();
	if(session.getAttribute("currentSessionUser") != null){
		bean = (net.vavasoft.bean.UserBean) session.getAttribute("currentSessionUser");	
	}
%>


<ul class="smk_accordion">
		<li>
			<div class="acc_head"><h3>환전신청 </h3></div>
			<div class="acc_content">
				<div class="acc_content_in_2">
				<form name="formwithdraw" id="formwithdraw" method="post">
					<div class="blue_wrap">
						<div class="cash_box">
							<div class="cash_in">
								<div class="cash_1"><p style="float:left">보유금액</p><p style="float:right"><span  class="font_002" id="money"><%=formatter.format("%.2f", (float) bean.getMoney())%></span>원 </p></div>
							</div>
							<div class="cash_in">
								<div class="cash_4">
									<input class="input_style03"  placeholder="환전금액" id="withdraw" name="withdraw">		
								</div>	
								<div class="cash_5">
									<span id="err-msg"></span>
								</div>
							</div>
							<div class="cash_in">
								<input class="btn1" type="button" value = "10000원" id="button1"> 
 	 									<input class="btn1" type="button" value = "50000원" id="button2"> 
 	 									<input class="btn1" type="button" value = "100000원" id="button3"> 
 	 									<input class="btn1" type="button" value = "1000000원" id="button4">
 	 									<input class="btn1" type="button" value = "정정" id="button5">
								<span><button type="submit" class="btn3c">환전신청</button></span>
							</div>
						</div>
					</div>
					</form>
				</div>
			</div>
		</li>
		<li>
			<div class="acc_head"><h3>환전신청 리스트</h3></div>
			<div class="acc_content">
				<div class="acc_content_in_2">
					<table class="list_table" cellspacing="0" cellpadding="0" width="100%">
						<tr>
							<td class="list_table_t" width="10%">번호</td>
							<td class="list_table_t" width="40%">신청일시</td>
							<td class="list_table_t" width="25%">금액</td>
							<td class="list_table_t" width="25%">상태</td>
						</tr>
						<tr> 
							<td class="list_table_center">123</td>
							<td class="list_table_center">2017-02-02</td>
							<td class="list_table_center"><span class="font_002">100,000</span>원</td>
							<td class="list_table_center font_009">신청</td>
						</tr>
						<tr>
							<td class="list_table_center">123</td>
							<td class="list_table_center">2017-02-02</td>
							<td class="list_table_center"><span class="font_002">100,000</span>원</td>
							<td class="list_table_center font_010">대기</td>
						</tr>
						<tr>
							<td class="list_table_center">123</td>
							<td class="list_table_center">2017-02-02</td>
							<td class="list_table_center"><span class="font_002">100,000</span>원</td>
							<td class="list_table_center">완료</td>
						</tr>
					</table>
					<div class="acc_btn_wrap"><a href="#"><div class="page"> >> </div></a> <a href="#"><span class="page"> > </span></a> <a href="#"><div class="page_on">1</div></a> <a href="#"><div class="page">2</div></a> <a href="#"><div class="page">3</div></a> <a href="#"><div class="page">4</div></a> <a href="#"><div class="page">5</div></a> <a href="#"><div class="page"> > </div></a> <a href="#"><div class="page"> >> </div></a></div>
				</div>			
			</div>
		</li>
		<li>
			<div class="acc_head"><h3>환전신청 관련 유의사항</h3></div>
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
<script>

	$('.acc_content_in_2').on('submit', '#formwithdraw', function(){
		console.log('aww');
		validateForm();
		return false;
	});
	
	function validateForm()
	{	
		var numbers = /^[0-9]+$/;
		var withdraw = document.formwithdraw.withdraw.value;
	    if(withdraw=="")
	    {
	    	$( "#err-msg" ).text( "Enter Money" ).show();
	    	event.preventDefault();
	      return false;
	    }
	    if(withdraw.match(numbers))
	    {
	    	
	    	if(withdraw <= 9999)
		    {
		    	$( "#err-msg" ).text( "Minimum exchangeable amount is 10,000 won" ).show();
		    	event.preventDefault();
		      return false;
		    }
	    	
	    	else {
	    		console.log(withdraw);
	    	var withdraw = {withdraw : withdraw};
	    	submitForm(withdraw);
	      	return true;
	    	}
	    }
	    
	    else  
	      {  
	    	$( "#err-msg" ).text( "Numbers Only" ).show();
	    	event.preventDefault();
	      return false; 
	      }
	    
	}
	
function submitForm(withdraw){
	$.ajax({
		url : 'process/application/exchange/withdrawprocess.jsp',
		data : withdraw,
		method: 'POST',
	}).done(function(data){ 
		//var mmm = parseInt($('#money').text());
		//var newmmmm = mmm - parseInt($('#withdraw').val());
		//$('#money').text(newmmmm);
		//console.log(newmmmm)
	});
}
$('#button1').click(function(){
	 $("#withdraw").val("10000");
});
$('#button2').click(function(){
	$("#withdraw").val("50000");
});
$('#button3').click(function(){
	$("#withdraw").val("100000");
});
$('#button4').click(function(){
	$("#withdraw").val("1000000");
});
$('#button5').click(function(){
	$("#withdraw").val("0");
});
</script> 