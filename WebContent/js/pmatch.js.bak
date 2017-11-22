	
var mainAngular = angular.module('Vava', [ 'ngAnimate', 'vAccordion' ]);
var s=[
		{"PID":0,"u":"center_live.html"},
		{"PID":1,"u":"left_live.html"},
		{"PID":2,"u":"right_bet.html"},
		//{"PID":3,"u":"ws://10.30.42.116:7071"},
		{"PID":3,"u":"ws://103.1.249.79:7071"},
		{"PID":4,"u":"center_pre.html"},
		{"PID":5,"u":"/JSON/period_name.json"},
		{"PID":6,"u":"/JSON/live_status.json"},
		{"PID":7,"u":"jsp/getValidMarketType.jsp"},
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
		{"PID":19,"u":"jsp/setFavMatch.jsp"}
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

mainAngular.filter('sf',function(){

	return function(arr, s){
		if(!s){
			return arr;
		}
		var r = [];		
		s = angular.lowercase(s);
		angular.forEach(arr, function(i){
			if(angular.lowercase(i.HT).indexOf(s) !== -1){
				r.push(i);
			}else if(angular.lowercase(i.AT).indexOf(s) !== -1){
				r.push(i);
			}
		});
		return r;
	};
});
      
mainAngular.controller("mc", function($scope, $templateCache, $compile, $http, wss) {		
	wss.subscribe(function( message) {		
		try {
						
			var obj = JSON.parse(message);				
			switch(obj.Command) {		     	 		   
				case "GetCompetitions": loadGetCompetitions(obj);
					break;							
				case "MatchStat": sub_loadGetMatchStat(obj);
					break;								
				case "GetMatches": loadGetMatch(obj); 
					break;					
				case "MatchUpdate":				
					if(obj.Type == "Match"){
						sub_loadGetMatch(obj);
						
					} else if (obj.Type == "MatchStat") {
						sub_loadGetMatchStat(obj);
						
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
		
	wss.con();
	//console.log("connected")
	
	  $scope.centerTab = s[0].u; 
	  $scope.leftTab = s[1].u; 
	  $scope.rightTab = s[2].u;     
	  $scope.tabSId = "0";	
	  $scope.tabCId = "0";							
	  $scope.tabMId = "0";							
	  $scope.tabMkId = "0" ;						
	  $scope.tabDate = "0" ;						
	  $scope.innerTab = [];
		$scope.selectedSId = 0;
	  $scope.bet=[];
	  $scope.betA = false;
	  $scope.betE = false;
	  $scope.betPrice = 1;
		$scope.betAmt = 100;	
	  $scope.liveTop = [];		
		$scope.PM = [];		
		$scope.PMk = [];
		$scope.PMkC = []; 
		$scope.CID = [];
		$scope.LS = [];
		$scope.LMK = [];	
		$scope.liveMatch = [];
		$scope.liveTop = [];					
		$scope.validMKTypeId =[];	
		$scope.lm =[];
	 
	  $scope.centerTab = s[4].u;    
    $scope.leftTab = s[16].u;    
    
	  //loadLiveMatchInit();
	  PreLoadLiveMatchInit();
	  preLoadPreMatch();
  	 
   	$scope.PMk =[];
  		
  	islive = false;
  	$scope.LMK = [];	
  	$scope.LS = [];	
		$scope.tabMId = "0";    
    $scope.toggleMId = "0";  
    //liveMatchCnt();  
    mode = "PreMatch"; 
	    
    			
	 $scope.goLiveMatch = function (left,center) {	  	
	  	loadLiveMatchInit();
	  	preMatchCnt();  	
	  	islive = true;
			$scope.PMk = [];	
			$scope.tabMId = "0";
			$scope.tabSId ="0";  	 	
	    $scope.centerTab = center;
	    $scope.leftTab = left;
	    mode = "LiveMatch";
	  }

	 $scope.goPreMatch = function (left,center) {	 
	 	

	  	$scope.PMk =[];
	  	$scope.tabCId = $scope.PMc[0].CId;
	  	getMatchInfobyCompetition($scope.tabCId);  	
	  	loadPreMatch();
	  	liveMatchCnt();  	
	  	islive = false;
	  	$scope.LMK = [];	
	  	$scope.LS = [];	
			$scope.tabMId = "0";
	    $scope.centerTab = center;
	    $scope.leftTab = left;    
	    $scope.toggleMId = "0";  
	    mode = "PreMatch";  
	  }
  
	 $scope.goMatchMarket = function (tab,sid,mid) { 
	 		$scope.getMarketbyMatchId(mid);
	 		$scope.getStatusbyMatchId(mid,sid);
	    $scope.centerTab = tab;
	    $scope.topLive = "top_live"+sid+".html";
	    $scope.MK = [];
	    $scope.tabMId = mid; 
	    $scope.tabMkId = "0";  
	    // $scope.leftTab = "left_live.html"; 
	    mode = "LiveMarket";
	  };
	  
		 $scope.goMatchMarketfromPre = function (tab,sid,mid) { 
		 	$scope.leftTab = "left_live.html"; 
		 	$scope.goLiveMatch($scope.leftTab,tab);
		 	
	 		$scope.getMarketbyMatchId(mid);
	 		$scope.getStatusbyMatchId(mid,sid);
	    $scope.centerTab = tab;
	    $scope.topLive = "top_live"+sid+".html";
	    $scope.MK = [];
	    $scope.tabMId = mid; 
	    $scope.tabMkId = "0";  
	    // $scope.leftTab = "left_live.html"; 
	    mode = "LiveMarket";
	  };
 
 
 
	  $scope.goPreMatchMarket = function (tab,ht,at,sid,mid,idx) {	
	    $scope.centerTab = tab;
	    $scope.innerTab = [];
	    $scope.innerTab[idx] = "inner_pre.html";
	    $scope.toggleMId = mid;	      
	    $scope.preHT = ht;
	    $scope.preAT = at;  	    
	    if($scope.tabMId !== mid){
	    	$scope.getMarketbyMatchId($scope.toggleMId);
	    	$scope.tabMId = mid;     	
	    } else{
	    	$scope.tabMId = "0"; 
	    }
	    $scope.MK = [];    
	    $scope.tabMkId = "0";  
	    mode = "PreMatch";
	  };
     
	  $scope.addBet  = function (sd,mkid,sn,st,ht,at,p,bp) { 	

			$scope.betE = true;  	
	  	for(var i = $scope.bet.length - 1; i >= 0; i--){  								
										
					if($scope.bet[i].Sd == sd){
						$scope.bet = $filter('omit')($scope.bet,'Sd ==' + sd);  // delete ID		
						return;
					};
					
					if($scope.bet[i].Mkid == mkid){
						$scope.betA = true;
						return;
					};

			};		
			
	  	$scope.bet.push({
				Sd:sd,
				Mkid:mkid,
	   		Sn:sn,
	   		ST:st,
	   		HT:ht,
	   		AT:at,
	   		P:p,
	   		BP:bp,
			});		
		var element =  document.getElementById("betPrice");
		if(element) element.focus();          
	 };
 
	 $scope.setBet  = function (sd,mkid,sn,st,ht,at,p,bp) { 	
	  	$scope.betE = true;  	
	  	for(var i = $scope.bet.length - 1; i >= 0; i--){  									
				if($scope.bet[i].Mkid == mkid){
					$scope.betA = true;
					return;					
				};
			};		
	  	$scope.bet.push({
	  		Sd:sd,
				Mkid:mkid,
	   		Sn:sn,
	   		ST:st,
	   		HT:ht,
	   		AT:at,
	   		P:p,
	   		BP:bp
			});		
		var element =  document.getElementById("betPrice");
		if(element) element.focus();          
	 };
 
	  $scope.delBet  = function (sd) { 	  	
	  	for(var i = $scope.bet.length - 1; i >= 0; i--){							
				if($scope.bet[i].Sd == sd){
					$scope.bet.splice(i,1);
				};
			};
			
			if($scope.bet.length < 1) $scope.betE = false;	
			else {	
				var element =  document.getElementById("betPrice");
				if(element) element.focus();
			 }
	  };
 
	  $scope.delAllBet  = function () { 	
	  	for(var i = $scope.bet.length - 1; i >= 0; i--){							
						$scope.bet.splice(i,1);
			};	
			$scope.betE = false;
			$scope.betA = false;
	 };
 	 		
	 $scope.conAlert  = function (alert) { 	  	
	  if(alert == "1") $scope.betA = false; 
	 	var element =  document.getElementById("betPrice");
		if(element) element.focus();
	 };

   $scope.getMaketbyCid  = function (left,center,cid) { 	  
  	$scope.centerTab = center;
    $scope.leftTab = left;
    $scope.tabDate = "0";
    $scope.CID = cid;
    //$scope.getMatchInfobyCompetition(cid);
    $scope.PMk =[];
    getMatchInfobyCompetition(cid);
 }

   $scope.preMatchDate = function (left, center,cid,date) {
  	$scope.innerTab = [];  
  	$scope.leftTab = left;
  	$scope.centerTab = center;
  	$scope.tabDate = date;
 }    

	$scope.lm.push({
		t:"실시간",
   	l:s[1].u, //"left_live.html",
   	c:s[0].u // "center_live.html"
	});		
	
	$scope.lm.push({
		t:"스포츠",
   	l:s[16].u, //"left_pre.html",
   	c:s[4].u //"center_pre.html"
	});	
				
	var $filter = angular.injector(['ng', 'Vava']).get('$filter');
	
	$http({
	    url: s[5].u, 
	    method: "GET",
	     headers: {
        'Content-Type': 'utf-8'
       }
    }).success(function(data, status, headers, config) {    	
	    $scope.periodName = data.Objects;
			data = null;
		}).error(function(data, status, headers, config) {
	    $scope.status = status;
	});

	$http({
	    url: s[6].u,
	    method: "GET",
	     headers: {
        'Content-Type': 'utf-8'
       }
    }).success(function(data, status, headers, config) {    	
	    $scope.liveS = data.Objects;
    	data = null;
		}).error(function(data, status, headers, config) {
	    $scope.status = status;
	});

  $http({
			method: 'GET', 
			url: s[7].u, 
			headers: {'Content-Type': 'application/json; charset=utf-8'} 
	}).success(function(data, status, headers, config) {					
		if(data) {
			$scope.validMKTypeId = data;		
		};
		data = null;
	}).error(function(data, status, headers, config) {;
		data = null;
	});
		 
	$http({
			method: 'GET', 
			url: s[8].u, //'jsp/getFavMatch.jsp', 
			params: {'uid':'testuser'},
			headers: {'Content-Type': 'application/json; charset=utf-8'} 
	}).success(function(data, status, headers, config) {
		$scope.favM = [];		
		if(data) {
			angular.forEach(data, function(obj,idx) {
					
				$scope.favM.push({
					Id: obj.Id,
					SId:obj.SId,
					SN:obj.SN,
					CN:obj.CN,
					HT:obj.HT,
					AT:obj.AT,				
					Dt:obj.Dt,
				});				
			});	
		};
		data = null;
		
	}).error(function(data, status, headers, config) {
	});

  function liveMatchCnt() {	  	
  	$scope.LMc = [];  	  	  	
  	for(var i = $scope.LS.length - 1; i >= 0; i--){
  		$scope.LMc.push({
		    	MId : $scope.LS[i].MId,
			});
  	};
  };
  
  function preMatchCnt() {		
  	$scope.PMc = [];  	
  	for(var i = $scope.PM.length - 1; i >= 0; i--){  		
  		$scope.PMc.push({
				CId : $scope.PM[i].CId,
	    	MId : $scope.PM[i].MId,
			});
  	};  	
  	$scope.PM = [];	
  };
  
  
  	function PreLoadLiveMatchInit() {		//market tab
		 $http({
				method: 'GET', 
				url: s[9].u, //'jsp/loadLiveMatchInit.jsp', 
				headers: {'Content-Type': 'application/json; charset=utf-8'} 
		 }).success(function(data, status, headers, config) {
			
			$scope.LMc = [];
			
			angular.forEach(data, function(obj,idx) {				
				
				//console.log(obj.Mt);
				
		    angular.forEach(obj.Mt, function(obj2,i2) {      			
		    	
					$scope.LMc.push({
			    	MId : obj2.Id,
					});			
					
			  });		 		
		 	}); 

			data=null;
				
			}).error(function(data, status, headers, config) {
					console.log(status);
					data=null;
			});
  };
  
 	function loadLiveMatchInit() {		//market tab
		 $http({
				method: 'GET', 
				url: s[9].u, //'jsp/loadLiveMatchInit.jsp', 
				headers: {'Content-Type': 'application/json; charset=utf-8'} 
		 }).success(function(data, status, headers, config) {
			
			$scope.LS = [];
			$scope.LMK = [];		
			$scope.LMKc = [];
			
			angular.forEach(data, function(obj,idx) {				
				if(obj.Mk !== null &&  obj.Mk !== undefined && obj.Mk.length > 0){					
					for (var j = 0; j < obj.Mk.length ; j++) {						
						$scope.LMKc.push(obj.Mk[j]);							
					}
				}
				
		    angular.forEach(obj.Mt, function(obj2,idx2) {       
				
				var mStat = obj.St.filter(function (el) { return el.MId == obj2.Id; })	
				var mResult = obj.Re.filter(function (el) { return el.MId == obj2.Id; })	
				var mSelect = obj.Se.filter(function (el) { return el.MId == obj2.Id; })	
				
				var HTeamScore = "-";
			  var ATeamScore = "-";	
			   			
				if(mStat !== undefined && mStat !== null && mStat.length > 0){			
					HTeamScore = mStat[0].Sc.split(':')[0];
		 			ATeamScore = mStat[0].Sc.split(':')[1]; 
				
				} else {
				 	//return;			 
				};		
											
				if(mResult !== undefined && mResult !== null && mResult.length > 0){				
					var w1Price, w2Price, xPrice  ="-";			
					var w1SelId, xSelId, w2SelId ="";	
					
					for(var i = mSelect.length - 1; i >= 0; i--){
						if(mSelect[i].Nm == 'W1') {
							w1SelId = mSelect[i].Id ;
							w1Price = mSelect[i].P ;					
						} else if(mSelect[i].Nm == 'X') {
							xSelId = mSelect[i].Id ;
							xPrice = mSelect[i].P ;					
						} else if(mSelect[i].Nm == 'W2') {
							w2SelId = mSelect[i].Id ;
							w2Price = mSelect[i].P ;
						}
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
			    	Pe:mStat[0].Pe,
			    	//EType : mMatchStat[0].EventType,
			    	HTS:HTeamScore,
			    	ATS:ATeamScore,
			    	Sus:obj2.Sus,
			    	Cur:(mStat[0].Cur == undefined) ? "" : mStat[0].Cur, //mStat[0].CurrentMinute,
			    	Rem:(mStat[0].Rem == undefined) ? "" : mStat[0].Rem, //mStat[0].RemainingTime,
			    	Inf:mStat.Inf,		    	
					});
			  			  		
					$scope.LMK.push({
			  		SId:obj2.SId,
			  		SN:obj2.SN,	    		
			  		RId:obj2.RId,
			  		RN:obj2.RN,
			  		CId:obj2.CId,
			  		CN:obj2.CN,
			    	MId:obj2.Id,
			    	HT:obj2.HT,
			    	AT:obj2.AT,
			    	Pe:mStat[0].Pe,
			    	HTS:HTeamScore,
			    	ATS:ATeamScore,
			    	//Market : obj.Market,
			    	MkId:mResult[0].Id, 
			    	Sus:mResult[0].Sus, 
			    	Vis:mResult[0].Vis,
			    	Cur:(mStat[0].Cur == undefined) ? "" : mStat[0].Cur, //mStat[0].CurrentMinute,
			    	Rem:(mStat[0].Rem == undefined) ? "" : mStat[0].Rem, //mStat[0].RemainingTime,  
			    	W1SD:w1SelId,
			    	XSD:xSelId,
			    	W2SD:w2SelId,
			    	BW1P:w1Price, 
				    BXP:xPrice,
				    BW2P:w2Price,			      	
			    	W1P:w1Price,
			    	XP:xPrice,
			    	W2P:w2Price,
					});				
				};
			  });
		 		
		 	}); 

			data=null;
				
			}).error(function(data, status, headers, config) {
					console.log(status);
					data=null;
			});
  };

  
 function loadPreMatchInit() {			
		 $http({
				method: 'GET', 
				url: s[10].u,  
				headers: {'Content-Type': 'application/json; charset=utf-8'} 
			}).success(function(data, status, headers, config) {				
			$scope.PMc = [];			
			
			angular.forEach(data, function(obj,idx) {
				if(obj.Id !== undefined && obj.Id !== null && obj.Id.length > 0){
					$scope.PMc.push({
						CId : obj.CId,
					 	MId : obj.Id,			 	
					});	  		
				};
			});
			data=null;
			}).error(function(data, status, headers, config) {
				console.log(status);
				data=null;
			});
 };
 
 function loadPreMatch() {			
		 $http({
				method: 'GET', 
				url: s[17].u, 
				headers: {'Content-Type': 'application/json; charset=utf-8'} 
		}).success(function(data, status, headers, config) {				
		
		if(data) {		
			$scope.PM = [];
			
	    angular.forEach(data, function(obj,idx) {      
				$scope.PM.push({
					SId:obj.SId,
					SN:obj.SN,
					RId:obj.RId,
					RN:obj.RN,
					CId:obj.CId,
					CN:obj.CN,
				 	MId:obj.Id,
				});
		  }); 
		};
		data = null;
		
		}).error(function(data, status, headers, config) {
			console.log(status);
			data = null;
		});
 };

	function preLoadPreMatch() {			
			 $http({
					method: 'GET', 
					url: s[17].u, 
					headers: {'Content-Type': 'application/json; charset=utf-8'} 
			}).success(function(data, status, headers, config) {				
			
			if(data) {		
				$scope.PM = [];
				
		    angular.forEach(data, function(obj,idx) {      
					$scope.PM.push({
						SId:obj.SId,
						SN:obj.SN,
						RId:obj.RId,
						RN:obj.RN,
						CId:obj.CId,
						CN:obj.CN,
					 	MId:obj.Id,
					});
			  }); 
			};
			
			$scope.tabCId = $scope.PM[1].CId;
  		//console.log($scope.tabCId);
  	
  		getMatchInfobyCompetition($scope.tabCId);  	
  	
			data = null;
			
			}).error(function(data, status, headers, config) {
				console.log(status);
				data = null;
			});
	 };
	 
 function subLoadPreMatch(mid) {				
		 $http({
				method: 'GET', 
				url: s[18].u, 
				params: { 'mid' : mid },
				headers: {'Content-Type': 'application/json; charset=utf-8'} 
		}).success(function(data, status, headers, config) {
				
		if(data) {		
			if(data.SId !== undefined && data.SId !== null && data.SId.length > 0){			
				$scope.PM.push({
					SId:data.SId,
					SN:data.SN,
					RId:data.RId,
					RN:data.RN,
					CId:data.CId,
					CN:data.CN,
				 	MId:data.Id,
				});
		  };
		};
		
		data = null;
		
		}).error(function(data, status, headers, config) {
			console.log(status);
			data = null;
		});
 };
 
	$scope.getMarketbyMatchId = function(mid) {	
	   $http({
				method: 'GET', 
				url: s[11].u, 
				params: { 'mid' : mid },
				headers: {'Content-Type': 'application/json; charset=utf-8'} 
		 }).success(function(data, status, headers, config) {		
		 			
			if(data) {
				$scope.MK = [];
				var se_tmp = [];
								
				angular.forEach(data, function(obj,idx) {
						
					if(obj.Sq != undefined){
						$scope.MK.push(obj);	
					}
										
					if(obj.Se != undefined){
						for (var i = 0; i < obj.Se.length; i++) {								
								se_tmp.push(obj.Se[i]);
						};
					};			
				});
				
				for (var k = 0; k < $scope.MK.length; k++) {			
					var s = [];
						
					for (var i = 0; i < se_tmp.length; i++) {								

						if($scope.MK[k].Id == se_tmp[i].MkId){ 				
							s.push(se_tmp[i]);
						};
					};
					$scope.MK[k].Se = s;
				};			
				se_tmp = null;
				s = null;
			};
			data = null;
			
		}).error(function(data, status, headers, config) {
		});
 };

	$scope.getStatusbyMatchId = function(mid,sid) {	
	   $http({
				method: 'GET', 
				url:  s[12].u, 
				params: { 'mid' : mid , 'sid' : sid},
				headers: {'Content-Type': 'application/json; charset=utf-8'} 
		 }).success(function(data, status, headers, config) {		

			if(data) {
								
				if(data.EventId !== undefined && data.EventId !== null && data.EventId.length > 0){
					
					$scope.liveTop = [];
					
					switch(sid) {
		     	 		   
						case "1":					 
				   		$scope.liveTop.push({	
				   			SId : sid,
				   			MId : data.EventId,							   			
				   			CornerScore: data.CornerScore,
					      CurrentMinute: data.CurrentMinute,
					      DangerousAttackScore: data.DangerousAttackScore,
					      EventType: data.EventType,
					      EventTypeId : data.EventTypeId,
					      FreeKickScore: data.FreeKickScore,
					      Id: data.Id,
					      Info: data.Info,
					      //IsTimeout: IsTimeout
					      //MatchLength: 90,
					      PenaltyScore: data.PenaltyScore,
					      Period: data.Period,
					      RedcardScore: data.RedcardScore,
					      Score: data.Score,
					      Set1CornerScore: data.Set1CornerScore,
					      Set1RedCardScore: data.Set1RedCardScore,
					      Set1Score: data.Set1Score,
					      Set1YellowCardScore: data.Set1YellowCardScore,
					      Set2CornerScore: data.Set2CornerScore,
					      Set2RedCardScore: data.Set2RedCardScore,
					      Set2Score: data.Set2Score,
					      Set2YellowCardScore: data.Set2YellowCardScore,
					      Set3Score: data.Set3Score,
					      Set4Score: data.Set4Score,
					      Set5Score: data.Set5Score,
					      ShotOffTargetScore: data.ShotOffTargetScore,
					      ShotOnTargetScore: data.ShotOnTargetScore,
					      //SportKind: 1,
					      YellowcardScore: data.YellowcardScore,   
					      Side: data.Side, 	
				  		});								  		
						break;
					
					case "2": 	
			   		$scope.liveTop.push({
			   			SId : sid,
			      	MId : data.EventId,			      	
				      EventType: data.EventType,
				      EventTypeId : data.EventTypeId,
				      ExtraTimeScore: data.ExtraTimeScore,
				      Info: data.Info,
				      Period: data.Period,
				      PeriodScore: data.PeriodScore,
				      RemainingTime: data.RemainingTime,
				      Score: data.Score,
				      Server: data.Server,
				      Set1Score: data.Set1Score,
				      Set2Score: data.Set2Score,
				      Set3Score: data.Set3Score,
				      Side: data.Side,
		  		});								  		
	  			break;
	  			
	  			case "3": 	
			   		$scope.liveTop.push({			 
			   			SId : sid,  			
			      	MId : data.EventId,			      	
				      EventType: data.EventType,
				      EventTypeId : data.EventTypeId,
				      ExtraTimeScore: data.ExtraTimeScore,
				      Info: data.Info,
				      Period: data.Period,
				      //PeriodLength: 10,
				      QuarterScore: data.QuarterScore,
				      RemainingTime: data.RemainingTime,
				      Score: data.Score,
				      Server: data.Server,
				      Set1Score: data.Set1Score,
				      Set2Score: data.Set2Score,
				      Set3Score: data.Set3Score,
				      Set4Score: data.Set4Score,
				      Set5Score: data.Set5Score,
				      Side: data.Side,
			  		});								  		
			  		
		  			break;
		  				  			
					case "4": 						
						$scope.liveTop.push({
							SId : sid,
			      	MId : data.EventId,				      	
			      	AcesScore: data.AcesScore,
				      DoubleFaultScore:data.DoubleFaultScore,
				      //EventTimeUtc: "2017-09-05T05:00:58.1542701",
				      EventType: data.EventType,
				      EventTypeId : data.EventTypeId,
				      //EventTypeId: 206,
				      GameScore: data.GameScore,
				      //Id: 129439219,
				      Info: data.Info, //"1:0, (6:4), (3:1) 30:15*;",
				      Period: data.Period,
				      Score: data.Score,
				      Server: data.Server,
				      Set1Score: data.Set1Score,
				      Set2Score: data.Set2Score,
				      Set3Score: data.Set3Score,
				      Set4Score: data.Set4Score,
				      Set5Score: data.Set5Score,
				      SetCount: data.SetCount, //3,
				      SetScore: data.SetScore, //"3:1",
				      Side: data.Side,      	
						});		
					break;
					
					case "5": 	
			   		$scope.liveTop.push({
			   			SId : sid,
			      	MId : data.EventId,			      	
			      	EventType: data.EventType,
			      	EventTypeId : data.EventTypeId,
				      Info: data.Info,
				      //IsTimeout: true,
				      Period: data.Period,
				      PeriodScore: data.PeriodScore,
				      Score: data.Score,
				      Server: data.Server,
				      Set1Score: data.Set1Score,
				      Set2Score: data.Set2Score,
				      Set3Score: data.Set3Score,
				      Set4Score: data.Set4Score,
				      Set5Score: data.Set5Score,
				      Side: data.Side,
				      SportKind: data.SportKind,   	
			  		});								  		
		  			break;
					
					case "6": 	
			   		$scope.liveTop.push({
			   			SId : sid,
			      	MId : data.EventId,			      	
			      	EventType: data.EventType,
			      	EventTypeId : data.EventTypeId,
				      Info: data.Info,
				      //IsTimeout: true,
				      Period: data.Period,
				      PeriodScore: data.PeriodScore,
				      Score: data.Score,
				      Server: data.Server,
				      Set1Score: data.Set1Score,
				      Set2Score: data.Set2Score,
				      Set3Score: data.Set3Score,
				      Set4Score: data.Set4Score,
				      Set5Score: data.Set5Score,
				      Side: data.Side,
				      SportKind: data.SportKind,   	
			  		});								  		
		  			break;
		  			
					case "11": 	
			   		$scope.liveTop.push({
			   			SId : sid,
			      	MId : data.EventId,			      	
			      	EventType: data.EventType,
			      	EventTypeId : data.EventTypeId,
				      Info: data.Info,
				       //IsTimeout: true,
				      Period: data.Period,
				      Score: data.Score,
				      Set1Score: data.Set1Score,
				      Set2Score: data.Set2Score,
				      Set3Score: data.Set3Score,
				      Set4Score: data.Set4Score,
				      Set5Score: data.Set5Score,
				      Set6Score: data.Set6Score,
				      Set7Score: data.Set7Score,
				      Set8Score: data.Set8Score,
				      Set9Score: data.Set9Score,
				      Set10Score: data.Set10Score,
				      Side: data.Side,	  	
			  		});								  		
		  			break;
		  		
					}; //end switch     		
			};
		};
			
			data = null;
			
		}).error(function(data, status, headers, config) {
			console.log(status);
			data = null;
		});
 };
 	

 	function getMarketbyMarketId(mkid){	  	
	   $http({
				method: 'GET', 
				url: s[13].u, 
				params: { 'mkid' : mkid },
				headers: {'Content-Type': 'application/json; charset=utf-8'} 
		}).success(function(data, status, headers, config) {
			
			if(data.Id !== undefined && data.Id !== null && data.Id.length > 0){
				
				if(data.Se != undefined){	
					$scope.MK.push(data);					
				};
			};
			data = null;
			
		}).error(function(data, status, headers, config) {
			console.log(status);
			data = null;
		});
 }
 
  function subLoadLiveMatch(mid) {
	   $http({
				method: 'GET', 
				url:s[14].u,//'jsp/subLoadLiveMatch.jsp',
				params: { 'mid' : mid },
				headers: {'Content-Type': 'application/json; charset=utf-8'} 
		}).success(function(data, status, headers, config) {
				
				console.log(data);
				console.log(data[0].Mt);
				//console.log(data[0].Mt.Id);
				console.log(data[0].Mk);
				console.log(data[0].St);
				console.log(data[0].Re);
				console.log(data[0].Se);
				
				console.log(data[0].Mt[0]);
				console.log(data[0].Mt[0].Id);
				console.log(data[0].Mk[0]);
				console.log(data[0].St[0]);
				console.log(data[0].Re[0]);
				console.log(data[0].Se[0]);
				//console.log(data[0].Se[0].Selections[0]);
				
				console.log("data[0].Market.length : " + data[0].Mk.length);
				console.log("data[0].Result.length : " + data[0].Re.length);
				console.log("data[0].Selections.length : " + data[0].Se.length);
				
				if(data[0].Mk !== undefined && data[0].Mk !== null && data[0].Mk.length > 0){
					for (var j = 0; j < data[0].Mk.length ; j++) {						
						$scope.LMKc.push(data[0].Mk[j]);							
					}
				}
								
				if(data[0].Re !== undefined && data[0].Re !== null && data[0].Re.length > 0){					
					var w1Price, w2Price, xPrice="-";					
					var w1SelId, xSelId, w2SelId ="";			
			    
			    for(var i = data[0].Se.length - 1; i >= 0; i--){						
						if(data[0].Se[i].Nm=='W1') {
							w1SelId = data[0].Se[i].Id ;
							w1Price = data[0].Se[i].P ;
						
						} else if(data[0].Se[i].Nm=='X') {
							xSelId = data[0].Se[i].Id ;
							xPrice = data[0].Se[i].P ;
						
						} else if(data[0].Se[i].Nm=='W2') {
							w2SelId = data[0].Se[i].Id ;
							w2Price = data[0].Se[i].P ;
						}
					};
					
			   	$scope.LS.push({
			  		SId:data[0].Mt[0].SId,
			  		SN:data[0].Mt[0].SN,	    		
			  		RId:data[0].Mt[0].RId,
			  		RN:data[0].Mt[0].RN,
			  		CId:data[0].Mt[0].CId,
			  		CN:data[0].Mt[0].CN,
			    	MId:data[0].Mt[0].Id,
			    	HT:data[0].Mt[0].HT,
			    	AT:data[0].Mt[0].AT,
			    	Pe:"0",
			    	//EType : mMatchStat[0].EventType,
			    	HTS:"0",
			    	ATS:"0",
			    	Sus:data[0].Mt[0].Sus,
			    	Cur:"",
			    	Rem:"",
			    	Inf:"",			    	
					});
			  			  		
					$scope.LMK.push({
			  		SId:data[0].Mt[0].SId,
			  		SN:data[0].Mt[0].SN,	    		
			  		RId:data[0].Mt[0].RId,
			  		RN:data[0].Mt[0].RN,
			  		CId:data[0].Mt[0].CId,
			  		CN:data[0].Mt[0].CN,
			    	MId:data[0].Mt[0].Id,
			    	HT:data[0].Mt[0].HT,
			    	AT:data[0].Mt[0].AT,
			    	Pe:"0", //(data[0].Stat[0].Period == undefined) ? "0" : data[0].Stat[0].Period, //mStat[0].CurrentMinute, data[0].Stat[0].Period, data[0].Stat[0].Period,
			    	HTS:"0",
			    	ATS:"0",
			    	//Market : obj.Market,
			    	MkId:data[0].Re[0].Id, 
			    	Sus:data[0].Re[0].Sus, 
			    	Vis:data[0].Re[0].Vis,
			    	Cur:"", //(data[0].Stat[0].CurrentMinute == undefined) ? "" : data[0].Stat[0].CurrentMinute, //mStat[0].CurrentMinute,
			    	Rem:"", //(data[0].Stat[0].RemainingTime == undefined) ? "" : data[0].Stat[0].RemainingTime, //mStat[0].RemainingTime,  
			    	W1SD:w1SelId,
			    	XSD:xSelId,
			    	W2SD:w2SelId,
			    	BW1P:w1Price, 
				    BXP:xPrice,
				    BW2P:w2Price,			      	
			    	W1P:w1Price,
			    	XP:xPrice,
			    	W2P:w2Price,
					});
				}				
				data = null;
		}).error(function(data, status, headers, config) {
				console.log(status);
				data = null;
		});
 };
 
 	function getMatchInfobyCompetition(cid) {	      	      
	   $http({
				method: 'GET', 
				url: s[15].u, 
				params: { 'cid' : cid },
				headers: {'Content-Type': 'application/json; charset=utf-8'} 
		}).success(function(data, status, headers, config) {					
			$scope.PMkC = [];
			$scope.PMk = [];
			$scope.tabCId = cid;

			if(data[0].Mk !== null &&  data[0].Mk !== undefined && data[0].Mk.length > 0){					
				for (var j = 0; j < data[0].Mk.length ; j++) {						
					$scope.PMkC.push(data[0].Mk[j]);							
				}
			};		
			if(data[0].Mt !== null &&  data[0].Mt !== undefined && data[0].Mt.length > 0){
				
				for (var j = 0; j < data[0].Mt.length ; j++) {										
					var w1Price, w2Price, xPrice ="-";
					var w1SelId, xSelId, w2SelId ="";										
					var mMatchResult = data[0].Re.filter(function (el) { return el.MId == data[0].Mt[j].Id; });	
															
					if(mMatchResult !== null && mMatchResult !== undefined && mMatchResult.length > 0 ){
						var mResult = data[0].Se.filter(function (el) { return el.MkId == mMatchResult[0].Id });
						
						for (var i = 0; i < mResult.length; i++) {								
							if(mResult[i].Nm == 'W1') {
								w1SelId = mResult[i].Id ;
								w1Price = mResult[i].P;
							
							} else if(mResult[i].Nm == 'X'){
								xSelId = mResult[i].Id ;
								xPrice = mResult[i].P;
							
							} else if(mResult[i].Nm == 'W2'){
								w2SelId = mResult[i].Id ;
								w2Price = mResult[i].P;
							}
						};
			  									  			  		
			  		$scope.PMk.push({
			    		SId:data[0].Mt[j].SId,
			    		SN:data[0].Mt[j].SN,	    		
			    		RId:data[0].Mt[j].RId,
			    		RN:data[0].Mt[j].RN,
			    		CId:data[0].Mt[j].CId,
			    		CN:data[0].Mt[j].CN,
			      	MId:data[0].Mt[j].Id,
			      	Dt:data[0].Mt[j].Dt,
			      	HT:data[0].Mt[j].HT,
			      	AT:data[0].Mt[j].AT,				      	
			      	//Market : mMatchMarket, //obj.Market.filter(function (el) { return el.MatchId == obj.Match[j].Id; }), //; obj.Match.Market, //marketId,
			      	MkId:mMatchResult[0].Id, //marketId,
			      	Sus:mMatchResult[0].Sus, // IsSuspended,	
			      	//IsSuspendedR: obj.Result[0].IsSuspended, // IsSuspended,	    	
			      	W1SD:w1SelId,
	    				XSD:xSelId,
	    				W2SD:w2SelId,	
			      	BW1P:w1Price, 
					    BXP:xPrice,
					    BW2P:w2Price,			      	
			      	W1P:w1Price,
			      	XP:xPrice,
			      	W2P:w2Price,
			  		});			  		

			  	}else{
			  		
			  		$scope.PMk.push({
			    		SId:data[0].Mt[j].SId,
			    		SN:data[0].Mt[j].SN,	    		
			    		RId:data[0].Mt[j].RId,
			    		RN:data[0].Mt[j].RN,
			    		CId:data[0].Mt[j].CId,
			    		CN:data[0].Mt[j].CN,
			      	MId:data[0].Mt[j].Id,
			      	Dt:data[0].Mt[j].Dt,
			      	HT:data[0].Mt[j].HT,
			      	AT:data[0].Mt[j].AT,				      	
			      	//Market : mMatchMarket, //obj.Market, //marketId,
			      	MkId:null, //marketId,
			      	Sus:true, // IsSuspended,	
			      	//IsSuspendedR: obj.Result[0].IsSuspended, // IsSuspended,	   
			      	W1SD:"0",
	    				XSD:"0",
	    				W2SD:"0",	 	
			      	BW1P:"0", 
					    BXP:"0",
					    BW2P:"0",			      	
			      	W1P:"0",
			      	XP:"0",
			      	W2P:"0",
				  		});	
			  		}
		  				  	
		    };
		     
	  	};
			data = null;				
			}).error(function(data, status, headers, config) {
				console.log(status);
				data = null;	
			});
 }
  	
	function finishLiveMatch(mid) {		
		$scope.LS = $filter('omit')($scope.LS,'MId ==' + mid);  // delete ID					
		$scope.LMK = $filter('omit')($scope.LMK,'MId ==' + mid);  // delete ID			
		$scope.MK = $filter('omit')($scope.MK,'MId ==' + mid);  // delete ID			
		$scope.LMKc = $filter('omit')($scope.LMKc,'M ==' + mid);  // delete ID	
		//check favorite match and bet match
	}

	function sub_loadGetMatchMarket(response) {		

		angular.forEach(response.Objects, function(obj,idx) {					
			var v_market = $scope.validMKTypeId.indexOf(obj.MarketTypeId);				
			if (v_market < 0){		
					return;  //un-used MarketTypeId
			}; 
		
			if(mode == "LiveMatch" || mode == "LiveMarket"){				
				var nMK = true;
											
				for (var a=0; a<$scope.LMKc.length; a++) {
					if($scope.LMKc[a].Id == obj.Id){						
						nMK = false;						
						$scope.LMKc[a].S = obj.IsSuspended;
						$scope.LMKc[a].V = obj.IsVisible;
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
					
				};
			};						
				
			if(mode == "LiveMatch"){	
				
				for (var c = 0; c < $scope.LMK.length; c++) {			 		
			 		var lm = $scope.LMK[c];	
			 				 		
				 	if(lm.MkId == obj.Id){					 		
				 		var w1Price, w2Price, xPrice ="-";
						var w1SelId, xSelId, w2SelId  ="";
										
		    		for (var j = 0; j < obj.Selections.length; j++) {
							
			    		if(obj.Selections[j].Name == 'W1') {
			    			w1SelId = obj.Selections[j].Id ;
			    			w1Price = obj.Selections[j].Price ;
			    		
			    		} else if(obj.Selections[j].Name == 'X') {
								xSelId = obj.Selections[j].Id ;
								xPrice = obj.Selections[j].Price ;
							
							} else if(obj.Selections[j].Name == 'W2') {
								w2SelId = obj.Selections[j].Id ;
								w2Price = obj.Selections[j].Price ;
							}
						};
	      									
						if(w1Price != lm.W1P || xPrice != lm.XP || w2Price != lm.W2P ||  lm.Sus != obj.IsSuspended){							
							$scope.LMK = $filter('omit')($scope.LMK,'MkId ==' + obj.Id);  								
			        $scope.LMK.push({
				    		SId:lm.SId,
				    		SN:lm.SN,	    		
				    		RId:lm.RId,
				    		RN:lm.RN,
				    		CId:lm.CId,
				    		CN:lm.CN,
				      	MId:lm.MId,
				      	HT:lm.HT,
				      	AT:lm.AT,
				      	Pe:lm.Pe,
				      	HTS:lm.HTS,
				      	ATS:lm.ATS,
				      	//Market : market_tmp,
				      	MkId:obj.Id,
		      			Sus:obj.IsSuspended,
		      			Vis:obj.IsVisible,
		      			Cur:lm.Cur,
								Rem:lm.Rem,	
								W1SD:w1SelId,
								XSD:xSelId,
								W2SD:w2SelId,		    	
		      			BW1P:lm.W1P,
				      	BXP:lm.XP,
				      	BW2P:lm.W2P,			      	
				      	W1P:w1Price,
				      	XP:xPrice,
				      	W2P:w2Price,
			  			});
				  	};				  						 
					};						
				};
			}
			
			if(mode == "PreMatch"){	
				
				for (var c = 0; c < $scope.PMK.length; c++) {		
							
			 		var pm = $scope.PMK[c];	
			 				 		
				 	if(pm.MkId == obj.Id){					 		
				 		var w1Price, w2Price, xPrice ="-";
						var w1SelId, xSelId, w2SelId  ="";
										
		    		for (var j = 0; j < obj.Selections.length; j++) {
							
			    		if(obj.Selections[j].Name == 'W1') {
			    			w1SelId = obj.Selections[j].Id ;
			    			w1Price = obj.Selections[j].Price ;
			    		
			    		} else if(obj.Selections[j].Name == 'X') {
								xSelId = obj.Selections[j].Id ;
								xPrice = obj.Selections[j].Price ;
							
							} else if(obj.Selections[j].Name == 'W2') {
								w2SelId = obj.Selections[j].Id ;
								w2Price = obj.Selections[j].Price ;
							}
						};
	      									
						if(w1Price != pm.W1P || xPrice != pm.XP || w2Price != pm.W2P ||  pm.Sus != obj.IsSuspended){							
							$scope.PMK = $filter('omit')($scope.PMK,'MkId ==' + obj.Id);  								
			        $scope.PMK.push({
				    		SId:pm.SId,
				    		SN:pm.SN,	    		
				    		RId:pm.RId,
				    		RN:pm.RN,
				    		CId:pm.CId,
				    		CN:pm.CN,
				      	MId:pm.MId,
				      	HT:pm.HT,
				      	AT:pm.AT,
				      	//Pe:pm.Pe,
				      	//HTS:pm.HTS,
				      	//ATS:pm.ATS,
				      	//Market : market_tmp,
				      	MkId:obj.Id,
		      			Sus:obj.IsSuspended,
		      			//Vis:obj.IsVisible,
		      			//Cur:lm.Cur,
								//Rem:lm.Rem,	
								W1SD:w1SelId,
								XSD:xSelId,
								W2SD:w2SelId,		    	
		      			BW1P:lm.W1P,
				      	BXP:lm.XP,
				      	BW2P:lm.W2P,			      	
				      	W1P:w1Price,
				      	XP:xPrice,
				      	W2P:w2Price,
			  			});
				  	};				  						 
					};						
				};
			}
				
				
				
			if($scope.tabMId !="0" && $scope.tabMId == obj.MatchId){			
				var newCmarket = true;	
				
				for (var d = 0; d < $scope.MK.length; d++) {
					var mk = $scope.MK[d];		
									
						if(mk.Id == obj.Id){															
							newCmarket = false;															
							var sel_tmp = [];	
																												
			    		for (var j = 0; j < obj.Selections.length; j++) {				    					    			
			    			for (var n = 0; n < mk.Se.length; n++) {						    				    				
			    				if(obj.Selections[j].Id == mk.Se[n].Id) {			    					
					    			sel_tmp.push({
												BP:mk.Se[n].BP,
												Id:obj.Selections[j].Id,
												MkId:mk.Se[n].MkId,
												Nm:mk.Se[n].Nm,
												Or:obj.Selections[j].Order,
												P:obj.Selections[j].Price,													
										});										
									};
								};
							};
						
							$scope.MK = $filter('omit')($scope.MK,'Id ==' + obj.Id);  	
							
							$scope.MK.push({
								Id:mk.Id,
								MTyId:mk.MTyId,
								Sus: obj.IsSuspended,
								Vis: obj.IsVisible, 
								MId: mk.MId,
								Nm: mk.Nm,
								Se: sel_tmp,
								Sq: obj.Sequence,
							});										
					   sel_tmp = [];
				  	}
				 };
				 
			  if(newCmarket && obj.IsVisible){ 		 		
				  		getMarketbyMarketId(obj.Id);		
			  };
			};

			for(var r = $scope.bet.length - 1;r >= 0; r--){					
					var betMk = $scope.bet[r];			
											
					if(betMk.Mkid == obj.Id){																
						for (var j = 0; j < obj.Selections.length; j++) {		    					    				
		    				if(obj.Selections[j].Id == betMk.Sd) {
									$scope.bet[r].P = obj.Selections[j].Price;							
								};
						};	
					};
			};				
		});			
	};

	function sub_loadGetMatchStat(res) { 	 	            
		  	
  	angular.forEach(res.Objects, function(obj,idx) {			
  					
			if(mode == "LiveMatch"){ 	
		  	
		  	angular.forEach($scope.LS, function(LS_obj,i2) {
		  			
		  		if (LS_obj.MId == obj.EventId){		
		  						  					  							  				
	  				if(obj.Score !== undefined && obj.Score !== null && obj.Score.length > 0){	  						 			
							var HTS = obj.Score.split(':')[0];
		   				var ATS = obj.Score.split(':')[1];
	   				} else{	   					
	   					var HTS = LS_obj.HTS;
		   				var ATS = LS_obj.ATS;
	   				}
	   								  		
			  		if(HTS != LS_obj.HTS || ATS != LS_obj.ATS || obj.Period != LS_obj.Pe || obj.CurrentMinute != LS_obj.Cur || obj.RemainingTime != LS_obj.Rem){  	 
			  			  					
		   				$scope.LS.splice(i2,1);						   						
		   				
				   		$scope.LS.push({
				    		SId:LS_obj.SId,
				    		SN:LS_obj.SN,	    		
				    		RId:LS_obj.RId,
				    		RN:LS_obj.RN,
				    		CId:LS_obj.CId,
				    		CN:LS_obj.CN,
				      	MId:LS_obj.MId,
				      	HT:LS_obj.HT,
				      	AT:LS_obj.AT,
				      	Pe:obj.Period,				      	
				      	//GScore : GameScore,
				      	//EType : obj.EventType,	
				      	HTS:HTS,
				      	ATS:ATS,
				      	Sus:obj.IsSuspended,		
				      	Cur:(obj.CurrentMinute == undefined) ? "" : obj.CurrentMinute,
	    					Rem:(obj.RemainingTime == undefined) ? "" : obj.RemainingTime, //RemainingTime : obj.RemainingTime,
				      	Inf:obj.Info,	      	
				  		});
			  				  			
			  			angular.forEach($scope.LMK, function(LMK_obj,i3) {
			  									 
								if (LMK_obj.MId == obj.EventId){					  			
					  			$scope.LMK[i3].HTS = HTS;
					  			$scope.LMK[i3].ATS = ATS;
					  			$scope.LMK[i3].Pe = obj.Period;
					  			$scope.LMK[i3].Cur = (obj.CurrentMinute == undefined) ? "" : obj.CurrentMinute; //obj.CurrentMinute;
					  			$scope.LMK[i3].Rem = (obj.RemainingTime == undefined) ? "" : obj.RemainingTime; //obj.RemainingTime;
					  										  							  		
				  			};
				  		});
			  		};
				  		
				  };
				}); 
			
			} else if(mode == "LiveMarket"){ 	
    					  	
		  	angular.forEach($scope.LS, function(LS_obj,i2) {
		  				  			 	
		  		if (LS_obj.MId == obj.EventId){			  			
		  						  					  				
	  				if(obj.Score !== undefined && obj.Score !== null && obj.Score.length > 0){	  								  					
			  			var HTS=obj.Score.split(':')[0];
		   				var ATS=obj.Score.split(':')[1];	   				
	   				} else{	   					
	   					var HTS = LS_obj.HTS;
		   				var ATS = LS_obj.ATS;
	   				}
		   			
		   			if(HTS != LS_obj.HTS || ATS != LS_obj.ATS || obj.Period != LS_obj.Pe || obj.CurrentMinute != LS_obj.Cur || obj.RemainingTime != LS_obj.Rem){  //updated score or period
	   				
		   				$scope.LS.splice(i2,1);			
			   						
				   		$scope.LS.push({
				    		SId:LS_obj.SId,
				    		SN:LS_obj.SN,	    		
				    		RId:LS_obj.RId,
				    		RN:LS_obj.RN,
				    		CId:LS_obj.CId,
				    		CN:LS_obj.CN,
				      	MId:LS_obj.MId,
				      	HT:LS_obj.HT,
				      	AT:LS_obj.AT,
				      	Pe:obj.Period,				      	
				      	//GScore : GameScore,
				      	//EType : obj.EventType,	
				      	HTS:HTS,
				      	ATS:ATS,
				      	Sus:obj.IsSuspended,		
				      	Cur:(obj.CurrentMinute == undefined) ? "" : obj.CurrentMinute, //obj.CurrentMinute,
	    					Rem:(obj.RemainingTime == undefined) ? "" : obj.RemainingTime, //obj.RemainingTime,
				      	Inf:obj.Info,	      	
				  		});
			  		};
			  						   				
   					if ($scope.tabMId == obj.EventId){   						
	   					$scope.liveTop.splice(0,1);		   				
		   				switch(obj.SportKind) {     	 		   
							case 1: 
					   		$scope.liveTop.push({							   			
					   			CornerScore: obj.CornerScore,
						      CurrentMinute: obj.CurrentMinute,
						      DangerousAttackScore: obj.DangerousAttackScore,
						      EventType: obj.EventType,
						      EventTypeId : obj.EventTypeId,
						      FreeKickScore: obj.FreeKickScore,
						      Id: obj.Id,
						      Info: obj.Info,
						      //IsTimeout: IsTimeout
						      //MatchLength: 90,
						      PenaltyScore: obj.PenaltyScore,
						      Period: obj.Period,
						      RedcardScore: obj.RedcardScore,
						      Score: obj.Score,
						      Set1CornerScore: obj.Set1CornerScore,
						      Set1RedCardScore: obj.Set1RedCardScore,
						      Set1Score: obj.Set1Score,
						      Set1YellowCardScore: obj.Set1YellowCardScore,
						      Set2CornerScore: obj.Set2CornerScore,
						      Set2RedCardScore: obj.Set2RedCardScore,
						      Set2Score: obj.Set2Score,
						      Set2YellowCardScore: obj.Set2YellowCardScore,
						      Set3Score: obj.Set3Score,
						      Set4Score: obj.Set4Score,
						      Set5Score: obj.Set5Score,
						      ShotOffTargetScore: obj.ShotOffTargetScore,
						      ShotOnTargetScore: obj.ShotOnTargetScore,
						      //SportKind: 1,
						      YellowcardScore: obj.YellowcardScore,
						      Side: obj.Side,    	
					  	});								  		
				  		break;
				  			
				  		case 2: 					  								  		
					   		$scope.liveTop.push({
					      	MId : obj.EventId,			      	
						      EventType: obj.EventType,
						      EventTypeId : obj.EventTypeId,
						      ExtraTimeScore: obj.ExtraTimeScore,
						      Info: obj.Info,
						      Period: obj.Period,
						      //PeriodLength: 10,
						      PeriodScore: obj.PeriodScore,
						      RemainingTime: obj.RemainingTime,
						      Score: obj.Score,
						      Server: obj.Server,
						      Set1Score: obj.Set1Score,
						      Set2Score: obj.Set2Score,
						      Set3Score: obj.Set3Score,
						      Side: obj.Side,
				  		});								  		
			  			break;
			  			
			  			case 3: 				  			
					   		$scope.liveTop.push({
					      	MId : obj.EventId,			      	
						      EventType: obj.EventType,
						      EventTypeId : obj.EventTypeId,
						      ExtraTimeScore: obj.ExtraTimeScore,
						      Info: obj.Info,
						      Period: obj.Period,
						      //PeriodLength: 10,
						      QuarterScore: obj.QuarterScore,
						      RemainingTime: obj.RemainingTime,
						      Score: obj.Score,
						      Server: obj.Server,
						      Set1Score: obj.Set1Score,
						      Set2Score: obj.Set2Score,
						      Set3Score: obj.Set3Score,
						      Set4Score: obj.Set4Score,
						      Set5Score: obj.Set5Score,
						      Side: obj.Side,
				  		});						
	
			  			break;
			  			
			  			case 4: 	
				   		$scope.liveTop.push({
				      	MId : obj.EventId,			      	
				      	AcesScore: obj.AcesScore,
					      DoubleFaultScore:obj.DoubleFaultScore,
					      EventType: obj.EventType,
					      EventTypeId : obj.EventTypeId,
					      GameScore: obj.GameScore,
					      Info: obj.Info, 
					      Period: obj.Period,
					      Score: obj.Score,
					      Server: obj.Server,
					      Set1Score: obj.Set1Score,
					      Set2Score: obj.Set2Score,
					      Set3Score: obj.Set3Score,
					      Set4Score: obj.Set4Score,
					      Set5Score: obj.Set5Score,
					      SetCount: obj.SetCount, 
					      SetScore: obj.SetScore, 
					      Side: obj.Side,      	
				  		});								  		
			  			break;
				  			
			  			case 5: 	
				   		$scope.liveTop.push({
				      	MId : obj.EventId,			      	
				      	EventType: obj.EventType,
				      	EventTypeId : obj.EventTypeId,
					      Info: obj.Info,
					      //IsTimeout: true,
					      Period: obj.Period,
					      PeriodScore: obj.PeriodScore,
					      Score: obj.Score,
					      Server: obj.Server,
					      Set1Score: obj.Set1Score,
					      Set2Score: obj.Set2Score,
					      Set3Score: obj.Set3Score,
					      Set4Score: obj.Set4Score,
					      Set5Score: obj.Set5Score,
					      Side: obj.Side,  	
				  		});								  		
			  			break;
				  		
				  		case 6: 	
				   		$scope.liveTop.push({
				      	MId : obj.EventId,			      	
				      	EventType: obj.EventType,
				      	EventTypeId : obj.EventTypeId,
					      Info: obj.Info,
					      //IsTimeout: true,
					      Period: obj.Period,
					      PeriodScore: obj.PeriodScore,
					      Score: obj.Score,
					      Server: obj.Server,
					      Set1Score: obj.Set1Score,
					      Set2Score: obj.Set2Score,
					      Set3Score: obj.Set3Score,
					      Set4Score: obj.Set4Score,
					      Set5Score: obj.Set5Score,
					      Side: obj.Side,  	
				  		});								  		
			  			break;
			  			
				  		case 11: 	
					   		$scope.liveTop.push({
					      	MId : obj.EventId,			      	
					      	EventType: obj.EventType,
					      	EventTypeId : obj.EventTypeId,
						      Info: obj.Info,
						       //IsTimeout: true,
						      Period: obj.Period,
						      Score: obj.Score,
						      Set1Score: obj.Set1Score,
						      Set2Score: obj.Set2Score,
						      Set3Score: obj.Set3Score,
						      Set4Score: obj.Set4Score,
						      Set5Score: obj.Set5Score,
						      Set6Score: obj.Set6Score,
						      Set7Score: obj.Set7Score,
						      Set8Score: obj.Set8Score,
						      Set9Score: obj.Set9Score,
						      Set10Score: obj.Set10Score,
						      Side: obj.Side,	
					  		});								  		
				  			break;
				  			
				  		};

		  			}; 		
				  };
				}); 
			};						
		});	
	};
		
  function sub_loadGetMatch(res) {		  	  	
  	var nlm = true;
  	  	
  	angular.forEach(res.Objects, function(obj,idx) {						
			
			if(!obj.IsBooked){
					return;
			};

	  	angular.forEach($scope.LS, function(Ls_obj,i2) {
	  			  		
	  		if (Ls_obj.MId == obj.Id){			  					  			
	  			nlm = false;			
	  			
	  			if(Ls_obj.IsVisible && !obj.IsVisible){	
	  				finishLiveMatch(obj.Id);
	  				
	  			} else if(!obj.IsLive){	  				
	  				finishLiveMatch(obj.Id);
	  			
	  			} else if(obj.LiveStatus == '2'){	  				
	  				finishLiveMatch(obj.Id);
		
	  			} else if(obj.IsLive) {
	  						  				
	  				if(obj.Stat !== undefined && obj.Stat !== null && obj.Stat.length > 0){							
							var HTS = obj.Stat.Score.split(':')[0];
					 		var ATS = obj.Stat.Score.split(':')[1];						 			
						} else{
		   				var HTS = Ls_obj.HTS;
		   				var ATS = Ls_obj.ATS;
	   				}	   				
	   				
	   				if(HTS != LS_obj.HTS || ATS != LS_obj.ATS || obj.Period != LS_obj.Pe || obj.CurrentMinute != LS_obj.Cur || obj.RemainingTime != LS_obj.Rem){  //updated score or period
	   					
		   				$scope.LS.splice(i2,1);			
			   						
				   		$scope.LS.push({
				    		SId:Ls_obj.SId,
				    		SN:Ls_obj.SN,	    		
				    		RId:Ls_obj.RId,
				    		RN:Ls_obj.RN,
				    		CId:Ls_obj.CId,
				    		CN:Ls_obj.CN,
				      	MId:Ls_obj.MId,
				      	HT:Ls_obj.HT,
				      	AT:Ls_obj.AT,
				      	Pe:obj.Period,				      	
				      	//GScore : GameScore,
				      	//EType : '',	
				      	HTS:HTS,
				      	ATS:ATS,
				      	Sus:obj.IsSuspended,	
				      	Cur:(obj.CurrentMinute == undefined) ? "" : obj.CurrentMinute, //obj.CurrentMinute, obj.CurrentMinute,
		    				Rem:(obj.RemainingTime == undefined) ? "" : obj.RemainingTime, //obj.RemainingTime, obj.,	
				      	Inf:obj.Info,	      	
				  		});
				  		
				  		angular.forEach($scope.LMK, function(LMK_obj,i3) {
				  						  									 
								if (LMK_obj.MId == obj.EventId){					  			
					  			$scope.LMK[i3].HTS = HTS;
					  			$scope.LMK[i3].ATS = ATS;
					  			$scope.LMK[i3].Pe = obj.Period;
					  			$scope.LMK[i3].Cur = (obj.CurrentMinute == undefined) ? "" : obj.CurrentMinute; //obj.CurrentMinute;
					  			$scope.LMK[i3].Rem = (obj.RemainingTime == undefined) ? "" : obj.RemainingTime; //obj.RemainingTime;					  										  							  		
				  			};
				  		});			  		
			  	};			  
			  	};
				};
			});
				
			if(nlm && obj.IsVisible ){
				
				if(obj.IsLive && obj.MatchStatus !='2'){		
					//getNewMatchbyMatchId(obj.Id);	
					subLoadLiveMatch(obj.Id);	
				
				} else if(!obj.IsLive && obj.MatchStatus =='0'){	
					
						$scope.PMc = $filter('omit')($scope.PMc,'MId ==' + obj.Id);  // delete ID			
						console.log("[!obj.IsLive && obj.MatchStatus =='0'] $scope.PMc.length:" + $scope.PMc.length);
						
						$scope.PMc.push({
									CId : obj.CompetitionId,
	    						MId : obj.Id,
						});	
						console.log("[!obj.IsLive && obj.MatchStatus =='0'] $scope.PMc.length:" + $scope.PMc.length);
						
					} else if(!obj.IsLive && obj.MatchStatus =='1'){
							console.log("[!obj.IsLive && obj.MatchStatus =='1'] $scope.PMc.length:" + $scope.PMc.length);	
							$scope.PMc = $filter('omit')($scope.PMc,'MId ==' + obj.Id);  // delete ID		
							console.log("[!obj.IsLive && obj.MatchStatus =='1'] $scope.PMc.length:" + $scope.PMc.length);	
							
					} else if(!obj.IsLive && obj.MatchStatus =='2'){	
							console.log("[!obj.IsLive && obj.MatchStatus =='2'] $scope.PMc.length:" + $scope.PMc.length);	
							$scope.PMc = $filter('omit')($scope.PMc,'MId ==' + obj.Id);  // delete ID		
							console.log("[!obj.IsLive && obj.MatchStatus =='2'] $scope.PMc.length:" + $scope.PMc.length);	
					
					};
			};
		});

	};
	
	/*
 	$scope.getWidth = function(cnt){	
		var selWidth ="";
		if(cnt == 3 ) 	selWidth = 100/cnt-cnt; // $scope.selWidth = '399px';
		else if(cnt == 2 ) 	selWidth = 100/cnt-cnt-1; // $scope.selWidth = '605px';
		else if(cnt == 5 ) 	selWidth = 100/5-3; //(1200/5*100); ///100; ///cnt+1; // $scope.selWidth = '605px';
		else selWidth = 100/4-3; //$scope.selWidth = '296px';
		return selWidth;
	};
	*/
	
	$scope.gBP = function(){		
		var tBetP = 1;	
		for(var h = $scope.bet.length - 1;h >= 0; h--){	
			tBetP = tBetP * $scope.bet[h].P;
		}
			$scope.betPrice = tBetP;	
			return $scope.betPrice;
	};

	$scope.rCom = function(n) { 
    if ( typeof n == "undefined" || n == null || n == "" ) {
        return "";
    }
    var txtNumber = '' + n;
    return txtNumber.replace(/(,)/g, "");
	 };
 
	$scope.comma = function(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	};

	$scope.inputNumberFormat2 = function(obj) {
	    obj.value = $scope.comma($scope.uncomma(obj.value));
	};

	$scope.$on('my-accordion:onExpandAnimationEnd', function () {
		// console.log("onExpandAnimationEnd");
	  $scope.tabMId = "0";
	});

	$scope.openSel = function() {
	  var cname = document.getElementById("selsport").className;	  
	  if(cname == "sports_more select open"){
	  	document.getElementById("selsport").className ="sports_more select";
	  }else {
	  	document.getElementById("selsport").className ="sports_more select open";
	  }	  
	};

	$scope.openComp = function() {
	  var cname = document.getElementById("selcomp").className;	  
	  if(cname == "sports_more select open"){
	  	document.getElementById("selcomp").className ="sports_more select";
	  }else {
	  	document.getElementById("selcomp").className ="sports_more select open";
	  }
	};

	$scope.selSport = function(sid,sname) {
	  $scope.selectedSId = sid;
	  document.getElementById("selsport1").innerHTML = sname;
	};

	$scope.selComp = function(cid,cname) {		
		$scope.innerTab = [];
		$scope.toggleMId = "";
		$scope.tabMId = "0"; 
	  document.getElementById("selcomp1").innerHTML = cname;
	  $scope.tabDate = "0";
	  getMatchInfobyCompetition(cid);
	};
	
	$scope.llive_load = function() {
	    var myVar = setTimeout(showPage_llive, 1000);
	};

	$scope.clive_load = function() {
	    var myVar = setTimeout(showPage_clive, 1000);
	};

	$scope.cmarket_load = function() {
	    var myVar = setTimeout(showPage_cmarket, 1000);
	};

	$scope.inner_load = function() {
	    var myVar = setTimeout(showPage_inner, 2000);
	};
	
	$scope.pre_load = function() {
	    var myVar = setTimeout(showPage_pre, 2000);
	};
	
	$scope.us = function(mid) {		
		$('#'+mid).toggleClass("fa-star fa-star-o");
		if( $('#'+mid).hasClass("fa-star-o") ) {
			$scope.sFaD(mid,"-1");
			
		} else { 
			$scope.sFaD(mid,"1");
		}
	};

  $scope.selectSport = function (tab,sid) {	//sports tab    	
  	//console.log("selectSport tab : " + tab + ", SId : " + sid);     	
    $scope.centerTab = tab;
    $scope.tabSId = sid;
  }
  
	$scope.sFaD = function(mid,f) {
		$scope.favM = [];			 
		$http({
				method: 'GET', 
				url: s[19].u, 
				params: {'mid':mid,'f':f},
				headers: {'Content-Type': 'application/json; charset=utf-8'} 
		}).success(function(data, status, headers, config) {
	
			if(data) {							
				angular.forEach(data, function(obj,idx) {			
								
					$scope.favM.push({
						Id: obj.Id,
						SId:obj.SId,
						SN:obj.SN,
						CN:obj.CN,
						HT:obj.HT,
						AT:obj.AT,				
						Dt:obj.Dt,
					});
				});	
			};
			data = null;
			
		}).error(function(data, status, headers, config) {
			console.log(status);
			data = null;
		});
		
	};

}); // end

	function showPage_llive() {
	  document.getElementById("spin_llive").style.display  = "none";
	  document.getElementById("myDiv").style.display = "block";
	}

	function showPage_clive() {
	  document.getElementById("spin_clive").style.display  = "none";
	  //document.getElementById("loader").style.display = "none";
	  document.getElementById("clive").style.display = "block";
	}

	function showPage_cmarket() {
	  document.getElementById("spin_cmarket").style.display  = "none";
	  //document.getElementById("loader").style.display = "none";
	  document.getElementById("cmarket").style.display = "block";
	}

	function showPage_inner() {
	  document.getElementById("spin_inner").style.display  = "none";
	  document.getElementById("pre_inner").style.display = "block";
	}

	function showPage_pre() {
	  document.getElementById("spin_pre").style.display  = "none";
	  document.getElementById("pmatch").style.display = "block";
	}
	
	function onlyNumber(obj) {
	    $(obj).keyup(function(){
	         $(this).val($(this).val().replace(/[^0-9]/g,""));
	    }); 
	}
	
	function comma(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}
	 
	function uncomma(str) {
	    str = String(str);
	    return str.replace(/[^\d]+/g, '');
	}
	 
	function inputNumberFormat(obj) {
	    obj.value = comma(uncomma(obj.value));
	}





