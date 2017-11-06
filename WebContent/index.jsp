<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="java.util.*"%>
<%@page import="net.vavasoft.bean.*"%>
<%@page import="java.lang.Integer"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="com.google.gson.reflect.TypeToken"%>




<%
// List<MatchListBean> mr = bm.getFavoriteMatch();
// List<DepositListBean> dl = bm.getDepositList();

//StringBuffer sb = bm.getMainLiveMatch();
//StringBuffer sb2 = bm.getMainPreMatch("0","0");
//StringBuffer sb3  = bm.getValidMarketType();

Gson gson = new Gson();
// Type type = new TypeToken<List<MatchListBean>>() {}.getType();
// Type type2 = new TypeToken<List<DepositListBean>>() {}.getType();

 // String mr_s = gson.toJson(mr, type);      
 // String dl_s = gson.toJson(dl, type2);   
     
%>
<%@ include file="/inc/main_header.jsp"%>
<script>
	var mainAngular = angular.module('Vava', [ 'ngAnimate', 'vAccordion' ]);

	var s=[
			{"PID":0,"u":"center_live.html"},
			{"PID":1,"u":"left_live.html"},
			{"PID":2,"u":"right_bet.html"},
			{"PID":3,"u":"ws://103.1.249.79:7071"},
			{"PID":4,"u":"center_pre.html"},
			{"PID":5,"u":"/JSON/period_name.json"},
			{"PID":6,"u":"/JSON/live_status.json"},
			{"PID":7,"u":"/sport/jsp/getValidMarketType.jsp"},
			{"PID":8,"u":"jsp/getFavMatch.jsp"},
			{"PID":9,"u":"jsp/loadLiveMatchInit.jsp"},
			{"PID":10,"u":"jsp/loadPreMatchInit.jsp"},
			{"PID":11,"u":"jsp/getMarketbyMatchId.jsp"},
			{"PID":12,"u":"jsp/getStatusbyMatchId.jsp"},
			{"PID":13,"u":"jsp/getMarketbyMarketId.jsp"},
			{"PID":14,"u":"jsp/subLoadLiveMatch.jsp"},
			{"PID":15,"u":"jsp/getMatchInfobyCompetition.jsp"},
			{"PID":16,"u":"left_pre.html"},
			{"PID":17,"u":"jsp/loadPreMatch.jsp"},
			{"PID":18,"u":"jsp/subLoadPreMatch.jsp"},
			{"PID":19,"u":"jsp/setFavMatch.jsp"},
			{"PID":20,"u":"/sport/jsp/getMainPreMatch.jsp"},
			{"PID":21,"u":"/main/jsp/getDepositList.jsp"},
			{"PID":22,"u":"/main/jsp/loadLiveMatch.jsp"},
			{"PID":22,"u":"/main/jsp/loadPreMatch.jsp"}	
			]
			
	mainAngular.factory('wss', function($window) {
		
		var sv = {};
		sv.ws = new Object();
			
		sv.con = function() {	
			var wsUrl = s[3].u ; 
			var websocket = new WebSocket(wsUrl);		
			websocket.onopen = function() {
				sv.callback("CONNECTED");
			};
			websocket.onerror = function() {
				websocket = null;			
				sv.callback("Failed to open a connection" );
			};
			websocket.onclose = function() {
				websocket = null;			
				sv.ws.close();
				sv.callback("DISCONNECTED");					
				setTimeout(function(){sv.con()}, 5000);			
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
		sv.loadGetMatchInit = function(){
			
		}
		
		sv.sendMessage = function(msg){
			sv.ws.send(msg);
		};
		
		return sv;
	});
	 


	mainAngular.controller("mc", function($scope, $sce, $templateCache, $compile, $http,wss) {		
		
			wss.subscribe(function( message) {		
			try {
							
				var obj = JSON.parse(message);				
				switch(obj.Command) {		     	 		   
					//case "GetCompetitions": loadGetCompetitions(obj);
					//	break;							
					//case "MatchStat": sub_loadGetMatchStat(obj);
					//	break;								
					//case "GetMatches": loadGetMatch(obj); 
					//	break;					
					case "MatchUpdate":				
						if(obj.Type == "Match"){
							sub_loadGetMatch(obj);
							
						//} else if (obj.Type == "MatchStat") {
						//	sub_loadGetMatchStat(obj);
							
						} else if (obj.Type == "Market") 
							sub_loadGetMatchMarket(obj);			
						break;									
					case "GetMatchMarkets": loadGetMatchMarket(obj);
						break;								
			 	} 		 	
			} catch (exception) {			
			}		
		$scope.$apply();
		});
		
		// wss.con();
		
		// loadLiveMatch();
			
		// $scope.ML = null;	
		// $scope.DL = null;	
		//getDepositList();	
		// dl_load();

		// loadPreMatch();
		
		
		// $http({
		// 		method: 'GET', 
		// 		url: s[7].u, 
		// 		headers: {'Content-Type': 'application/json; charset=utf-8'} 
		// }).success(function(data, status, headers, config) {					
		// 	if(data) {
				
		// 		$scope.validMKTypeId = data;		
		// 		//console.log($scope.validMKTypeId);
		// 	};
		// 	data = null;
		// }).error(function(data, status, headers, config) {;
		// 	console.log("Error $scope.validMKTypeId");
		// 	data = null;
		// });
		
		function dl_load() {
		    var sp = setInterval(getDepositList, 1000*30);
		};
		
		function getDepositList() {		
			
			$http({
					method: 'GET', 
					url: s[21].u, 
					headers: {'Content-Type': 'application/json; charset=utf-8'} 
			}).success(function(data, status, headers, config) {					
				if(data) {
					
					$scope.DL = [];
					$scope.DL = data;
					console.log($scope.DL);
					
						
				};
				data = null;
			}).error(function(data, status, headers, config) {;
				console.log("Exception getDepositList");
				data = null;
			});
		};


		$scope.vM = function(tab,sid,mid) {		
			console.log("$scope.vM");		

	console.log($scope.form);	


	document.getElementById('formId').tab.value = tab		
	document.getElementById('formId').sid.value = sid		
	document.getElementById('formId').mid.value = mid		
	console.log("$scope.form.mid:" + $scope.form.mid.value);
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
	  


	  $scope.vM2 = function(sid,mid) {		
			//console.log("$scope.vM");			
				document.form.mid.value = mid				
				document.form.sid.value = sid		
				document.form.tab.value = "2"	
				document.form.method = "post";	
				document.form.action="/sport/livematch.jsp"
				document.form.submit();		
		};
		 
	   	$scope.com = function(str) {
		    str = String(str);
		    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
			};
			
			var $filter = angular.injector(['ng', 'Vava']).get('$filter');
			
			
			function loadLiveMatch() {

				$scope.LS = [];
				$scope.LMKc = [];
				
				$http({
					method: 'GET', 
					url: s[22].u, 
					headers: {'Content-Type': 'application/json; charset=utf-8'} 
			}).success(function(data, status, headers, config) {					
				if(data) {
					
				angular.forEach(data, function(obj,idx) {				
					if(obj.Mk !== null &&  obj.Mk !== undefined && obj.Mk.length > 0){					
						for (var j = 0; j < obj.Mk.length ; j++) {						
							$scope.LMKc.push(obj.Mk[j]);							
						}
					}
					
			    angular.forEach(obj.Mt, function(obj2,idx2) {       
					
					//var mStat = obj.St.filter(function (el) { return el.MId == obj2.Id; })	
					var mResult = obj.Re.filter(function (el) { return el.MId == obj2.Id; })	
					var mSelect = obj.Se.filter(function (el) { return el.MId == obj2.Id; })	
					
					var w1Price, w2Price, xPrice  ="-";		
					var SusM = true;
					var Vis = true;
					var MkId = "0";
					
					if(mResult !== undefined && mResult !== null && mResult.length > 0){				
						//var w1Price, w2Price, xPrice  ="-";			
						//var w1SelId, xSelId, w2SelId ="";	
						
						SusM = mResult[0].Sus;
						Vis = mResult[0].Vis;
						MkId = mResult[0].Id;
						
						for(var i = mSelect.length - 1; i >= 0; i--){
							if(mSelect[i].Nm == 'W1') {
								//w1SelId = mSelect[i].Id ;
								w1Price = mSelect[i].P ;					
							} else if(mSelect[i].Nm == 'X') {
								//xSelId = mSelect[i].Id ;
								xPrice = mSelect[i].P ;					
							} else if(mSelect[i].Nm == 'W2') {
								//w2SelId = mSelect[i].Id ;
								w2Price = mSelect[i].P ;
							}
						};
					};

				   	$scope.LS.push({
				  		SId:obj2.SId,
				  		SN:obj2.SN,	    		
				  		RId:obj2.RId,
				  		RN:obj2.RN,
				  		CId:obj2.CId,
				  		CN:obj2.CN,
				    	MId:obj2.Id,
				    	HT:obj2.HT,
				    	AT:obj2.AT,
				    	//Pe:mStat[0].Pe,
				    	//EType : mMatchStat[0].EventType,
				    	//HTS:HTeamScore,
				    	//ATS:ATeamScore,
				    	SusS:obj2.Sus,
				    	//Cur:(mStat[0].Cur == undefined) ? "" : mStat[0].Cur, //mStat[0].CurrentMinute,
				    	//Rem:(mStat[0].Rem == undefined) ? "" : mStat[0].Rem, //mStat[0].RemainingTime,
				    	//Inf:mStat.Inf,	
				    	MkId:MkId, 
				    	SusM:SusM, 
				    	Vis:Vis,			    	
				    	//W1SD:w1SelId,
				    	//XSD:xSelId,
				    	//W2SD:w2SelId,
				    	BW1P:w1Price, 
					    BXP:xPrice,
					    BW2P:w2Price,			      	
				    	W1P:w1Price,
				    	XP:xPrice,
				    	W2P:w2Price,	    	
						});
				  			
					//};
				  });
			 		
			 	}); 
			 	
			};
				data = null;
			}).error(function(data, status, headers, config) {;
				console.log("Exception loadLiveMatch");
				data = null;
			});
		};
			
			 	//console.log("LS");
			 	//console.log($scope.LS);
			
		function loadPreMatch() {
				//////
			 	$scope.PS = [];
				$scope.PMKc = [];
				
			$http({
					method: 'GET', 
					url: s[23].u, 
					headers: {'Content-Type': 'application/json; charset=utf-8'} 
			}).success(function(data, status, headers, config) {					
				if(data) {
				
				angular.forEach(data, function(obj,idx) {				
					if(obj.Mk !== null &&  obj.Mk !== undefined && obj.Mk.length > 0){					
						for (var j = 0; j < obj.Mk.length ; j++) {						
							$scope.PMKc.push(obj.Mk[j]);							
						}
					}
					
			    angular.forEach(obj.Mt, function(obj2,idx2) {       
					
					//var mStat = obj.St.filter(function (el) { return el.MId == obj2.Id; })	
					var mResult = obj.Re.filter(function (el) { return el.MId == obj2.Id; })	
					var mSelect = obj.Se.filter(function (el) { return el.MId == obj2.Id; })	
					
					
					//console.log(mResult);
					//console.log(mSelect);
					
					var w1Price, w2Price, xPrice  ="-";		
					var SusM = true;
					var Vis = true;
					var MkId = "0";
									
					if(mResult !== undefined && mResult !== null && mResult.length > 0){				
						//var w1Price, w2Price, xPrice  ="-";			
						//var w1SelId, xSelId, w2SelId ="";	
						
						SusM = mResult[0].Sus;
						Vis = mResult[0].Vis;
						MkId = mResult[0].Id;
						
						//console.log(mSelect);
						
						for(var i = mSelect.length - 1; i >= 0; i--){
							if(mSelect[i].Nm == 'W1') {
								//w1SelId = mSelect[i].Id ;
								w1Price = mSelect[i].P ;					
							} else if(mSelect[i].Nm == 'X') {
								//xSelId = mSelect[i].Id ;
								xPrice = mSelect[i].P ;					
							} else if(mSelect[i].Nm == 'W2') {
								//w2SelId = mSelect[i].Id ;
								w2Price = mSelect[i].P ;
							}
						};
					};

				   	$scope.PS.push({
				  		SId:obj2.SId,
				  		SN:obj2.SN,	    		
				  		RId:obj2.RId,
				  		RN:obj2.RN,
				  		CId:obj2.CId,
				  		CN:obj2.CN,
				    	MId:obj2.Id,
				    	HT:obj2.HT,
				    	AT:obj2.AT,
				    	Dt:obj2.Dt,
				    	//Pe:mStat[0].Pe,
				    	//EType : mMatchStat[0].EventType,
				    	//HTS:HTeamScore,
				    	//ATS:ATeamScore,
				    	SusS:obj2.SusS,
				    	//Cur:(mStat[0].Cur == undefined) ? "" : mStat[0].Cur, //mStat[0].CurrentMinute,
				    	//Rem:(mStat[0].Rem == undefined) ? "" : mStat[0].Rem, //mStat[0].RemainingTime,
				    	//Inf:mStat.Inf,	
				    	//MkId:mResult[0].Id, 
				    	//SusM:mResult[0].Sus, 
				    	//Vis:mResult[0].Vis,				    		
				    	SusM:SusM,
				    	Vis:Vis,    	
				    	MkId:MkId,
				    	//W1SD:w1SelId,
				    	//XSD:xSelId,
				    	//W2SD:w2SelId,
				    	BW1P:w1Price, 
					    BXP:xPrice,
					    BW2P:w2Price,			      	
				    	W1P:w1Price,
				    	XP:xPrice,
				    	W2P:w2Price,	    	
						});			  	
				
					//};
				  });
			 		
			 	}); 

				};
			}).error(function(data, status, headers, config) {;
				console.log("Exception loadLiveMatch");
				data = null;
			});
		};
		

		function sub_loadGetMatchMarket(res) {		
			
				angular.forEach(res.Objects, function(obj,idx) {					
				
				var v_market = $scope.validMKTypeId.indexOf(obj.MarketTypeId);				

				if (v_market < 0){		
						return;  //un-used MarketTypeId
				}; 

				var nMK = true;

				for (var a=0; a< $scope.LMKc.length; a++) {
					if($scope.LMKc[a].Id == obj.Id){				
						nMK = false;								
						$scope.LMKc[a].S = obj.IsSuspended;
						$scope.LMKc[a].V = obj.IsVisible;
					
						break;
					};
				}
									
				for (var b=0; b<$scope.PMKc.length; b++) {
					if($scope.PMKc[b].Id == obj.Id){				
						nMK = false;							
						$scope.PMKc[b].S = obj.IsSuspended;
						$scope.PMKc[b].V = obj.IsVisible;
											
						break;
					};
				}
						
				if(nMK){	
									
						for (var b = 0; b < $scope.LS.length; b++) {								
							if($scope.LS[b].MId == obj.MatchId){				
									
								$scope.LMKc.push({
					    		Id:obj.Id,
					    		S:obj.IsSuspended,	    		
					    		V:obj.IsVisible,
					    		M:obj.MatchId,
								});
								break;
							};
						};		
						
						for (var k = 0; k < $scope.PS.length; k++) {								
							if($scope.PS[k].MId == obj.MatchId){				
									
								$scope.PMKc.push({
					    		Id:obj.Id,
					    		S:obj.IsSuspended,	    		
					    		V:obj.IsVisible,
					    		M:obj.MatchId,
								});
								break;
							};
						};	
				};
			
				for (var c = 0; c < $scope.LS.length; c++) {	
							 		
				 		var lm = $scope.LS[c];	
				 				 		
					 	if(lm.MkId == obj.Id){		
					 						 					 		
					 		var w1Price, w2Price, xPrice ="-";
											
			    		for (var j = 0; j < obj.Selections.length; j++) {
								
				    		if(obj.Selections[j].Name == 'W1') {
				    			w1Price = obj.Selections[j].Price ;
				    		
				    		} else if(obj.Selections[j].Name == 'X') {
									xPrice = obj.Selections[j].Price ;
								
								} else if(obj.Selections[j].Name == 'W2') {
									w2Price = obj.Selections[j].Price ;
								}
							};
								      				
			      			$scope.LS[c].SusM = obj.IsSuspended;
			      			$scope.LS[c].Vis = obj.IsVisible;
			      			$scope.LS[c].BW1P = lm.W1P;
			      			$scope.LS[c].BXP = lm.XP;
			      			$scope.LS[c].BW2P = lm.W2P;
			      			
			      			$scope.LS[c].W1P = w1Price;
			      			$scope.LS[c].XP = xPrice;
			      			$scope.LS[c].W2P = w2Price;
						};						
				};

			
				for (var c = 0; c < $scope.PS.length; c++) {	
							 		
				 		var pm = $scope.PS[c];	
				 				 		
					 	if(pm.MkId == obj.Id){		
				
					 		var w1Price, w2Price, xPrice ="-";
											
			    		for (var j = 0; j < obj.Selections.length; j++) {
								
				    		if(obj.Selections[j].Name == 'W1') {
				    			w1Price = obj.Selections[j].Price ;
				    		
				    		} else if(obj.Selections[j].Name == 'X') {
									xPrice = obj.Selections[j].Price ;
								
								} else if(obj.Selections[j].Name == 'W2') {
									w2Price = obj.Selections[j].Price ;
								}
							};
				  			
				  			$scope.PS[c].SusM = obj.IsSuspended;
		      			$scope.PS[c].Vis = obj.IsVisible;
		      			$scope.PS[c].BW1P = pm.W1P;
		      			$scope.PS[c].BXP = pm.XP;
		      			$scope.PS[c].BW2P = pm.W2P;
		      			
		      			$scope.PS[c].W1P = w1Price;
		      			$scope.PS[c].XP = xPrice;
		      			$scope.LP[c].W2P = w2Price;		      			
		  						 
						};						
				};
			
					
				
			});			
		};
		
		
		function sub_loadGetMatch(res) {		  	  	
	  	var nlm = true;
	  	
	  	console.log("sub_loadGetMatch");
	  	  	
	  	angular.forEach(res.Objects, function(obj,idx) {						
				
				if(!obj.IsBooked){
					console.log("obj.IsBooked : " + obj.IsBooked);
						return;
				};

				console.log(obj);
				console.log("MATCH ID:" +obj.Id);

		  	angular.forEach($scope.LS, function(Ls_obj,i2) {
		  			  		
		  		if (Ls_obj.MId == obj.Id){			  					  			
		  			nlm = false;			
		  			
		  			console.log("MATCH LIVE MatchId : " + obj.MatchId);
		  			
		  			if(Ls_obj.IsVisible && !obj.IsVisible){	
		  				finishLiveMatch(obj.Id);

		  			} else if(!obj.IsLive){	  				
		  				finishLiveMatch(obj.Id);
		  			
		  			} else if(obj.LiveStatus == '2'){	  				
		  				finishLiveMatch(obj.Id);
			
		  			} 
					};
				});
						
				if(nlm && obj.IsVisible ){				
					if(obj.IsLive && obj.MatchStatus !='2'){		
						subLoadLiveMatch(obj.Id);	
					};
				};
				
				
				angular.forEach($scope.PS, function(Ps_obj,i3) {
		  			  		
		  		if (Ps_obj.MId == obj.Id){			  					  			
		  			nlm = false;			
		  			console.log("MATCH PRE MatchId : " + obj.MatchId);
		  			
			  		if (Ps_obj.SusS != obj.IsSuspended){			
			  			$scope.PS[i3].SusS = obj.IsSuspended;
			  		}
			  		
			  		if (Ps_obj.Vis != obj.IsVisible){
			      	$scope.PS[i3].Vis = obj.IsVisible;
		      	}
		      	
		      	if (Ps_obj.MatchStatus =='1'){		
		      		finishPreMatch(obj.Id);
			      	//$scope.PS[i3].Vis = obj.IsVisible;
		      		//delete //insert  
		      	}
		      }
				});
				
			});	
		};
		
		
		function subLoadLiveMatch(mid) {
		  loadLiveMatch();
	 	};
	 
		function finishLiveMatch(mid) {		
			loadLiveMatch();
		};
		
		function finishPreMatch(mid) {		
			loadPreMatch()		
		};
		
		$scope.tabSId = "0";
		
		$scope.selLS = function (sid) {
			
			document.getElementById("spin2").style.display = "none";
	  	document.getElementById("lm_spin").style.display  = "block";
	  	
			$scope.lm_load();
	  	console.log("selLS");
			
			
	  	$scope.tabSId = sid ;
	  	//$scope.tableParams.reload();
	  	  
			//if(sid !="0"){
	    	//stopTicker(".myTable2");
	    	
	  	//} else {
	  		//console.log("start");
	  		//startTicker(".myTable2");		  
	  //	}
	  	

	  };    
	    
		$scope.TM = "0";


		$scope.setTM = function (tm) {
	  	$scope.TM = tm ;
	 	}  	
		
		$scope.pm_load = function() {
		    var sp = setTimeout(sp_pm, 1000);
		};
		
		$scope.main_load = function() {
		    var sp = setTimeout(sp_main, 1500);
		};
		
		$scope.lm_load = function() {
		    var sp = setTimeout(sp_lm, 1000);
		};
		

		
		$scope.PMSD = "0";
		
		$scope.getPM = function(sid,min) {
			
			$scope.PMSD = sid ;
			
			document.getElementById("spin1").style.display  = "none";
		  document.getElementById("pm_spin").style.display = "block";
			
			$http({
					method: 'GET', 
					url: s[20].u, 
					params: {'sid':sid,'min':min},
					headers: {'Content-Type': 'application/json; charset=utf-8'} 
			}).success(function(data, status, headers, config) {
		
				if(data) {			
					
					$scope.PS = [];
					
					//console.log(data);
					
					angular.forEach(data, function(obj,idx) {		
								
					if(obj.Mk !== null &&  obj.Mk !== undefined && obj.Mk.length > 0){					
						for (var j = 0; j < obj.Mk.length ; j++) {						
							$scope.PMKc.push(obj.Mk[j]);							
						}
					}
					
				    angular.forEach(obj.Mt, function(obj2,idx2) {       
						
						//var mStat = obj.St.filter(function (el) { return el.MId == obj2.Id; })	
						var mResult = obj.Re.filter(function (el) { return el.MId == obj2.Id; })	
						var mSelect = obj.Se.filter(function (el) { return el.MId == obj2.Id; })	
						
						
						//console.log(mResult);
						//console.log(mSelect);
						
						var w1Price, w2Price, xPrice  ="-";		
						var SusM = true;
						var Vis = true;
						var MkId = "0";
										
						if(mResult !== undefined && mResult !== null && mResult.length > 0){				
							//var w1Price, w2Price, xPrice  ="-";			
							//var w1SelId, xSelId, w2SelId ="";	
							
							SusM = mResult[0].Sus;
							Vis = mResult[0].Vis;
							MkId = mResult[0].Id;
						
							for(var i = mSelect.length - 1; i >= 0; i--){
								if(mSelect[i].Nm == 'W1') {
									//w1SelId = mSelect[i].Id ;
									w1Price = mSelect[i].P ;					
								} else if(mSelect[i].Nm == 'X') {
									//xSelId = mSelect[i].Id ;
									xPrice = mSelect[i].P ;					
								} else if(mSelect[i].Nm == 'W2') {
									//w2SelId = mSelect[i].Id ;
									w2Price = mSelect[i].P ;
								}
							};
						};

					   	$scope.PS.push({
					  		SId:obj2.SId,
					  		SN:obj2.SN,	    		
					  		RId:obj2.RId,
					  		RN:obj2.RN,
					  		CId:obj2.CId,
					  		CN:obj2.CN,
					    	MId:obj2.Id,
					    	HT:obj2.HT,
					    	AT:obj2.AT,
					    	Dt:obj2.Dt,
					    	SusS:obj2.Sus,
					    	SusM:SusM,
					    	Vis:Vis,    	
					    	MkId:MkId,
						    BW1P:w1Price, 
						    BXP:xPrice,
						    BW2P:w2Price,			      	
					    	W1P:w1Price,
					    	XP:xPrice,
					    	W2P:w2Price,	    	
							});			  	

					  });
			 		
			 	}); 		 					

				};
							
				data = null;

				//document.getElementById("table").deleteRow(0);
				
			//document.getElementById("pm_spin").style.display  = "none";
		  //document.getElementById("spin1").style.display = "block";
		  	
		  	$scope.pm_load();
		  	  
			}).error(function(data, status, headers, config) {
				console.log(status);
				data = null;
			});
			
		};

		function sp_pm() {
		  document.getElementById("pm_spin").style.display  = "none";	 	  
		  document.getElementById("spin1").style.display = "block"; 
		}
			  
		function sp_lm() {
		  document.getElementById("lm_spin").style.display  = "none";
		  document.getElementById("spin2").style.display = "block";
		}
		
		function sp_main() {
		  document.getElementById("main_spin").style.display  = "none";
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

<style type="text/css">

	.sk-fading-circle {
	  margin: 15% auto 50px;
	  width: 80px;
	  height: 80px;
	  position: relative; }
	  .sk-fading-circle .sk-circle {
	    width: 100%;
	    height: 100%;
	    position: absolute;
	    left: 0;
	    top: 0; }
	  .sk-fading-circle .sk-circle:before {
	    content: '';
	    display: block;
	    margin: 0 auto;
	    width: 15%;
	    height: 15%;
	    background-color: #333;
	    border-radius: 100%;
	    -webkit-animation: sk-circleFadeDelay 1.2s infinite ease-in-out both;
	            animation: sk-circleFadeDelay 1.2s infinite ease-in-out both; }
	  .sk-fading-circle .sk-circle2 {
	    -webkit-transform: rotate(30deg);
	        -ms-transform: rotate(30deg);
	            transform: rotate(30deg); }
	  .sk-fading-circle .sk-circle3 {
	    -webkit-transform: rotate(60deg);
	        -ms-transform: rotate(60deg);
	            transform: rotate(60deg); }
	  .sk-fading-circle .sk-circle4 {
	    -webkit-transform: rotate(90deg);
	        -ms-transform: rotate(90deg);
	            transform: rotate(90deg); }
	  .sk-fading-circle .sk-circle5 {
	    -webkit-transform: rotate(120deg);
	        -ms-transform: rotate(120deg);
	            transform: rotate(120deg); }
	  .sk-fading-circle .sk-circle6 {
	    -webkit-transform: rotate(150deg);
	        -ms-transform: rotate(150deg);
	            transform: rotate(150deg); }
	  .sk-fading-circle .sk-circle7 {
	    -webkit-transform: rotate(180deg);
	        -ms-transform: rotate(180deg);
	            transform: rotate(180deg); }
	  .sk-fading-circle .sk-circle8 {
	    -webkit-transform: rotate(210deg);
	        -ms-transform: rotate(210deg);
	            transform: rotate(210deg); }
	  .sk-fading-circle .sk-circle9 {
	    -webkit-transform: rotate(240deg);
	        -ms-transform: rotate(240deg);
	            transform: rotate(240deg); }
	  .sk-fading-circle .sk-circle10 {
	    -webkit-transform: rotate(270deg);
	        -ms-transform: rotate(270deg);
	            transform: rotate(270deg); }
	  .sk-fading-circle .sk-circle11 {
	    -webkit-transform: rotate(300deg);
	        -ms-transform: rotate(300deg);
	            transform: rotate(300deg); }
	  .sk-fading-circle .sk-circle12 {
	    -webkit-transform: rotate(330deg);
	        -ms-transform: rotate(330deg);
	            transform: rotate(330deg); }
	  .sk-fading-circle .sk-circle2:before {
	    -webkit-animation-delay: -1.1s;
	            animation-delay: -1.1s; }
	  .sk-fading-circle .sk-circle3:before {
	    -webkit-animation-delay: -1s;
	            animation-delay: -1s; }
	  .sk-fading-circle .sk-circle4:before {
	    -webkit-animation-delay: -0.9s;
	            animation-delay: -0.9s; }
	  .sk-fading-circle .sk-circle5:before {
	    -webkit-animation-delay: -0.8s;
	            animation-delay: -0.8s; }
	  .sk-fading-circle .sk-circle6:before {
	    -webkit-animation-delay: -0.7s;
	            animation-delay: -0.7s; }
	  .sk-fading-circle .sk-circle7:before {
	    -webkit-animation-delay: -0.6s;
	            animation-delay: -0.6s; }
	  .sk-fading-circle .sk-circle8:before {
	    -webkit-animation-delay: -0.5s;
	            animation-delay: -0.5s; }
	  .sk-fading-circle .sk-circle9:before {
	    -webkit-animation-delay: -0.4s;
	            animation-delay: -0.4s; }
	  .sk-fading-circle .sk-circle10:before {
	    -webkit-animation-delay: -0.3s;
	            animation-delay: -0.3s; }
	  .sk-fading-circle .sk-circle11:before {
	    -webkit-animation-delay: -0.2s;
	            animation-delay: -0.2s; }
	  .sk-fading-circle .sk-circle12:before {
	    -webkit-animation-delay: -0.1s;
	            animation-delay: -0.1s; }
	@-webkit-keyframes sk-circleFadeDelay {
	  0%, 39%, 100% {
	    opacity: 0; }
	  40% {
	    opacity: 1; } }
	@keyframes sk-circleFadeDelay {
	  0%, 39%, 100% {
	    opacity: 0; }
	  40% {
	    opacity: 1; } }
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
			<%@ include file="/inc/session.jsp"%>
			<%@ include file="/inc/header.jsp"%>
			<div id="contents_wrap">
				<div class="contents">
			    	<div class="contents_in_m20">
						<div class="main_visual">
							<div id="jssor_1" style="position:relative;width:930px;height:225px;overflow:hidden;visibility:hidden;">
								<div data-u="slides" style="cursor:default;position:relative;top:0px;left:0px;width:930px;height:225px;overflow:hidden;">
									<div>
										<a class='<%=(!checkSession) ? "fade_1_open" : ""  %>' href="#fade_1"><img src="/images/visual001.jpg"/></a> 
									</div>
									<div>
										<a class='<%=(!checkSession) ? "fade_1_open" : ""  %>' href="#fade_1"><img src="/images/visual001.jpg"/></a>
									</div>
									<div>
										<a class='<%=(!checkSession) ? "fade_1_open" : ""  %>' href="#fade_1"><img src="/images/visual001.jpg"/></a>
									</div>
								</div>
								<!-- Bullet Navigator -->
								<div data-u="navigator" class="jssorb051" style="position:absolute;bottom:14px;right:12px;" data-autocenter="1" data-scale="0.5" data-scale-bottom="0.75">
									<div data-u="prototype" class="i" style="width:18px;height:18px;">
										<svg viewbox="0 0 16000 16000" style="position:absolute;top:0;left:0;width:100%;height:100%;">
											<circle class="b" cx="8000" cy="8000" r="5800"></circle>
										</svg>
									</div>
								</div>
							</div>
							<script type="text/javascript">jssor_1_slider_init();</script>
						</div>
						<div class="video_wrap">
						<video id="videoId" width="100%" height="100%" controls loop >
							  <source src="inc/video/vid_1.mp4" type="video/mp4">
						</video>
						</div>
					</div>
			        <div class="contents_in_m20">
			        	<div class="main_title_1">인기베팅경기</div>
						<div id="third" class="carouseller"> 
							<a href="javascript:void(0)" class="carouseller__left"> <img src="/images/arrow_left.png"> </a> 
							<a href="javascript:void(0)" class="carouseller__right"> <img src="/images/arrow_right.png"> </a>
							<div class="carouseller__wrap"> 
								<div class="carouseller__list">
									<div class="car__4">
										<a href="#">
											<div class="main_bet_time">
												<p class="main_bet_time_icon"><img src="/images/bet_icon.png"></p>
												<p class="main_bet_time_text">2017년00월00일<br>00:00</p>
											</div>
											<div class="main_bet_game">
												<div class="main_bet_name">
													<img src="/images/main_bet_name01.jpg">
													<div class="main_bet_name_text">
														<span>레알마드리드</span><br><span>FC 바르셀로나123456</span>
													</div>
												</div>
												<span class="main_bet_btn">베팅하기</span>
											</div>
										</a>
									</div>
									<div class="car__4">
										<a href="#">
											<div class="main_bet_time">
												<p class="main_bet_time_icon"><img src="/images/bet_icon.png"></p>
												<p class="main_bet_time_text">2017년00월00일<br>00:00</p>
											</div>
											<div class="main_bet_game">
												<div class="main_bet_name">
													<img src="/images/main_bet_name02.jpg">
													<div class="main_bet_name_text">
														<span>레알마드리드</span><br><span>FC 바르셀로나123456</span>
													</div>
												</div>
												<span class="main_bet_btn">베팅하기</span>
											</div>
										</a>
									</div>
									<div class="car__4">
										<a href="#">
											<div class="main_bet_time">
												<p class="main_bet_time_icon"><img src="/images/bet_icon.png"></p>
												<p class="main_bet_time_text">2017년00월00일<br>00:00</p>
											</div>
											<div class="main_bet_game">
												<div class="main_bet_name">
													<img src="/images/main_bet_name03.jpg">
													<div class="main_bet_name_text">
														<span>레알마드리드</span><br><span>FC 바르셀로나123456</span>
													</div>
													
												</div>
												<span class="main_bet_btn">베팅하기</span>
											</div>
										</a>
									</div>
									<div class="car__4">
										<a href="#">
											<div class="main_bet_time">
												<p class="main_bet_time_icon"><img src="/images/bet_icon.png"></p>
												<p class="main_bet_time_text">2017년00월00일<br>00:00</p>
											</div>
											<div class="main_bet_game">
												<div class="main_bet_name">
													<img src="/images/main_bet_name04.jpg">
													<div class="main_bet_name_text">
														<span>레알마드리드</span><br><span>FC 바르셀로나123456</span>
													</div>
												</div>
												<span class="main_bet_btn">베팅하기</span>
											</div>
										</a>
									</div>
									<div class="car__4">
										<a href="#">
											<div class="main_bet_time">
												<p class="main_bet_time_icon"><img src="/images/bet_icon.png"></p>
												<p class="main_bet_time_text">2017년00월00일<br>00:00</p>
											</div>
											<div class="main_bet_game">
												<div class="main_bet_name">
													<img src="/images/main_bet_name05.jpg">
													<div class="main_bet_name_text">
														<span>레알마드리드</span><br><span>FC 바르셀로나123456</span>
													</div>
												</div>
												<span class="main_bet_btn">베팅하기</span>
											</div>
										</a>
									</div>
									<div class="car__4">
										<a href="#">
											<div class="main_bet_time">
												<p class="main_bet_time_icon"><img src="/images/bet_icon.png"></p>
												<p class="main_bet_time_text">2017년00월00일<br>00:00</p>
											</div>
											<div class="main_bet_game">
												<div class="main_bet_name">
													<img src="/images/main_bet_name06.jpg">
													<div class="main_bet_name_text">
														<span>레알마드리드</span><br><span>FC 바르셀로나123456</span>
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
								</div>
							</div>
						</div>
					</div>

			        <div class="contents_in_m20">
						<div class="main_board_wrap">
							<div class="main_title_2">실시간 환전현황</div>
							<div class="main_board">
								<table width="100%" cellpadding="0" cellspacing="0" class="myTable">
									<tbody>
										<tr>
											<td>
												<table width="100%" cellpadding="0" cellspacing="0" class="board_table_1">
													<tr>
														<td class="board_time">2017년00월00일 00:00</td>
														<td class="board_name">*****fdsaf</td>
														<td class="board_money">10,000,000</td>
													</tr>
												</table>									
											</td>
										</tr>
										<tr>
											<td>
												<table width="100%" cellpadding="0" cellspacing="0" class="board_table_1">
													<tr>
														<td class="board_time">2017년00월00일 00:00</td>
														<td class="board_name">*****fdsaf</td>
														<td class="board_money">10,000,000</td>
													</tr>
												</table>									
											</td>
										</tr>
										<tr>
											<td>
												<table width="100%" cellpadding="0" cellspacing="0" class="board_table_1">
													<tr>
														<td class="board_time">2017년00월00일 00:00</td>
														<td class="board_name">*****fdsaf</td>
														<td class="board_money">10,000,000</td>
													</tr>
												</table>									
											</td>
										</tr>
										<tr>
											<td>
												<table width="100%" cellpadding="0" cellspacing="0" class="board_table_1">
													<tr>
														<td class="board_time">2017년00월00일 00:00</td>
														<td class="board_name">*****fdsaf</td>
														<td class="board_money">10,000,000</td>
													</tr>
												</table>									
											</td>
										</tr>
										<tr>
											<td>
												<table width="100%" cellpadding="0" cellspacing="0" class="board_table_1">
													<tr>
														<td class="board_time">2017년00월00일 00:00</td>
														<td class="board_name">*****fdsaf</td>
														<td class="board_money">10,000,000</td>
													</tr>
												</table>									
											</td>
										</tr>
										<tr>
											<td>
												<table width="100%" cellpadding="0" cellspacing="0" class="board_table_1">
													<tr>
														<td class="board_time">2017년00월00일 00:00</td>
														<td class="board_name">*****fdsaf</td>
														<td class="board_money">10,000,000</td>
													</tr>
												</table>									
											</td>
										</tr>
										<tr>
											<td>
												<table width="100%" cellpadding="0" cellspacing="0" class="board_table_1">
													<tr>
														<td class="board_time">2017년00월00일 00:00</td>
														<td class="board_name">*****fdsaf</td>
														<td class="board_money">10,000,000</td>
													</tr>
												</table>									
											</td>
										</tr>
										<tr>
											<td>
												<table width="100%" cellpadding="0" cellspacing="0" class="board_table_1">
													<tr>
														<td class="board_time">2017년00월00일 00:00</td>
														<td class="board_name">*****fdsaf</td>
														<td class="board_money">10,000,000</td>
													</tr>
												</table>									
											</td>
										</tr>
										<tr>
											<td>
												<table width="100%" cellpadding="0" cellspacing="0" class="board_table_1">
													<tr>
														<td class="board_time">2017년00월00일 00:00</td>
														<td class="board_name">*****fdsaf</td>
														<td class="board_money">10,000,000</td>
													</tr>
												</table>									
											</td>
										</tr>
										<tr>
											<td>
												<table width="100%" cellpadding="0" cellspacing="0" class="board_table_1">
													<tr>
														<td class="board_time">2017년00월00일 00:00</td>
														<td class="board_name">*****fdsaf</td>
														<td class="board_money">10,000,000</td>
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
							<script type="text/javascript">
								$(document).ready(function($) {
									 $('#tabs').tabulous({
										effect: 'scale'
									});
									 $('#tabs2').tabulous({
										effect: 'scale'
									});
								});
							</script>
							<div class="main_title_2">실시간 경기목록</div>
							<div id="tabs">
								<ul>
									<li><a href="#tabs-1" title=""><img src="/images/main_icon_game01.png"> 축구</a></li>
									<li><a href="#tabs-2" title=""><img src="/images/main_icon_game02.png"> 농구</a></li>
									<li><a href="#tabs-3" title=""><img src="/images/main_icon_game03.png"> 야구</a></li>
									<li><a href="#tabs-4" title=""><img src="/images/main_icon_game04.png"> 배구</a></li>
									<li><a href="#tabs-5" title=""><img src="/images/main_icon_game05.png"> 하키</a></li>
									<li><a href="#tabs-6" title=""><img src="/images/main_icon_game06.png"> 테니스</a></li>
								</ul>
								<div id="tabs_container">
									<div id="tabs-1">
										<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
											<tr>
												<td width="13%" class="board_table_2_t">시간</td>
												<td width="22%" class="board_table_2_t">홈</td>
												<td width="22%" class="board_table_2_t">원정</td>
												<td width="12%" class="board_table_2_t">승</td>
												<td width="12%" class="board_table_2_t">무</td>
												<td width="12%" class="board_table_2_t">패</td>
												<td width="7%" class="board_table_2_t"></td>
											</tr>
										</table>
										<a href="#">	
											<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
												<tr>
													<td class="board_bet_time">00:00</td>
													<td class="board_bet_home">바르셀로나</td>
													<td class="board_bet_expedition">레알마드리드</td>
													<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
													<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_score">+1</td>
												</tr>
											</table>
										</a>
										<a href="#">	
											<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
												<tr>
													<td class="board_bet_time">00:00</td>
													<td class="board_bet_home">바르셀로나</td>
													<td class="board_bet_expedition">레알마드리드</td>
													<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
													<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_score">+1</td>
												</tr>
											</table>
										</a>
										<a href="#">	
											<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
												<tr>
													<td class="board_bet_time">00:00</td>
													<td class="board_bet_home">바르셀로나</td>
													<td class="board_bet_expedition">레알마드리드</td>
													<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
													<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_score">+1</td>
												</tr>
											</table>
										</a>
										<a href="#">	
											<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
												<tr>
													<td class="board_bet_time">00:00</td>
													<td class="board_bet_home">바르셀로나</td>
													<td class="board_bet_expedition">레알마드리드</td>
													<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
													<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_score">+1</td>
												</tr>
											</table>
										</a>
									</div>
									<div id="tabs-2">
										<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
											<tr>
												<td width="13%" class="board_table_2_t">시간</td>
												<td width="22%" class="board_table_2_t">홈</td>
												<td width="22%" class="board_table_2_t">원정</td>
												<td width="12%" class="board_table_2_t">승</td>
												<td width="12%" class="board_table_2_t">무</td>
												<td width="12%" class="board_table_2_t">패</td>
												<td width="7%" class="board_table_2_t"></td>
											</tr>
										</table>
										<a href="#">	
											<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
												<tr>
													<td class="board_bet_time">00:00</td>
													<td class="board_bet_home">바르셀로나</td>
													<td class="board_bet_expedition">레알마드리드</td>
													<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
													<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_score">+1</td>
												</tr>
											</table>
										</a>
										<a href="#">	
											<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
												<tr>
													<td class="board_bet_time">00:00</td>
													<td class="board_bet_home">바르셀로나</td>
													<td class="board_bet_expedition">레알마드리드</td>
													<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
													<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_score">+1</td>
												</tr>
											</table>
										</a>
										<a href="#">	
											<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
												<tr>
													<td class="board_bet_time">00:00</td>
													<td class="board_bet_home">바르셀로나</td>
													<td class="board_bet_expedition">레알마드리드</td>
													<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
													<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_score">+1</td>
												</tr>
											</table>
										</a>
										<a href="#">	
											<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
												<tr>
													<td class="board_bet_time">00:00</td>
													<td class="board_bet_home">바르셀로나</td>
													<td class="board_bet_expedition">레알마드리드</td>
													<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
													<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_score">+1</td>
												</tr>
											</table>
										</a>
									</div>
									<div id="tabs-3">
										<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
											<tr>
												<td width="13%" class="board_table_2_t">시간</td>
												<td width="22%" class="board_table_2_t">홈</td>
												<td width="22%" class="board_table_2_t">원정</td>
												<td width="12%" class="board_table_2_t">승</td>
												<td width="12%" class="board_table_2_t">무</td>
												<td width="12%" class="board_table_2_t">패</td>
												<td width="7%" class="board_table_2_t"></td>
											</tr>
										</table>
										<a href="#">	
											<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
												<tr>
													<td class="board_bet_time">00:00</td>
													<td class="board_bet_home">바르셀로나</td>
													<td class="board_bet_expedition">레알마드리드</td>
													<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
													<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_score">+1</td>
												</tr>
											</table>
										</a>
										<a href="#">	
											<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
												<tr>
													<td class="board_bet_time">00:00</td>
													<td class="board_bet_home">바르셀로나</td>
													<td class="board_bet_expedition">레알마드리드</td>
													<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
													<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_score">+1</td>
												</tr>
											</table>
										</a>
										<a href="#">	
											<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
												<tr>
													<td class="board_bet_time">00:00</td>
													<td class="board_bet_home">바르셀로나</td>
													<td class="board_bet_expedition">레알마드리드</td>
													<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
													<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_score">+1</td>
												</tr>
											</table>
										</a>
										<a href="#">	
											<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
												<tr>
													<td class="board_bet_time">00:00</td>
													<td class="board_bet_home">바르셀로나</td>
													<td class="board_bet_expedition">레알마드리드</td>
													<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
													<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_score">+1</td>
												</tr>
											</table>
										</a>
									</div>
									<div id="tabs-4">
										소스가 길어져 생략합니다.
									</div>
									<div id="tabs-5">
										소스가 길어져 생략합니다.
									</div>
									<div id="tabs-6">
										소스가 길어져 생략합니다.
									</div>
								</div>
							</div>
						</div>
						<div class="main_board_wrap" style="margin:0px">
							<div class="main_title_2">
								<p style="float:left;">마감임박경기</p>
								<ul class="deadline">
									<li class="time_on"><a href="#">15분전</a></li>
									<li><a href="#">30분전</a></li>
									<li><a href="#">60분전</a></li>
								</ul>
							</div>
							<div id="tabs2">
								<ul>
									<li><a href="#tabs-1" title=""><img src="/images/main_icon_game01.png"> 축구</a></li>
									<li><a href="#tabs-2" title=""><img src="/images/main_icon_game02.png"> 농구</a></li>
									<li><a href="#tabs-3" title=""><img src="/images/main_icon_game03.png"> 야구</a></li>
									<li><a href="#tabs-4" title=""><img src="/images/main_icon_game04.png"> 배구</a></li>
									<li><a href="#tabs-5" title=""><img src="/images/main_icon_game05.png"> 하키</a></li>
									<li><a href="#tabs-6" title=""><img src="/images/main_icon_game06.png"> 테니스</a></li>
								</ul>
								<div id="tabs_container">
									<div id="tabs-1">
										<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
											<tr>
												<td width="13%" class="board_table_2_t">시간</td>
												<td width="22%" class="board_table_2_t">홈</td>
												<td width="22%" class="board_table_2_t">원정</td>
												<td width="12%" class="board_table_2_t">승</td>
												<td width="12%" class="board_table_2_t">무</td>
												<td width="12%" class="board_table_2_t">패</td>
												<td width="7%" class="board_table_2_t"></td>
											</tr>
										</table>
										<a href="#">	
											<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
												<tr>
													<td class="board_bet_time">00:00</td>
													<td class="board_bet_home">바르셀로나</td>
													<td class="board_bet_expedition">레알마드리드</td>
													<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
													<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_score">+1</td>
												</tr>
											</table>
										</a>
										<a href="#">	
											<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
												<tr>
													<td class="board_bet_time">00:00</td>
													<td class="board_bet_home">바르셀로나</td>
													<td class="board_bet_expedition">레알마드리드</td>
													<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
													<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_score">+1</td>
												</tr>
											</table>
										</a>
										<a href="#">	
											<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
												<tr>
													<td class="board_bet_time">00:00</td>
													<td class="board_bet_home">바르셀로나</td>
													<td class="board_bet_expedition">레알마드리드</td>
													<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
													<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_score">+1</td>
												</tr>
											</table>
										</a>
										<a href="#">	
											<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
												<tr>
													<td class="board_bet_time">00:00</td>
													<td class="board_bet_home">바르셀로나</td>
													<td class="board_bet_expedition">레알마드리드</td>
													<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
													<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_score">+1</td>
												</tr>
											</table>
										</a>
									</div>
									<div id="tabs-2">
										<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
											<tr>
												<td width="13%" class="board_table_2_t">시간</td>
												<td width="22%" class="board_table_2_t">홈</td>
												<td width="22%" class="board_table_2_t">원정</td>
												<td width="12%" class="board_table_2_t">승</td>
												<td width="12%" class="board_table_2_t">무</td>
												<td width="12%" class="board_table_2_t">패</td>
												<td width="7%" class="board_table_2_t"></td>
											</tr>
										</table>
										<a href="#">	
											<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
												<tr>
													<td class="board_bet_time">00:00</td>
													<td class="board_bet_home">바르셀로나</td>
													<td class="board_bet_expedition">레알마드리드</td>
													<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
													<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_score">+1</td>
												</tr>
											</table>
										</a>
										<a href="#">	
											<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
												<tr>
													<td class="board_bet_time">00:00</td>
													<td class="board_bet_home">바르셀로나</td>
													<td class="board_bet_expedition">레알마드리드</td>
													<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
													<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_score">+1</td>
												</tr>
											</table>
										</a>
										<a href="#">	
											<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
												<tr>
													<td class="board_bet_time">00:00</td>
													<td class="board_bet_home">바르셀로나</td>
													<td class="board_bet_expedition">레알마드리드</td>
													<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
													<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_score">+1</td>
												</tr>
											</table>
										</a>
										<a href="#">	
											<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
												<tr>
													<td class="board_bet_time">00:00</td>
													<td class="board_bet_home">바르셀로나</td>
													<td class="board_bet_expedition">레알마드리드</td>
													<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
													<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_score">+1</td>
												</tr>
											</table>
										</a>
									</div>
									<div id="tabs-3">
										<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
											<tr>
												<td width="13%" class="board_table_2_t">시간</td>
												<td width="22%" class="board_table_2_t">홈</td>
												<td width="22%" class="board_table_2_t">원정</td>
												<td width="12%" class="board_table_2_t">승</td>
												<td width="12%" class="board_table_2_t">무</td>
												<td width="12%" class="board_table_2_t">패</td>
												<td width="7%" class="board_table_2_t"></td>
											</tr>
										</table>
										<a href="#">	
											<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
												<tr>
													<td class="board_bet_time">00:00</td>
													<td class="board_bet_home">바르셀로나</td>
													<td class="board_bet_expedition">레알마드리드</td>
													<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
													<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_score">+1</td>
												</tr>
											</table>
										</a>
										<a href="#">	
											<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
												<tr>
													<td class="board_bet_time">00:00</td>
													<td class="board_bet_home">바르셀로나</td>
													<td class="board_bet_expedition">레알마드리드</td>
													<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
													<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_score">+1</td>
												</tr>
											</table>
										</a>
										<a href="#">	
											<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
												<tr>
													<td class="board_bet_time">00:00</td>
													<td class="board_bet_home">바르셀로나</td>
													<td class="board_bet_expedition">레알마드리드</td>
													<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
													<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_score">+1</td>
												</tr>
											</table>
										</a>
										<a href="#">	
											<table width="100%" cellpadding="0" cellspacing="0" class="board_table_2">
												<tr>
													<td class="board_bet_time">00:00</td>
													<td class="board_bet_home">바르셀로나</td>
													<td class="board_bet_expedition">레알마드리드</td>
													<td class="board_bet_victory"><img src="/images/arrow_red.gif"> 0.22</td>
													<td class="board_bet_draw"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_loss"><img src="/images/arrow_green.gif"> 3.22</td>
													<td class="board_bet_score">+1</td>
												</tr>
											</table>
										</a>
									</div>
									<div id="tabs-4">
										소스가 길어져 생략합니다.
									</div>
									<div id="tabs-5">
										소스가 길어져 생략합니다.
									</div>
									<div id="tabs-6">
										소스가 길어져 생략합니다.
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
</body>
</html>