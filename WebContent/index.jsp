<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="bean.*"%>
<%@page import="java.lang.Integer"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="com.google.gson.reflect.TypeToken"%>
<%@page import="dao.NoticeEventDao"%>
<%@page import="bean.NoticeEventBean"%>

<%
	NoticeEventDao ne_dao			= new NoticeEventDao();
	List<NoticeEventBean> all_banner	= ne_dao.getAllBanner();	
		
%>


<jsp:useBean id="bm" class="bc4.BetConManager2" />

<%
List<MatchListBean> mr = bm.getFavoriteMatch();
List<DepositListBean> dl = bm.getDepositList();

StringBuffer sb = bm.getMainLiveMatch();
StringBuffer sb2 = bm.getMainPreMatch("0","0");
StringBuffer sb3  = bm.getValidMarketType();

Gson gson = new Gson();
Type type = new TypeToken<List<MatchListBean>>() {}.getType();
Type type2 = new TypeToken<List<DepositListBean>>() {}.getType();

 String mr_s = gson.toJson(mr, type);      
 String dl_s = gson.toJson(dl, type2);   
     
%>

<%@ include file="/inc/session.jsp"%>
			
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>iBET25(TEST WEB)</title>


<meta name="viewport" content="width=1400,minimum-scale=0,maximum-scale=5,target-densitydpi=device-dpi">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">		
<link href="/images/favicon.ico" rel="icon">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.1.min.js"></script>
<script type="text/javascript" src="/js/header.js" charset="utf-8"></script><!-- header -->
<script type="text/javascript" src="/js/select.js" charset="utf-8"></script><!-- util_select -->
<script type="text/javascript" src="/js/my_select.js"></script>
<script type="text/javascript" src="/js/visual_slider.js"></script><!-- VisualBanner, CasinoBanner -->
<script type="text/javascript" src="/js/script.js"></script><!-- VisualBanner, CasinoBanner -->
<script type="text/javascript" src="/js/multislider.js"></script><!-- contents_slider -->
<script type="text/javascript" src="/js/tabulous.js"></script><!-- MainTab -->
<script type="text/javascript" src="/js/sub_tab.js"></script><!-- sub_tab -->
<script type="text/javascript" src="/js/jquery-popover.js"></script><!-- point_popup -->
<script type="text/javascript" src="/js/popup.js"></script><!-- popup -->
<script type="text/javascript" src="/js/left_menu.js"></script><!-- left_menu -->
<script type="text/javascript" src="/js/gallery.js"></script>
<script type="text/javascript" src="/js/showid.js"></script>
<script type="text/javascript" src="/js/vertical_tab.js"></script>
<script type="text/javascript" src="/js/over.js"></script>
<script type="text/javascript" src="/js/over_script.js"></script>
<script type="text/javascript" src="/js/table.js"></script><!-- main_table_slide -->
<script type="text/javascript" src="/js/gateway.js"></script><!-- gateway -->
<script type="text/javascript" src="/js/img_hover.js"></script><!-- casino_hover -->
<script type="text/javascript" src="/js/text_slide.js"></script><!-- text_slide -->
<script type="text/javascript" src="/js/switch.js"></script><!-- switch -->
<script type="text/javascript" src="/js/sports_acc.js"></script><!-- 스포츠아코디언, 베팅내역 아코디언-->
<script type="text/javascript" src="/js/fade.js"></script><!-- switch -->
<script type="text/javascript" src="/js/jquery.serializejson.js"></script><!-- json serializer -->
<script type="text/javascript" src="/js/accordion.js"></script><!-- sub_아코디언 -->
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript" src="/js/jquery.validate.js"></script> 
<script type="text/javascript" src="/js/jquery.nice-select.js"></script><!-- select -->
<script type="text/javascript" src="/js/jqueryRemote.js"></script> 
<script type="text/javascript" src="/js/additional-methods.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/list.js/1.5.0/list.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/list.pagination.js/0.1.1/list.pagination.min.js"></script>
<script type="text/javascript" src="/js/datatables/jquery.dataTables.js"></script><!-- datatable -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.js"></script><!-- custom scrollbar -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/qtip2/3.0.3/jquery.qtip.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.js"></script><!-- moment js -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pikaday/1.6.1/pikaday.js"></script><!-- pickaday -->



<link href="/css/common.css" rel="stylesheet" type="text/css">
<link href="/css/layout.css" rel="stylesheet" type="text/css">
<link href="/css/main.css" rel="stylesheet" type="text/css"><!-- main -->
<link href="/css/sub.css" rel="stylesheet" type="text/css"><!-- sub -->
<link href="/css/game.css" rel="stylesheet" type="text/css"><!-- game -->
<link href="/css/gateway.css" rel="stylesheet" type="text/css"><!-- gateway -->
<link href="/css/customize.css" rel="stylesheet" type="text/css">
<link href="/css/font-awesome.css" rel="stylesheet" type="text/css">
<link href="/css/spin.css" rel="stylesheet" type="text/css">
<link href="/css/nice-select.css" rel="stylesheet" type="text/css"><!-- select -->
<link href="/css/common2.css" rel="stylesheet" type="text/css">
<link href="/css/manual.css" rel="stylesheet" type="text/css"><!--slide-->
<link href="/css/custom.css" rel="stylesheet" type="text/css"><!--공통-->
<link rel="stylesheet" href="/css/datatables.net-bs/css/bootstrap-simple.css" /> 
<link rel="stylesheet" href="/css/datatables.net-bs/css/dataTables.bootstrap.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.css" rel="stylesheet" type="text/css"><!-- toaster test  -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/qtip2/3.0.3/jquery.qtip.css" /><!-- tooltip -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/pikaday/1.6.1/css/pikaday.css" rel="stylesheet" type="text/css">
<!-- custom scrollbar test -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css" />

<script type="text/javascript" src="/js/angular.js"></script> 
<script type="text/javascript" src="/js/angular-animate.min.js"></script> 
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/angular-filter/0.5.16/angular-filter.js"></script>    
<script type="text/javascript" src="/js/v-accordion.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.28//angular-route.min.js"></script>
<link href="/css/v-accordion.css" rel="stylesheet" type="text/css">

<script>
	var mainAngular = angular.module('Vava', [ 'ngAnimate', 'vAccordion' ]);

