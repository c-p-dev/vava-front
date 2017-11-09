<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="java.util.*"%>
<%@page import="net.vavasoft.bean.*"%>
<%@page import="java.lang.Integer"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="com.google.gson.reflect.TypeToken"%>

 
<jsp:useBean id="bm" class="net.vavasoft.bc4.BetConManager2" />
	
<%
List<MatchResultBean> mr = bm.getAllMatchResult();

Gson gson = new Gson();
Type type = new TypeToken<List<MatchResultBean>>() {}.getType();
 String json = gson.toJson(mr, type);            

%>


<%@ include file="/inc/main_header.jsp" %>


<style type="text/css">
.dataTables_filter {
display: none; 
}



.pagination a {
    color: #fff ;
    text-decoration: none;
}

.disabled {
	background: #dddddd;
	}
	
</style>


<script>

var mainAngular = angular.module('Vava', [ 'ngAnimate', 'vAccordion' ]);

    
mainAngular.controller("mc", function($scope, $templateCache, $compile, $http) {		

   	
	$scope.table = table;		
	$scope.tabDate = "0";
	
	var $filter = angular.injector(['ng', 'Vava']).get('$filter');

	$scope.MR = [];			
	$scope.MR = <%=json%>;
	

	$scope.selSport = function(sid,sname) {
    
    //console.log("selSport");
    
	  $scope.sSId = sid;
		$scope.tabDate = "0";
		
		table.columns(0).search('').draw();
		table.columns(1).search('').draw();
		table.columns(2).search('').draw();
		table.columns(3).search('').draw();
		
		document.getElementById("selsport1").innerHTML = sname;		
		document.getElementById("selreg1").innerHTML = "지역 선택";
		document.getElementById("selcomp1").innerHTML = "리그 선택";
		
		if(sid != 0)
  		table.columns(0).search(sid).draw();
        
	};
	
	$scope.selReg = function(rid,rname) {				
    
		$scope.sRId = rid;
		$scope.tabDate = "0";
		
		table.columns(1).search('').draw();
		table.columns(2).search('').draw();
		table.columns(3).search('').draw();
		
	  document.getElementById("selreg1").innerHTML = rname;
	  document.getElementById("selcomp1").innerHTML = "리그 선택";
	  
	  if(rid != 0)		
  	table.columns(1).search(rid).draw();
	};
	
	$scope.selComp = function(cid,cname) {		
		
		$scope.sCId = cid;
		$scope.tabDate = "0";
		
		table.columns(2).search('').draw();
		table.columns(3).search('').draw();
		
	  document.getElementById("selcomp1").innerHTML = cname;
	  
	  if(cid != 0)	
  	table.columns(2).search(cid).draw();
	};
	
	$scope.MatchDate = function (date) {
  	$scope.tabDate = date;
  	table.columns(3).search(date).draw();
 }    
  

 	$scope.getSel = function (mid){
		
			$http({
					method: 'GET', 
					url: 'jsp/getSelectionList.jsp', 
					params: {'mid':mid},
					headers: {'Content-Type': 'application/json; charset=utf-8'} 
			}).success(function(data, status, headers, config) {
						
				//$scope.MKTY = $filter('groupBy')(data,'MTD');  // delete ID	
				//console.log("$scope.getSel");
				//console.log(data);
				//$scope.SEL = [];
				$scope.SEL = data;
				$scope.SEL2 = [{"1":1}];
				//return data;
				
			}).error(function(data, status, headers, config) {
			});
	}
});
	
</script>
	
</head>



<body id="myAnchor" ng-app="Vava" ng-controller="mc"> 
	
<a href="#myAnchor" class="go-top">▲</a>
<div id="wrap">

<%@ include file="/inc/session.jsp" %>
<%@ include file="/inc/header.jsp" %>


