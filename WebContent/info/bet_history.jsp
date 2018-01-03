<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="bean.*"%>
<%@page import="dao.*"%>
<%@page import="java.util.*"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="com.google.gson.reflect.TypeToken"%>
<%@ page import="java.text.DecimalFormat" %>

<jsp:useBean id="bm" class="bc4.BetConManager2" />
<%

	boolean checkSession=false;
	String SITEID = "1";	
	String UID=null;
	
	HttpSession sess = request.getSession(false);		
	 
	if((String) sess.getAttribute("UID") != null){			
		checkSession = true;			
	 	UID = (String)sess.getAttribute("UID");		
	}
	
	
					
	List<BettingListBean> bl = bm.getBetList(SITEID,UID);
	List<BettingSName> bs = bm.getBetSNames(SITEID,UID);

	List<BettingListBean_SC> bl_sc = bm.getBetList_SC(SITEID,UID);
	List<BettingListBean_SC> bl_mg = bm.getBetList_MG(SITEID,UID);
	List<BettingListBean_SC> bl_ag = bm.getBetList_AG(SITEID,UID);

	Gson gson = new Gson();
	Type type = new TypeToken<List<BettingListBean>>() {}.getType();
	Type type2 = new TypeToken<List<BettingSName>>() {}.getType();

	String blj = gson.toJson(bl, type);      
	String bsj = gson.toJson(bs, type);   
%>

<style>
	table.dataTable tbody td {
	    padding: 0px!important;
	    text-align: center!important;
	    height: 35px!important;

	}

	table.dataTable tbody tr:nth-child(odd) {
		cursor:pointer;
		background:#262a2b;
	}

	table.dataTable tbody tr:nth-child(even) {
		cursor:pointer;
		background:#262a2b;
	}	

	table.dataTable tbody tr{
		background:#262a2b;
	}

	.dataTables_empty{
	 height:50px;
	}

	.dataTables_filter {
		display: none; 
	}

	.list_table_t_1{
		border-right:solid 1px #1c2021
	}

	.sdp,.bclose{
		cursor: pointer;
	}
	#table1 tbody tr td{

	}
	.pika-table {
	    min-height: 201px!important;
	}
</style>

<script>

	var mainAngular = angular.module('Vava', [ 'ngAnimate', 'vAccordion' ]);
	mainAngular.controller("mc", function($scope, $templateCache, $compile, $http) {		
		$scope.BLJ = <%=blj%>;
		$scope.BSJ = <%=bsj%>;	
		$scope.table = table1;		

		$scope.updateSport = function(item) {
			// console.log(item);
			table1.columns(9).search(item).draw();
			table1.draw();
		}

		Date.prototype.yyyymmdd = function() {
			var yyyy = this.getFullYear();
			var mm = this.getMonth() < 9 ? "0" + (this.getMonth() + 1) : (this.getMonth() + 1); // getMonth() is zero-based
			var dd  = this.getDate() < 10 ? "0" + this.getDate() : this.getDate();
			return "".concat(yyyy).concat(mm).concat(dd);
	  	};
	});
	
	function selBet(bid,$scope){
		
		var row = table1.row(document.getElementById(bid)); 
		// console.log(row);
	 	//var row = table.row(document.getElementById('cbForm1').cb); 
	 	//var row = table.row(document.getElementById('SP_'+bid));
	 	//console.log(row);
	 
	 	var $scope = angular.element(document.getElementById(bid)).scope();
	 	var $http = angular.injector(['ng', 'Vava']).get('$http');
		var $filter = angular.injector(['ng', 'Vava']).get('$filter');

		/*
			var sss="	<div id='spin_re_"+bid+"' class='sk-circle'> " +
			"		  <div class='sk-circle1 sk-child'></div>" +
			"		  <div class='sk-circle2 sk-child'></div>" +
			"		  <div class='sk-circle3 sk-child'></div>" +
			"		  <div class='sk-circle4 sk-child'></div>" +
			"		  <div class='sk-circle5 sk-child'></div>" +
			"		  <div class='sk-circle6 sk-child'></div>" +
			"		  <div class='sk-circle7 sk-child'></div>" +
			"		  <div class='sk-circle8 sk-child'></div>" +
			"		  <div class='sk-circle9 sk-child'></div>" +
			"		  <div class='sk-circle10 sk-child'></div>" +
			"		  <div class='sk-circle11 sk-child'></div>" +
			"		  <div class='sk-circle12 sk-child'></div>" +
			"		</div> ";
		*/			
			//console.log(sss);
			
		if($('#sub_'+bid).hasClass('panel-body')){
			//row.child(sss).show();
			//row.child().slideUp(1000);
			row.child().toggle();

		}else{
							
		//row.child(sss).show();
		//row.child().slideDown();		
		//console.log("row.child(sss).show();");
		
			$http({
					method: 'GET', 
					url: 'jsp/getBetDetail.jsp', 
					params: {'bid':bid},
					headers: {'Content-Type': 'application/json; charset=utf-8'} 
			}).success(function(data, status, headers, config) {
										
			//console.log(data);
			var s="<table  id='sub_"+bid+"' class='panel-body bet_dd_p acc_list_table_in_01' cellpadding='0' cellspacing='0' >"+
				"<tr>"+			
				"	<td class='acc_list_table_in_t' width='11%'>경기일시</td>"+
				"	<td class='acc_list_table_in_t' width='8%'>종목</td>"+
				"	<td class='acc_list_table_in_t' width='15%'>리그</td>"+
				"	<td class='acc_list_table_in_t' width='18%'>팀</td>"+
				"	<td class='acc_list_table_in_t' width='10%'>타입</td>"+
				"	<td class='acc_list_table_in_t' width='14%'>배팅</td>	"+
				"	<td class='acc_list_table_in_t' width='6%'>배당율</td>"+
				"	<td class='acc_list_table_in_t' width='6%'>결과</td>"+
				"</tr> ";
																
			angular.forEach(data, function(obj,idx) {
				
				// console.log(obj);
				var ss = "진행중";
				
				if(obj.bresult== 'MISS'){
					ss = "<span class='font_002'>미적중</span>";
				} else if(obj.bresult=='HIT'){
					ss = "<span class='font_004'>적중</span>";
				} else if(obj.bresult=='CANCEL'){
					ss = "취소";
				}
				
				s +="<tr>"+
					  	"	<td class='bet_time'>"+obj.mDt+"</td>"+
							"	<td class='bet_event'>"+obj.sName+"</td>"+
							"	<td class='bet_name'>"+obj.cName+"</td>"+
							"	<td class='bet_name'>"+obj.ht+" - " +obj.at+"</td>"+
							"	<td class='bet_type'>"+obj.mkName+"</td>"+
							"	<td class='bet_type'>"+obj.selName+"</td>"+
							"	<td class='bet_type'>"+obj.selPrice+"</td>"+
							"	<td class='beting_in_btn'>"+ss+"</td>"+
							"</tr> ";
				});
				
				s +="</table>";
				
				//console.log(s);
				row.child(s).show('1000');
				
				//$('#sub_'+bid , row.child()).slideDown(1000);
				//row.child().slideDown();

			}).error(function(data, status, headers, config) {
			});
			
		};
			
	}
