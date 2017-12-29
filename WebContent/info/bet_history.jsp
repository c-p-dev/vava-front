
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
				
DecimalFormat dfrmt	= new DecimalFormat("#,###,###,###,###");	
				
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
	/*background:#262a2b!important; */
	background:#262a2b;
}

table.dataTable tbody tr:nth-child(even) {
	cursor:pointer;
	/*background:#262a2b!important;*/
	background:#262a2b;
}	

table.dataTable tbody tr{
	/*background:#262a2b!important;*/
	background:#262a2b;
}

.dataTables_empty{
 height:50px;
}
</style>

<link href="/css/common3.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="/js/angular.js"></script> 
<script type="text/javascript" src="/js/angular-animate.min.js"></script> 
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/angular-filter/0.5.16/angular-filter.js"></script>    
<script type="text/javascript" src="/js/v-accordion.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.28//angular-route.min.js"></script>


<script>

	var mainAngular = angular.module('Vava', [ 'ngAnimate', 'vAccordion' ]);

    
	mainAngular.controller("mc", function($scope, $templateCache, $compile, $http) {		

			//$scope.$apply();
			
			$scope.BLJ = <%=blj%>;
			$scope.BSJ = <%=bsj%>;	
			
			$scope.table = table;		
			
			
			
			$scope.updateSport = function(item) {
				table.columns(9).search(item).draw();
		  // $scope.sName = $scope.selectedItem.snames
		  
	}

		Date.prototype.yyyymmdd = function() {
		   var yyyy = this.getFullYear();
		   var mm = this.getMonth() < 9 ? "0" + (this.getMonth() + 1) : (this.getMonth() + 1); // getMonth() is zero-based
		   var dd  = this.getDate() < 10 ? "0" + this.getDate() : this.getDate();
		   return "".concat(yyyy).concat(mm).concat(dd);
		  };

			$scope.updateDate = function(item) {
				if(item == -1){
					item = 365;
				}
				
				
				var today_ = new Date();
				//var today__= today_.yyyymmdd();
				
				var ft_eday = moment(today_).format('YYYYMMDD');
				
				var sday_ = today_.setDate(today_.getDate()-item);
				var ft_sday= moment(sday_).format('YYYYMMDD');
				
				
				$.fn.dataTable.ext.search.push(
		   		function( settings, data, dataIndex ) {
		       // var min = parseInt( $('#min').val(), 10 );
		       // var max = parseInt( $('#max').val(), 10 );
		        var age = parseFloat( moment(data[2]).format('YYYYMMDD') ) || 0; // use data for the age column
		       // var dt = table.columns(2);
		 				
		 				/* 
		        if ( ( isNaN( ft_sday ) && isNaN( ft_eday ) ) ||
		             ( isNaN( ft_sday ) && age <= ft_eday ) ||
		             ( ft_sday <= age   && isNaN( ft_eday ) ) ||
		             ( ft_sday <= age   && age <= ft_eday ) )
		        {
		            return true;
		        }
		        */
		        
		        if ( ft_sday <= age  && age <= ft_eday  ) {
		            return true;
		        }
		        
		        return false;
		    }
		);


				
		table.draw();
				
			//string p1date =DateTimeValue1.ToString("MM/dd/yyyy HH:mm:ss");
			//string p2date =DateTimeValue2.ToString("MM/dd/yyyy HH:mm:ss");
			//var myfilter = "TradeTime > #" + sday_ + "# AND TradeTime <=#" + today_ + "#";
			//DataRow[] drTemp = dtRecord.Select(myfilter);

			//	table.columns(2).search(myfilter).draw();
		  	// $scope.sName = $scope.selectedItem.snames
		  
		}
	
	//$scope.$watch;
	});


	function selBet(bid,$scope){
		
		var row = table.row(document.getElementById(bid)); 
	 	//var row = table.row(document.getElementById('cbForm1').cb); 
	 //var row = table.row(document.getElementById('SP_'+bid));
	 
	 
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
			
			if($('#sub_'+bid).hasClass('panel-body')){
				//row.child(sss).show();
				//row.child().slideUp(1000);
				row.child().toggle();
			
			}else{
								
			//row.child(sss).show();
			//row.child().slideDown();		
			
				$http({
						method: 'GET', 
						url: 'jsp/getBetDetail.jsp', 
						params: {'bid':bid},
						headers: {'Content-Type': 'application/json; charset=utf-8'} 
				}).success(function(data, status, headers, config) {
											
				var s="<table  id='sub_"+bid+"' class='panel-body bet_dd_p acc_list_table_in_01' cellpadding='0' cellspacing='0' >"+
					"<tr>"+			
					"	<td class='acc_list_table_in_t' width='11%'>경기일시</td>"+
					"	<td class='acc_list_table_in_t' width='8%'>종목</td>"+
					"	<td class='acc_list_table_in_t' width='15%'>리그</td>"+
					"	<td class='acc_list_table_in_t' width='12%'>홈팀</td>"+
					"	<td class='acc_list_table_in_t' width='12%'>원정팀</td>"+
					"	<td class='acc_list_table_in_t' width='10%'>타입</td>"+
					"	<td class='acc_list_table_in_t' width='8%'>배팅</td>	"+
					"	<td class='acc_list_table_in_t' width='6%'>배당율</td>"+
					"	<td class='acc_list_table_in_t' width='6%'>결과</td>"+
					"</tr> ";
																	
				angular.forEach(data, function(obj,idx) {
					
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
								"	<td class='bet_name'>"+obj.ht+"</td>"+
								"	<td class='bet_name'>"+obj.at+"</td>"+
								"	<td class='bet_type'>"+obj.mkName+"</td>"+
								"	<td class='bet_type'>"+obj.selName+"</td>"+
								"	<td class='bet_type'>"+obj.selPrice+"</td>"+
								"	<td class='beting_in_btn'>"+ss+"</td>"+
								"</tr> ";
					});
					
					s +="</table>";
					
					row.child(s).show('1000');
					
					//$('#sub_'+bid , row.child()).slideDown(1000);
					//row.child().slideDown();

				}).error(function(data, status, headers, config) {
				});
				
			};
			
	}


</script>


<link href="/css/v-accordion.css" rel="stylesheet" type="text/css">