<div id="contents_wrap">
	<div class="game_contents">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>

				<td width="80%" style="padding:0 10px 0 10px;"  valign="top">
					<div class="game_center_wrap">
					    <div class="effect_tab_wrap">
							<div class="effect_tab_table">
								<div class="effect_row">
									
									<div style="background:#293133; padding:5px 10px 5px 10px">
										<input type="text" size="30" class="input_style01" id="input1" placeholder="팀,지역 또는 리그">
									</div>
									

									<div id="selsport"  href="#"  class="effect_more select open">
										<button type="button" class="myValue effect_tab_select_t_1"><span id="selsport1">종목 선택</span> <img src="/images/arrow_right.png"></button>
										<ul class="effect_tab_select_1">
											<li><div style="width:100%" ng-click="selSport('0','전체')">전체 </div></li> 
											<li ng-repeat="(key,value) in MR|orderBy:'SD'|groupBy:'SD'"><div style="width:100%" ng-click="selSport(key,value[0].SN)"> {{value[0].SN}} </div></li> 
										</ul>
									</div>
									
									<div id="selreg" href="#" class="effect_more select open">
										<button type="button" class="myValue effect_tab_select_t_1"><span id="selreg1">지역 선택</span> <img src="/images/arrow_right.png"></button>
										<ul class="effect_tab_select_1">
											<li><div style="width:100%" ng-click="selReg('0','전체')">전체 </div></li>
											<li ng-if="sSId != 0" ng-repeat="(key,value) in MR |where:{SD:sSId} |orderBy:'RN'|groupBy:'RD'"> <div style="width:100%" href="#" ng-click="selReg(key,value[0].RN)"> {{value[0].RN}} </div></li> 
											<li ng-if="sSId == 0" ng-repeat="(key,value) in MR | orderBy:'RN'|groupBy:'RD'"> <div style="width:100%" href="#" ng-click="selReg(key,value[0].RN)"> {{value[0].RN}} </div></li> 
										</ul>
									</div>
									
									<div id="selcomp" href="#" class="effect_more select open">
										<button type="button" class="myValue effect_tab_select_t_1"><span id="selcomp1">리그 선택</span> <img src="/images/arrow_right.png"></button>
										<ul class="effect_tab_select_1">
											<li><div style="width:100%" ng-click="selComp('0','전체')">전체 </div></li>
											<li ng-if="sRId != 0 && sSId != 0" ng-repeat="(key,value) in MR|where:{SD:sSId,RD:sRId} |orderBy:'CN'|groupBy:'CD'"><div style="width:100%" href="#" ng-click="selComp(key,value[0].CN)"> {{value[0].CN}} </div></li>
											<li ng-if="sRId != 0 && sSId == 0" ng-repeat="(key,value) in MR|where:{RD:sRId} | orderBy:'CN'|groupBy:'CD'"><div style="width:100%" href="#" ng-click="selComp(key,value[0].CN)"> {{value[0].CN}} </div></li>
											<li ng-if="sRId == 0 && sSId != 0" ng-repeat="(key,value) in MR|where:{SD:sSId} |orderBy:'CN'|groupBy:'CD'"><div style="width:100%" href="#" ng-click="selComp(key,value[0].CN)"> {{value[0].CN}} </div></li>
											<li ng-if="sRId == 0 && sSId == 0" ng-repeat="(key,value) in MR| orderBy:'CN'|groupBy:'CD'"><div style="width:100%" href="#" ng-click="selComp(key,value[0].CN)"> {{value[0].CN}} </div></li>
										</ul>
									</div>
									
									<a href="#" ng-class="{effect_tab_1_on:tabDate=='0',effect_tab_1:tabDate != '0'}" ng-click="MatchDate('0')">
										<span class="effect_tab_text">전체</span>
									</a>
									
									<a href="#" ng-class="{effect_tab_1_on:tabDate == key,effect_tab_1:tabDate != key}" ng-click="MatchDate(key)" 
											ng-repeat="(key,value) in MR |orderBy:'MT':true |groupBy:'MT'" >
												<span class="effect_tab_text">{{ key.substring(4,6) }}/{{key.substring(6,8)}} </span> <!-- <span class="live_tab_count">{{value.length}}</span> -->
									</a>

								</div>
							</div>
						</div>
						
							<div class="example1">
								<div class="panel panel-primary"><!-- 1 -->
									<div class="accOpen panel-heading" >
										
							<table id="table1" ng-table="tableParams" class="table"  width="100%" cellpadding="0" cellspacing="0">
								<thead>
									<tr>
										<td class="effect_table_t" width="0%">SID</td>
										<td class="effect_table_t" width="0%">RID</td>
										<td class="effect_table_t" width="0%">CID</td>
										<td class="effect_table_t" width="13%">경기시각</td>
										<td class="effect_table_t" width="7%">종목</td>
										<td class="effect_table_t" width="8%">국가</td>
										<td class="effect_table_t" width="15%">리그</td>
										<td class="effect_table_t" width="6%">결과</td>
										<td class="effect_table_t" width="20%">홈팀</td>
										<td class="effect_table_t" width="5%">무승부</td>
										<td class="effect_table_t" width="20%">원정팀</td>
										<td class="effect_table_t">더보기</td>
									</tr>
								</thead>
								<tbody>
						
						<%
								for (int k=0; k < mr.size() ; k++){
									MatchResultBean mrb = (MatchResultBean) mr.get(k);
									
									int hscore = Integer.parseInt(mrb.getScore().trim().split(":")[0]);
									int ascore = Integer.parseInt(mrb.getScore().trim().split(":")[1]);
						%>
										
									<tr id='<%=mrb.getMid()%>' style="cursor:pointer">
										<td class="effect_table_t" width="0%"><%=mrb.getSid()%></td>
										<td class="effect_table_t" width="0%"><%=mrb.getRid()%></td>
										<td class="effect_table_t" width="0%"><%=mrb.getCid()%></td>
										<td class="effect_time_1" data-acc-link="<%=mrb.getMid()%>" onClick="selMatch('<%=mrb.getMid()%>')"><%=mrb.getMdate()%></td>
										<td class="effect_name_1" data-acc-link="<%=mrb.getMid()%>" onClick="selMatch('<%=mrb.getMid()%>')"><%=mrb.getSname()%></td>
										<td class="effect_nation_1" data-acc-link="<%=mrb.getMid()%>" onClick="selMatch('<%=mrb.getMid()%>')"><!--<img src="/images/af.png">--> <%=mrb.getRname()%></td>
										<td class="effect_league_1" data-acc-link="<%=mrb.getMid()%>" onClick="selMatch('<%=mrb.getMid()%>')"><%=mrb.getCname()%></td>
										<td class="effect_effect_1" data-acc-link="<%=mrb.getMid()%>" onClick="selMatch('<%=mrb.getMid()%>')"><%=mrb.getScore()%></td>
										
						<%
						if(hscore == ascore){
						%>
										<td class="effect_home_1" data-acc-link="<%=mrb.getMid()%>" onClick="selMatch('<%=mrb.getMid()%>')"><div class="effect_right_1"><%=mrb.getHteam()%>&nbsp;&nbsp;&nbsp;<img src="/images/res_icon001-1.png"></div></td>
										<td class="effect_vs_1" data-acc-link="<%=mrb.getMid()%>" onClick="selMatch('<%=mrb.getMid()%>')"><div class="effect_center_1"><img src="/images/res_icon002.png"></div></td>
										<td class="effect_loss_1" data-acc-link="<%=mrb.getMid()%>" onClick="selMatch('<%=mrb.getMid()%>')"> <div class="effect_left_1"><img src="/images/res_icon003-1.png">&nbsp;&nbsp;&nbsp;<%=mrb.getAteam()%> </div> </td> 
						
						<%
						} else if(hscore > ascore){
						%>
										<td class="effect_home_1" data-acc-link="<%=mrb.getMid()%>" onClick="selMatch('<%=mrb.getMid()%>')"><div class="effect_right_2"><%=mrb.getHteam()%>&nbsp;&nbsp;&nbsp;<img src="/images/res_icon001.png"></div></td>
										<td class="effect_vs_1" data-acc-link="<%=mrb.getMid()%>" onClick="selMatch('<%=mrb.getMid()%>')"><div class="effect_center_1"><img src="/images/res_icon002-1.png"></div></td>
										<td class="effect_loss_1" data-acc-link="<%=mrb.getMid()%>" onClick="selMatch('<%=mrb.getMid()%>')"> <div class="effect_left_1"><img src="/images/res_icon003-1.png">&nbsp;&nbsp;&nbsp;<%=mrb.getAteam()%> </div> </td> 
										
						<%
						} else if(hscore < ascore){
						%>
										<td class="effect_home_1" data-acc-link="<%=mrb.getMid()%>" onClick="selMatch('<%=mrb.getMid()%>')"><div class="effect_right_1"><%=mrb.getHteam()%>&nbsp;&nbsp;&nbsp;<img src="/images/res_icon003-1.png"></div></td>
										<td class="effect_vs_1" data-acc-link="<%=mrb.getMid()%>" onClick="selMatch('<%=mrb.getMid()%>')"><div class="effect_center_1"><img src="/images/res_icon002-1.png"></div></td>
										<td class="effect_loss_1" data-acc-link="<%=mrb.getMid()%>" onClick="selMatch('<%=mrb.getMid()%>')"> <div class="effect_left_2"><img src="/images/res_icon001.png">&nbsp;&nbsp;&nbsp;<%=mrb.getAteam()%> </div> </td> 
										
						<%
						}
						%>												
										<td class="effect_m_1"  data-acc-link="<%=mrb.getMid()%>" onClick="selMatch('<%=mrb.getMid()%>')">+ <%=mrb.getMcount()%>&nbsp;&nbsp;&nbsp;&nbsp;<img src="/images/arrow_right.png"></td>
									</tr>
						<%
						}
						%>
						
								</tbody>
															
							</table>
						
								</div>
								</div><!-- 1 -->
						
							</div>
							
							<script type="text/javascript">
								$(function() {
									$('.example1').accordion({ multiOpen: true });
								});
								$(function() {
									$('.example2').accordion({ multiOpen: false });
								});
							</script>
							
							<script>
								$(document).ready(function() {
									$('[data-behavior=accordion]').simpleAccordion({cbOpen:accOpen, cbClose:accClose});
								});


								function accClose(e, $this) {
									$this.find('span').fadeIn(200);
								}

								function accOpen(e, $this) {
									$this.find('span').fadeOut(200)
								}

							</script>
							
						
					</div>
				</td>

			</tr>
		</table>
	</div>