</script>
<ul class="smk_accordion" ng-app="Vava" ng-controller="mc">
	<li>
		<div class="acc_head"><h3>실시간 / 스포츠 베팅내역 [<span id="dt_l1"></span>]</h3></div>
		<div class="acc_content ddtbl1">
			<div class="acc_content_in_2">
				<div class="bet_search_wrap">
					<table cellspacing="0" cellpadding="0" class="my_search_select">
						<tr>
							<td>
								<select ng-model="selectedItem" ng-change="updateSport(selectedItem)" id="sport_type">
									<option value=""> 종목</option>	
									<option value=""> 전체</option>	
									<option ng-repeat="(key,value) in BSJ|orderBy:'snames' |groupBy:'snames'" value="{{key}}"> {{key}} </option>
								</select>
							</td>									
							<td>
								<input class="input_style04" id="bd1" placeholder="기간" value="2017-00-00 ~ 2017-00-00" readonly>
								<span class="sdp showdp1"><img src="/images/car_icon.jpg"></span>
							</td>
						</tr>
					</table>
				</div>
				<div class="cal">
					<div id="bet-depth1" style="display:none; width:; position:absolute; z-index:100000000; left: 480px;top:75px;">
						<div style="float:right; padding:7px 2px 7px 10px;">
							<span id="closeMoneyPikaday" class="bclose bclose1" >
								<img src="/images/car_close.png" class="bclose1">
							</span>
						</div>
						<table border="0" cellspacing="0" cellpadding="0" class="car_table">
							<tr>
								<td id="bdfdiv1" bgcolor="#303030" style="border-radius:3px; padding:5px; box-shadow: 10px 10px 20px -5px rgba(10, 10, 5, 5);">
									<input type="text" id="bfd1" class=" bhdp1 hidden" style="display:none;"  >
								</td>
								<td id="bdtdiv1" bgcolor="#303030" style="border-radius:3px; padding:5px; box-shadow: 10px 10px 20px -5px rgba(10, 10, 5, 5);">
									<input type="text" id="bdt1" class=" bhdp1 hidden"  style="display:none;" >
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="bet_wrap">
					<div class="example1">
						<div class="panel panel-primary">
							<form name="cbForm1" id="cbForm1">											
								<table  id="table1"  cellspacing="0" cellpadding="0" width="100%">
								</table>	
							</form>
						</div>
					</div>
				</div>
				<div class="left_btn_wrap">
					<span class="btn7 sa_sp1 spnchkall" id="sa_sp2" style="cursor: pointer">전체 선택</span>
					<span class="btn8 spndelall" id="del_all" style="cursor: pointer">선택 삭제</span></div>
			</div>
		</div>
	</li>
	<li>
		<div class="acc_head"><h3>아시안 게임 베팅내역  [<span id="dt_l2"></span>]</h3></div>
		<div class="acc_content">
			<div class="acc_content_in_2">
				<div class="bet_search_wrap">
					<table cellspacing="0" cellpadding="0" class="my_search_select">
						<tr>
							<td>
								<input class="input_style04" id="bd2" placeholder="기간" value="2017-00-00 ~ 2017-00-00" readonly>
								<span class="sdp showdp2"><img src="../images/car_icon.jpg"></span>
							</td>
						</tr>
					</table>
				</div>
				<div class="cal">
					<div id="bet-depth2" style="display:none; width:; position:absolute; z-index:100000000;left: 235px;">
						<div style="float:right; padding:7px 2px 7px 10px; margin-top: -50px;">
							<span id="closeMoneyPikaday" class="bclose bclose2" >
								<img src="../images/car_close.png" class="bclose2">
							</span>
						</div>
						<table border="0" cellspacing="0" cellpadding="0" class="car_table">
							<tr>
								<td id="bdfdiv2" bgcolor="#303030" style="border-radius:3px; padding:5px; box-shadow: 10px 10px 20px -5px rgba(10, 10, 5, 5);">
									<input type="text" id="bfd2" class="hidden bhdp2" style="display: none;" >
								</td>
								<td id="bdtdiv2" bgcolor="#303030" style="border-radius:3px; padding:5px; box-shadow: 10px 10px 20px -5px rgba(10, 10, 5, 5);">
									<input type="text" id="bdt2" class="hidden bhdp2"  style="display: none;">
								</td>
							</tr>
							
						</table>
						
					</div>
				</div>
				<div class="bet_wrap">
					<div class="example4">
						<div class="panel panel-primary">
							<form name="cbForm4" id="cbForm4">											
								<table  id="table2"  cellspacing="0" cellpadding="0" width="100%">
								</table>	
							</form>
						</div><!-- 1 -->
					</div>
					
				</div>
				<div class="left_btn_wrap">
					<span class="btn7 spnchkall" id="sa2_ag" style="cursor: pointer">전체 선택</span>&nbsp;<span class="btn8 spndelall" id="del_all_ag" style="cursor: pointer">선택 삭제</span>
				</div>
			</div>
		</div>
	</li>
	<li>
		<div class="acc_head"><h3>가상 게임 베팅내역 [<span id="dt_l3"></span>]</h3></div>
		<div class="acc_content">
			<div class="acc_content_in_2">
				<div class="bet_search_wrap">
					<table cellspacing="0" cellpadding="0" class="my_search_select">
						<tr>
							<td>
								<input class="input_style04" id="bd3" placeholder="기간" value="2017-00-00 ~ 2017-00-00" readonly>
								<span class="sdp showdp3" style="cursor:pointer"><img src="/images/car_icon.jpg"></span>
							</td>
						</tr>
					</table>
				</div>
				<div class="cal">
					<div id="bet-depth3" style="display:none; width:; position:absolute; z-index:100000000; left: 225px;">
						<div style="float:right; padding:7px 2px 7px 10px;margin-top: -50px;">
							<span id="closeMoneyPikaday" class=" bclose bclose3" style="cursor:pointer">
								<img src="/images/car_close.png" class="bclose3">
							</span>
						</div>
						
						<table border="0" cellspacing="0" cellpadding="0" class="car_table">
							<tr>
								<td id="bdfdiv3" bgcolor="#303030" style="border-radius:3px; padding:5px; box-shadow: 10px 10px 20px -5px rgba(10, 10, 5, 5);">
									<input type="text" id="bfd3" class="hidden bhdp3" style="display: none;" >
								</td>
								<td id="bdtdiv3" bgcolor="#303030" style="border-radius:3px; padding:5px; box-shadow: 10px 10px 20px -5px rgba(10, 10, 5, 5);">
									<input type="text" id="bdt3" class="hidden bhdp3"  style="display: none;">
								</td>
							</tr>											
						</table>
						
					</div>
				</div>
				<div class="bet_wrap">
					
					<div class="example2">
						<div class="panel panel-primary"><!-- 1 -->
								<form name="cbForm2" id="cbForm2">											
								<table  id="table3"  cellspacing="0" cellpadding="0" width="100%">
								</table>	
							</form>
						</div>
					</div>
					
				</div>
				<div class="left_btn_wrap">
					<span class="btn7 spnchkall" id="sa2_sc" style="cursor: pointer">전체 선택</span> &nbsp;<span class="btn8 spndelall" id="del_all_sc" style="cursor: pointer">선택 삭제</span>
				</div>
									
			</div>
		</div>		
	</li>
	<li>
		<div class="acc_head"><h3>마이크로 게임 베팅내역  [<span id="dt_l4"></span>] </h3></div>
		<div class="acc_content">
			<div class="acc_content_in_2">
				<div class="bet_search_wrap">
					<table cellspacing="0" cellpadding="0" class="my_search_select">
						<tr>
							<td>
								<input class="input_style04" id="bd4" placeholder="기간" value="2017-00-00 ~ 2017-00-00" readonly>
								<span class="sdp showdp4" style="cursor:pointer"><img src="/images/car_icon.jpg"></span>
							</td>
						</tr>
					</table>
				</div>
				<div class="cal">
					<div id="bet-depth4" style="display:none; width:; position:absolute; z-index:100000000; left: 225px;">
						<div style="float:right; padding:7px 2px 7px 10px; margin-top:-50px;">
							<span id="closeMoneyPikaday" class="bclose bclose4" style="cursor:pointer">
								<img src="/images/car_close.png" class="bclose4">
							</span>
						</div>
						
						<table border="0" cellspacing="0" cellpadding="0" class="car_table">
							<tr>
								<td id="bdfdiv4" bgcolor="#303030" style="border-radius:3px; padding:5px; box-shadow: 10px 10px 20px -5px rgba(10, 10, 5, 5);">
									<input type="text" id="bfd4" class="hidden bhdp4" style="display: none;" >
								</td>
								<td id="bdtdiv4" bgcolor="#303030" style="border-radius:3px; padding:5px; box-shadow: 10px 10px 20px -5px rgba(10, 10, 5, 5);">
									<input type="text" id="bdt4" class="hidden bhdp4"  style="display: none;">
								</td>
							</tr>											
						</table>
					</div>
				</div>
				<div class="bet_wrap">
					<div class="example3">
						<div class="panel panel-primary">
							<form name="cbForm3" id="cbForm3">											
								<table  id="table4"  cellspacing="0" cellpadding="0" width="100%">
								</table>	
							</form>
						</div>
					</div>
				</div>
				<div class="left_btn_wrap">
					<span class="btn7 spnchkall" id="sa2_mg" style="cursor: pointer">전체 선택</span>&nbsp;<span class="btn8 spndelall" id="del_all_mg" style="cursor: pointer">선택 삭제</span>
				</div>	
			</div>
		</div>			
	</li>