<style type="text/css">
	.dataTables_filter {
		display: none; 
	}
</style>
	<ul class="smk_accordion" ng-app="Vava" ng-controller="mc">
		<li>
			<div class="acc_head"><h3>실시간 / 스포츠 베팅내역 [{{BLJ.length}}]</h3></div>
			<div class="acc_content">
				<div class="acc_content_in_2">
					<div class="bet_search_wrap">
						<table cellspacing="0" cellpadding="0" class="my_search_select">
							<tr>
								<td>
									<select ng-model="selectedItem" ng-change="updateSport(selectedItem)">
										<option value=""> 종목</option>	
										<option value=""> 전체</option>	
										<option ng-repeat="(key,value) in BSJ|orderBy:'snames' |groupBy:'snames'"> {{key}} </option>
									</select>
								</td>									
								<!-- <td>
									<select clas">
										<option value="-1">기간</option>	
										<option value="-1">전체</option>	
										<option value="0">오늘</option>
										<option value="3">최근3일</option>
										<option value="7">최근7일</option>																				
									</select>
								</td> -->
								<td>
									<input class="input_style04" id="bd1" placeholder="기간" value="2017-00-00 ~ 2017-00-00" readonly>
									<span class="showdp1" style="cursor:pointer"><img src="/images/car_icon.jpg"></span>
									<div id="bet-depth1" style="display:none; width:; position:absolute; z-index:100000000; left: 230px; top:130px;">
										
										<div style="float:right;">
											<span id="closeMoneyPikaday" class="bclose1" >
												<img src="/images/car_close.png" class="bclose1">
											</span>
										</div>
										
										<table border="0" cellspacing="0" cellpadding="0" class="car_table">
											<tr>
												<td id="bdfdiv1" bgcolor="#303030" style="border-radius:3px; padding:5px; box-shadow: 10px 10px 20px -5px rgba(10, 10, 5, 5);">
													<input type="text" id="bfd1" class="hidden bhdp1" style="display: none;" >
												</td>
												<td id="bdtdiv1" bgcolor="#303030" style="border-radius:3px; padding:5px; box-shadow: 10px 10px 20px -5px rgba(10, 10, 5, 5);">
													<input type="text" id="bdt1" class="hidden bhdp1"  style="display: none;">
												</td>
											</tr>											
										</table>
										
									</div>
								</td>
								<!--
								<td>
									<span class="btn1" id="dpbtn1">검색</span>
								</td>
								-->
							</tr>
						</table>
					</div>
					<div class="bet_wrap">
						
						<div class="example1">
							<div class="panel panel-primary"><!-- 1 -->
									<form name="cbForm1" id="cbForm1">											
									<table  id="table1"  cellspacing="0" cellpadding="0" width="100%">
										<thead>
										<tr>
											
											<td class="list_table_t_1" width="5%" style="border-left:solid 1px #1c2021; border-right:solid 1px #1c2021;"><input type="checkbox"  name="sa_sp" id="sa_sp" ></td>
											<td class="list_table_t_1" width="12%" style="border-right:solid 1px #1c2021;">베팅 NO.</td>
											<td class="list_table_t_1" width="16%" style="border-right:solid 1px #1c2021;">일시</td>
											<td class="list_table_t_1" width="11%" style="border-right:solid 1px #1c2021;">종목</td>
											<td class="list_table_t_1" style="border-right:solid 1px #1c2021;">결과</td>
											<td class="list_table_t_1" width="12%" style="border-right:solid 1px #1c2021;">배팅금액</td>
											<td class="list_table_t_1" width="12%" style="border-right:solid 1px #1c2021;">배당율</td>
											<td class="list_table_t_1" width="12%" style="border-right:solid 1px #1c2021;">예상적중금액</td>
											<td class="list_table_t_1" width="6%" style="border-right:solid 1px #1c2021;">폴더</td>
											<td class="list_table_t_1" width="12%" style="border-right:solid 1px #1c2021;">a</td>
											
										</tr>
									</thead>
									
									<tbody>
									
								<%
										
										
										for (int k=0; k < bl.size() ; k++){
											String fn = "다폴더";
											String etc = " 외";
											String fullsname = "";
											
											BettingListBean blb = (BettingListBean) bl.get(k);
											
											if(blb.getScnt().equals("1")){
												fn = "싱글";
												etc = "";
											}
											String sname="";
												
											for (int i = 0; i < bs.size(); i++){		
											
												BettingSName bsn = bs.get(i);			
												boolean chk = false;
															
													if(bsn.getBgid().equals(blb.getBgid())){	
														
														//if(chk){							
														//	sname += " 외";		
														//	chk = false;													
														//}else{
															sname = bsn.getSNames();
															fullsname = fullsname+" "+sname;
														//	chk = true;
														//}
									
													}
											}
											
											sname = sname + etc;
									
							%>
								<tr id='<%=blb.getBgid()%>' style="cursor: pointer">									
									<td class="acc_list_check_1" style="border-left:solid 1px #1c2021; border-right:solid 1px #1c2021;"><input type="checkbox" name="cb" value="<%=blb.getBgid()%>"></td>
									<td class="acc_list_num"  onmouseover="CBg(this)" onmouseout="RBg(this)" style="border-right:solid 1px #1c2021;" onClick="selBet('<%=blb.getBgid()%>')" data-acc-link="<%=blb.getBgid()%>"><%=blb.getBgid()%></td>
									<td class="acc_list_time"  onmouseover="CBg(this)" onmouseout="RBg(this)" style="border-right:solid 1px #1c2021;" onClick="selBet('<%=blb.getBgid()%>')" data-acc-link="<%=blb.getBgid()%>"><%=blb.getBdate()%></td>
									<td class="acc_list_event"  onmouseover="CBg(this)" onmouseout="RBg(this)" style="border-right:solid 1px #1c2021;" onClick="selBet('<%=blb.getBgid()%>')" data-acc-link="<%=blb.getBgid()%>"><%=sname%></td>
									
							<%
									if(blb.getBresult().equals("HIT")){
							%>
									
									<td class="beting_btn" onmouseover="CBg(this)" onmouseout="RBg(this)" style="border-right:solid 1px #1c2021;" onClick="selBet('<%=blb.getBgid()%>')" data-acc-link="<%=blb.getBgid()%>"><span class="font_004">적중</span></td>
									<td class="acc_list_price1"  onmouseover="CBg(this)" onmouseout="RBg(this)" style="border-right:solid 1px #1c2021;" onClick="selBet('<%=blb.getBgid()%>')" data-acc-link="<%=blb.getBgid()%>"><span class="font_002"><%=dfrmt.format(Integer.parseInt(blb.getBmoney()))%></span> 원</td>
									<td class="acc_list_dividend" onmouseover="CBg(this)" onmouseout="RBg(this)" style="border-right:solid 1px #1c2021;" onClick="selBet('<%=blb.getBgid()%>')" data-acc-link="<%=blb.getBgid()%>"><span class="font_002"><%=blb.getErate()%></span> 배</td>
									<td class="acc_list_price2" onmouseover="CBg(this)" onmouseout="RBg(this)" style="border-right:solid 1px #1c2021;" onClick="selBet('<%=blb.getBgid()%>')" data-acc-link="<%=blb.getBgid()%>"><span class="font_002"><%=dfrmt.format(Integer.parseInt(blb.getEmoney()))%></span> 원</td>
							
							<%
									} else if(blb.getBresult().equals("MISS")){
							%>
									<td class="beting_btn_1" onmouseover="CBg(this)" onmouseout="RBg(this)" style="border-right:solid 1px #1c2021;color:red" onClick="selBet('<%=blb.getBgid()%>')" data-acc-link="<%=blb.getBgid()%>"><span class="font_002">미적중</span></td>
									<td class="acc_list_price1"  onmouseover="CBg(this)" onmouseout="RBg(this)" style="border-right:solid 1px #1c2021;" onClick="selBet('<%=blb.getBgid()%>')" data-acc-link="<%=blb.getBgid()%>"><%=dfrmt.format(Integer.parseInt(blb.getBmoney()))%> 원</td>
									<td class="acc_list_dividend"  onmouseover="CBg(this)" onmouseout="RBg(this)" style="border-right:solid 1px #1c2021;" onClick="selBet('<%=blb.getBgid()%>')" data-acc-link="<%=blb.getBgid()%>"><%=blb.getErate()%> 배</td>
									<td class="acc_list_price2" onmouseover="CBg(this)" onmouseout="RBg(this)" style="border-right:solid 1px #1c2021;" onClick="selBet('<%=blb.getBgid()%>')" data-acc-link="<%=blb.getBgid()%>"><%=dfrmt.format(Integer.parseInt(blb.getEmoney()))%> 원</td>
							
							
							<%
									} else if(blb.getBresult().equals("NO")){
							%>
									<td class="beting_btn_1" onmouseover="CBg(this)" onmouseout="RBg(this)" style="border-right:solid 1px #1c2021;" onClick="selBet('<%=blb.getBgid()%>')" data-acc-link="<%=blb.getBgid()%>">진행중</td>
									<td class="acc_list_price1"  onmouseover="CBg(this)" onmouseout="RBg(this)" style="border-right:solid 1px #1c2021;" onClick="selBet('<%=blb.getBgid()%>')" data-acc-link="<%=blb.getBgid()%>"><%=dfrmt.format(Integer.parseInt(blb.getBmoney()))%> 원</td>
									<td class="acc_list_dividend"  onmouseover="CBg(this)" onmouseout="RBg(this)" style="border-right:solid 1px #1c2021;" onClick="selBet('<%=blb.getBgid()%>')" data-acc-link="<%=blb.getBgid()%>"><%=blb.getErate()%> 배</td>
									<td class="acc_list_price2" onmouseover="CBg(this)" onmouseout="RBg(this)" style="border-right:solid 1px #1c2021;" onClick="selBet('<%=blb.getBgid()%>')" data-acc-link="<%=blb.getBgid()%>"><%=dfrmt.format(Integer.parseInt(blb.getEmoney()))%> 원</td>
							
							<%
							
									} else if(blb.getBresult().equals("CANCEL")){
							%>
									
									<td class="beting_btn_1" onmouseover="CBg(this)" onmouseout="RBg(this)" style="border-right:solid 1px #1c2021;" onClick="selBet('<%=blb.getBgid()%>')" data-acc-link="<%=blb.getBgid()%>">취소</td>
									<td class="acc_list_price1"  onmouseover="CBg(this)" onmouseout="RBg(this)" style="border-right:solid 1px #1c2021;" onClick="selBet('<%=blb.getBgid()%>')" data-acc-link="<%=blb.getBgid()%>"><%=dfrmt.format(Integer.parseInt(blb.getBmoney()))%> 원</td>
									<td class="acc_list_dividend" onmouseover="CBg(this)" onmouseout="RBg(this)" style="border-right:solid 1px #1c2021;" onClick="selBet('<%=blb.getBgid()%>')" data-acc-link="<%=blb.getBgid()%>"><%=blb.getErate()%> 배</td>
									<td class="acc_list_price2" onmouseover="CBg(this)" onmouseout="RBg(this)" style="border-right:solid 1px #1c2021;" onClick="selBet('<%=blb.getBgid()%>')" data-acc-link="<%=blb.getBgid()%>"><%=dfrmt.format(Integer.parseInt(blb.getEmoney()))%> 원</td>
							<%
							}
							%>	
									<td class="acc_list_folder" onmouseover="CBg(this)" onmouseout="RBg(this)" style="border-right:solid 1px #1c2021;" onClick="selBet('<%=blb.getBgid()%>')" data-acc-link="<%=blb.getBgid()%>"><%=fn%></td>						
									<td class="acc_list_check_1"><%=fullsname%></td>						
								</tr>
											
						<%
						}
						%>
								
					
									</tbody>
								</table>	
								</form>
							</div><!-- 1 -->
						</div>
						
					</div>
					<div class="left_btn_wrap"><span class="btn7" id="sa_sp2" style="cursor: pointer">전체 선택</span> &nbsp;<span class="btn8" id="del_all" style="cursor: pointer">선택 삭제</span></div>
											
						<script type="text/javascript">
									
							$('#sa_sp').click(function(event) {	

							  if(this.checked) {

							      $(document.getElementById('cbForm1').cb).each(function() {
							          this.checked = true;
							      });
							      
							      document.getElementById('sa_sp2').innerHTML = "선택 해제"
							  } else {
							    $(document.getElementById('cbForm1').cb).each(function() {
							          this.checked = false;
							      });
							      
							      document.getElementById('sa_sp2').innerHTML = "전체 선택"
							      
							  }
							});
							
							$('#sa_sp2').click(function(event) {	
								
								var stat = document.getElementById('sa_sp2');
								
								 if(stat.innerHTML == "전체 선택") {
								 	
							    $(document.getElementById('cbForm1').cb).each(function() {
							          this.checked = true;
							     });	
							     
							     $(document.getElementById('cbForm1').sa_sp).each(function() {
							          this.checked = true;
							     });			
							     
							     document.getElementById('sa_sp2').innerHTML = "선택 해제"
							   
							   } else { 
							    
							    $(document.getElementById('cbForm1').cb).each(function() {
							          this.checked = false;
							     });	
							     
							     $(document.getElementById('cbForm1').sa_sp).each(function() {
							          this.checked = false;
							     });	
							     
							     document.getElementById('sa_sp2').innerHTML = "전체 선택"
							     
							   }
							   
							    
							      
							});

							$(function() {
									$('.example1').accordion({ multiOpen: true });

							});
							
							$('#delAllAsk').popup({
					      	transition: 'all 0.3s',
					      	scrolllock: true,
					    });	
					    
					    $('#delSelAsk').popup({
					      	transition: 'all 0.3s',
					      	scrolllock: true,
					    });	
					    
					    $('#delAllCon').popup({
					      	transition: 'all 0.3s',
					      	scrolllock: true
					    });        						
		
							$("#del_all").on("click",function(){
								
								document.form.seltab.value="SP";
								
								if(!validCheckBox()){
									$("#delSelAsk").popup("show");
								} else{
									$("#delAllAsk").popup("show");
								}
							});
							
							function validCheckBox(){
								//var opts = document.getElementsByName('cb');
								var opts = document.getElementById('cbForm1').cb;
								
								for(i=0; i < opts.length; i++) {
								      if(opts[i].checked) {return true;}
								}
								return false;
							}

							var table =jQuery('#table1').DataTable( {

								"columnDefs": [ 
									{
				            "targets": [9],
				            "visible": false,
				            "searchable": true
				          },
				          {
				            "targets": [2],
				            "visible": true,
				            "searchable": true
				          },
				          {
				          	"targets": [3],
				          	"visible": true,
				          	"searchable": true
				          }
								],     
										"order": [[ 2, "desc" ]] ,   
						      	"paging": true,
						      	"lengthChange": false,
						      	"searching": true,
						      	"ordering": true,
						      	"info": false,
						      	"autoWidth": false,
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
						    });
						    
						$.fn.dataTable.ext.search.push(
					    function( settings, data, dataIndex ) {
					        var min  = $('#bfd1').val();					        
					        var max  = $('#bdt1').val();
					        var max2 =  moment(max).add('days', 1);
					        
					        var createdAt = data[2] || 0; // Our date column in the table

					        if((min== ""||max2== "")||( moment(createdAt).isSameOrAfter(min) && moment(createdAt).isSameOrBefore(max2) ) ){
					            return true;
					        }
					        return false;
					    }
						);
						
				
				    	function d1(){
								var dateFrom = $("#bfd1").val();
						    var dateTo = $("#bdt1").val();
						    $("#bd1").val(dateFrom + ' ~ '+ dateTo);
						    table.draw();
							}
	
						  $(".bhdp1").on("change",function(e){
        				d1();        				
	 			      });
	 			       

				


						    
						</script>
						
				</div>
			</div>
		</li>
		
		<li>
			<div class="acc_head"><h3>아시안 게임 베팅내역  [<%=bl_ag.size()%>]</h3></div>
			<div class="acc_content">
				<div class="acc_content_in_2">
					
					<div class="bet_search_wrap">
						<table cellspacing="0" cellpadding="0" class="my_search_select">
							<tr>
								<td>
									<input class="input_style04" id="bd2" placeholder="기간" value="2017-00-00 ~ 2017-00-00" readonly>
									<span class="showdp2" style="cursor:pointer"><img src="/images/car_icon.jpg"></span>
									<div id="bet-depth2" style="display:none; position:absolute; z-index:100000000; left: 100px;">
										
										<div style="float:right; padding:7px 2px 7px 10px;">
											<span id="closeMoneyPikaday" class="bclose2" >
												<img src="/images/car_close.png" class="bclose2">
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
								</td>
								<!--
								<td>
									<span class="btn1" id="dpbtn2">검색</span>
								</td>
								-->
							</tr>
						</table>
					</div>
					
					<div class="bet_wrap">
						
						<div class="example4">
							<div class="panel panel-primary"><!-- 1 -->
									<form name="cbForm4" id="cbForm4">											
									<table  id="table4"  cellspacing="0" cellpadding="0" width="100%">
										<thead>
										<tr>
											<td class="list_table_t_1" width="5%" style="border-left:solid 1px #1c2021; border-right:solid 1px #1c2021;"><input type="checkbox"  name="sa_ag" id="sa_ag" ></td>
											<td class="list_table_t_1" width="12%" style="border-right:solid 1px #1c2021;">베팅 NO.</td>
											<td class="list_table_t_1" width="16%" style="border-right:solid 1px #1c2021;">일시</td>
											<td class="list_table_t_1" style="border-right:solid 1px #1c2021;">결과</td>
											<td class="list_table_t_1" width="24%" style="border-right:solid 1px #1c2021;">배팅금액</td>
											<td class="list_table_t_1" width="24%" style="border-right:solid 1px #1c2021;">결과금액</td>
										</tr>
									</thead>
									
									<tbody>
									
								<%
										for (int n=0; n < bl_ag.size() ; n++){
											BettingListBean_SC blb_ag = (BettingListBean_SC) bl_ag.get(n);	
																																				
								%>
								<tr style="cursor: pointer">
									<td class="acc_list_check_1" style="border-left:solid 1px #1c2021; border-right:solid 1px #1c2021;"><input type="checkbox" name="cb" value="<%=blb_ag.getBgid()%>"></td>
									<td class="acc_list_num" style="border-right:solid 1px #1c2021;"><%=blb_ag.getBgid()%></td>
									<td class="acc_list_time" style="border-right:solid 1px #1c2021;"><%=blb_ag.getRegdt()%></td>
							
							<%
									if(blb_ag.getJob().equals("WIN")){
							%>
									<td class="acc_list_num" style="border-right:solid 1px #1c2021;"><span class="font_004">승</span></td>
									<td style="text-align:right; border-right:solid 1px #1c2021;"><%=dfrmt.format(Integer.parseInt(blb_ag.getBmoney()))%>원</td>
									<td class="acc_list_price1" style="border-right:solid 1px #1c2021;"><%=dfrmt.format(Integer.parseInt(blb_ag.getRmoney()))%> 원</td>
							<%		
									} else if(blb_ag.getJob().equals("LOSE")){ 
							%>
									<td class="acc_list_num" style="border-right:solid 1px #1c2021;"><span class="font_002">패</span></td>
									<td class="acc_list_price1_1" style="border-right:solid 1px #1c2021;"><%=dfrmt.format(Integer.parseInt(blb_ag.getBmoney()))%> 원</td>
									<td class="acc_list_price1_1" style="border-right:solid 1px #1c2021;"><%=dfrmt.format(Integer.parseInt(blb_ag.getRmoney()))%> 원</td>
							
							<%		
									} else if(blb_ag.getJob().equals("BET")){ 
							%>
									<td class="acc_list_num" style="border-right:solid 1px #1c2021;">배팅</td>
									<td class="acc_list_price1" style="border-right:solid 1px #1c2021;"><%=dfrmt.format(Integer.parseInt(blb_ag.getBmoney()))%> 원</td>
									<td class="acc_list_price1" style="border-right:solid 1px #1c2021;"><%=dfrmt.format(Integer.parseInt(blb_ag.getRmoney()))%> 원</td>
							<%		
									} else if(blb_ag.getJob().equals("REFUND")){ 
							%>
									<td class="acc_list_num" style="border-right:solid 1px #1c2021;"><span class="font_004">환불</span></td>
									<td class="acc_list_price1" style="border-right:solid 1px #1c2021;"><%=dfrmt.format(Integer.parseInt(blb_ag.getBmoney()))%> 원</td>
									<td class="acc_list_price1" style="border-right:solid 1px #1c2021;"><%=dfrmt.format(Integer.parseInt(blb_ag.getRmoney()))%> 원</td>
							<%		
									}
							%>		

								</tr>
											
						<%
						}
						%>
								
					
									</tbody>
								</table>	
								</form>
							</div>
						</div>
						
					</div>
					
					<div class="left_btn_wrap"><span class="btn7" id="sa2_ag" style="cursor: pointer">전체 선택</span> &nbsp;<span class="btn8" id="del_all_ag" style="cursor: pointer">선택 삭제</span></div>
											
						<script type="text/javascript">
									
							$('#sa_ag').click(function(event) {	
							  
							  if(this.checked) {

							      $(document.getElementById('cbForm4').cb).each(function() {
							          this.checked = true;
							      });
							      
							      document.getElementById('sa2_ag').innerHTML = "선택 해제"
							      
							  } else {
							    $(document.getElementById('cbForm4').cb).each(function() {
							          this.checked = false;
							      });
							      
							      document.getElementById('sa2_ag').innerHTML = "전체 선택"
							      
							  }
							  
							});
							
							$('#sa2_ag').click(function(event) {	
								
							  var stat = document.getElementById('sa2_ag');
								
								 if(stat.innerHTML == "전체 선택") {
								 	
							    $(document.getElementById('cbForm4').cb).each(function() {
							          this.checked = true;
							     });	
							     
							     $(document.getElementById('cbForm4').sa_ag).each(function() {
							          this.checked = true;
							     });			
							     
							     document.getElementById('sa2_ag').innerHTML = "선택 해제"
							   
							   } else { 
							    
							    $(document.getElementById('cbForm4').cb).each(function() {
							          this.checked = false;
							     });	
							     
							     $(document.getElementById('cbForm4').sa_ag).each(function() {
							          this.checked = false;
							     });	
							     
							     document.getElementById('sa2_ag').innerHTML = "전체 선택"
							     
							   }
							   
							     
							});

							$(function() {
									$('.example4').accordion({ multiOpen: true });

							});
							
		
							$("#del_all_ag").on("click",function(){
								
								document.form.seltab.value="AG";
								
								if(!validCB_AG()){
									$("#delSelAsk").popup("show");
								} else{
									$("#delAllAsk").popup("show");
								}
							});
							
							function validCB_AG(){
				
								var opts = document.getElementById('cbForm4').cb;
								
								for(i=0; i < opts.length; i++) {
								      if(opts[i].checked) {return true;}
								}
								return false;
							}

							var table4 =jQuery('#table4').DataTable( {
								"columnDefs": [ 
						],        
						      "paging": true,
						      "lengthChange": false,
						      "searching": true,
						      "ordering": true,
						      "info": false,
						      "autoWidth": false,
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
						    });
						    
						 $.fn.dataTable.ext.search.push(
					    function( settings, data, dataIndex ) {
					        var min  = $('#bfd2').val();					        
					        var max  = $('#bdt2').val();
					        var max2 =  moment(max).add('days', 1);
					        
					        var createdAt = data[2] || 0; // Our date column in the table

					        if((min== ""||max2== "")||( moment(createdAt).isSameOrAfter(min) && moment(createdAt).isSameOrBefore(max2) ) ){
					            return true;
					        }
					        return false;
					    }
						);
						    
						</script>
						
				</div>
			</div>
		</li>
		<li>
			<div class="acc_head"><h3>가상 게임 베팅내역 [<%=bl_sc.size()%>]</h3></div>
			<div class="acc_content">
				<div class="acc_content_in_2">
					<div class="bet_search_wrap">
						<table cellspacing="0" cellpadding="0" class="my_search_select">
							<tr>
								<td>
									<input class="input_style04" id="bd3" placeholder="기간" value="2017-00-00 ~ 2017-00-00" readonly>
									<span class="showdp3" style="cursor:pointer"><img src="/images/car_icon.jpg"></span>
									<div id="bet-depth3" style="display:none; width:; position:absolute; z-index:100000000; left: 100px;">
										<div style="float:right; padding:7px 2px 7px 10px;">
											<span id="closeMoneyPikaday" class="bclose3" style="cursor:pointer">
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
								</td>
								<!--
								<td>
									<span class="btn1" id="dpbtn3">검색</span>
								</td>
								-->
							</tr>
						</table>
					</div>
					<div class="bet_wrap">
						
						<div class="example2">
							<div class="panel panel-primary"><!-- 1 -->
									<form name="cbForm2" id="cbForm2">											
									<table  id="table2"  cellspacing="0" cellpadding="0" width="100%">
										<thead>
										<tr>
											<td class="list_table_t_1" width="5%" style="border-right:solid 1px #1c2021; border-left:solid 1px #1c2021;" ><input type="checkbox"  name="sa_sc" id="sa_sc" ></td>
											<td class="list_table_t_1" width="7%" style="border-right:solid 1px #1c2021;">베팅 NO.</td>
											<td class="list_table_t_1" width="21%" style="border-right:solid 1px #1c2021;">일시</td>
											<td class="list_table_t_1" width="11%" style="border-right:solid 1px #1c2021;">충/환전</td>
											<td class="list_table_t_1" width="16%" style="border-right:solid 1px #1c2021;">금액</td>
										</tr>
									</thead>
									
									<tbody>
									
								<%
										for (int j=0; j < bl_sc.size() ; j++){
											BettingListBean_SC blb_sc = (BettingListBean_SC) bl_sc.get(j);			
											
											String wd = "<span class='font_004'>충전</span>";
											
											if(blb_sc.getJob().equals("W")){
												wd = "<span class='font_002'>환전</span>";
											}
																				
								%>
								<tr style="cursor: pointer">
									<td class="acc_list_check" width="5%"><input type="checkbox"  name="cb" value="<%=blb_sc.getBgid()%>"></td>
									<td class="acc_list_num" width="7%"><%=blb_sc.getBgid()%></td>
									<td class="acc_list_time"  width="7%"><%=blb_sc.getRegdt()%></td>
									<td class="acc_list_time"  width="21%"><%=wd%></td>
									<td class="acc_list_price1"  width="16%"><%=dfrmt.format(Integer.parseInt(blb_sc.getBmoney()))%> 원</td>
								</tr>
											
						<%
						}
						%>
								
					
									</tbody>
								</table>	
								</form>
							</div><!-- 1 -->
						</div>
						
					</div>
					<div class="left_btn_wrap"><span class="btn7" id="sa2_sc" style="cursor: pointer">전체 선택</span> &nbsp;<span class="btn8" id="del_all_sc" style="cursor: pointer">선택 삭제</span></div>
											
						<script type="text/javascript">
									
							$('#sa_sc').click(function(event) {	
							  
							  if(this.checked) {

							      $(document.getElementById('cbForm2').cb).each(function() {
							          this.checked = true;
							      });
							      
							      document.getElementById('sa2_sc').innerHTML = "선택 해제"
							      
							  } else {
							    $(document.getElementById('cbForm2').cb).each(function() {
							          this.checked = false;
							      });
							      
							      document.getElementById('sa2_sc').innerHTML = "전체 선택"
							      
							  }
							  
							});
							
							$('#sa2_sc').click(function(event) {	
								
							  var stat = document.getElementById('sa2_sc');
								
								 if(stat.innerHTML == "전체 선택") {
								 	
							    $(document.getElementById('cbForm2').cb).each(function() {
							          this.checked = true;
							     });	
							     
							     $(document.getElementById('cbForm2').sa_sc).each(function() {
							          this.checked = true;
							     });			
							     
							     document.getElementById('sa2_sc').innerHTML = "선택 해제"
							   
							   } else { 
							    
							    $(document.getElementById('cbForm2').cb).each(function() {
							          this.checked = false;
							     });	
							     
							     $(document.getElementById('cbForm2').sa_sc).each(function() {
							          this.checked = false;
							     });	
							     
							     document.getElementById('sa2_sc').innerHTML = "전체 선택"
							     
							   }
							   
							     
							});

							$(function() {
									$('.example2').accordion({ multiOpen: true });

							});
							
		
							$("#del_all_sc").on("click",function(){
								
								document.form.seltab.value="SC";
								
								if(!validCB_SC()){
									$("#delSelAsk").popup("show");
								} else{
									$("#delAllAsk").popup("show");
								}
							});
							
							function validCB_SC(){
								//var opts = document.cbForm2.getElementsByName('cb_sc');											
								//var opts = document.getElementsByTagName('cbForm2')[0]											
								var opts = document.getElementById('cbForm2').cb;
								
								for(i=0; i < opts.length; i++) {
								      if(opts[i].checked) {return true;}
								}
								return false;
							}

							var table2 =jQuery('#table2').DataTable( {
								"columnDefs": [ 
						],        
						      "paging": true,
						      "lengthChange": false,
						      "searching": true,
						      "ordering": true,
						      "info": false,
						      "autoWidth": false,
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
						    });
						  
						  $.fn.dataTable.ext.search.push(
					    function( settings, data, dataIndex ) {
					        var min  = $('#bfd3').val();					        
					        var max  = $('#bdt3').val();
					        var max2 =  moment(max).add('days', 1);
					        
					        var createdAt = data[2] || 0; // Our date column in the table

					        if((min== ""||max2== "")||( moment(createdAt).isSameOrAfter(min) && moment(createdAt).isSameOrBefore(max2) ) ){
					            return true;
					        }
					        return false;
					    }
						);
						  
						    
						</script>
						
				</div>
			</div>		
		</li>
		<li>
			<div class="acc_head"><h3>마이크로 게임 베팅내역  [<%=bl_mg.size()%>] </h3></div>
			<div class="acc_content">
				<div class="acc_content_in_2">
					<div class="bet_search_wrap">
						<table cellspacing="0" cellpadding="0" class="my_search_select">
							<tr>
								<td>
									<input class="input_style04" id="bd4" placeholder="기간" value="2017-00-00 ~ 2017-00-00" readonly>
									<span class="showdp4" style="cursor:pointer"><img src="/images/car_icon.jpg"></span>
									<div id="bet-depth4" style="display:none; width:; position:absolute; z-index:100000000; left: 100px;">
										
										<div style="float:right; padding:7px 2px 7px 10px;">
											<span id="closeMoneyPikaday" class="bclose4" style="cursor:pointer">
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
								</td>
								<!--
								<td>
									<span class="btn1" id="dpbtn4">검색</span>
								</td>
								-->
							</tr>
						</table>
					</div>
					<div class="bet_wrap">
						
						<div class="example3">
							<div class="panel panel-primary"><!-- 1 -->
									<form name="cbForm3" id="cbForm3">											
									<table  id="table3"  cellspacing="0" cellpadding="0" width="100%">
										<thead>
										<tr>
											<td class="list_table_t_1" width="5%" style="border-right:solid 1px #1c2021; border-left: solid 1px #1c2021; "><input type="checkbox"  name="sa_mg" id="sa_mg" ></td>
											<td class="list_table_t_1" width="7%" style="border-right:solid 1px #1c2021;">베팅 NO.</td>
											<td class="list_table_t_1" width="21%" style="border-right:solid 1px #1c2021;" >일시</td>
											<td class="list_table_t_1" width="11%" style="border-right:solid 1px #1c2021;">충/환전</td>
											<td class="list_table_t_1" width="16%" style="border-right:solid 1px #1c2021;">금액</td>
										</tr>
									</thead>
									
									<tbody>
									
								<%
										for (int m=0; m < bl_mg.size() ; m++){
											BettingListBean_SC blb_mg = (BettingListBean_SC) bl_mg.get(m);	
											
											String wd = "<span class='font_004'>충전</span>";
											
											if(blb_mg.getJob().equals("W")){
												wd = "<span class='font_002'>환전</span>";
											}
																						
								%>
								<tr style="cursor: pointer">
									<td class="acc_list_check" width="5%"  ><input type="checkbox"  name="cb" value="<%=blb_mg.getBgid()%>"></td>
									<td class="acc_list_num" width="7%" ><%=blb_mg.getBgid()%></td>
									<td class="acc_list_time"  width="7%" ><%=blb_mg.getRegdt()%></td>
									<td class="acc_list_time"  width="21%" ><%=wd%></td>
									<td class="acc_list_price1"  width="16%" ><%=dfrmt.format(Integer.parseInt(blb_mg.getBmoney()))%> 원</td>
								</tr>
											
						<%
						}
						%>
								
					
									</tbody>
								</table>	
								</form>
							</div><!-- 1 -->
						</div>
						
					</div>
					<div class="left_btn_wrap"><span class="btn7" id="sa2_mg" style="cursor: pointer">전체 선택</span> &nbsp;<span class="btn8" id="del_all_mg" style="cursor: pointer">선택 삭제</span></div>
											
						<script type="text/javascript">
									
							$('#sa_mg').click(function(event) {	
							  
							  if(this.checked) {

							      $(document.getElementById('cbForm3').cb).each(function() {
							          this.checked = true;
							      });
							      
							      document.getElementById('sa2_mg').innerHTML = "선택 해제"
							      
							  } else {
							    $(document.getElementById('cbForm3').cb).each(function() {
							          this.checked = false;
							      });
							      
							      document.getElementById('sa2_mg').innerHTML = "전체 선택"
							      
							  }
							  
							});
							
							$('#sa2_mg').click(function(event) {	
								
							  var stat = document.getElementById('sa2_mg');
								
								 if(stat.innerHTML == "전체 선택") {
								 	
							    $(document.getElementById('cbForm3').cb).each(function() {
							          this.checked = true;
							     });	
							     
							     $(document.getElementById('cbForm3').sa_mg).each(function() {
							          this.checked = true;
							     });			
							     
							     document.getElementById('sa2_mg').innerHTML = "선택 해제"
							   
							   } else { 
							    
							    $(document.getElementById('cbForm3').cb).each(function() {
							          this.checked = false;
							     });	
							     
							     $(document.getElementById('cbForm3').sa_mg).each(function() {
							          this.checked = false;
							     });	
							     
							     document.getElementById('sa2_mg').innerHTML = "전체 선택"
							     
							   }
							   
							     
							});

							$(function() {
									$('.example3').accordion({ multiOpen: true });

							});
							
		
							$("#del_all_mg").on("click",function(){
								
								document.form.seltab.value="MG";
								
								if(!validCB_MG()){
									$("#delSelAsk").popup("show");
								} else{
									$("#delAllAsk").popup("show");
								}
							});
							
							function validCB_MG(){
				
								var opts = document.getElementById('cbForm3').cb;
								
								for(i=0; i < opts.length; i++) {
								      if(opts[i].checked) {return true;}
								}
								return false;
							}

							var table3 =jQuery('#table3').DataTable( {
								"columnDefs": [ 
						],        
						      "paging": true,
						      "lengthChange": false,
						      "searching": true,
						      "ordering": true,
						      "info": false,
						      "autoWidth": false,
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
						    });
						    
						$.fn.dataTable.ext.search.push(
					    function( settings, data, dataIndex ) {
					        var min  = $('#bfd4').val();					        
					        var max  = $('#bdt4').val();
					        var max2 =  moment(max).add('days', 1);
					        
					        var createdAt = data[2] || 0; // Our date column in the table

					        if((min== ""||max2== "")||( moment(createdAt).isSameOrAfter(min) && moment(createdAt).isSameOrBefore(max2) ) ){
					            return true;
					        }
					        return false;
					    }
						);
						
						    
						</script>
						
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

	<script type="text/javascript">					
		$("#del_all_no").on("click",function(){

			$("#delAllAsk").popup("hide");
		});		
		
		$("#del_all_no2").on("click",function(){

			$("#delAllAsk").popup("hide");
		});	
		
		$("#del_all_yes").on("click",function(){		
			
			$("#delAllAsk").popup("hide");	
			
			if(document.form.seltab.value =="SP"){
				var param = $(document.getElementById('cbForm1').cb).serialize();
				param += '&st=SP';
				
			} else if(document.form.seltab.value =="SC"){
				var param = $(document.getElementById('cbForm2').cb).serialize();
				param += '&st=SC';
				
			} else if(document.form.seltab.value =="MG"){
				var param = $(document.getElementById('cbForm3').cb).serialize();
				param += '&st=MG';
				
			} else if(document.form.seltab.value =="AG"){
				var param = $(document.getElementById('cbForm4').cb).serialize();
				param += '&st=AG';
			}

			

			$.ajax({
				url:'/info/jsp/delBettingHistory.jsp',								
				type:'POST',
				cache: false,
	   			data: param,
			}).done(function(data){
				
				if(data !="" || data !=null){
					//alert("deleted");
					//logoutModal2.show();
					$("#delAllCon").popup("show");
					//window.location.reload();
				}else{
					alert("something went wrong");
				}
			});
		});
	</script>							
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
	
	<script>
	$("#del_all_conf").on("click",function(){
		//e.preventDefault();
		$("#delAllCon").popup("hide");
		location.reload();
	});						
	</script>
						
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
		//e.preventDefault();
		$("#delSelAsk").popup("hide");
		//location.reload();
	});						
	</script>
	
	
	<form name="form" id="form">
		<input type="hidden" name="seltab">
	</form>					