mainAngular.directive('tooltip', function ($document, $compile) {
  return {
    restrict: 'A',
    scope: true,
    link: function (scope, element, attrs) {
      var tip = $compile('<div ng-class="tipClass">{{ text }}<div class="tooltip-arrow"></div></div>')(scope),
          tipClassName = 'tooltip',
          tipActiveClassName = 'tooltip-show';

      scope.tipClass = [tipClassName];
      scope.text = attrs.tooltip;
      
      if(attrs.tooltipPosition) {
        scope.tipClass.push('tooltip-' + attrs.tooltipPosition);
      }
      else {
       scope.tipClass.push('tooltip-down'); 
      }
      $document.find('body').append(tip);
      
      element.bind('mouseover', function (e) {
        tip.addClass(tipActiveClassName);
        
        var pos = e.target.getBoundingClientRect(),
            offset = tip.offset(),
            tipHeight = tip.outerHeight(),
            tipWidth = tip.outerWidth(),
            elWidth = pos.width || pos.right - pos.left,
            elHeight = pos.height || pos.bottom - pos.top,
            tipOffset = 10;
        
        if(tip.hasClass('tooltip-right')) {
          offset.top = pos.top - (tipHeight / 2) + (elHeight / 2);
          offset.left = pos.right + tipOffset;
        }
        else if(tip.hasClass('tooltip-left')) {
          offset.top = pos.top - (tipHeight / 2) + (elHeight / 2);
          offset.left = pos.left - tipWidth - tipOffset;
        }
        else if(tip.hasClass('tooltip-down')) {
          offset.top = pos.top + elHeight + tipOffset;
          offset.left = pos.left - (tipWidth / 2) + (elWidth / 2);
        }
        else {
          offset.top = pos.top - tipHeight - tipOffset;
          offset.left = pos.left - (tipWidth / 2) + (elWidth / 2);
        }

        tip.offset(offset);
      });
      
      element.bind('mouseout', function () {
        tip.removeClass(tipActiveClassName);
      });

      tip.bind('mouseover', function () {
        tip.addClass(tipActiveClassName);
      });

      tip.bind('mouseout', function () {
        tip.removeClass(tipActiveClassName);
      });

      
    }
  }
});

	var s = [ {
		"PID" : 0,
		"u" : "center_live.html"
	}, {
		"PID" : 1,
		"u" : "left_live.html"
	}, {
		"PID" : 2,
		"u" : "right_bet.html"
	}, {
		"PID" : 3,
		"u" : "ws://103.1.249.79:7071"
	}, {
		"PID" : 4,
		"u" : "center_pre.html"
	}, {
		"PID" : 5,
		"u" : "/JSON/period_name.json"
	}, {
		"PID" : 6,
		"u" : "/JSON/live_status.json"
	}, {
		"PID" : 7,
		"u" : "/sport/jsp/getValidMarketType.jsp"
	}, {
		"PID" : 8,
		"u" : "jsp/getFavMatch.jsp"
	}, {
		"PID" : 9,
		"u" : "jsp/loadLiveMatchInit.jsp"
	}, {
		"PID" : 10,
		"u" : "jsp/loadPreMatchInit.jsp"
	}, {
		"PID" : 11,
		"u" : "jsp/getMarketbyMatchId.jsp"
	}, {
		"PID" : 12,
		"u" : "jsp/getStatusbyMatchId.jsp"
	}, {
		"PID" : 13,
		"u" : "jsp/getMarketbyMarketId.jsp"
	}, {
		"PID" : 14,
		"u" : "jsp/subLoadLiveMatch.jsp"
	}, {
		"PID" : 15,
		"u" : "jsp/getMatchInfobyCompetition.jsp"
	}, {
		"PID" : 16,
		"u" : "left_pre.html"
	}, {
		"PID" : 17,
		"u" : "jsp/loadPreMatch.jsp"
	}, {
		"PID" : 18,
		"u" : "jsp/subLoadPreMatch.jsp"
	}, {
		"PID" : 19,
		"u" : "jsp/setFavMatch.jsp"
	}, {
		"PID" : 20,
		"u" : "/sport/jsp/getMainPreMatch.jsp"
	}, {
		"PID" : 21,
		"u" : "/main/jsp/getDepositList.jsp"
	}, {
		"PID" : 22,
		"u" : "/main/jsp/loadLiveMatch.jsp"
	}, {
		"PID" : 22,
		"u" : "/main/jsp/loadPreMatch.jsp"
	} ]

	mainAngular.factory('wss', function($window) {

		var sv = {};
		sv.ws = new Object();

		sv.con = function() {
			var wsUrl = s[3].u;
			var websocket = new WebSocket(wsUrl);
			websocket.onopen = function() {
				sv.callback("CONNECTED");
			};
			websocket.onerror = function() {
				websocket = null;
				sv.callback("Failed to open a connection");
			};
			websocket.onclose = function() {
				websocket = null;
				sv.ws.close();
				sv.callback("DISCONNECTED");
				setTimeout(function() {
					sv.con()
				}, 5000);
			};
			websocket.onmessage = function(message) {
				sv.callback(message.data);
			};
			sv.ws = websocket;
		};

		sv.disc = function() {
			sv.ws.close();
		};
		sv.subscribe = function(callback) {
			sv.callback = callback;
		};
		sv.loadGetMatchInit = function() {

		}

		sv.sendMessage = function(msg) {
			sv.ws.send(msg);
		};

		return sv;
	});

	mainAngular
			.controller(
					"mc",
					function($scope, $sce, $templateCache, $compile, $http, wss) {

						wss.subscribe(function(message) {
							try {

								var obj = JSON.parse(message);
								switch (obj.Command) {
								//case "GetCompetitions": loadGetCompetitions(obj);
								//	break;							
								//case "MatchStat": sub_loadGetMatchStat(obj);
								//	break;								
								//case "GetMatches": loadGetMatch(obj); 
								//	break;					
								case "MatchUpdate":
									if (obj.Type == "Match") {
										sub_loadGetMatch(obj);

										//} else if (obj.Type == "MatchStat") {
										//	sub_loadGetMatchStat(obj);

									} else if (obj.Type == "Market")
										sub_loadGetMatchMarket(obj);
									break;
								case "GetMatchMarkets":
									loadGetMatchMarket(obj);
									break;
								}
							} catch (exception) {
							}
							$scope.$apply();
						});

						wss.con();

						loadLiveMatch();

						$scope.ML =<%=mr_s%>;
						$scope.DL =<%=dl_s%>;
						//getDepositList();	
						dl_load();

						loadPreMatch();

						$http(
								{
									method : 'GET',
									url : s[7].u,
									headers : {
										'Content-Type' : 'application/json; charset=utf-8'
									}
								}).success(
								function(data, status, headers, config) {
									if (data) {

										$scope.validMKTypeId = data;
										//console.log($scope.validMKTypeId);
									}
									;
									data = null;
								}).error(
								function(data, status, headers, config) {
									;
									console.log("Error $scope.validMKTypeId");
									data = null;
								});

						function dl_load() {
							var sp = setInterval(getDepositList, 1000 * 60 * 3);
						}
						;

						function getDepositList() {

							$http(
									{
										method : 'GET',
										url : s[21].u,
										headers : {
											'Content-Type' : 'application/json; charset=utf-8'
										}
									})
									.success(
											function(data, status, headers,
													config) {
												if (data) {

													$scope.DL = [];
													$scope.DL = data;
													console.log($scope.DL);

												}
												;
												data = null;
											})
									.error(
											function(data, status, headers,
													config) {
												;
												console
														.log("Exception getDepositList");
												data = null;
											});
						}
						;

						$scope.vM = function(tab, sid, mid) {
							console.log("$scope.vM");

							console.log($scope.form);

							document.getElementById('formId').tab.value = tab
							document.getElementById('formId').sid.value = sid
							document.getElementById('formId').mid.value = mid
							console.log("$scope.form.mid:"
									+ $scope.form.mid.value);
							//console.log("$scope.mid:" + $scope.mid);

							//$scope.form.action="/sport/livematch.jsp"

							//$('#formId').attr('action', '/sport/livematch.jsp');

							//$scope.formUrl = $sce.trustAsResourceUrl('/sport/livematch.jsp');

							document.getElementById('formId').submit()
							//$scope.form.$submitted = true;
							//console.log("$scope.submitted");
							/*		
							 document.form.sid.value = sid		
							 document.form.tab.value = tab
							 document.form.method = "post";	
							 document.form.action="/sport/livematch.jsp"
							 document.form.submit();		
							 */

						};

						$scope.vM2 = function(sid, mid) {
							//console.log("$scope.vM");			
							document.form.mid.value = mid
							document.form.sid.value = sid
							document.form.tab.value = "2"
							document.form.method = "post";
							document.form.action = "/sport/livematch.jsp"
							document.form.submit();
						};

						$scope.com = function(str) {
							str = String(str);
							return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g,
									'$1,');
						};

						var $filter = angular.injector([ 'ng', 'Vava' ]).get(
								'$filter');

						function loadLiveMatch() {

							$scope.LS = [];
							$scope.LMKc = [];

							$http(
									{
										method : 'GET',
										url : s[22].u,
										headers : {
											'Content-Type' : 'application/json; charset=utf-8'
										}
									})
									.success(
											function(data, status, headers,
													config) {
												if (data) {
													
													angular
															.forEach(
																	data,
																	function(
																			obj,
																			idx) {
																		if (obj.Mk !== null
																				&& obj.Mk !== undefined
																				&& obj.Mk.length > 0) {
																			for (var j = 0; j < obj.Mk.length; j++) {
																				$scope.LMKc
																						.push(obj.Mk[j]);
																			}
																		}

																		angular
																				.forEach(
																						obj.Mt,
																						function(
																								obj2,
																								idx2) {

																							//var mStat = obj.St.filter(function (el) { return el.MId == obj2.Id; })	
																							var mResult = obj.Re
																									.filter(function(
																											el) {
																										return el.MId == obj2.Id;
																									})
																							var mSelect = obj.Se
																									.filter(function(
																											el) {
																										return el.MId == obj2.Id;
																									})

																							var w1Price, w2Price, xPrice = "-";
																							var SusM = true;
																							var Vis = true;
																							var MkId = "0";

																							if (mResult !== undefined
																									&& mResult !== null
																									&& mResult.length > 0) {
																								//var w1Price, w2Price, xPrice  ="-";			
																								//var w1SelId, xSelId, w2SelId ="";	

																								SusM = mResult[0].Sus;
																								Vis = mResult[0].Vis;
																								MkId = mResult[0].Id;

																								for (var i = mSelect.length - 1; i >= 0; i--) {
																									if (mSelect[i].Nm == 'W1') {
																										//w1SelId = mSelect[i].Id ;
																										//w1Price = mSelect[i].P;			
																										w1Price = $filter('number')(mSelect[i].P, 2);																							
																										//console.log("w1Price:"+ w1Price)
																										//console.log("w1Price-1:"+$filter('number')(w1Price, 2))
																										
																									} else if (mSelect[i].Nm == 'X') {
																										//xSelId = mSelect[i].Id ;
																										//xPrice = mSelect[i].P;
																										xPrice = $filter('number')(mSelect[i].P, 2);
																										//console.log("xPrice:"+ xPrice)
																										//console.log("xPrice-1:"+$filter('number')(xPrice, 2))
																										
																									} else if (mSelect[i].Nm == 'W2') {
																										//w2SelId = mSelect[i].Id ;
																										//w2Price = mSelect[i].P;
																										w2Price = $filter('number')(mSelect[i].P, 2);
																										//console.log("w2Price:"+ w2Price)
																										//console.log("w2Price-1:"+$filter('number')(w2Price, 2))
																									}
																								}
																								;
																							}
																							;
																							
																							
																							$scope.LS
																									.push({
																										SId : obj2.SId,
																										SN : obj2.SN,
																										RId : obj2.RId,
																										RN : obj2.RN,
																										CId : obj2.CId,
																										CN : obj2.CN,
																										MId : obj2.Id,
																										HT : obj2.HT,
																										AT : obj2.AT,
																										//Pe:mStat[0].Pe,
																										//EType : mMatchStat[0].EventType,
																										//HTS:HTeamScore,
																										//ATS:ATeamScore,
																										SusS : obj2.Sus,
																										//Cur:(mStat[0].Cur == undefined) ? "" : mStat[0].Cur, //mStat[0].CurrentMinute,
																										//Rem:(mStat[0].Rem == undefined) ? "" : mStat[0].Rem, //mStat[0].RemainingTime,
																										//Inf:mStat.Inf,	
																										MkId : MkId,
																										SusM : SusM,
																										Vis : Vis,
																										//W1SD:w1SelId,
																										//XSD:xSelId,
																										//W2SD:w2SelId,
																										BW1P : w1Price,
																										BXP : xPrice,
																										BW2P : w2Price,
																										W1P : w1Price,
																										XP : xPrice,
																										W2P : w2Price,
																									});

																							//};
																						});

																	});

												}
												;
												data = null;
											})
									.error(
											function(data, status, headers,
													config) {
												;
												console
														.log("Exception loadLiveMatch");
												data = null;
											});
						}
						;

						//console.log("LS");
						// console.log($scope.LS);

						function loadPreMatch() {
							//////
							$scope.PS = [];
							$scope.PMKc = [];

							$http(
									{
										method : 'GET',
										url : s[23].u,
										headers : {
											'Content-Type' : 'application/json; charset=utf-8'
										}
									})
									.success(
											function(data, status, headers,
													config) {
												if (data) {

													angular
															.forEach(
																	data,
																	function(
																			obj,
																			idx) {
																		if (obj.Mk !== null
																				&& obj.Mk !== undefined
																				&& obj.Mk.length > 0) {
																			for (var j = 0; j < obj.Mk.length; j++) {
																				$scope.PMKc
																						.push(obj.Mk[j]);
																			}
																		}

																		angular
																				.forEach(
																						obj.Mt,
																						function(
																								obj2,
																								idx2) {

																							//var mStat = obj.St.filter(function (el) { return el.MId == obj2.Id; })	
																							var mResult = obj.Re
																									.filter(function(
																											el) {
																										return el.MId == obj2.Id;
																									})
																							var mSelect = obj.Se
																									.filter(function(
																											el) {
																										return el.MId == obj2.Id;
																									})

																							//console.log(mResult);
																							//console.log(mSelect);

																							var w1Price, w2Price, xPrice = "-";
																							var SusM = true;
																							var Vis = true;
																							var MkId = "0";

																							if (mResult !== undefined
																									&& mResult !== null
																									&& mResult.length > 0) {
																								//var w1Price, w2Price, xPrice  ="-";			
																								//var w1SelId, xSelId, w2SelId ="";	

																								SusM = mResult[0].Sus;
																								Vis = mResult[0].Vis;
																								MkId = mResult[0].Id;

																								//console.log(mSelect);

																								for (var i = mSelect.length - 1; i >= 0; i--) {
																									if (mSelect[i].Nm == 'W1') {
																										//w1SelId = mSelect[i].Id ;
																										//w1Price = mSelect[i].P;
																										w1Price = $filter('number')(mSelect[i].P, 2);
																										//console.log("w1Price:"+ w1Price)
																										//console.log("w1Price-1:"+$filter('number')(w1Price, 2))
																										
																									} else if (mSelect[i].Nm == 'X') {
																										//xSelId = mSelect[i].Id ;
																										//xPrice = mSelect[i].P;
																										xPrice = $filter('number')(mSelect[i].P, 2);
																										//console.log("xPrice"+ xPrice)
																										//console.log("xPrice-1:"+$filter('number')(xPrice, 2))
																										
																									} else if (mSelect[i].Nm == 'W2') {
																										//w2SelId = mSelect[i].Id ;
																										//w2Price = mSelect[i].P;
																										w2Price = $filter('number')(mSelect[i].P, 2);
																										//console.log("w2Price:"+ w2Price)
																										//console.log("w2Price-1:"+$filter('number')(w2Price, 2))
																									}
																								}
																								;
																							}
																							;

																							$scope.PS
																									.push({
																										SId : obj2.SId,
																										SN : obj2.SN,
																										RId : obj2.RId,
																										RN : obj2.RN,
																										CId : obj2.CId,
																										CN : obj2.CN,
																										MId : obj2.Id,
																										HT : obj2.HT,
																										AT : obj2.AT,
																										Dt : obj2.Dt,
																										//Pe:mStat[0].Pe,
																										//EType : mMatchStat[0].EventType,
																										//HTS:HTeamScore,
																										//ATS:ATeamScore,
																										SusS : obj2.SusS,
																										//Cur:(mStat[0].Cur == undefined) ? "" : mStat[0].Cur, //mStat[0].CurrentMinute,
																										//Rem:(mStat[0].Rem == undefined) ? "" : mStat[0].Rem, //mStat[0].RemainingTime,
																										//Inf:mStat.Inf,	
																										//MkId:mResult[0].Id, 
																										//SusM:mResult[0].Sus, 
																										//Vis:mResult[0].Vis,				    		
																										SusM : SusM,
																										Vis : Vis,
																										MkId : MkId,
																										//W1SD:w1SelId,
																										//XSD:xSelId,
																										//W2SD:w2SelId,
																										BW1P : w1Price,
																										BXP : xPrice,
																										BW2P : w2Price,
																										W1P : w1Price,
																										XP : xPrice,
																										W2P : w2Price,
																									});

																							//};
																						});

																	});

												}
												;
											})
									.error(
											function(data, status, headers,
													config) {
												;
												console
														.log("Exception loadLiveMatch");
												data = null;
											});
						}
						;

						function sub_loadGetMatchMarket(res) {

							angular
									.forEach(
											res.Objects,
											function(obj, idx) {

												var v_market = $scope.validMKTypeId
														.indexOf(obj.MarketTypeId);

												if (v_market < 0) {
													return; //un-used MarketTypeId
												}
												;

												var nMK = true;

												for (var a = 0; a < $scope.LMKc.length; a++) {
													if ($scope.LMKc[a].Id == obj.Id) {
														nMK = false;
														$scope.LMKc[a].S = obj.IsSuspended;
														$scope.LMKc[a].V = obj.IsVisible;

														break;
													}
													;
												}

												for (var b = 0; b < $scope.PMKc.length; b++) {
													if ($scope.PMKc[b].Id == obj.Id) {
														nMK = false;
														$scope.PMKc[b].S = obj.IsSuspended;
														$scope.PMKc[b].V = obj.IsVisible;

														break;
													}
													;
												}

												if (nMK) {

													for (var b = 0; b < $scope.LS.length; b++) {
														if ($scope.LS[b].MId == obj.MatchId) {

															$scope.LMKc
																	.push({
																		Id : obj.Id,
																		S : obj.IsSuspended,
																		V : obj.IsVisible,
																		M : obj.MatchId,
																	});
															break;
														}
														;
													}
													;

													for (var k = 0; k < $scope.PS.length; k++) {
														if ($scope.PS[k].MId == obj.MatchId) {

															$scope.PMKc
																	.push({
																		Id : obj.Id,
																		S : obj.IsSuspended,
																		V : obj.IsVisible,
																		M : obj.MatchId,
																	});
															break;
														}
														;
													}
													;
												}
												;

												for (var c = 0; c < $scope.LS.length; c++) {

													var lm = $scope.LS[c];

													if (lm.MkId == obj.Id) {

														var w1Price, w2Price, xPrice = "-";

														for (var j = 0; j < obj.Selections.length; j++) {

															if (obj.Selections[j].Name == 'W1') {
																//w1Price = obj.Selections[j].Price;
																w1Price = $filter('number')(obj.Selections[j].Price, 2);
																//console.log("w1Price:"+ w1Price)
																//console.log("w1Price-1:"+$filter('number')(w1Price, 2))
																										

															} else if (obj.Selections[j].Name == 'X') {
																//xPrice = obj.Selections[j].Price;
																xPrice = $filter('number')(obj.Selections[j].Price, 2);
																//console.log("xPrice:"+ xPrice)
																//console.log("xPrice-1:"+$filter('number')(xPrice, 2))

															} else if (obj.Selections[j].Name == 'W2') {
																//w2Price = obj.Selections[j].Price;
																w2Price = $filter('number')(obj.Selections[j].Price, 2);
																//console.log("w2Price:"+ w2Price)
																//console.log("w2Price-1:"+$filter('number')(w2Price, 2))
															}
														}
														;

														$scope.LS[c].SusM = obj.IsSuspended;
														$scope.LS[c].Vis = obj.IsVisible;
														$scope.LS[c].BW1P = lm.W1P;
														$scope.LS[c].BXP = lm.XP;
														$scope.LS[c].BW2P = lm.W2P;

														$scope.LS[c].W1P = w1Price;
														$scope.LS[c].XP = xPrice;
														$scope.LS[c].W2P = w2Price;
													}
													;
												}
												;

												for (var c = 0; c < $scope.PS.length; c++) {

													var pm = $scope.PS[c];

													if (pm.MkId == obj.Id) {

														var w1Price, w2Price, xPrice = "-";

														for (var j = 0; j < obj.Selections.length; j++) {

															if (obj.Selections[j].Name == 'W1') {
																//w1Price = obj.Selections[j].Price;
																w1Price = $filter('number')(obj.Selections[j].Price, 2);

															} else if (obj.Selections[j].Name == 'X') {
																//xPrice = obj.Selections[j].Price;
																xPrice = $filter('number')(obj.Selections[j].Price, 2);

															} else if (obj.Selections[j].Name == 'W2') {
																//w2Price = obj.Selections[j].Price;
																w2Price = $filter('number')(obj.Selections[j].Price, 2);
															}
														}
														;

														$scope.PS[c].SusM = obj.IsSuspended;
														$scope.PS[c].Vis = obj.IsVisible;
														$scope.PS[c].BW1P = pm.W1P;
														$scope.PS[c].BXP = pm.XP;
														$scope.PS[c].BW2P = pm.W2P;

														$scope.PS[c].W1P = w1Price;
														$scope.PS[c].XP = xPrice;
														$scope.LP[c].W2P = w2Price;

													}
													;
												}
												;

											});
						}
						;

						function sub_loadGetMatch(res) {
							var nlm = true;

							console.log("sub_loadGetMatch");

							angular
									.forEach(
											res.Objects,
											function(obj, idx) {

												if (!obj.IsBooked) {
													console
															.log("obj.IsBooked : "
																	+ obj.IsBooked);
													return;
												}
												;

												console.log(obj);
												console.log("MATCH ID:"
														+ obj.Id);

												angular
														.forEach(
																$scope.LS,
																function(
																		Ls_obj,
																		i2) {

																	if (Ls_obj.MId == obj.Id) {
																		nlm = false;

																		console
																				.log("MATCH LIVE MatchId : "
																						+ obj.MatchId);

																		if (Ls_obj.IsVisible
																				&& !obj.IsVisible) {
																			finishLiveMatch(obj.Id);

																		} else if (!obj.IsLive) {
																			finishLiveMatch(obj.Id);

																		} else if (obj.LiveStatus == '2') {
																			finishLiveMatch(obj.Id);

																		}
																	}
																	;
																});

												if (nlm && obj.IsVisible) {
													if (obj.IsLive
															&& obj.MatchStatus != '2') {
														subLoadLiveMatch(obj.Id);
													}
													;
												}
												;

												angular
														.forEach(
																$scope.PS,
																function(
																		Ps_obj,
																		i3) {

																	if (Ps_obj.MId == obj.Id) {
																		nlm = false;
																		console
																				.log("MATCH PRE MatchId : "
																						+ obj.MatchId);

																		if (Ps_obj.SusS != obj.IsSuspended) {
																			$scope.PS[i3].SusS = obj.IsSuspended;
																		}

																		if (Ps_obj.Vis != obj.IsVisible) {
																			$scope.PS[i3].Vis = obj.IsVisible;
																		}

																		if (Ps_obj.MatchStatus == '1') {
																			finishPreMatch(obj.Id);
																			//$scope.PS[i3].Vis = obj.IsVisible;
																			//delete //insert  
																		}
																	}
																});

											});
						}
						;

						function subLoadLiveMatch(mid) {
							loadLiveMatch();
						}
						;

						function finishLiveMatch(mid) {
							loadLiveMatch();
						}
						;

						function finishPreMatch(mid) {
							loadPreMatch()
						}
						;

						$scope.tabSId = "0";

						$scope.selLS = function(sid) {

							document.getElementById("spin2").style.display = "none";
							document.getElementById("lm_spin").style.display = "block";

							$scope.lm_load();
							console.log("selLS");

							$scope.tabSId = sid;
							//$scope.tableParams.reload();

							//if(sid !="0"){
							//stopTicker(".myTable2");

							//} else {
							//console.log("start");
							//startTicker(".myTable2");		  
							//	}

						};

						$scope.TM = "0";

						$scope.setTM = function(tm) {
							$scope.TM = tm;
						}

						$scope.pm_load = function() {
							var sp = setTimeout(sp_pm, 1000);
						};

						$scope.main_load = function() {
							var sp = setTimeout(sp_main, 2500);
						};

						$scope.lm_load = function() {
							var sp = setTimeout(sp_lm, 1000);
						};

						$scope.PMSD = "0";

						$scope.getPM = function(sid, min) {

							$scope.PMSD = sid;

							document.getElementById("spin1").style.display = "none";
							document.getElementById("pm_spin").style.display = "block";

							$http(
									{
										method : 'GET',
										url : s[20].u,
										params : {
											'sid' : sid,
											'min' : min
										},
										headers : {
											'Content-Type' : 'application/json; charset=utf-8'
										}
									})
									.success(
											function(data, status, headers,
													config) {

												if (data) {

													$scope.PS = [];

													//console.log(data);

													angular
															.forEach(
																	data,
																	function(
																			obj,
																			idx) {

																		if (obj.Mk !== null
																				&& obj.Mk !== undefined
																				&& obj.Mk.length > 0) {
																			for (var j = 0; j < obj.Mk.length; j++) {
																				$scope.PMKc
																						.push(obj.Mk[j]);
																			}
																		}

																		angular
																				.forEach(
																						obj.Mt,
																						function(
																								obj2,
																								idx2) {

																							//var mStat = obj.St.filter(function (el) { return el.MId == obj2.Id; })	
																							var mResult = obj.Re
																									.filter(function(
																											el) {
																										return el.MId == obj2.Id;
																									})
																							var mSelect = obj.Se
																									.filter(function(
																											el) {
																										return el.MId == obj2.Id;
																									})

																							//console.log(mResult);
																							//console.log(mSelect);

																							var w1Price, w2Price, xPrice = "-";
																							var SusM = true;
																							var Vis = true;
																							var MkId = "0";

																							if (mResult !== undefined
																									&& mResult !== null
																									&& mResult.length > 0) {
																								//var w1Price, w2Price, xPrice  ="-";			
																								//var w1SelId, xSelId, w2SelId ="";	

																								SusM = mResult[0].Sus;
																								Vis = mResult[0].Vis;
																								MkId = mResult[0].Id;

																								for (var i = mSelect.length - 1; i >= 0; i--) {
																									if (mSelect[i].Nm == 'W1') {
																										//w1SelId = mSelect[i].Id ;
																										//w1Price = mSelect[i].P;
																										w1Price = $filter('number')(mSelect[i].P, 2);
																										
																									} else if (mSelect[i].Nm == 'X') {
																										//xSelId = mSelect[i].Id ;
																										//xPrice = mSelect[i].P;
																										xPrice = $filter('number')(mSelect[i].P, 2);
																										
																									} else if (mSelect[i].Nm == 'W2') {
																										//w2SelId = mSelect[i].Id ;
																										//w2Price = mSelect[i].P;
																										w2Price = $filter('number')(mSelect[i].P, 2);
																									}
																								}
																								;
																							}
																							;

																							$scope.PS
																									.push({
																										SId : obj2.SId,
																										SN : obj2.SN,
																										RId : obj2.RId,
																										RN : obj2.RN,
																										CId : obj2.CId,
																										CN : obj2.CN,
																										MId : obj2.Id,
																										HT : obj2.HT,
																										AT : obj2.AT,
																										Dt : obj2.Dt,
																										SusS : obj2.Sus,
																										SusM : SusM,
																										Vis : Vis,
																										MkId : MkId,
																										BW1P : w1Price,
																										BXP : xPrice,
																										BW2P : w2Price,
																										W1P : w1Price,
																										XP : xPrice,
																										W2P : w2Price,
																									});

																						});

																	});

												}
												;

												data = null;

												//document.getElementById("table").deleteRow(0);

												//document.getElementById("pm_spin").style.display  = "none";
												//document.getElementById("spin1").style.display = "block";

												$scope.pm_load();

											}).error(
											function(data, status, headers,
													config) {
												console.log(status);
												data = null;
											});

						};

						function sp_pm() {
							document.getElementById("pm_spin").style.display = "none";
							document.getElementById("spin1").style.display = "block";
						}

						function sp_lm() {
							document.getElementById("lm_spin").style.display = "none";
							document.getElementById("spin2").style.display = "block";
						}

						function sp_main() {
							document.getElementById("main_spin").style.display = "none";
							document.getElementById("spin3").style.display = "block";
							$('#videoId').get(0).play();
						}

						$scope.alertAction = function($event) {
							alert($scope.action);
							$event.preventDefault();
						};
					});
