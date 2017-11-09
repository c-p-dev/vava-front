	
var mainAngular = angular.module('Vava', [ 'ngAnimate', 'vAccordion' ]);
var s=[
		{"PID":0,"u":"center_live.html"},
		{"PID":1,"u":"left_live.html"},
		{"PID":2,"u":"right_bet.html"},
		{"PID":3,"u":"ws://10.30.42.116:7071"},
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
	
		var wsUrl = s[3].u ; //"ws://10.30.42.116:7071";		
		//var wsUrl = "ws://10.30.42.116:7071";		
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
			console.log("Disconnected");
			sv.callback("DISCONNECTED");			
			
			setTimeout(function(){sv.con()}, 5000);			
		};

		websocket.onmessage = function(message) {
			sv.callback(message.data);
		};

		sv.ws = websocket;
	};
	
	sv.disc = function() {
		console.log("dis-connected")
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
			if(angular.lowercase(i.HTName).indexOf(s) !== -1){
				r.push(i);
			}else if(angular.lowercase(i.ATName).indexOf(s) !== -1){
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
	console.log("connected")
	

  			
	
  $scope.centerTab = s[0].u; 
  $scope.leftTab = s[1].u; //"left_live.html";
  $scope.rightTab = s[2].u; //"right_bet.html";
    
  $scope.tabSId = "0";	
  $scope.tabCId = "0";							//Sports ID on click sports tab
  $scope.tabMId = "0";							//Match ID on click match tab
  $scope.tabMkId = "0" ;						//Market ID on click market tab
  $scope.tabDate = "0" ;						//Market ID on click market tab
  $scope.innerTab = [];
	$scope.selectedSId = 0;

  $scope.bet=[];
  $scope.betA = false;
  $scope.betE = false;
  $scope.betPrice = 1;
	$scope.betAmt = 100;
	
  $scope.liveTop = [];	
	
	//$scope.preMatch = [];		
	$scope.PM = [];		
	$scope.PMk = [];
	//$scope.preMarketCnt = [];
	$scope.PMkC = []; 
	$scope.CID = [];

	//$scope.sel = [];
	
	$scope.LS = [];
	$scope.LMK = [];	
	$scope.liveMatch = [];
	$scope.liveTop = [];		
			
	$scope.validMKTypeId =[];
	
  loadLiveMatchInit();
  loadPreMatchInit();
  
  var mode = "LiveMatch";   
    			
 $scope.goLiveMatch = function (left,center) {	//sports tab    	
  	console.log("liveMatch left : " + left+ ", center : " + center ); 

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

 $scope.goPreMatch = function (left,center) {	//sports tab    	
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
    mode = "PreMatch";
    $scope.toggleMId = "0";
    
    
  }
  
 $scope.goMatchMarket = function (tab,sid,mid) {  //match tab
 		console.log("goMatchMarket, tab :" +tab+", mid : "+mid);
 		$scope.getMarketbyMatchId(mid);
 		$scope.getStatusbyMatchId(mid,sid);
    $scope.centerTab = tab;
    $scope.topLive = "top_live"+sid+".html";
    $scope.MK = [];
    $scope.tabMId = mid; 
    $scope.tabMkId = "0";  
    mode = "LiveMarket";
  };
 
  $scope.goPreMatchMarket = function (tab,sid,mid,idx) {  //match tab
 		console.log("goPreMatchMarket, tab :" +tab+", mid : "+mid+", idx : "+idx); 		
    $scope.centerTab = tab;
    $scope.innerTab = [];
    $scope.innerTab[idx] = "inner_pre.html";
    $scope.toggleMId = mid;
    
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
  	
  	console.log("addBet Sd : " + sd + ", mkid : " + mkid+", Sn : " + sn+", ST : " + st+", HT : " + ht+", AT : " + at+", P : " +p);    
  	
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
   		BP:bp,
	});	
	
	var element =  document.getElementById("betPrice");
	if(element) element.focus();
          
 };
 
 $scope.setBet  = function (sd,mkid,sn,st,ht,at,p,bp) { 	
  	console.log("setBet selid : " + sd + ", mkid : " + mkid+", selnm : " + sn+", hteam : " + ht+", ateam : " + at+", price : " + p);    
  	
  	$scope.betE = true;
  	
  	for(var i = $scope.bet.length - 1; i >= 0; i--){  									
				if($scope.bet[i].Mkid == mkid){
					$scope.betA = true;
					return;
					//$scope.bet.splice(i,1);
					//already reserved.
					
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
  	console.log("detBet selid : " + sd);    
  	
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
  	console.log("detAllBet");    
  	
  	for(var i = $scope.bet.length - 1; i >= 0; i--){							
					$scope.bet.splice(i,1);
		};
		
	$scope.betE = false;
	$scope.betA = false;
 };
 	
 		
 $scope.conAlert  = function (alert) { 	
  	console.log("conAlert alert : " + alert);    
  	
  if(alert == "1") $scope.betA = false;
 
 	var element =  document.getElementById("betPrice");
	if(element) element.focus();

 };

   $scope.getMaketbyCid  = function (left,center,cid) { 	
  	//console.log("getMaketbyCid left : " + left + ", center : " + center+", cid : " + cid);    
  	$scope.centerTab = center;
    $scope.leftTab = left;
    $scope.tabDate = "0";
    $scope.CID = cid;
    //$scope.getMatchInfobyCompetition(cid);
    $scope.PMk =[];
    getMatchInfobyCompetition(cid);
 }
 
  	
   $scope.preMatchDate = function (left, center,cid,date) {
  	console.log("preMatchDate center : " + center + ", cid : " + cid+ ", date : " + date);  
  	$scope.innerTab = [];  
  	$scope.leftTab = left;
  	$scope.centerTab = center;
  	$scope.tabDate = date;
 }    
 
 /* 
  $scope.selectMarket = function (tab,mkid) {		//market tab
    $scope.centerTab = tab;
    $scope.tabMkId = mkid;
    //console.log("$scope.tabMkId : " + $scope.tabMkId)
  }
	*/  
	$scope.lm =[];
	
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
	    url: s[5].u, //'/JSON/period_name.json',
	    method: "GET",
	     headers: {
        'Content-Type': 'utf-8'
      	}
    }).success(function(data, status, headers, config) {
    	
	    $scope.periodName = data.Objects;
    //	$scope.RegionObj_init = data.Objects;  
    	    
    //	console.log("$scope.periodName");
    //	console.log($scope.periodName);
    
		}).error(function(data, status, headers, config) {
	    $scope.status = status;
	});


	$http({
	    url: s[6].u, //'/JSON/live_status.json',
	    method: "GET",
	     headers: {
        'Content-Type': 'utf-8'
      	}
    }).success(function(data, status, headers, config) {
    	
	    $scope.liveS = data.Objects;
    
		}).error(function(data, status, headers, config) {
	    $scope.status = status;
	});
	
	

  $http({
			method: 'GET', 
			url: s[7].u, //'jsp/getValidMarketType.jsp', 
			headers: {'Content-Type': 'application/json; charset=utf-8'} 
	}).success(function(data, status, headers, config) {
					
		if(data) {
			$scope.validMKTypeId = data;		
		};
		
		data = null;
		
	}).error(function(data, status, headers, config) {
		console.log(status);
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
							HT:obj.AT,
							AT:obj.AT,				
							Dt:obj.Dt,
						});
						
					});	
				
					//console.log($scope.favMatch);				
			};
				
				//console.log("[getMarketbyMarketId] (2): "+ $scope.MK.length);
					
				data = null;
			
		}).error(function(data, status, headers, config) {
			console.log(status);
			data = null;
		});

   
  function liveMatchCnt() {	
  	
  	$scope.LMc = [];  	
  	
  	console.log("$scope.LS.length : " + $scope.LS.length);
  	
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
  

 	function loadLiveMatchInit() {		//market tab

		 $http({
				method: 'GET', 
				url: s[9].u, //'jsp/loadLiveMatchInit.jsp', 
				headers: {'Content-Type': 'application/json; charset=utf-8'} 
		 }).success(function(data, status, headers, config) {
			
			console.log(data);
												
			$scope.LS = [];
			$scope.LMK = [];		
			//$scope.leftMarketCnt = [];		
			$scope.LMKc = [];
			
			//console.log("loadLiveMatchInit");
			//console.log(data);
			
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
		 			ATeamScore = mStat[0].Sc.split(':')[1]; //score[1];	
				
				} else {
				 // no stat data
				 	return;
				 
				};		
											
				if(mResult !== undefined && mResult !== null && mResult.length > 0){
					
					var w1Price ="-";
					var w2Price ="-";
					var xPrice ="-";
					
					var w1SelId ="";
					var xSelId ="";
					var w2SelId ="";
					
					
					for(var i = mSelect.length - 1; i >= 0; i--){
						
						//var select = mResult[0].Selections[i];
						
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
					}
 
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
					
				}
				

			  });
		 		
		 		}); 
		 		
	 		//}); 

			data=null;
				
		}).error(function(data, status, headers, config) {
				console.log(status);
				data=null;
		});
  };

  
 function loadPreMatchInit() {		//market tab
		
		 $http({
				method: 'GET', 
				url: s[10].u, //'jsp/loadPreMatchInit.jsp', 
				headers: {'Content-Type': 'application/json; charset=utf-8'} 
		}).success(function(data, status, headers, config) {
				
			$scope.PMc = [];
			
			angular.forEach(data, function(obj,idx) {

			if(obj.Id !== undefined && obj.Id !== null && obj.Id.length > 0){
										
				$scope.PMc.push({
					CId : obj.CId,
				 	MId : obj.Id,			 	
				});	  		
			}
		});
		
		data=null;
		
	}).error(function(data, status, headers, config) {
		console.log(status);
		data=null;
	});
 };
 
 function loadPreMatch() {		//market tab
		
		 $http({
				method: 'GET', 
				url: s[17].u, //'jsp/loadPreMatch.jsp', 
				headers: {'Content-Type': 'application/json; charset=utf-8'} 
		}).success(function(data, status, headers, config) {
				
		if(data) {
		
		console.log("loadPreMatch");	
		console.log(data);
		
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

 function subLoadPreMatch(mid) {		//market tab
		
		 $http({
				method: 'GET', 
				url: s[18].u, //'jsp/subLoadPreMatch.jsp', 
				params: { 'mid' : mid },
				headers: {'Content-Type': 'application/json; charset=utf-8'} 
		}).success(function(data, status, headers, config) {
				
		if(data) {
		    
    console.log("loadPreMatch : " + mid);
   	console.log(data);
   	       
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
 
	// for new matches
	$scope.getMarketbyMatchId = function(mid) {
	
	   $http({
				method: 'GET', 
				url: s[11].u, //'jsp/getMarketbyMatchId.jsp', 
				params: { 'mid' : mid },
				headers: {'Content-Type': 'application/json; charset=utf-8'} 
		 }).success(function(data, status, headers, config) {		
		 			
			if(data) {
								
				//console.log("[getMarketbyMatchId] data.length : " + data.length);
				
				$scope.MK = [];
				var se_tmp = [];
				//var selections = [];
				
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
					
					//console.log("$scope.MK : " + k);			
					for (var i = 0; i < se_tmp.length; i++) {								
								//console.log("selections_tmp : " + (k+1)*(i+1));
								
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
			console.log(status);
			data = null;
		});
 };

	$scope.getStatusbyMatchId = function(mid,sid) {
	
	   $http({
				method: 'GET', 
				url:  s[12].u, //'jsp/getStatusbyMatchId.jsp', 
				params: { 'mid' : mid , 'sid' : sid},
				headers: {'Content-Type': 'application/json; charset=utf-8'} 
		 }).success(function(data, status, headers, config) {		
		 			
		 			console.log("getStatusbyMatchId");
		 			
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
			  		
			  		//console.log($scope.liveTop);
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
				url: s[13].u, //'jsp/getMarketbyMarketId.jsp', 
				params: { 'mkid' : mkid },
				headers: {'Content-Type': 'application/json; charset=utf-8'} 
		}).success(function(data, status, headers, config) {
			
							
			//if(data) {
			
			console.log(data);
			
			if(data.Id !== undefined && data.Id !== null && data.Id.length > 0){
					
				console.log("[getMarketbyMarketId] (1): "+ $scope.MK.length);
				//console.log($scope.MK);
						
						console.log(data);
						console.log(data.Se);
						
					if(data.Se != undefined){	
													
						//console.log(data);
						$scope.MK.push(data);
						
					};

				console.log("[getMarketbyMarketId] (2): "+ $scope.MK.length);

			};
			console.log($scope.MK);
			data = null;
			
		}).error(function(data, status, headers, config) {
			console.log(status);
			data = null;
		});
 }
 
  function subLoadLiveMatch(mid) {
  
  	console.log("getNewMatchbyMatchId step1");
  		      
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
				
				console.log("$scope.LMKc.push");
								
				if(data[0].Re !== undefined && data[0].Re !== null && data[0].Re.length > 0){
					
					var w1Price ="-";
					var w2Price ="-";
					var xPrice ="-";
					
					var w1SelId ="";
					var xSelId ="";
					var w2SelId ="";
				
			    
			    for(var i = data[0].Se.length - 1; i >= 0; i--){
						
						//var select = mResult[0].Selections[i];
						
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
					}
					 
					console.log("w1SelId : " + w1SelId);
					console.log("w1Price : " + w1Price);
					
					console.log("xSelId : " + xSelId);
					console.log("xPrice : " + xPrice);
					
					console.log("w2SelId : " + w2SelId);
					console.log("w2Price : " + w2Price);
					  
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
			  		RN:data[0].MatMtch[0].RN,
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
				url: s[15].u, // 'jsp/getMatchInfobyCompetition.jsp', 
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
				}
				
									
				if(data[0].Mt !== null &&  data[0].Mt !== undefined && data[0].Mt.length > 0){
					
					for (var j = 0; j < data[0].Mt.length ; j++) {
											
						var w1Price ="-";
						var w2Price ="-";
						var xPrice ="-";

						var w1SelId ="";
						var xSelId ="";
						var w2SelId ="";
											
						var mMatchResult = data[0].Re.filter(function (el) { return el.MId == data[0].Mt[j].Id; });
												
						if(mMatchResult !== null && mMatchResult !== undefined && mMatchResult.length > 0 ){
													
							//var mResult = mMatchResult[0].Selections;
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
							}
				  									  			  		
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
			//});
				
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

		console.log("REMOVED MATCH :" + mid)
		console.log("TOTAL LIVE MATCHES :" + $scope.LS.length)
			
	}


	function sub_loadGetMatchMarket(response) {		//market tab

		angular.forEach(response.Objects, function(obj,idx) {
		
			//var AmarketSub = response.Objects[a];
			
			var valid_market = $scope.validMKTypeId.indexOf(obj.MarketTypeId);
			
				
			if (valid_market < 0){		
				//console.log("Unused marketTypeId : " + obj.MarketTypeId);
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
							console.log("$scope.LMKc.push");
						};
					};		
					
				};
			};	
					
				
			if(mode == "LiveMatch"){
			
				
				for (var c = 0; c < $scope.LMK.length; c++) {			 		
			 		var lm = $scope.LMK[c];
			 		
				 	if(lm.MkId == obj.Id){			 		
				 		
				 		var w1Price ="-";
				  	var w2Price ="-";
						var xPrice ="-";
						var w1SelId ="";
						var xSelId ="";
						var w2SelId ="";
										
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
						}
	      									
						if(w1Price != lm.W1P || xPrice != lm.XP || w2Price != lm.W2P ||  lm.Sus != obj.IsSuspended){
							
							$scope.LMK = $filter('omit')($scope.LMK,'MkId ==' + obj.Id);  // delete ID		
							
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
			/*
			} else if(mode == "PreMatch"){
				
				
					var im = $scope.PMkC.map(function(x) {
					return x.Id;  
					}).indexOf(obj.Id);
						
					if (im > -1){		    	
						
						$scope.PMkC = $filter('omit')($scope.PMkC,'Id ==' + obj.Id);  // delete ID			
						
						$scope.PMkC.push({
			    		Id:obj.Id,
			    		S:obj.S,	    		
			    		V:obj.V,
			    		M:obj.M,
						});					
						
					} else {
						
					var it = $scope.PMk.map(function(x) {
						return x.MId;  
					}).indexOf(obj.MatchId);
						
						if (it > -1){
							
							$scope.PMkC.push({
				    		Id:obj.Id,
				    		S:obj.S,	    		
				    		V:obj.V,
				    		M:obj.M,
							});
						};
					}
				
					
				angular.forEach($scope.PMk, function(obj3,idx3) {
																			
						if(obj3.MkId == obj.Id){
							
							var w1Price ="-";
					  	var w2Price ="-";
							var xPrice ="-";
							var w1SelId ="";
							var xSelId ="";
							var w2SelId ="";
							
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
											
							}
			      	
							if(w1Price !== obj3.W1P || xPrice !== obj3.XP || w2Price !== obj3.W2P ||  obj3.Sus !== obj.IsSuspended){
					
				  			$scope.PMk[idx3].Sus=obj.IsSuspended;
				  			$scope.PMk[idx3].W1SD=w1SelId;
    						$scope.PMk[idx3].XSD=xSelId;
    						$scope.PMk[idx3].W2SD=w2SelId;
				  			$scope.PMk[idx3].BW1P=obj3.W1P;
					      $scope.PMk[idx3].BXP=obj3.XP;
					      $scope.PMk[idx3].BW2P=obj3.W2P;			      	
					      $scope.PMk[idx3].W1P=w1P;
					      $scope.PMk[idx3].XP=xP;
					      $scope.PMk[idx3].W2P=w2P;
					      
				  			//console.log("$scope.PMk.push");
	  			  	};
	  			  	
	  			  	
		  			};
						
						//$scope.market_tmp = [];
						
				//}; 
				});

			}; 
		  */
			//if(mode == "LiveMarket" || mode == "PreMatch"){
				
				//console.log("$scope.tabMId : " + $scope.tabMId);
				
				if($scope.tabMId !="0" && $scope.tabMId == obj.MatchId){
				
				//console.log("$scope.tabMId : " + $scope.tabMId);
				
					 var newCmarket = true;	
					 	
					 //console.log("$scope.tabMId : " +  obj.MatchId);
					 
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
 
						$scope.MK = $filter('omit')($scope.MK,'Id ==' + obj.Id);  // delete ID		
								
								$scope.MK.push({
									//Date : selMk.Date,
									//Handicap : obj.Handicap,
									Id:mk.Id,
									MTyId:mk.MTyId,
									Sus: obj.IsSuspended,
									Vis: obj.IsVisible, 
									MId: mk.MId,
									Nm: mk.Nm,
									Se: sel_tmp,
									//Selections : obj.Selections,
									Sq: obj.Sequence,
								});
																		
						   sel_tmp = [];
					  	}
					 };
					  	
					  //if(newCmarket && obj.IsVisible){ 
					  if(newCmarket && obj.IsVisible){ 		
						  		console.log("find new market : Id = " + obj.Id+", MarketTypeId  = " + obj.MarketTypeId );	  		
						  		//$scope.getMarketbyMarketId(obj.Id);		
						  		getMarketbyMarketId(obj.Id);		
					  };
						
						//};
				//	});
				};
			//};

			for(var r = $scope.bet.length - 1;r >= 0; r--){	
				
					var betMk = $scope.bet[r];
									
					if(betMk.Mkid == obj.Id){			//live market			
														
						for (var j = 0; j < obj.Selections.length; j++) {
		    					    				
		    				if(obj.Selections[j].Id == betMk.Sd) {

									$scope.bet[r].P = obj.Selections[j].Price;
							
								};
						};	
					};
			};
			
			//sel_tmp = null;
			//Sel = null;
				
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
  	
  	console.log("sub_loadGetMatch");
  	
  	var nlm = true;
  	
  	angular.forEach(res.Objects, function(obj,idx) {
						
			if(!obj.IsBooked){
				console.log("IsBooked false");
					return;
			};

	  	angular.forEach($scope.LS, function(Ls_obj,i2) {
	  		
	  		if (Ls_obj.MId == obj.Id){		
	  					  			
	  			nlm = false;
	  			
	  			console.log("[sub_loadGetMatch] obj.Id : " + obj.Id); 		  			
	  			
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
					 		
					 		//console.log("[sub_loadGetMatch] HTeamScore : " +HTeamScore+", ATeamScore : " +ATeamScore); 
					 			
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
			  		//console.log("[sub_loadGetMatch] LS.push : " + obj.Id+", obj.IsSuspended : "+obj.IsSuspended); 
			  
			  	};
				};
			});
				
			if(nlm && obj.IsVisible ){
				
				if(obj.IsLive && obj.MatchStatus !='2'){		
					console.log("go to getNewMatchbyMatchId");
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
				
				}
			}
				
				
		
		
		});

	};
	
	
	
 	$scope.getWidth = function(cnt){	
	
	//if(cnt > 3 ) cnt = 3;
var selWidth ="";

	if(cnt == 3 ) 	selWidth = 100/cnt-cnt; // $scope.selWidth = '399px';
	else if(cnt == 2 ) 	selWidth = 100/cnt-cnt-1; // $scope.selWidth = '605px';
	else if(cnt == 5 ) 	selWidth = 100/5-3; //(1200/5*100); ///100; ///cnt+1; // $scope.selWidth = '605px';
	else selWidth = 100/4-3; //$scope.selWidth = '296px';

		return selWidth;
	};
	
	$scope.gBP = function(){	
	
	var tBetP = 1;
	
	for(var h = $scope.bet.length - 1;h >= 0; h--){	
		tBetP = tBetP * $scope.bet[h].P;
	}
		$scope.betPrice = tBetP;
	
		return $scope.betPrice;
	};

	$scope.rCom = function(n) {  // 콤마제거
    if ( typeof n == "undefined" || n == null || n == "" ) {
        return "";
    }
    var txtNumber = '' + n;
    return txtNumber.replace(/(,)/g, "");
 };


$scope.comma = function(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}
 


$scope.inputNumberFormat2 = function(obj) {
    obj.value = $scope.comma($scope.uncomma(obj.value));
}

$scope.$on('my-accordion:onExpandAnimationEnd', function () {
	 console.log("onExpandAnimationEnd");
  $scope.tabMId = "0";
 		
});


	$scope.openSel = function() {
			//alert("a");
	  var cname = document.getElementById("selsport").className;
	  
	  if(cname == "sports_more select open"){
	  	document.getElementById("selsport").className ="sports_more select";
	  }else {
	  	document.getElementById("selsport").className ="sports_more select open";
	  }
	  
	}

	$scope.openComp = function() {
			//alert("a");
			
	  var cname = document.getElementById("selcomp").className;
	  
	  if(cname == "sports_more select open"){
	  	document.getElementById("selcomp").className ="sports_more select";
	  }else {
	  	document.getElementById("selcomp").className ="sports_more select open";
	  }
	  
	}

	$scope.selSport = function(sid,sname) {

	  $scope.selectedSId = sid;
	  document.getElementById("selsport1").innerHTML = sname;
	}

	$scope.selComp = function(cid,cname) {
		
		console.log("$scope.selComp");
		
		  $scope.innerTab = [];
		$scope.toggleMId = "";
		$scope.tabMId = "0"; 
	  document.getElementById("selcomp1").innerHTML = cname;
	  $scope.tabDate = "0";
	  getMatchInfobyCompetition(cid)

	}
	

	$scope.llive_load = function() {
	    var myVar = setTimeout(showPage_llive, 1000);
	}

	$scope.clive_load = function() {
	    var myVar = setTimeout(showPage_clive, 1000);
	}

	$scope.cmarket_load = function() {
	    var myVar = setTimeout(showPage_cmarket, 1000);
	}

	$scope.inner_load = function() {
	    var myVar = setTimeout(showPage_inner, 2000);
	}

	$scope.us = function(mid) {
		console.log("mid : " + mid);
		
		$('#'+mid).toggleClass("fa-star fa-star-o");
		
		if( $('#'+mid).hasClass("fa-star-o") ) {
		  		//favorite('-1',game_id);
			//console.log("(-) del fav");
			//$scope.sFa(mid,sn,cn,ht,at,-1);
			$scope.sFaD(mid,"-1");
			
		} else { 
			//console.log("(+) add fav");
			//favorite('+1',game_id);					
			//$scope.sFa(mid,sn,cn,ht,at,1);
			$scope.sFaD(mid,"1");
		}
				
		//document.getElementById(mid).toggleClass("fa-star fa-star-o")
	}

	$scope.sFaD = function(mid,f) {
		
		//console.log("$scope.sFaD : mid="+mid+", f:"+f);
		
		 $scope.favM = [];	
		 
		$http({
				method: 'GET', 
				url: s[19].u, //'jsp/setFavMatch.jsp', 
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
		
}

});

function showPage_llive() {
  document.getElementById("spin_llive").style.display  = "none";
  //document.getElementById("loader").style.display = "none";
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
  //document.getElementById("loader").style.display = "none";
  document.getElementById("pre_inner").style.display = "block";
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