</div>

<script>
	$(document).ready(function(){

		// calendar 1

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
      i18n : i18n,
		});

   	var bpt1 = new Pikaday({ 
   		field: document.getElementById('bdt1'), 
   		bound: false, 
   		container: document.getElementById('bdtdiv1'),
   		format :'YYYY-MM-DD',
   		i18n : i18n,
   		onSelect: function() {
	    	$("#bet-depth1").hide();
	    },	        
   		defaultDate: moment().toDate(),
   		setDefaultDate : moment().toDate(),       		
   		minDate : bpf1.getDate(),
   		maxDate : moment().toDate(),
   	});
   	
    d1();
       	
/*
        $("#dpbtn1").on("click",function(e){
        	e.preventDefault();
        	$moneyUseTable.ajax.reload();
        	$("#bet-depth1").hide();
        });
*/

        $(".showdp1").on("click",function(e){
        	e.preventDefault();
        	show_over(this);
        	show_layer('bet-depth1');
        	
        });

        $(".bclose1 ").on("click",function(e){
        	e.preventDefault();
        	$("#bet-depth1").hide();
        });

        //  cal 2

     var bpf2 = new Pikaday({ 
			field: document.getElementById('bfd2'), 
			bound: false, 
			container: document.getElementById('bdfdiv2'),
			format: 'YYYY-MM-DD',
	    defaultDate:moment().subtract(30,'days').toDate(),
   		setDefaultDate:moment().subtract(30,'days').toDate(),
	    minDate : moment().subtract(30,'days').toDate(),
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
	   		onSelect: function() {
	    	$("#bet-depth2").hide();
	    	},	
	   	});

       	d2();

       	$(".bhdp2").on("change",function(e){
        	d2();
        });