</ul>	
		
<div id="delAllAsk" class="bg_mask_pop4">
	<div class="bg_mask_pop_title">
		<span class="popup_logo"><img src="/images/popup_logo.png"></span>
		<span id="del_all_no2" class="popup_close"><img src="/images/popup_close.png"></span>
	</div>
	<div class="bg_mask_pop4_in">
		<div class="pop_icon_center">
			<img src="/images/question_icon.png">
		</div>
		<div class="pop_text">
			선택한 배팅내역을 삭제하시겠습니까?<br>
		</div>
		<div class="btn_wrap">
			<span class="btn3" style="cursor: pointer" id="del_all_no">아니요</span>
			<span class="btn3" style="cursor: pointer" id="del_all_yes">예</span>
		</div>
	</div>						
</div>


<div id="delAllCon" class="bg_mask_pop4">
	<div class="bg_mask_pop_title">
		<span class="popup_logo"><img src="/images/popup_logo.png"></span>
		<span class="popup_close del_all_conf"><img src="/images/popup_close.png"></span>
	</div>
	<div class="bg_mask_pop4_in">
		<div class="pop_icon_center">
			<img src="/images/check_icon.png">
		</div>
		<div class="pop_text">
			선택한 배팅내역이 삭제되었습니다.<br>
		</div>
		<div class="btn_wrap">
			<a href="#"><span class="btn3" style="cursor: pointer" id="del_all_conf">확인</span></a>
		</div>
	</div>					