</div><!-- contents -->

<!-- page script -->
<script>

	var table =jQuery('#table1').DataTable( {
		"columnDefs": [
            {
            	"targets": [0],
              "visible": false,
              "searchable": true
            },
            {
            	"targets": [1],
              "visible": false,
              "searchable": true
            },
            {
              "targets": [2],
              "visible": false,
              "searchable": true
            }
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
			emptyTable: "결과가 없습니다.",
		},
    });
    	

function selMatch(mid,$scope){
	
	var row = table.row(document.getElementById(mid));
 
 	var $scope = angular.element(document.getElementById(mid)).scope();
 	var $http = angular.injector(['ng', 'Vava']).get('$http');
	var $filter = angular.injector(['ng', 'Vava']).get('$filter');

	
		var sss="	<div id='spin_re_"+mid+"' class='sk-circle'> " +
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
				

		if($('#sub_'+mid).hasClass('panel-body')){
			row.child(sss).show();
			row.child().toggle();
		
		}else{
							
				row.child(sss).show();
				
			$http({
					method: 'GET', 
					url: 'jsp/getSelectionList.jsp', 
					params: {'mid':mid},
					headers: {'Content-Type': 'application/json; charset=utf-8'} 
			}).success(function(data2, status, headers, config) {
					
					//console.log(data2);

				$http({
						method: 'GET', 
						url: 'jsp/getMarketList.jsp', 
						params: {'mid':mid},
						headers: {'Content-Type': 'application/json; charset=utf-8'} 
				}).success(function(data, status, headers, config) {
											
				$scope.MKTY = $filter('groupBy')(data,'MTD');  // delete ID	
				
				var count=0;
				for(var i in $scope.MKTY){
  	 			count++;
  			}
				
				var s="<div  id='sub_"+mid+"' class='panel-body'>"+
							"<div class='sports_dd_p'><table style='width:100%'><tr><td style='width:50%'  valign='top'>";
				
				var k=0;
											
				angular.forEach($scope.MKTY, function(obj,idx) {
					
					k+=1;
					var im = "/images/arrow_top.png";
										
					if(Math.ceil(count/2)+1 == k){
						s +="</td></tr></table> <td style='width:50%' valign='top'>"
					}
					
					s += "	<table class='effect_table_1' style='width:100%'>"+
							"		<tr>"+
							"			<td style='height:30px !important' data-acc-link='"+ obj[0].MD+"_"+obj[0].MTD+"' class='effect_in_t_1' >"+
							"				" + obj[0].MN +
							"			</td>"+
							"		</tr>"+
							"		</table>"+
							" <table class='acc-open effect_table_1' style='width:100%' data-acc-content='"+ obj[0].MD+"_"+obj[0].MTD+"'>";
							//"		<tr class='panel-body acc-open' data-acc-content='"+ obj[0].MD+"_"+obj[0].MTD+"'>";
							
					angular.forEach(obj, function(obj2,idx2) { 
						
						var mSel = data2.filter(function (el) { return el.MKD ==obj2.MKD; })	
							s +="		<tr>";							
						angular.forEach(mSel, function(obj3,idx3) { 
							
							var win ="";
							var cla = "";
							var cla2 = "";
							
							
							if(obj3.OC==3) {
								
								win="<img src='/images/res_icon003-1.png'>";
								cla ="effect_in_right_1";
								
							} else if(obj3.OC==4){							
									
								 win="<img src='/images/res_icon001.png'>";
								 cla ="effect_in_right_y";
								 cla2 = "sel";
							}
							
							if(mSel.length ==2){
								s +=	"<td class='effect_table_in_t_1 "+cla2+"' style='height:30px !important' width='50%'><span class='effect_in_left_1'>"+obj3.SN+"</span><span class='"+cla+"'>" +win+" </span></td>";
								
							} else if(mSel.length ==3){
								s +=	"<td class='effect_table_in_t_1 "+cla2+"' style='height:30px !important' width='33.3%'><span class='effect_in_left_1'>"+obj3.SN+"</span><span class='"+cla+"'>" +win+" </span></td>";
								
							} else if(mSel.length ==4){
								s +=	"<td class='effect_table_in_t_1 "+cla2+"' style='height:30px !important' width='25%'><span class='effect_in_left_1'>"+obj3.SN+"</span><span class='"+cla+"'>" +win+" </span></td>";
								
							} else if(mSel.length > 3){
								
								if(idx3!=0 && idx3%4==0){
								s +=	"</tr><tr>";
								//console.log("</tr><tr>");
								
								}
								s +=	"<td class='effect_table_in_t_1 "+cla2+"' style='height:30px !important' width='25%'><span class='effect_in_left_1'>"+obj3.SN+"</span><span class='"+cla+"'>" +win+" </span></td>";
							}
						});
												
					});		
							
					s +="	</tr>";
					 		
						
				});	
					//s += "</table>"+
					//		"</div>"+
					//			"</div>";	
					
					s += "</table></td></tr></table></div>"+
					"</div></div>";
					
					row.child(s).show();

				}).error(function(data, status, headers, config) {
				});
			
			}).error(function(data, status, headers, config) {
			});	

		}
		
}


$(document).ready(function() {

  $('#input1').on( 'keyup', function () {
  	
  	table
      .search( this.value )
      .draw(false);
      });
});

</script>

<%@ include file="/inc/footer.jsp" %>

	
</div><!-- wrap -->
</body>
</html>