/*
        $("#dpbtn2").on("click",function(e){
        	e.preventDefault();
        	$moneyUseTable.ajax.reload();
        	$("#bet-depth2").hide();
        });
*/

        $(".showdp2").on("click",function(e){
        	e.preventDefault();
        	show_over(this);
        	show_layer('bet-depth2');
        	
        });

        $(".bclose2 ").on("click",function(e){
        	e.preventDefault();
        	$("#bet-depth2").hide();
        });


        // cal 3 


    var bpf3 = new Pikaday({ 
			field: document.getElementById('bfd3'), 
			bound: false, 
			container: document.getElementById('bdfdiv3'),
			format: 'YYYY-MM-DD',
	    defaultDate:moment().subtract(30,'days').toDate(),
   		setDefaultDate:moment().subtract(30,'days').toDate(),
	    minDate : moment().subtract(30,'days').toDate(),
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
   		onSelect: function() {
	    	$("#bet-depth3").hide();
	    },	
   	});

       	d3();

       	$(".bhdp3").on("change",function(e){
        	d3();
        });
/*
        $("#dpbtn3").on("click",function(e){
        	e.preventDefault();
        	$moneyUseTable.ajax.reload();
        	$("#bet-depth3").hide();
        });
*/
        $(".showdp3").on("click",function(e){
        	e.preventDefault();
        	show_over(this);
        	show_layer('bet-depth3');
        	
        });

        $(".bclose3 ").on("click",function(e){
        	e.preventDefault();
        	$("#bet-depth3").hide();
        });

        // cal 4 


    var bpf4 = new Pikaday({ 
			field: document.getElementById('bfd4'), 
			bound: false, 
			container: document.getElementById('bdfdiv4'),
			format: 'YYYY-MM-DD',
	    defaultDate:moment().subtract(30,'days').toDate(),
   		setDefaultDate:moment().subtract(30,'days').toDate(),
	    minDate : moment().subtract(30,'days').toDate(),
	    i18n : i18n,
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
	    	$("#bet-depth4").hide();
	    },	
   	});

   	d4();

   	$(".bhdp4").on("change",function(e){
    	d4();
    });