</script>

<style>    
	.no-class{display:none}

	.sk-circle {
	  margin: 45px auto;
	  width: 40px;
	  height: 40px;
	  position: relative;
	}

	.main-circle {
	  margin: 200px auto;
	  width: 80px;
	  height: 80px;
	  position: relative;
	}
	#tableTicker_wrap1{
		width: 100%!important;
	}
</style>


</head>

<body id="myAnchor" ng-app="Vava" ng-controller="mc"> 
	<div id="main_spin">
	 	<div class="sk-fading-circle">
	        <div class="sk-circle1 sk-circle"></div>
	        <div class="sk-circle2 sk-circle"></div>
	        <div class="sk-circle3 sk-circle"></div>
	        <div class="sk-circle4 sk-circle"></div>
	        <div class="sk-circle5 sk-circle"></div>
	        <div class="sk-circle6 sk-circle"></div>
	        <div class="sk-circle7 sk-circle"></div>
	        <div class="sk-circle8 sk-circle"></div>
	        <div class="sk-circle9 sk-circle"></div>
	        <div class="sk-circle10 sk-circle"></div>
	        <div class="sk-circle11 sk-circle"></div>
	        <div class="sk-circle12 sk-circle"></div>
	    </div>
		<div style="margin: 50px auto; width: 156px; height: 75px; position: relative; background-image: url('/images/logo.png')"></div>
	</div>

	<div ng-init="main_load()" style="display:none;" id="spin3" class="animate-bottom">	
		<a href="#myAnchor" class="go-top">▲</a>

		<div id="wrap">

			<%@ include file="/inc/header.jsp"%>
			
			<div id="contents_wrap">
				<div class="contents">
					<div class="contents_in_m20">
						<div class="main_visual">
							<div id="jssor_1" style="position: relative; width: 930px; height: 225px; overflow: hidden; visibility: hidden;">
								<div data-u="slides"
									style="cursor: default; position: relative; top: 0px; left: 0px; width: 930px; height: 225px; overflow: hidden;">
									<%
										for (int i = 0; i < all_banner.size(); i++) {
											NoticeEventBean ne = all_banner.get(i);
											
											String img_path = "http://admin.vava21.com:88/contents/";
											String img_folder = (ne.getGubun().toString().equals("BANNER") ? "banner/" : "event/");
											String img = img = img_path + img_folder + ne.getImg();
											
										
											if(ne.getImg() == null){
												img = "images/notice_ready.jpg";
											}
									%>
									
									<div>
										<a class='<%=(!checkSession) ? "fade_1_open" : ""%>'
											href="#fade_1"><img src="<%=img %>" /></a>
									</div>
									<%
										}
									%>
								</div>
								<!-- Bullet Navigator -->
								<div data-u="navigator" class="jssorb051"
									style="position: absolute; bottom: 14px; right: 12px;"
									data-autocenter="1" data-scale="0.5" data-scale-bottom="0.75">
									<div data-u="prototype" class="i"
										style="width: 18px; height: 18px;">
										<svg viewbox="0 0 16000 16000"
											style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;">
											<circle class="b" cx="8000" cy="8000" r="5800"></circle>
										</svg>
									</div>
								</div>
							</div>
							<script type="text/javascript">
								jssor_1_slider_init();
							</script>
						</div>

						<div class="video_wrap">
							<video  id="videoId" width="100%" height="100%" controls loop muted>
								<source src="/inc/video/vid_1.mp4" type="video/mp4">
							</video>
						</div>



						<div class="contents_in_m20">
							<div class="main_title_1">인기베팅경기</div>
							<div id="third" class="carouseller">
								<a href="javascript:void(0)" class="carouseller__left"> <img src="/images/arrow_left.png" style="vertical-align:middle;margin-top:5px;">
								</a> <a href="javascript:void(0)" class="carouseller__right"> <img src="/images/arrow_right.png" style="vertical-align:middle;margin-top:5px;">
								</a>
								<div class="carouseller__wrap">
									<div class="carouseller__list">

										<div class="car__4" ng-repeat="ml in ML|orderBy:'SD'">


											<a style="cursor: pointer" ng-click="vM('1',ml.SD,ml.MD)">
												<div class="main_bet_time">
													<p class="main_bet_time_icon">
														<img src="/images/comp_m/{{ml.CD}}.png">
													</p>
													<p class="main_bet_time_text">
														{{ml.MT.substring(0,10)}}<br>{{ml.MT.substring(10,16)}}
													</p>
												</div>
												<div class="main_bet_game">
													<div class="main_bet_name">
														<img src="/images/main_bet_name_{{ml.SD}}.jpg">
														<div class="main_bet_name_text_1">
															<span><img src="/images/team_s/{{ml.HID}}.png" width="23">&nbsp;&nbsp;{{ml.HT}}</span><br>
															<br>
															<span><img src="/images/team_s/{{ml.AID}}.png" width="23">&nbsp;&nbsp;{{ml.AT}}</span>
														</div>
													</div>
													<span class="main_bet_btn">베팅하기</span>

												</div>
											</a>

										</div>
										
										<script type="text/javascript">
											$(function() {
												$('#third').carouseller({ 
													scrollSpeed: 500,
													autoScrollDelay: 6000,
													easing: 'linear'
												});
											});
										</script>
						

										<form id="formId" name="form" method="post"
											action="/sport/livematch.jsp">
											<input type="hidden" name="sid" ng-model="sid"> <input
												type="hidden" name="mid" ng-model="mid"> <input
												type="hidden" name="tab" ng-model="tab">
										</form>
									</div>
								</div>
							</div>
						</div>

						<div class="contents_in_m20">
							<div class="main_board_wrap">
								<div class="main_title_2">실시간 환전현황</div>
								<div class="main_board">
									<table width="100%" cellpadding="0" cellspacing="0"
										class="myTable">
										<tbody>

											<tr ng-repeat="dl in DL |orderBy:'-CT'">
												<td>
													<table width="100%" cellpadding="0" cellspacing="0"
														class="board_table_1_1">
														<tr>
															<td class="board_time_1">{{dl.CT}}</td>
															<td class="board_name_1">{{dl.UD}}</td>
															<td class="board_money_1">{{com(dl.MN)}} 원</td>
														</tr>
													</table>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>

							<div class="main_board_wrap">
								<!-- tab -->

								<div class="main_title_2">실시간 경기목록</div>
								<div id="tabs">
									<ul>
										<li>
											<a ng-class="{tabulous_active:tabSId=='0'}" style="cursor: pointer" style="cursor:pointer" ng-click="selLS('0')">&nbsp;&nbsp;&nbsp;전체&nbsp;&nbsp;&nbsp;</a>
										</li>
											
										<!--
										<li ng-repeat="(key,value) in LS | orderBy:'SId' |  groupBy:'SId'"><a ng-class="{tabulous_active:tabSId==key}" style="cursor: pointer" style="cursor:pointer" ng-click="selLS(key)">
												<img src="/images/sport_m/{{key}}.png" width="15">&nbsp;{{value[0].SN}}</a>
										</li>
										-->
										
										<li ng-repeat="(key,value) in LS | orderBy:'SId' |  groupBy:'SId'"><a ng-class="{tabulous_active:tabSId==key}" style="cursor:pointer" ng-click="selLS(key)">
												&nbsp;&nbsp;&nbsp;<img src="/images/sport_s/{{key}}.png" width="15">&nbsp;&nbsp;&nbsp;</a>
										</li>
										
									</ul>
								</div>

								<table width="100%" cellpadding="0" cellspacing="0"
									class="board_table_2">
									<tr>
										<td width="28%" class="board_table_2_t" style="color:#0792c4">홈</td>
										<td width="28%" class="board_table_2_t" style="color:#0792c4">원정</td>
										<td width="12%" class="board_table_2_t" style="color:#0792c4">승</td>
										<td width="12%" class="board_table_2_t" style="color:#0792c4">무</td>
										<td width="12%" class="board_table_2_t" style="color:#0792c4">패</td>
										<td width="8%" class="board_table_2_t">&nbsp;</td>
									</tr>
								</table>

								<div id="lm_spin" class="sk-fading-circle_s">
									<div class="sk-circle1 sk-circle"></div>
									<div class="sk-circle2 sk-circle"></div>
									<div class="sk-circle3 sk-circle"></div>
									<div class="sk-circle4 sk-circle"></div>
									<div class="sk-circle5 sk-circle"></div>
									<div class="sk-circle6 sk-circle"></div>
									<div class="sk-circle7 sk-circle"></div>
									<div class="sk-circle8 sk-circle"></div>
									<div class="sk-circle9 sk-circle"></div>
									<div class="sk-circle10 sk-circle"></div>
									<div class="sk-circle11 sk-circle"></div>
									<div class="sk-circle12 sk-circle"></div>
								</div>

								<div ng-init="lm_load()" style="display: none;" id="spin2" class="animate-top">

									<div ng-show="tabSId=='0' ? LS.length>4 : (LS|filter:{SId:tabSId}).length>4 ">
										<table width="100%" cellpadding="0" cellspacing="0"	class="myTable2">
											<tbody>
												<tr ng-if="tabSId==ls.SId||tabSId=='0'" ng-init="oIndex = $index"  ng-repeat="ls in LS">
													<td>
														<table width="100%" cellpadding="0" cellspacing="0" class="board_table_1_1">
															<tr ng-if="ls.SusS">
																<td width="28%" class="board_bet_home_2">{{ls.HT.substring(0,10)}}</td>
																<td width="28%" class="board_bet_expedition_2" ng-bind="ls.AT.substring(0,10)"></td>
																<td width="12%" class="board_bet_victory_1"><i class='fa fa-fw fa-lock'></i></td>
																<td width="12%" class="board_bet_draw_1"><i class='fa fa-fw fa-lock'></i></td>
																<td width="12%" class="board_bet_loss_1"><i class='fa fa-fw fa-lock'></i></td>
																<td width="8%" class="board_bet_score_1"><i class='fa fa-fw fa-lock'></i></td>
															</tr>

															<tr ng-if="!ls.SusS && ls.SusM" style="cursor: pointer" ng-click="vM('2',ls.SId,ls.MId)">
																<td width="28%" class="board_bet_home_2" ng-bind="ls.HT.substring(0,10)"></td>
																<td width="28%" class="board_bet_expedition_2" ng-bind="ls.AT.substring(0,10)"></td>
																<td width="12%" class="board_bet_victory_1"><i class='fa fa-fw fa-lock'></i></td>
																<td width="12%" class="board_bet_draw_1"><i class='fa fa-fw fa-lock'></i></td>
																<td width="12%" class="board_bet_victory_1"><i class='fa fa-fw fa-lock'></i></td>
																<td width="8%" class="board_bet_score_1">+{{(LMKc|filter:{M:ls.MId,S:false,V:true}).length}}</td>
															</tr>

															<tr ng-if="!ls.SusS && !ls.SusM" style="cursor: pointer" ng-click="vM('2',ls.SId,ls.MId)">
																<td width="28%" class="board_bet_home_2" ng-bind="ls.HT.substring(0,10)"></td>
																<td width="28%" class="board_bet_expedition_2" ng-bind="ls.AT.substring(0,10)"></td>
																<td width="12%" class="board_bet_victory_1">
																	<div ng-show="ls.BW1P<ls.W1P">
																		<i class="fa fa-fw fa-chevron-up" style="color: green"></i><span class="font_002">{{ls.W1P}}</span>
																	</div>
																	<div ng-show="ls.BW1P>ls.W1P">
																		<i class="fa fa-fw fa-chevron-down" style="color: red"></i><span class="font_002">{{ls.W1P}}</span>
																	</div>
																	<div ng-show="ls.BW1P==ls.W1P"><span class="font_002">{{ls.W1P}}</span>	</div>
																</td>

																<td width="12%" class="board_bet_draw_1">
																	<div ng-show="ls.BXP<ls.XP">
																		<i class="fa fa-fw fa-chevron-up" style="color: green"></i><span class="font_002">{{ls.XP}}</span>
																	</div>
																	<div ng-show="ls.BXP>ls.XP">
																		<i class="fa fa-fw fa-chevron-down" style="color: red"></i><span class="font_002">{{ls.XP}}</span>
																	</div>
																	<div ng-show="ls.BXP==ls.XP"><span class="font_002">{{ls.XP}}</span></div>
																</td>

																<td width="12%" class="board_bet_loss_1">
																	<div ng-show="ls.BW2P<ls.W2P">
																		<i class="fa fa-fw fa-chevron-up" style="color: green"></i><span class="font_002">{{ls.W2P}}</span>
																	</div>
																	<div ng-show="ls.BW2P>ls.W2P">
																		<i class="fa fa-fw fa-chevron-down" style="color: red"></i><span class="font_002">{{ls.W2P}}</span>
																	</div>
																	<div ng-show="ls.BW2P==ls.W2P"> <span class="font_002">{{ls.W2P}}</span></div>
																</td>

																<td width="8%" class="board_bet_score_1">+{{(LMKc|filter:{M:ls.MId,S:false,V:true}).length}}</td>

															</tr>

														</table>
													</td>
												</tr>

											</tbody>
										</table>
									</div>

									<div ng-show="tabSId=='0' ? LS.length<5 : (LS|filter:{SId:tabSId}).length<5 ">
										<table width="100%" cellpadding="0" cellspacing="0">

											<tbody>

												<tr ng-if="tabSId==ls.SId||tabSId=='0'" ng-init="oIndex = $index" ng-repeat="ls in LS">
													<td>
														<table width="100%" cellpadding="0" cellspacing="0" class="board_table_1_1">
															<tr ng-if="ls.SusS">
																<td width="28%" class="board_bet_home_2" ng-bind="ls.HT.substring(0,10)"></td>
																<td width="28%" class="board_bet_expedition_2" ng-bind="ls.AT.substring(0,10)"></td>
																<td width="12%" class="board_bet_victory_1"><i class='fa fa-fw fa-lock'></i></td>
																<td width="12%" class="board_bet_draw_1"><i class='fa fa-fw fa-lock'></i></td>
																<td width="12%" class="board_bet_loss_1"><i class='fa fa-fw fa-lock'></i></td>
																<td width="8%" class="board_bet_score_1"><i class='fa fa-fw fa-lock'></i></td>
															</tr>

															<tr ng-if="!ls.SusS && ls.SusM" style="cursor: pointer" ng-click="vM('2',ls.SId,ls.MId)">
																<td width="28%" class="board_bet_home_2" ng-bind="ls.HT.substring(0,10)"></td>
																<td width="28%" class="board_bet_expedition_2" ng-bind="ls.AT.substring(0,10)"></td>
																<td width="12%" class="board_bet_victory_1"><i class='fa fa-fw fa-lock'></i></td>
																<td width="12%" class="board_bet_draw_1"><i class='fa fa-fw fa-lock'></i></td>
																<td width="12%" class="board_bet_victory_1"><i class='fa fa-fw fa-lock'></i></td>
																<td width="8%" class="board_bet_score_1">+{{(LMKc|filter:{M:ls.MId,S:false,V:true}).length}}</td>
															</tr>

															<tr ng-if="!ls.SusS && !ls.SusM" style="cursor: pointer" ng-click="vM('2',ls.SId,ls.MId)">
																<td width="28%" class="board_bet_home_2"ng-bind="ls.HT.substring(0,10)"></td>
																<td width="28%" class="board_bet_expedition_2" ng-bind="ls.AT.substring(0,10)"></td>
																<td width="12%" class="board_bet_victory_1">
																	<div ng-show="ls.BW1P<ls.W1P">
																		<i class="fa fa-fw fa-chevron-up" style="color: green"></i><span class="font_002">{{ls.W1P}}</span>
																	</div>
																	<div ng-show="ls.BW1P>ls.W1P">
																		<i class="fa fa-fw fa-chevron-down" style="color: red"></i><span class="font_002">{{ls.W1P}}</span>
																	</div>
																	<div ng-show="ls.BW1P==ls.W1P"><span class="font_002">{{ls.W1P}}</span></div>
																</td>

																<td width="12%" class="board_bet_draw_1">
																	<div ng-show="ls.BXP<ls.XP">
																		<i class="fa fa-fw fa-chevron-up" style="color: green"></i><span class="font_002">{{ls.XP}}</span>
																	</div>
																	<div ng-show="ls.BXP>ls.XP">
																		<i class="fa fa-fw fa-chevron-down" style="color: red"></i><span class="font_002">{{ls.XP}}</span>
																	</div>
																	<div ng-show="ls.BXP==ls.XP"><span class="font_002">{{ls.XP}}</span></div>
																</td>

																<td width="12%" class="board_bet_loss_1">
																	<div ng-show="ls.BW2P<ls.W2P">
																		<i class="fa fa-fw fa-chevron-up" style="color: green"></i><span class="font_002">{{ls.W2P}}</span>
																	</div>
																	<div ng-show="ls.BW2P>ls.W2P">
																		<i class="fa fa-fw fa-chevron-down" style="color: red"></i><span class="font_002">{{ls.W2P}}</span>
																	</div>
																	<div ng-show="ls.BW2P==ls.W2P"><span class="font_002">{{ls.W2P}}</span></div>
																</td>

																<td width="8%" class="board_bet_score_1">+{{(LMKc|filter:{M:ls.MId,S:false,V:true}).length}}</td>

															</tr>

														</table>
													</td>
												</tr>

											</tbody>
										</table>
									</div>
									
									
									<div ng-show="tabSId=='0' ? LS.length<1 : (LS|filter:{SId:tabSId}).length<1 ">
										<table width="100%" cellpadding="0" cellspacing="0">

											<tbody>

												<tr>
													<td>
														<table width="100%" cellpadding="0" cellspacing="0">
															<tr>
																<td style="padding:30px 0 10px 0; width:100%; heigth:100px; text-align:center;">현재 진행중인 경기가 없습니다. </td>															
															</tr>
														</table>
													</td>
												</tr>

											</tbody>
										</table>
									</div>
									

								</div>

								<script>
									$(function() {

										$(".myTable").tableTicker({
											row : 1, //몇줄 롤링?
											speed : 2000, //롤링 속도 1000 = 1초에 애니메이션 종료
											interval : 2000, //정지 기간 (1000 = 1초, 0 = 논스탑)
											buffer : 0, // 이동폭 및 높이 보정용 추가 픽셀 (마이너스 값은 입력 불가)
											complete : null
										// 매 롤링 후 호출되는 callback function
										});

										$(".myTable2").tableTicker2({
											row : 1, //몇줄 롤링?
											speed : 2000, //롤링 속도 1000 = 1초에 애니메이션 종료
											interval : 2000, //정지 기간 (1000 = 1초, 0 = 논스탑)
											buffer : 0, // 이동폭 및 높이 보정용 추가 픽셀 (마이너스 값은 입력 불가)
											complete : null
										// 매 롤링 후 호출되는 callback function
										});

									})
								</script>

							</div>

							<div class="main_board_wrap" style="margin: 0px">

								<div class="main_title_2">
									<p style="float: left;">마감임박경기</p>
									<ul class="deadline">
										<li style="cursor: pointer" ng-class="{'time_on':TM=='0'}"><a
											ng-click="setTM('0')">전체</a></li>
										<li style="cursor: pointer" ng-class="{'time_on':TM=='15'}"><a
											ng-click="setTM('15')">15분전</a></li>
										<li style="cursor: pointer" ng-class="{'time_on':TM=='30'}"><a
											ng-click="setTM('30')">30분전</a></li>
										<li style="cursor: pointer" ng-class="{'time_on':TM=='60'}"><a
											ng-click="setTM('60')">60분전</a></li>
									</ul>
								</div>

								<div id="tabs2">
									<ul>
										<li><a ng-class="{tabulous_active:PMSD=='0'}"
											style="cursor: pointer" ng-click="getPM('0',TM)">&nbsp;&nbsp;&nbsp;전체&nbsp;&nbsp;&nbsp; </a></li>
										<li><a ng-class="{tabulous_active:PMSD=='1'}" style="cursor: pointer" ng-click="getPM('1',TM)">&nbsp;&nbsp;&nbsp;<img src="/images/sport_s/1.png" width="15">&nbsp;&nbsp;&nbsp;</a></li>
										<li><a ng-class="{tabulous_active:PMSD=='3'}" style="cursor: pointer" ng-click="getPM('3',TM)">&nbsp;&nbsp;&nbsp;<img src="/images/sport_s/3.png" width="15">&nbsp;&nbsp;&nbsp;</a></li>
										<li><a ng-class="{tabulous_active:PMSD=='11'}" style="cursor: pointer" ng-click="getPM('11',TM)">&nbsp;&nbsp;&nbsp;<img src="/images/sport_s/11.png" width="15">&nbsp;&nbsp;&nbsp;</a></li>
										<li width="30"><a ng-class="{tabulous_active:PMSD=='5'}" style="cursor: pointer" ng-click="getPM('5',TM)">&nbsp;&nbsp;&nbsp;<img src="/images/sport_s/5.png" width="15">&nbsp;&nbsp;&nbsp;</a></li>
										<li><a ng-class="{tabulous_active:PMSD=='4'}" style="cursor: pointer" ng-click="getPM('4',TM)">&nbsp;&nbsp;&nbsp;<img src="/images/sport_s/4.png" width="15">&nbsp;&nbsp;&nbsp;</a></li>
									</ul>
								</div>


								<table width="100%" cellpadding="0" cellspacing="0"
									class="board_table_2">
									<tr>
										<td width="13%" class="board_table_2_t" style="color:#0792c4">시각</td>
										<td width="22%" class="board_table_2_t" style="color:#0792c4">홈</td>
										<td width="22%" class="board_table_2_t" style="color:#0792c4">원정</td>
										<td width="12%" class="board_table_2_t" style="color:#0792c4">승</td>
										<td width="12%" class="board_table_2_t" style="color:#0792c4">무</td>
										<td width="12%" class="board_table_2_t" style="color:#0792c4">패</td>
										<td width="7%" class="board_table_2_t">&nbsp;</td>
									</tr>
								</table>


								<div id="pm_spin" class="sk-fading-circle_s">
									<div class="sk-circle1 sk-circle"></div>
									<div class="sk-circle2 sk-circle"></div>
									<div class="sk-circle3 sk-circle"></div>
									<div class="sk-circle4 sk-circle"></div>
									<div class="sk-circle5 sk-circle"></div>
									<div class="sk-circle6 sk-circle"></div>
									<div class="sk-circle7 sk-circle"></div>
									<div class="sk-circle8 sk-circle"></div>
									<div class="sk-circle9 sk-circle"></div>
									<div class="sk-circle10 sk-circle"></div>
									<div class="sk-circle11 sk-circle"></div>
									<div class="sk-circle12 sk-circle"></div>
								</div>

								<div ng-init="pm_load()" style="display: none;" id="spin1"
									class="animate-top">

									<div ng-show="PMSD=='0' ? PS.length>4 : (PS|filter:{SId:PMSD}).length>4 ">
										<table id="table3" width="100%" cellpadding="0" cellspacing="0" class="myTable2">
											<!--<table id="table" width="100%" cellpadding="0" cellspacing="0">-->
											<tbody>

												<tr class="active" ng-init="oIndex = $index" ng-repeat="ps in PS | orderBy:'Dt' ">
													<td>
														<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">

															<tr  ng-if="ps.SusS">
																<td width="13%" class="board_bet_time_1" ng-bind="ps.Dt"></td>
																<td width="22%" class="board_bet_home_1" ng-bind="ps.HT.substring(0,8)"></td>
																<td width="22%" class="board_bet_expedition_1" ng-bind="ps.AT.substring(0,8)"></td>
																<td width="12%" class="board_bet_victory_1"><i class='fa fa-fw fa-lock'></i></td>
																<td width="12%" class="board_bet_draw_1"><i class='fa fa-fw fa-lock'></i></td>
																<td width="12%" class="board_bet_loss_1"><i class='fa fa-fw fa-lock'></i></td>
																<td width="7%" class="board_bet_score_1"><i class='fa fa-fw fa-lock'></i></td>
															</tr>

															<tr ng-if="!ps.SusS && ps.SusM" style="cursor: pointer" ng-click="vM('3',ps.SId,ps.MId)">
																<td class="board_bet_time_1" ng-bind="ps.Dt"></td>
																<td class="board_bet_home_1" ng-bind="ps.HT.substring(0,8)"></td>
																<td class="board_bet_expedition_1" ng-bind="ps.AT.substring(0,8)"></td>
																<td class="board_bet_victory_1"><i class='fa fa-fw fa-lock'></i></td>
																<td class="board_bet_draw_1"><i class='fa fa-fw fa-lock'></i></td>
																<td class="board_bet_loss_1" ><i class='fa fa-fw fa-lock'></i></td>
																<td class="board_bet_score_1">+{{(PMKc|filter:{M:ps.MId,S:false,V:true}).length}}</td>
															</tr>

															<tr ng-if="!ps.SusS && !ps.SusM" style="cursor: pointer" ng-click="vM('3',ps.SId,ps.MId)">
																<td class="board_bet_time_1" ng-bind="ps.Dt"></td>
																<td class="board_bet_home_1" ng-bind="ps.HT.substring(0,8)"></td>
																<td class="board_bet_expedition_1" ng-bind="ps.AT.substring(0,8)"></td>
																<td class="board_bet_victory_1">
																	<div ng-show="ps.BW1P<ps.W1P">
																		<i class="fa fa-fw fa-chevron-up" style="color: green"></i><span class="font_002">{{ps.W1P}}</span>
																	</div>
																	<div ng-show="ps.BW1P>ps.W1P">
																		<i class="fa fa-fw fa-chevron-down" style="color: red"></i><span class="font_002">{{ps.W1P}}</span>
																	</div>
																	<div ng-show="ps.BW1P==ps.W1P"><span class="font_002">{{ps.W1P}}</span></div>
																</td>
																
																<td class="board_bet_draw_1">
																	<div ng-show="ps.BXP<ps.XP">
																		<i class="fa fa-fw fa-chevron-up" style="color: green"></i><span class="font_002">{{ps.XP}}</span>
																	</div>
																	<div ng-show="ps.BXP>ps.XP">
																		<i class="fa fa-fw fa-chevron-down" style="color: red"></i><span class="font_002">{{ps.XP}}</span>
																	</div>
																	<div ng-show="ps.BXP==ps.XP"><span class="font_002">{{ps.XP}}</span></div>
																</td>
																<td class="board_bet_loss_1">
																	<div ng-show="ps.BW2P<ps.W2P">
																		<i class="fa fa-fw fa-chevron-up" style="color: green"></i><span class="font_002">{{ps.W2P}}</span>
																	</div>
																	<div ng-show="ps.BW2P>ps.W2P">
																		<i class="fa fa-fw fa-chevron-down" style="color: red"></i><span class="font_002">{{ps.W2P}}</span>
																	</div>
																	<div ng-show="ps.BW2P==ps.W2P"><span class="font_002">{{ps.W2P}}</span></div>
																</td>
																<td class="board_bet_score_1">+{{(PMKc|filter:{M:ps.MId,S:false,V:true}).length}}</td>
															</tr>

														</table>
													</td>
												</tr>

											</tbody>
										</table>
									</div>

									<div ng-show="PMSD=='0' ? PS.length<5 : (PS|filter:{SId:PMSD}).length<5 ">
										<table id="table3" width="100%" cellpadding="0" cellspacing="0">
											<!--<table id="table" width="100%" cellpadding="0" cellspacing="0">-->
											<tbody>

												<tr class="active" ng-if="PS.length!=0" ng-init="oIndex = $index"  ng-repeat="ps in PS | orderBy:'Dt'">
													<td>
														<table ng-show="PS.length!=0" width="100%" cellpadding="0" cellspacing="0" class="board_table_2">

															<tr ng-if="ps.SusS">
																<td width="13%" class="board_bet_time_1" ng-bind="ps.Dt"></td>
																<td width="22%" class="board_bet_home_1"
																	ng-bind="ps.HT.substring(0,8)"></td>
																<td width="22%" class="board_bet_expedition_1"
																	ng-bind="ps.AT.substring(0,8)"></td>
																<td width="12%" class="board_bet_victory_1"><i
																	class='fa fa-fw fa-lock'></i></td>
																<td width="12%" class="board_bet_draw_1"><i
																	class='fa fa-fw fa-lock'></i></td>
																<td width="12%" class="board_bet_loss_1"><i
																	class='fa fa-fw fa-lock'></i></td>
																<td width="7%" class="board_bet_score_1"><i class='fa fa-fw fa-lock'></i></td>
															</tr>

															<tr ng-if="!ps.SusS && ps.SusM" style="cursor: pointer"
																ng-click="vM('3',ps.SId,ps.MId)">
																<td class="board_bet_time_1" ng-bind="ps.Dt"></td>
																<td class="board_bet_home_1" ng-bind="ps.HT.substring(0,8)"></td>
																<td class="board_bet_expedition_1"
																	ng-bind="ps.AT.substring(0,8)"></td>
																<td class="board_bet_victory_1"><i
																	class='fa fa-fw fa-lock'></i></td>
																<td class="board_bet_draw_1"><i class='fa fa-fw fa-lock'></i></td>
																<td class="board_bet_loss_1"><i
																	class='fa fa-fw fa-lock'></i></td>
																<td class="board_bet_score_1">+{{(PMKc|filter:{M:ps.MId,S:false,V:true}).length}}</td>
															</tr>

															<tr ng-if="!ps.SusS && !ps.SusM" style="cursor: pointer"
																ng-click="vM('3',ps.SId,ps.MId)">
																<td class="board_bet_time_1" ng-bind="ps.Dt"></td>
																<td class="board_bet_home_1" ng-bind="ps.HT.substring(0,8)"></td>
																<td class="board_bet_expedition_1"
																	ng-bind="ps.AT.substring(0,8)"></td>
																<td class="board_bet_victory_1">
																	<div ng-show="ps.BW1P<ps.W1P">
																		<i class="fa fa-fw fa-chevron-up" style="color: green"></i><span class="font_002">{{ps.W1P}}</span>
																	</div>
																	<div ng-show="ps.BW1P>ps.W1P">
																		<i class="fa fa-fw fa-chevron-down" style="color: red"></i><span class="font_002">{{ps.W1P}}</span>
																	</div>
																	<div ng-show="ps.BW1P==ps.W1P"><span class="font_002">{{ps.W1P}}</span></div>
																</td>
																<td class="board_bet_draw_1">
																	<div ng-show="ps.BXP<ps.XP">
																		<i class="fa fa-fw fa-chevron-up" style="color: green"></i><span class="font_002">{{ps.XP}}</span>
																	</div>
																	<div ng-show="ps.BXP>ps.XP">
																		<i class="fa fa-fw fa-chevron-down" style="color: red"></i><span class="font_002">{{ps.XP}}</span>
																	</div>
																	<div ng-show="ps.BXP==ps.XP"> <span class="font_002">{{ps.XP}}</span> </div>
																</td>
																<td class="board_bet_loss_1">
																	<div ng-show="ps.BW2P<ps.W2P">
																		<i class="fa fa-fw fa-chevron-up" style="color: green"></i><span class="font_002">{{ps.W2P}}</span>
																	</div>
																	<div ng-show="ps.BW2P>ps.W2P">
																		<i class="fa fa-fw fa-chevron-down" style="color: red"></i><span class="font_002">{{ps.W2P}}</span>
																	</div>
																	<div ng-show="ps.BW2P==ps.W2P"><span class="font_002">{{ps.W2P}}</span></div>
																</td>
																<td class="board_bet_score_1">+{{(PMKc|filter:{M:ps.MId,S:false,V:true}).length}}</td>
															</tr>

														</table>
													</td>
												</tr>

												<tr ng-if="PS.length==0" height="100">
													<td align="center" width="100%">경기가 없습니다.</td>
												</tr>

											</tbody>
										</table>
									</div>

								</div>

							</div>


						</div>
					</div>
				</div>
			</div>
			<!-- wrap -->
		</div>
		<%@ include file="/inc/footer.jsp" %>

	</div><!-- wrap -->
	</div><!-- wrap -->
</body>
</html>