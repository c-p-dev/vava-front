<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.vavasoft.bean.UserBean, net.vavasoft.dao.UserDao, java.text.DecimalFormat"%>
<style>
	.add-money{
		cursor: pointer;
	}
	.error_cash_in{
		margin:0px;
		display: none;
	}
	
	/*datatable*/
	.dataTables_wrapper .dataTables_paginate {
	     float: none!important; 
	    text-align: center!important;
	    padding-top: 20px!important;
	}
	.dataTables_wrapper .dataTables_paginate .paginate_button{
		padding: 8px 12px 8px 12px!important;
	    font-size: 12px!important;
	    border-radius: 3px!important;
	    display: inline-block!important;
	    background: #2b2d2e!important;
	    color:white!important;
	}
	.dataTables_wrapper .dataTables_paginate .paginate_button.current, .dataTables_wrapper .dataTables_paginate .paginate_button.current:hover {
	    color: #333 !important;
	    color: #ffffff!important;
	    background: #0792c4!important;
	    border:none!important;
	}
	.dataTables_wrapper {
	    width: 100%!important;
	    margin: 0 0 20px 0!important;
	    border-top: solid 1px #0792c4!important;
	}
	table.dataTable thead th{ 
	    color: #ffffff!important;
	    background: #151516!important;
	    /*height: 40px!important;*/ 	 
	    text-align: center!important;
	    border-bottom: solid 1px #000000!important;
	}
	table.dataTable tbody tr {
	    background-color: transparent;
	}
	table.dataTable tbody td {
	     padding: 0px; 
	    text-align: center;
	    border-bottom: solid 1px #2e3032;
	    height: 40px;
	}
</style>
<jsp:useBean id="bean" class="net.vavasoft.bean.UserBean" />
<%
	DecimalFormat dfrmt				= new DecimalFormat("#,###,###,###,###.00");

	if(session.getAttribute("currentSessionUser") != null){
		bean = (net.vavasoft.bean.UserBean) session.getAttribute("currentSessionUser");	
	}
%>
<%
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
			<div class="acc_head"><h3>환전신청 </h3></div>
			<div class="acc_content">
				<div class="acc_content_in_2">
				<form name="formwithdraw" id="formwithdraw" method="post">
					<div class="blue_wrap">
						<div class="cash_box">
							<div class="cash_in">
								<div class="cash_1"><p style="float:left">보유금액</p><p style="float:right"><span class="font_002 money_dsp" id="money"><%=dfrmt.format(currentUser.getMoney())%></span>원 </p></div>
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
		<div class="acc_head dt_div"><h3>충전신청 리스트</h3></div>
		<div class="acc_content">
			<div class="acc_content_in_2">
				<table id="dataTable2" cellspacing="0" cellpadding="0" data-scroll-x="true" style="width: 100%!important;">
            	</table>
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
<!-- success -->
<div id="ExchangeSuccesModal" class="bg_mask_pop2">
	<div class="bg_mask_pop_title">
		<span class="popup_logo"><img src="/images/popup_logo.png"></span>
		<span class="popup_close fade_2_close cs_close"><img src="/images/popup_close.png"></span>
	</div>
	<div class="bg_mask_pop2_in">
		<div class="pop_icon_center">
			<img src="/images/check_icon.png">
		</div>
		<div class="pop_text">
			Exchange Application Submited<br>			
		</div>
		<div class="btn_wrap">
			<span class="btn3c cs_close">충전하기</span></a>
		</div>
	</div>
</div>
<script>
$dataTable1 = $('#dataTable2').DataTable({
	ajax : 'process/application/exchange/getWithdrawList.jsp',
	bProcessing: true,
	sAjaxDataProp:"",
	searching: false,
	bInfo : false,
	lengthChange: false,
	autowWidth:true,
    columns : [
        	{ 
                data   : 'wdid',
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
                data   : 'wdstate',
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
		$("#ExchangeSuccesModal").popup("show");
		//var mmm = parseInt($('#money').text());
		//var newmmmm = mmm - parseInt($('#withdraw').val());
		//$('#money').text(newmmmm);
		//console.log(newmmmm)
	});
}
$('#ExchangeSuccesModal').popup({
  	transition: 'all 0.3s',
  	scrolllock: true,
  	onclose:function(){
  		resetformwithdraw();
	}
});

$(".cs_close").on("click",function(e){
	e.preventDefault();
	$dataTable1.ajax.reload();
	$dataTable1.columns.adjust().draw();
	$("#ExchangeSuccesModal").popup("hide");

});
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