</div>

<div id="delSelAsk" class="bg_mask_pop4">
	<div class="bg_mask_pop_title">
		<span class="popup_logo"><img src="/images/popup_logo.png"></span>
		<span class="popup_close del_all_conf"><img src="/images/popup_close.png"></span>
	</div>
	<div class="bg_mask_pop4_in">
		<div class="pop_icon_center">
			<img src="/images/check_icon.png">
		</div>
		<div class="pop_text">
			삭제할 배팅내역을 선택해 주세요.<br>
		</div>
		<div class="btn_wrap">
			<a href="#"><span class="btn3" style="cursor: pointer" id="del_sel_conf">확인</span></a>
		</div>
	</div>
	
	<script>
	$("#del_sel_conf").on("click",function(){
		$("#delSelAsk").popup("hide");
	});						
	</script>
	
	
	<form name="form" id="form">
		<input type="hidden" name="seltab">
	</form>					
</div>

<script>
	var table1;
	var table2;
	var table3;
	var table4;

	$(document).ready(function(){

		table1 = $('#table1').DataTable({
			ajax : '/info/jsp/getLiveBH.jsp',
			sAjaxDataProp:"",
			searching: true,
			bInfo : false,
			lengthChange: false,
			autowWidth:false,
			columns : [
	      		{ 
					data  :'bgid',
					title :'<input type="checkbox" class="chckall" name="sa_sp" id="sa_sp"></td>',	
					width : '62px',
					render : function(data,type,row,meta){
						var html  = '<input type="checkbox"  name="cb" class="dTable1_chk" value="'+data+'">';
	     				return html;
					}                      
				},
				{
					title : '베팅 NO.',
					width : "150px",
					data  : "bgid",
				},
				{
					title : '일시',
					width : "200px",
					data  : "betdate",
				},
				{
					title : '종목',
					width : "200px",
					data  : "sname",
				},
				{
					title : '과',
					width : "137px",
					data  : "bgresult",
					render : function(data,type,row,meta){
						// console.log(data);
						var html  = '<span class="">'+data+'</span>';
						
						if(data == "NO"){
							html  = '<span class="">진행중</span>';
						}else if(data == "HIT"){
							html  = '<span class="font_004">적중</span>';
						}else if(data == "MISS"){
							html  = '<span class="font_002">미적중</span>';
						}else if(data == "CANCEL"){
							html  = '<span class=""> 취소</span>';
						}
		
	     				return html;
					}
				},
				{
					title : '배팅금액',
					width : "176px",
					data  : "bet_money",
					render : function(data,type,row,meta){
						var html  = '<span class="">'+data+'</span> 원';
						if(row.bgresult == "NO" || row.bgresult == "HIT"  ){
							html  = '<span class="font_002">'+data+'</span> 원';
						}
	     				return html;
					}
				},
				{
					title : '배당율',
					width : "150px",
					data  : "expect_rate",
					render : function(data,type,row,meta){
						var html  = '<span class="">'+data+'</span> 원';
						if(row.bgresult == "HIT" ){
							html  = '<span class="font_002">'+data+'</span> 배';
						}
	     				return html;
					}
				},
				{
					title : '예상적중금액',
					width : "150px",
					data  : "expect_money",
					render : function(data,type,row,meta){
						var html  = '<span class="">'+data+'</span> 원';
						if(row.bgresult == "NO" || row.bgresult == "HIT"  ){
							html  = '<span class="font_002">'+data+'</span> 원';
						}
	     				return html;
					}
				},
				{
					title : '폴더',
					width : "75px",
					data  : "fn",
				},

	  
	      	],	    
			order: [[ 2, "desc" ]] ,   
	      	paging: true,
	      	pagingType: "full_numbers",
	      	language: {
				paginate: {
		      		previous: "<",
				    next: ">",
				    first: "<<",
				    last: ">>",
				},
				emptyTable: "베팅 내역이 없습니다.",
			},
			drawCallback: function( settings ) {
				//console.log("drawed table1");
		        var api = this.api();
		        $("#dt_l1").html(api.rows().data().length);
		    },
		    createdRow: function( row, data, dataIndex ){
		    	var tds = $( row ).find('td').not('td:eq(0)').attr("data-acc-link", data.bgid);
		    	$(row).attr("id", data.bgid);
		    	// console.log(tds);
		    	tds.on("click",function(e){
		    		selBet(data.bgid);
		    	});
		    }

    	});

		table2 = $('#table2').DataTable({
			ajax : '/info/jsp/getAgBH.jsp',
			sAjaxDataProp:"",
			searching: true,
			bInfo : false,
			lengthChange: false,
			autowWidth:false,
			columns : [
	      		{
					data : "bgid", 
					title: '<input type="checkbox" class="chckall" name="sa_ag" id="sa_ag" ></td>', 
					width : "62px",
					render : function(data,type,row,meta){
						var html = '<input type="checkbox" name="cb" value="'+data+'">';
	     				return html;
					}  
				},
				{
					data : "bgid", 
					title: "베팅 NO.", 
					width : "150px",
				}, 
				{
					data : "regdate", 
					title: "일시", 
					width : "200px",
				}, 
				{
					data : "job", 
					title: "결과", 
					render : function(data,type,row,meta){
						var html = "";
						if(data == "WIN"){
							html = '<span class="font_002">승<span>';						
						}else if (data == "LOSE"){
							html = '<span class="font_004">패</span>';
						}else if(data == "BET"){
							html = '<span class="font_004">배팅</span>';
						}

	     				return html;
					},
					width : "238px",
				}, 
				{
					data : "bet_money", 
					title: "배팅금액",
				 	render : function(data,type,row,meta){
						var html = "";
						if(row.job == "WIN"){
							html = '<span class="font_002">'+data+'</span> 원';						
						}else if (row.job == "LOSE"){
							html = '<span class="font_004">'+data+'</span> 원';
						}else if(row.job == "BET"){
							html = '<span class="font_004">'+data+'</span> 원';
						}

	     				return html;
					},
					width : "300px",
				}, 
				{
					data : "res_money", 
					title: "결과금액", 
					render : function(data,type,row,meta){
						var html = "";
						if(row.job == "WIN"){
							html = '<span class="font_002">'+data+'</span> 원';						
						}else if (row.job == "LOSE"){
							html = '<span class="font_004">'+data+'</span> 원';
						}else if(row.job == "BET"){
							html = '<span class="font_004">'+data+'</span> 원';
						}

	     				return html;
					},
					width : "300px",
				}, 

	  
	      	],	    
			order: [[ 2, "desc" ]] ,   
	      	paging: true,
	      	pagingType: "full_numbers",
	      	language: {
				paginate: {
		      		previous: "<",
				    next: ">",
				    first: "<<",
				    last: ">>",
				},
				emptyTable: "베팅 내역이 없습니다.",
			},
			drawCallback: function( settings ) {
				// console.log(settings);
				// console.log("drawed table2");
		        var api = this.api();
		        $("#dt_l2").html(api.rows().data().length);
		    }

    	});

    	table3 = $('#table3').DataTable({
			ajax : '/info/jsp/getVgBH.jsp',
			sAjaxDataProp:"",
			searching: true,
			bInfo : false,
			lengthChange: false,
			autowWidth:false,
			columns : [
	      		{
					data: "bgid",
					title: '<input type="checkbox" class="chckall" name="sa_sc" id="sa_sc" >',
					width: "88px",
					render : function(data,type,row,meta){
						var html  = '<input type="checkbox"  name="cb" value="'+data+'">';
						return html;
					}
				},
				{
					data: "bgid",
					title: "베팅 NO.",
					width: "124px",
					
				},
				{
					data: "regdate",
					title: "일시",
					width: "375px",
				},
				{
					data: "job",
					title: "충/환전",
					width: "376px",
					render : function(data,type,row,meta){
						var html = "<span class='font_004'>충전</span>";
						if(data == "W" ){
							html = "<span class='font_002'>환전</span>";
						}

						return html;
					}	
				},
				{
					data: "bet_money",
					title: "금액",
					width: "287px",
					render : function(data,type,row,meta){
						var html = '<span class="font_002">'+data+'</span> 원';
						return html;
					}	
				},

	  
	      	],	    
			order: [[ 2, "desc" ]] ,   
	      	paging: true,
	      	pagingType: "full_numbers",
	      	language: {
				paginate: {
		      		previous: "<",
				    next: ">",
				    first: "<<",
				    last: ">>",
				},
				emptyTable: "베팅 내역이 없습니다.",
			},
			drawCallback: function( settings ) {
		        var api = this.api();
		        $("#dt_l3").html(api.rows().data().length);
		    }

    	});

    	table4 = $('#table4').DataTable({
			ajax : '/info/jsp/getMgBH.jsp',
			sAjaxDataProp:"",
			searching: true,
			bInfo : false,
			lengthChange: false,
			autowWidth:true,
			columns : [
	      		{
					data:"bgid",
					title: '<input type="checkbox" class="chckall"  name="sa_mg" id="sa_mg" >',
					width: "103px",
					render : function(data,type,row,meta){
						var html  = '<input type="checkbox"  name="cb" value="'+data+'">';
						return html;
					}
				},
				{
					data:"bgid",
					title: "베팅 NO.",
					width: "145px",
				},
				{
					data:"regdate",
					title: "일시",
					width: "438px",

				},
				{
					data:"job",
					title: "충/환전",
					width: "229px",
					render : function(data,type,row,meta){
						var html = "<span class='font_004'>충전</span>";
						if(data == "W"){
							html = "<span class='font_002'>환전</span>";
						}
						return html;
					}
				},
				{
					data:"bet_money",
					title: "금액",
					width: "335px",
					render : function(data,type,row,meta){
						var html  = data + ' 원';
						return html;
					}

				},
	  
	      	],	    
			order: [[ 2, "desc" ]] ,   
	      	paging: true,
	      	pagingType: "full_numbers",
	      	language: {
				paginate: {
		      		previous: "<",
				    next: ">",
				    first: "<<",
				    last: ">>",
				},
				emptyTable: "베팅 내역이 없습니다.",
			},
			drawCallback: function( settings ) {
		        var api = this.api();
		        $("#dt_l4").html(api.rows().data().length);
		    }

    	});


		var i18n = {
			previousMonth	: '이전 달',
			nextMonth		: '다음 달',
			months 			: ['1월','2월', '3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			weekdays		: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
			weekdaysShort	: ['일', '월', '화', '수', '목', '금', '토'],
		};
    	
		var bpf1 = new Pikaday({ 
			field: document.getElementById('bfd1'), 
			bound: false, 
			container: document.getElementById('bdfdiv1'),
			format: 'YYYY-MM-DD',
			defaultDate:moment().subtract(30,'days').toDate(),
			setDefaultDate:moment().subtract(30,'days').toDate(),
			minDate : moment().subtract(30,'days').toDate(),
			maxDate : moment().toDate(),
			i18n : i18n,
			onSelect: function() {
	            bpt1.setMinDate(this.getDate());
	            table1.draw();
	        },
		});

	   	var bpt1 = new Pikaday({ 
	   		field: document.getElementById('bdt1'), 
	   		bound: false, 
	   		container: document.getElementById('bdtdiv1'),
	   		format :'YYYY-MM-DD',
	   		i18n : i18n,
	   		onSelect: function() {
		    	table1.draw();
		    },	        
	   		defaultDate: moment().toDate(),
	   		setDefaultDate : moment().toDate(),       		
	   		minDate : bpf1.getDate(),
	   		maxDate : moment().toDate(),
	   	});
   		
   		var bpf2 = new Pikaday({ 
			field: document.getElementById('bfd2'), 
			bound: false, 
			container: document.getElementById('bdfdiv2'),
			format: 'YYYY-MM-DD',
	        defaultDate: moment().toDate(),
	        setDefaultDate : moment().toDate(),
	        onSelect: function() {
	            bpt2.setMinDate(this.getDate());
	            table2.draw();
	        },
	        minDate : moment().subtract(30,'days').toDate(),
	        maxDate : moment().toDate(),
	        i18n : i18n,
		});

       	var bpt2 = new Pikaday({ 
       		field: document.getElementById('bdt2'), 
       		bound: false, 
       		container: document.getElementById('bdtdiv2'),
       		format :'YYYY-MM-DD',
       		defaultDate: moment().toDate(),
       		setDefaultDate : moment().toDate(),
       		minDate : bpf2.getDate(),
       		maxDate : moment().toDate(),
       		i18n : i18n,
       		onSelect: function(){
       			table2.draw();
       		}
       	});

       	var bpf3 = new Pikaday({ 
			field: document.getElementById('bfd3'), 
			bound: false, 
			container: document.getElementById('bdfdiv3'),
			format: 'YYYY-MM-DD',
	        defaultDate: moment().toDate(),
	        setDefaultDate : moment().toDate(),
	        onSelect: function() {
	           	bpt3.setMinDate(this.getDate());
	            table3.draw();
	        },
	        minDate : moment().subtract(30,'days').toDate(),
	        maxDate : moment().toDate(),
	        i18n : i18n,
		});

       	var bpt3 = new Pikaday({ 
       		field: document.getElementById('bdt3'), 
       		bound: false, 
       		container: document.getElementById('bdtdiv3'),
       		format :'YYYY-MM-DD',
       		defaultDate: moment().toDate(),
       		setDefaultDate : moment().toDate(),
       		minDate : bpf3.getDate(),
       		maxDate : moment().toDate(),
       		i18n : i18n,
       		onSelect: function(){
       			table3.draw();
       		}
       	});

       	var bpf4 = new Pikaday({ 
			field: document.getElementById('bfd4'), 
			bound: false, 
			container: document.getElementById('bdfdiv4'),
			format: 'YYYY-MM-DD',
		    defaultDate:moment().subtract(30,'days').toDate(),
	   		setDefaultDate:moment().subtract(30,'days').toDate(),
		    minDate : moment().subtract(30,'days').toDate(),
		    maxDate : moment().toDate(),
		    i18n : i18n,
		    onSelect: function(){
   				bpt4.setMinDate(this.getDate());
       			table4.draw();
       		}
		});

	   	var bpt4 = new Pikaday({ 
	   		field: document.getElementById('bdt4'), 
	   		bound: false, 
	   		container: document.getElementById('bdtdiv4'),
	   		format :'YYYY-MM-DD',
	   		defaultDate: moment().toDate(),
	   		setDefaultDate : moment().toDate(),
	   		minDate : bpf4.getDate(),
	   		maxDate : moment().toDate(),
	   		i18n : i18n,
	   		onSelect: function() {
		    	table4.draw();
		    },	
	   	});

        $(".sdp").on("click",function(e){
        	e.preventDefault();
        	show_over(this);
        	var sl = $(this).closest('li').find('.cal div:first-child').attr("id");
        	show_layer(sl);
        	
        });

        $(".bclose").on("click",function(e){
        	e.preventDefault();
        	var sl = $(this).closest('li').find('.cal > div').hide();
        	table1.draw();
        	table2.draw();
        	table3.draw();
        	table4.draw();
     
        });

       	drawDate();

    	$(".bhdp1").on("change",function(e){
    		changeDate($("#bfd1").val(),$("#bdt1").val(),$("#bd1"),table1);		
    	});

    	$(".bhdp2").on("change",function(e){
        	changeDate($("#bfd2").val(),$("#bdt2").val(),$("#bd2"),table2);		
        	
        });

        $(".bhdp3").on("change",function(e){
        	changeDate($("#bfd3").val(),$("#bdt3").val(),$("#bd3"),table3);		
        	
        });

        $(".bhdp4").on("change",function(e){
        	changeDate($("#bfd4").val(),$("#bdt4").val(),$("#bd4"),table4);		
        });

    	$(".chckall").on("change",function(e){
    		checkAll($(this));
    	});

    	$(".spnchkall").on("click",function(e){
    		var ckbx = $(this).closest('li').find("table thead tr th input[type=checkbox]");
    		ckbx.trigger("click");
    	});

    	$(".spndelall").on("click",function(e){

    		var frm =  $(this).closest('li').find("form"); 
    		var tbl = $(this).closest('li').find("table");

    		var chkbxs = tbl.find("tbody tr td input[name=cb]");

    		if(frm.attr("name") == "cbForm1"){
    			document.form.seltab.value="SP";
    		}else if(frm.attr("name") == "cbForm2"){
    			document.form.seltab.value="SC";
    		}else if(frm.attr("name") == "cbForm3"){
    			document.form.seltab.value="MG";
    		}else if(frm.attr("name") == "cbForm4"){
    			document.form.seltab.value="AG";
    		}

    		if(chkbxs.length > 0){
    			$("#delAllAsk").popup("show");
    		}else{
    			$("#delSelAsk").popup("show");
    		}
			
    	});


    	$("#del_all_yes").on("click",function(){		
			
			$("#delAllAsk").popup("hide");	
			var dt;
			if(document.form.seltab.value =="SP"){
				var param = $(document.getElementById('cbForm1').cb).serialize();
				param += '&st=SP';
				dt = table1;
				
			} else if(document.form.seltab.value =="SC"){
				var param = $(document.getElementById('cbForm2').cb).serialize();
				param += '&st=SC';
				dt = table3;
				
			} else if(document.form.seltab.value =="MG"){
				var param = $(document.getElementById('cbForm3').cb).serialize();
				param += '&st=MG';
				dt = table4;
				
			} else if(document.form.seltab.value =="AG"){
				var param = $(document.getElementById('cbForm4').cb).serialize();
				param += '&st=AG';
				dt = table2;
			}

			
			// console.log("param : " + param);
			$.ajax({
				url:'/info/jsp/delBettingHistory.jsp',								
				type:'POST',
				cache: false,
	   			data: param,
			}).done(function(data){
				// console.log("done");
				
				if(data !="" || data !=null){
					
					$("#delAllCon").popup("show");
					dt.ajax.reload();

					
				}else{
					toastr.success("something went wrong");
				}
			});
		});

    	$(".acc_section").on("tab_toggled", function() {
			$('.cal > div').hide();
		});
			


		//seerch function 
		$.fn.dataTable.ext.search.push(
		    function( settings, data, dataIndex ) {
    		if(settings.nTable.id == "table2"){
    			var from =  moment($("#bfd2").val(),"YYYY-MM-DD");
				var to = moment($("#bdt2").val(),"YYYY-MM-DD");
				var column_date = moment(data[2],"YYYY-MM-DD");

				if(moment(column_date).isBetween(from,to,'days', '[]')){
					return true;
			
				}else{
					return false;
				}
    		}else if(settings.nTable.id == "table1"){
  
    			var from =  moment($("#bfd1").val(),"YYYY-MM-DD");
				var to = moment($("#bdt1").val(),"YYYY-MM-DD");
				var selected_sport_type = $("#sport_type").val();
				var column_date = moment(data[2],"YYYY-MM-DD");
				
				if(selected_sport_type != ""){
					
					if(moment(column_date).isBetween(from,to,'days', '[]') && data[3] == selected_sport_type){
						
						return true;
		
					}else{

						return false;
					}
				}else{
					
					if(moment(column_date).isBetween(from,to,'days', '[]')){

						return true;
						
					}else{

						return false;
					}
				}
    		}else if(settings.nTable.id == "table3"){
    			
    			var from =  moment($("#bfd3").val(),"YYYY-MM-DD");
				var to = moment($("#bdt3").val(),"YYYY-MM-DD");
				var column_date = moment(data[2],"YYYY-MM-DD");
				
				if(moment(column_date).isBetween(from,to,'days', '[]')){

					return true;
	
				}else{

					return false;
				}
    		}else if(settings.nTable.id == "table4"){
    			
    			var from =  moment($("#bfd4").val(),"YYYY-MM-DD");
				var to = moment($("#bdt4").val(),"YYYY-MM-DD");
				var column_date = moment(data[2],"YYYY-MM-DD");
				
				if(moment(column_date).isBetween(from,to,'days', '[]')){
					
					return true;
					
				}else{

					return false;

				}
    		}
	    });


	    $("#del_all_conf").on("click",function(){
			// console.log("NO")
			//e.preventDefault();
			$("#delAllCon").popup("hide");
			// location.reload();
		});	

	});
	
	function changeDate(dateFrom,dateTo,el,table){
    	el.val(dateFrom + ' ~ '+ dateTo);
    	table.draw();

	}

	function checkAll(obj){
		var table = obj.closest("table");		
		var chkbxs = table.find("tbody tr td input[name=cb]");
		// console.log(chkbxs);
		if(chkbxs.length > 0){
			$.each(chkbxs,function(index,item){
				if(obj.is(":checked")){
					$(this).prop("checked",true);
				}else{
					$(this).prop("checked",false);
				}
			});
			
		}	

		if(obj.is(":checked")){
			table.closest("li").find(".left_btn_wrap span:first").html('선택 해제');
		}else{
			table.closest("li").find('.left_btn_wrap span:first').html('전체 선택');
		}
	}

	function drawDate(){
		changeDate($("#bfd1").val(),$("#bdt1").val(),$("#bd1"),table1);
		changeDate($("#bfd2").val(),$("#bdt2").val(),$("#bd2"),table2);
		changeDate($("#bfd3").val(),$("#bdt3").val(),$("#bd3"),table3);
		changeDate($("#bfd4").val(),$("#bdt4").val(),$("#bd4"),table4);
	}
</script>