/*
    $("#dpbtn4").on("click",function(e){
    	e.preventDefault();
    	$moneyUseTable.ajax.reload();
    	$("#bet-depth4").hide();
    });
*/
    $(".showdp4").on("click",function(e){
    	e.preventDefault();
    	show_over(this);
    	show_layer('bet-depth4');
    	
    });

    $(".bclose4 ").on("click",function(e){
    	e.preventDefault();
    	$("#bet-depth4").hide();
    });

	});




	function d2(){
		var dateFrom = $("#bfd2").val();
    var dateTo = $("#bdt2").val();
    $("#bd2").val(dateFrom + ' ~ '+ dateTo);
   	table4.draw();
	}

	function d3(){
		var dateFrom = $("#bfd3").val();
    var dateTo = $("#bdt3").val();
    $("#bd3").val(dateFrom + ' ~ '+ dateTo);
    table2.draw();
	}

	function d4(){
		var dateFrom = $("#bfd4").val();
    var dateTo = $("#bdt4").val();
    $("#bd4").val(dateFrom + ' ~ '+ dateTo);
    table3.draw();
	}
	
var NColor= "#262a2b";
var CColor= "#293133";

	function CBg(row) { 
		row.parentNode.style.backgroundColor = CColor; 
	}

	function RBg(row) { 
		row.parentNode.style.backgroundColor = NColor; 
	}

</script>
