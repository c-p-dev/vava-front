	
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
		{"PID":19,"u":"jsp/setFavMatch.jsp"},
		{"PID":20,"u":"jsp/getMarketCategory.jsp"},
		{"PID":21,"u":"jsp/getSearchMatch.jsp"},
		{"PID":22,"u":"jsp/getTodayMatchInfo.jsp"},
		{"PID":23,"u":"jsp/getMatchInfobySport.jsp"},
		{"PID":24,"u":"jsp/getMaxBetAmt.jsp"},
		{"PID":25,"u":"jsp/setMultiBet.jsp"},
		{"PID":26,"u":"jsp/setSingleBet.jsp"},
		{"PID":27,"u":"jsp/getUserBalance.jsp"},
		{"PID":28,"u":"jsp/getCart.jsp"}
		
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
 
 mainAngular.directive("outsideClick", ['$document','$parse', function( $document, $parse ){
    return {
        link: function( $scope, $element, $attributes ){
            var scopeExpression = $attributes.outsideClick,
                onDocumentClick = function(event){
                    var isChild = $element.find(event.target).length > 0;

                    if(!isChild) {
                        $scope.$apply(scopeExpression);
                    }
                };

            $document.on("click", onDocumentClick);

            $element.on('$destroy', function() {
                $document.off("click", onDocumentClick);
            });
        }
    }
}]);


mainAngular.directive('restrictTo', function() {
    return {
        restrict: 'A',
        link: function (scope, element, attrs) {
            var re = RegExp(attrs.restrictTo);
            var exclude = /Backspace|Enter|Tab|Delete|Del|ArrowUp|Up|ArrowDown|Down|ArrowLeft|Left|ArrowRight|Right/;

            element[0].addEventListener('keydown', function(event) {
                if (!exclude.test(event.key) && !re.test(event.key)) {
                    event.preventDefault();
                }
            });
        }
    }
});

mainAngular.directive('format', ['$filter', function ($filter) {
    return {
        require: '?ngModel',
        link: function (scope, elem, attrs, ctrl) {
            if (!ctrl) return;


            ctrl.$formatters.unshift(function (a) {
                return $filter(attrs.format)(ctrl.$modelValue)
            });


            ctrl.$parsers.unshift(function (viewValue) {
                var plainNumber = viewValue.replace(/[^\d|\-+|\.+]/g, '');
                elem.val($filter(attrs.format)(plainNumber));
                return plainNumber;
            });
        }
    };
}]);

     
mainAngular.controller("mc", function($window,$scope, $templateCache, $compile, $http, wss) {		
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
					
				case "GetBlock": sub_loadBlockMatch(obj);
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
	  $scope.tabCId = "-1";							
	  $scope.tabMId = "0";							
	  $scope.tabMkId = "0" ;						
	  $scope.tabDate = "0" ;						
	  $scope.innerTab = [];
		$scope.selectedSId = 0;
	  $scope.bet=[];
	  $scope.betA = false;
	  $scope.betE = false;
	  $scope.betPrice = 1;
	  $scope.betPrice_p  = 1;
	  $scope.betAmt = [];	
		$scope.betAmt[0] = "1000";
	  $scope.liveTop = [];		
		$scope.PM = [];		
		$scope.PMk = [];
		$scope.toPMk = [];
		//$scope.PMkC = []; 
		$scope.CID = [];
		$scope.LS = [];
		$scope.LMK = [];	
		$scope.liveMatch = [];
		$scope.liveTop = [];					
		$scope.validMKTypeId =[];	
		$scope.lm =[];
	 	$scope.favM = [];		
	 	$scope.MK = [];
	 	
	  $scope.centerTab = s[4].u;    
    $scope.leftTab = s[16].u;    
    
	  //loadLiveMatchInit();
	  //PreLoadLiveMatchInit();
	  //preLoadPreMatch();
  	 
   	//$scope.PMk =[];
  		
  	islive = false;
  	$scope.LMK = [];	
  	$scope.LS = [];	
		$scope.tabMId = "0";    
    $scope.toggleMId = "0";  
    //liveMatchCnt();  
    
    $scope.mTyId = "ALL";
		$scope.MKCAT = [];
		//$scope.savedFavM = [];
		$scope.Fav_mode = false;
		
		$scope.date0 = moment().utcOffset('+0800').format('YYYY-MM-DD');
		$scope.date1 = moment().add(1, 'days').utcOffset('+0800').format('YYYY-MM-DD');
		$scope.date2 = moment().add(2, 'days').utcOffset('+0800').format('YYYY-MM-DD');
		$scope.date3 = moment().add(3, 'days').utcOffset('+0800').format('YYYY-MM-DD');
		$scope.date4 = moment().add(4, 'days').utcOffset('+0800').format('YYYY-MM-DD');
		$scope.date5 = moment().add(5, 'days').utcOffset('+0800').format('YYYY-MM-DD');
		$scope.date6 = moment().add(6, 'days').utcOffset('+0800').format('YYYY-MM-DD');
		
		$scope.tabDt = $scope.date0;
		$scope.betM = "1"; //bet-mode
		
		$scope.betClick = false;
		$scope.betConf = false;
		
		$scope.betB = false;
		$scope.betC = false;
		$scope.betD = false;
		$scope.betF = false;
		$scope.betG = false;
		$scope.betH = false;
		$scope.betJ = false;
		$scope.betK =  false;
		$scope.UID = "";
		
		//console.log("$scope.betJ:"+$scope.betJ);
		
		
		$scope.paneIdx = -1;
		$scope.betFix = 1;
		
		$scope.betFix2 = function(f){
			$scope.betFix = f;
		}
		

		$scope.savedFavM = JSON.parse(localStorage.getItem('SFM'));
		
		if($scope.savedFavM  === null){
			$scope.savedFavM = [];
		}
		
		$scope.getTr = function(n) {			
			var res = [];			
			for (var i = 0; i < n; i++) {
        res.push(i);
      }
      return res;
		}
	
		//console.log("$scope.savedFavM = " + $scope.savedFavM);
		
		//$scope.savedFavM = JSON.parse(chrome.storage.local.getItem('SFM'));
    var mode = "PreMatch"; 
    $scope.pm_mode = "t";
    $scope.parseFloat = parseFloat;
    
    $scope.ISLG = checkSession;
    $scope.UID = UID;
	  $scope.ubal = UBAL;
	  
	  $scope.BL = "N";
	  
	
	function sub_loadBlockMatch(response) {		
			
			$scope.BLR = response;
				
				if(response.Type =="N"){	
									
					if($scope.BL !="N"){
					
						for(var i=$scope.LS.length-1;i>=0;i--){  
								$scope.LS[i].B = false;
						}
					
						for(var i=$scope.LMK.length-1;i>=0;i--){  						
								$scope.LMK[i].B = false;
						}
					}
					
					$scope.BL ="N";
				
				} else if(response.Type =="L"){
					
					for(var i=$scope.LS.length-1;i>=0;i--){  
							$scope.LS[i].B = true;
					}
					
					for(var i=$scope.LMK.length-1;i>=0;i--){  						
							$scope.LMK[i].B = true;
					}
					
					$scope.BL ="L";
				
				} else if(response.Type =="P"){
					for(var i=$scope.LS.length-1;i>=0;i--){  
							$scope.LS[i].B = true;
					}
					
					for(var i=$scope.LMK.length-1;i>=0;i--){  						
							$scope.LMK[i].B = true;
					}
					
					for(var i=$scope.PMk.length-1;i>=0;i--){  
							$scope.PMk[i].B = true;
					}
					
					for(var i=$scope.toPMk.length-1;i>=0;i--){  
							$scope.toPMk[i].B = true;
					}
					
					for(var i=$scope.favM.length-1;i>=0;i--){  	
								$scope.favM[i].B = true;
					}
					
						$scope.BL ="P";
				}
				
			angular.forEach(response.Objects, function(obj,idx) {	
					
					console.log("mode = "+ mode);
					console.log(obj);					
					console.log("obj.MId:"+obj.MId);
					console.log("obj.AS:"+obj.AS);
					
					if(obj.AS=="F"){
						
						for(var i=$scope.favM.length-1;i>=0;i--){  
								
								if ($scope.favM[i].MId==obj.MId){	
									$scope.favM[i].B = true;
								}
						}
						
						for(var i=$scope.bet.length-1;i>=0;i--){  
								
								if ($scope.bet[i].MId==obj.MId){	
									$scope.bet[i].B = true;
								}
						}
							
						if(mode == "LiveMatch" || mode == "LiveMarket"){ 						
							
							for(var i=$scope.LS.length-1;i>=0;i--){  
								
								if ($scope.LS[i].MId==obj.MId){	
									$scope.LS[i].B = true;
								}
							}
							
							for(var i=$scope.LMK.length-1;i>=0;i--){  
								
								if ($scope.LMK[i].MId==obj.MId){	
									$scope.LMK[i].B = true;
								}
							}
						
						} else if(mode == "PreMatch" ){	
							
							console.log("pm_mode = "+ $scope.pm_mode);
							
							if ($scope.pm_mode=="m"){
								
								for(var i=$scope.PMk.length-1;i>=0;i--){  
									
									if ($scope.PMk[i].MId==obj.MId){	
										$scope.PMk[i].B = true;
									}
								}
							
							} else if ($scope.pm_mode=="t"){ 
								for(var i=$scope.toPMk.length-1;i>=0;i--){  
									
									if ($scope.toPMk[i].MId==obj.MId){	
										$scope.toPMk[i].B = true;
									}
								}
							}
						}
						
					}	if(obj.AS=="M"){	
						
						for(var i=$scope.favM.length-1;i>=0;i--){  
								
								if ($scope.favM[i].MId==obj.MId){	
									$scope.favM[i].B = false;
								}
						}
							
						if(mode == "LiveMatch" || mode == "LiveMarket"){ 						
							
							for(var i=$scope.LS.length-1;i>=0;i--){  
								
								if ($scope.LS[i].MId==obj.MId){	
									$scope.LS[i].B = false;
								}
							}
							
							for(var i=$scope.LMK.length-1;i>=0;i--){  
								
								if ($scope.LMK[i].MId==obj.MId){	
									$scope.LMK[i].B = false;
								}
							}
						
						} else if(mode == "PreMatch" ){	
							
							console.log("pm_mode = "+ $scope.pm_mode);
							
							if ($scope.pm_mode == "m"){
								
								for(var i=$scope.PMk.length-1;i>=0;i--){  
									
									if ($scope.PMk[i].MId==obj.MId){	
										$scope.PMk[i].B = false;
									}
								}
							
							} else if ($scope.pm_mode == "t"){ 
								for(var i=$scope.toPMk.length-1;i>=0;i--){  
									
									if ($scope.toPMk[i].MId==obj.MId){	
										$scope.toPMk[i].B = false;
									}
								}
							}
						}
					}
			});			
	};
	
	$scope.getCart = function(){
      var cart = [];
      //var cart = [];
      var c = false;
      //var data = sessionStorage.getItem('key');
      $.each($window.sessionStorage, function(i, v){
        cart.push(angular.fromJson(v));
        c = true;     
        $scope.betE = true;  	
	  		$scope.betClick = true;
	  	   
        //console.log(cart[0].Sd);
      });
    
		
		
		if(c){
			var sd = [];
			for(var i = cart[0].length - 1; i >= 0; i--){  
				sd.push(cart[0][i].Sd);
			}
			  		 
			$http({
					method: 'GET', 
					url: s[28].u, 
					params: {'selid':sd},
					headers: {'Content-Type': 'application/json; charset=utf-8'} 
			}).success(function(data, status, headers, config) {
		
				if(data) {			
					
					angular.forEach(data, function(obj,idx) {	
						
						//console.log("obj");
						
						for(var i=cart[0].length-1;i>=0;i--){  
							

							if(obj.sel_id==cart[0][i].Sd){ 							
								cart[0][i].P = obj.sel_price;
								
								if(obj.match_vis=='F' || obj.match_sus=='T'){
									cart[0][i].SuM = true;
								}
								
								if(obj.market_vis=='F' || obj.market_sus=='T'){
									cart[0][i].SuK = true;
								}
							
							$scope.bet.push(cart[0][i]);	
						}
						
						
					}		
					
					console.log("$scope.bet");
					console.log($scope.bet);

				});
				data = null;
				
			};
			
			}).error(function(data, status, headers, config) {
				console.log(status);
				data = null;
			});
			
	  
	  };
		
	};
	
	$scope.addCart = function(id){
		$window.sessionStorage.clear();
  	$window.sessionStorage.setItem(id, JSON.stringify($scope.bet));        
    
    console.log("$window.sessionStorage:"+$window.sessionStorage.length);
  }
  
  if($scope.ISLG&&$scope.UID!="-1"){
		$scope.getCart(); 
	}
	   

	 $scope.goLiveMatch = function (left,center) {	  	
	  	loadLiveMatchInit();
	  	//preMatchCnt();  
	  	loadPreMatchInit(); 	
	  	islive = true;
			$scope.PMk = [];	
			$scope.tabMId = "0";
			$scope.tabSId ="0";  	 	
	    $scope.centerTab = center;
	    $scope.leftTab = left;
	    mode = "LiveMatch";
	  }
		
		$scope.loadPop = function (sid,mid) {
			$scope.Fav_mode = false;
	    //$scope.mTyId = "ALL";
	    //$scope.Fav_mode = false;
			$scope.getMatchInfobyMatchId(mid);
			$scope.getMarketbyMatchId(mid);
	 		//$scope.getStatusbyMatchId(mid,sid);
	    $scope.centerTab = "center_popular.html";	    
	    $scope.topLive = "/sport/html/top_pre"+sid+".html";
	    //console.log($scope.topLive);
	    $scope.tabMId = mid; 
	    $scope.tabMkId = "0";  
	    //$scope.Fav_mode = false;
	    $scope.mTyId = "ALL";
	    mode = "LiveMatch";
		}	  	
		
		
	 $scope.goPreMatch = function (left,center) {	 	 	

	  	$scope.PMk =[];
	  	$scope.innerTab = [];
	  	$scope.centerTab = center;
	    $scope.leftTab = left;  
	  	//console.log("$scope.innerTab = []");	
	  	//$scope.tabCId = $scope.PMc[0].CId;
	  	$scope.tabCId = "-1";
	  	//getMatchInfobyCompetition($scope.tabCId);  	
	  	//getTodayMatchInfo($scope.date0);

	  	getTodayMatchInfo("1");
	  	$scope.tabDt = $scope.date0;	  	
	  	$scope.pm_mode = "t";	  	
	  	loadPreMatch();
	  	liveMatchCnt();  	
	  	islive = false;
	  	$scope.LMK = [];	
	  	$scope.LS = [];	
			$scope.tabMId = "0";	      
	    $scope.toggleMId = "0";  
	    mode = "PreMatch";  
	  }
  
	 $scope.goMatchMarket = function (tab,sid,mid) { 
	 	  //console.log("goMatchMarket");
	 	  
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
	  	
	  	
	  	
	  	$scope.mTyId ="ALL";
	  	
	  	console.log("$scope.mTyId:"+$scope.mTyId);
	  	
	  	
	  	$scope.Fav_mode = false;
	    $scope.centerTab = tab;
	    $scope.innerTab = [];
	    $scope.innerTab[idx] = "inner_pre.html";
	    $scope.toggleMId = mid;	      
	    $scope.preHT = ht;
	    $scope.preAT = at;  	    
	    if($scope.tabMId !== mid){
	    	$scope.getMarketbyMatchId($scope.toggleMId);	    	
	    	$scope.tabMId = mid; 
	    	$scope.paneIdx = idx;    	
	    } else{
	    	$scope.tabMId = "0"; 
	    	$scope.paneIdx = -1;
	    }
	    $scope.MK = [];    
	    $scope.tabMkId = "0";  
	    mode = "PreMatch";
	  };
    
    $scope.setMTyId = function(mTyId) {	  	 		
			
			$scope.mTyId = mTyId;
			//$scope.pp = 0;
			$scope.MKCAT =[];
			$scope.Fav_mode = false;
			
	 		if(mTyId =='WL'){
	 			$scope.MKCAT = $scope.cat_wl;
	 		
	 		} else if(mTyId =='OU'){
	 			$scope.MKCAT = $scope.cat_ou;
	 		
	 		} else if(mTyId =='HD'){
	 			$scope.MKCAT = $scope.cat_hd;
	 			
	 		} else if(mTyId =='CB'){
	 			$scope.MKCAT = $scope.cat_cb ;
	 		
	 		} else if(mTyId =='ETC'){
	 			$scope.MKCAT = $scope.cat_etc ;
	 		
	 		} 	 		
	 		//console.log($scope.MKCAT);
   
	  };
	  
	$scope.findMakret =  function(arr,arr2){

		var r = [];		

		//angular.forEach(arr, function(i){
			
			angular.forEach(arr, function(k){
				
				if(arr2.indexOf(k.MTyId) !== -1){
					r.push(k);
				};				
		});
		return r;
	};
	 
	  $scope.addBet  = function (sd,mkid,sn,st,ht,at,p,bp,mid) { 	
			
			if($scope.betA||$scope.betB||$scope.betC||$scope.betD||$scope.betF||$scope.betG||$scope.betH){
				return
			}
			
			$scope.betE = true;  	
			$scope.betClick = true;
			
	  	for(var i = $scope.bet.length - 1; i >= 0; i--){  								
										
					if($scope.bet[i].Sd == sd){
						$scope.bet = $filter('omit')($scope.bet,'Sd ==' + sd);  // delete ID		
						
						if($scope.ISLG&&$scope.UID!="-1"){
							$scope.addCart($scope.UID);
						}
						
						return;
					};
					
					if($scope.bet[i].MId == mid){
						$scope.bet = $filter('omit')($scope.bet,'MId ==' + mid);  // delete ID
					//$scope.betA = true;
					//$scope.betClick = false;
					//return;
					};

			};		
			
	  	$scope.bet.push({
	  		MId:mid,
				Sd:sd,
				Mkid:mkid,
	   		Sn:sn,
	   		ST:st,
	   		HT:ht,
	   		AT:at,
	   		P:$filter('number')(p, 2),
	   		BP:$filter('number')(bp, 2),
	   		Amt:1000,
	   		SuM:false,
	   		SuK:false
			});		
			
			if($scope.ISLG&&$scope.UID!="-1"){
				$scope.addCart($scope.UID);
			}
				
			if($scope.bet.length<2)
				$scope.betM ="1";
				
			if($scope.bet.length>1)
				$scope.betM ="2";
				
		var element =  document.getElementById("betPrice");
		if(element) element.focus();          
	 };

/* 
	 $scope.setBet  = function (sd,mkid,sn,st,ht,at,p,bp,mid) { 	
	  	$scope.betE = true;  	
	  	for(var i = $scope.bet.length - 1; i >= 0; i--){  									
				if($scope.bet[i].Mkid == mkid){
					$scope.betA = true;
					return;					
				};
			};		
	  	$scope.bet.push({
	  		MId:mid,
	  		Sd:sd,
				Mkid:mkid,
	   		Sn:sn,
	   		ST:st,
	   		HT:ht,
	   		AT:at,
	   		P:$filter('number')(p, 2),
	   		BP:$filter('number')(bp, 2),
	   		Amt:1000,
	   		SuM:false,
	   		SuK:false
			});
					
		var element =  document.getElementById("betPrice");
		if(element) element.focus();          
	 };
*/ 
	  $scope.delBet  = function (sd) { 	  	
	  	for(var i = $scope.bet.length - 1; i >= 0; i--){							
				if($scope.bet[i].Sd == sd){
					$scope.bet.splice(i,1);
				};
			};
			
			if($scope.ISLG&&$scope.UID!="-1")
				$scope.addCart($scope.UID);
				
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
			
			if($scope.ISLG&&$scope.UID!="-1")
				$scope.addCart($scope.UID);
				
			$scope.betE = false;
			$scope.betA = false;
	 };
 	 		
	 $scope.conAlert  = function (alert) { 	  
	 	
	 	//document.getElementById("betA").style="display:none;"
	 		
	  if(alert == "1"){
	  	document.getElementById("betA").style="display:none;"
	  	 $scope.betA = false; 	 
	  	 $scope.betClick = true; 	 
	  	}
	  if(alert == "2") {
	  	document.getElementById("betB").style="display:none;"
	  	$scope.betB = false; 
	  	$scope.betClick = true; 
	  }
	  
	  if(alert == "3") {
	  	document.getElementById("betC").style="display:none;"
	  	$scope.betC = false; 	 
	  	//$scope.getHeader(); 	
	  }
	  
	  if(alert == "4") {
	  	document.getElementById("betD").style="display:none;"
	  	$scope.betD = false; 
	  	$scope.betE = true; 
	  	 $scope.betClick = true; 
	  }
	  
	  if(alert == "5") {
	  	document.getElementById("betF").style="display:none;"
	  	$scope.betF = false; 
	  	 $scope.betClick = true; 
	  }
	  
	  if(alert == "6") {
	  	document.getElementById("betG").style="display:none;"
	  	$scope.betG = false; 
	  	
	  	$scope.betConf = true;
	  	console.log("$scope.betM:" + $scope.betM);
	  	
	  	if($scope.betM =="2")
	  		$scope.betProcM();
	  	
	  	else if ($scope.betM =="1")
	  		$scope.betProcS();	  		
	  }
	  
	  if(alert == "7") {
	  	document.getElementById("betG").style="display:none;"
	  	$scope.betG = false; 
	  	$scope.betClick = true; 	 
	  }
	  
	  if(alert == "8") {
	  	document.getElementById("betH").style="display:none;"
	  	$scope.betH = false; 
	  }
	  
	  if(alert == "9") {
	  	document.getElementById("betJ").style="display:none;"
	  	$scope.betJ = false; 
	  	$scope.betClick = true;
	  }
	  
	  if(alert == "10") {
	  	document.getElementById("betK").style="display:none;"
	  	$scope.betK = false; 
	  	$scope.betClick = true;
	  }
	  
	 	//var element =  document.getElementById("betPrice");
		//if(element) element.focus();
	 };

   $scope.getMaketbyCid  = function (left,center,cid,sid) { 	  
   	
   	$scope.innerTab = []; 
  	$scope.centerTab = center;
    $scope.leftTab = left;
    $scope.tabDate = "0";
    $scope.pm_mode = "p"; 
    $scope.CID = cid;
    $scope.selectedSId = sid;
    $scope.PMk =[];
    getMatchInfobyCompetition(cid);
 }

   $scope.preMatchDate = function (left, center,cid,date) {
  	$scope.pm_mode = "p";  
  	$scope.innerTab = [];  
  	$scope.leftTab = left;
  	$scope.centerTab = center;
  	$scope.tabDate = date;
 }    

   $scope.todayMatch = function (dt) {
   		$scope.innerTab = []; 
			$scope.pm_mode = "t";  
			$scope.tabDt = dt;
			
			getTodayMatchInfo(dt);
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
	
	//console.log("$scope.mk_cat_before"); 
	
	$http({
	    url: s[20].u, 
	    method: "GET",
	     headers: {
        'Content-Type': 'utf-8'
       }
    }).success(function(data, status, headers, config) {  
    	
    	//console.log("$scope.mk_cat"); 	
    	//console.log(data[0]);
    	 	
	    $scope.cat_wl = data[0].WL;
	    $scope.cat_ou = data[0].OU;
	    $scope.cat_hd = data[0].HD;
	    
	    //console.log("$scope.cat_hd");
	    console.log($scope.cat_hd);
	    
	    $scope.cat_cb = data[0].CB;
	    $scope.cat_etc = data[0].ETC;

		}).error(function(data, status, headers, config) {
	    $scope.status = status;
	});
	
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
	
	
	if($scope.ISLG){	
			 
		$http({
				method: 'GET', 
				url: s[8].u, //'jsp/getFavMatch.jsp', 
				params: {'uid':$scope.UID},
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
	}

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
					//var w1Price, w2Price, xPrice  ="-";			
					//var w1SelId, xSelId, w2SelId ="";	
					
					var w1Price="0"; 
					var w2Price="0";
					var xPrice="0";
					var w1SelId="-1";
					var xSelId="-1";
					var w2SelId="-1";	
							
					for(var i = mSelect.length - 1; i >= 0; i--){
						if(mSelect[i].Nm == 'W1') {
							w1SelId = mSelect[i].Id ;
							//w1Price = mSelect[i].P ;			
							w1Price = $filter('number')(mSelect[i].P, 2);
							
						} else if(mSelect[i].Nm == 'X') {
							xSelId = mSelect[i].Id ;
							//xPrice = mSelect[i].P ;					
							xPrice = $filter('number')(mSelect[i].P, 2);
							
							
						} else if(mSelect[i].Nm == 'W2') {
							w2SelId = mSelect[i].Id ;
							//w2Price = mSelect[i].P ;
							w2Price = $filter('number')(mSelect[i].P, 2);
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
			    	B:false,	   	
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
			    	B:false,
					});				
				};
			  });
		 		
		 	}); 
			
			sub_loadBlockMatch($scope.BLR) ;
			
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
					Dt:obj.Dt,
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
						Dt:obj.Dt,
						RId:obj.RId,
						RN:obj.RN,
						CId:obj.CId,
						CN:obj.CN,
					 	MId:obj.Id,
					});
			  }); 
			};
			
			//$scope.tabCId = $scope.PM[1].CId;
  		//console.log($scope.tabCId);
  	
  		//getMatchInfobyCompetition($scope.tabCId);  	
  		getTodayMatchInfo($scope.date0);
  	
			data = null;
			
			
			
			}).error(function(data, status, headers, config) {
				console.log(status);
				data = null;
			});
	 };


	PreLoadLiveMatchInit();
	preLoadPreMatch();
	  	 
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
					Dt:data.Dt,
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
 
 	$scope.getMatchInfobyMatchId = function(mid) {	
	   $http({
				method: 'GET', 
				url: "jsp/getMatchInfobyMatchId.jsp", 
				params: { 'mid' : mid },
				headers: {'Content-Type': 'application/json; charset=utf-8'} 
		 }).success(function(data, status, headers, config) {		
		 			
			if(data) {
					$scope.MI = [];
					console.log(data);
					$scope.MI=data[0].Mt;
					console.log($scope.MI);
					
			};
			data = null;
			
		}).error(function(data, status, headers, config) {
		});
 };
 
	$scope.getMarketbyMatchId = function(mid) {	
		
	
		if(document.getElementById("spin_inner")){
			document.getElementById("spin_inner").style.display  = "block";
	  	document.getElementById("pre_inner").style.display = "none";
		}
	  
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
			//$scope.mTyId ="ALL";
		
		if(document.getElementById("spin_inner")){
	  	setTimeout(showPage_inner, 2000);
		}		
	  
		}).error(function(data, status, headers, config) {
		});
 };

	function ss(){
			document.getElementById("spin_inner").style.display  = "none";
	  	document.getElementById("pre_inner").style.display = "block";
	}

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
				      RemainingTime: data.RemainingTime,
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
		  			
		  		case "29": 	
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
	  			
	  			case "77": 	
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
 
 //var ret = 0;
  function subLoadLiveMatch(mid) {
	   $http({
				method: 'GET', 
				url:s[14].u,//'jsp/subLoadLiveMatch.jsp',
				params: { 'mid' : mid },
				headers: {'Content-Type': 'application/json; charset=utf-8'} 
		}).success(function(data, status, headers, config) {
				
				
				if(data[0].Re[0] == 'undefined' || data[0].Re.length<1){
					//ret=ret+1;					
					//var myVar = setTimeout(subLoadLiveMatch(mid), 1000*20);
					setInterval(function() { subLoadLiveMatch(mid); },1000*20); 
					
					console.log("data[0].Re.length<1");
					console.log("return [MId]:" + mid);
					return;
				}
				
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

				
				if(mode != "PreMatch"){
					
					if(data[0].Mk !== undefined && data[0].Mk !== null && data[0].Mk.length > 0){
						for (var j = 0; j < data[0].Mk.length ; j++) {						
							$scope.LMKc.push(data[0].Mk[j]);							
						}
					}
								
				if(data[0].Re !== undefined && data[0].Re !== null && data[0].Re.length > 0){					
					//var w1Price, w2Price, xPrice="-";					
					//var w1SelId, xSelId, w2SelId ="";			
			    
			    var w1Price="0"; 
					var w2Price="0";
					var xPrice="0";
					var w1SelId="-1";
					var xSelId="-1";
					var w2SelId="-1";	
							
			    for(var i = data[0].Se.length - 1; i >= 0; i--){						
						if(data[0].Se[i].Nm=='W1') {
							w1SelId = data[0].Se[i].Id ;
							//w1Price = data[0].Se[i].P ;
							w1Price = $filter('number')(data[0].Se[i].P, 2);
						
						} else if(data[0].Se[i].Nm=='X') {
							xSelId = data[0].Se[i].Id ;
							//xPrice = data[0].Se[i].P ;
							xPrice = $filter('number')(data[0].Se[i].P, 2);
						
						} else if(data[0].Se[i].Nm=='W2') {
							w2SelId = data[0].Se[i].Id ;
							//w2Price = data[0].Se[i].P ;
							w2Price = $filter('number')(data[0].Se[i].P, 2);
						}
					};
					
				}
			}
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
			    	B:false,	
					});
			  
			  if(mode != "PreMatch"){
			  				  		
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
			    	//MkId:data[0].Re[0].Id, 
			    	//Sus:data[0].Re[0].Sus, 
			    	//Vis:data[0].Re[0].Vis,
			    	MkId:(data[0].Re[0].Id == undefined) ? "" : data[0].Re[0].Id,
			    	Sus:(data[0].Re[0].Sus == undefined) ? "" : data[0].Re[0].Sus,
			    	Vis:(data[0].Re[0].Vis == undefined) ? "" : data[0].Re[0].Vis,	
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
			    	B:false,
					});
				}				
				data = null;
		}).error(function(data, status, headers, config) {
				console.log(status);
				data = null;
		});
 };
 
  function getTodayMatchInfo(dt) {	 
  	
  	// console.log("dt:"+dt);
  	 
  	if(dt != "1"){
	
	  //		document.getElementById("spin_clive2").style.display  = "block";
	  //		document.getElementById("clive2").style.display = "none";
	  		//console.log("dt==" + dt);
	  		
	  } else {
	  	dt = $scope.date0;
	  }
	  
	   $http({
				method: 'GET', 
				url: s[22].u, 
				params: { 'dt' : dt },
				headers: {'Content-Type': 'application/json; charset=utf-8'} 
		}).success(function(data, status, headers, config) {	
							
			//$scope.toPMkC = [];
			$scope.toPMk = [];
			//$scope.tabCId = cid;
			
			console.log(data);
			

			//if(data[0].Mk !== null &&  data[0].Mk !== undefined && data[0].Mk.length > 0){					
			//	for (var j = 0; j < data[0].Mk.length ; j++) {						
			//		$scope.toPMkC.push(data[0].Mk[j]);							
			//	}
			//};		
			
			if(data[0].Mt !== null &&  data[0].Mt !== undefined && data[0].Mt.length > 0){
				
				for (var j = 0; j < data[0].Mt.length ; j++) {										
					//var w1Price, w2Price, xPrice ="-";
					//var w1SelId, xSelId, w2SelId ="";										
					
					var w1Price="0"; 
					var w2Price="0";
					var xPrice="0";
					var w1SelId="-1";
					var xSelId="-1";
					var w2SelId="-1";	
							
					var mMatchResult = data[0].Re.filter(function (el) { return el.MId == data[0].Mt[j].Id; });	
															
					if(mMatchResult !== null && mMatchResult !== undefined && mMatchResult.length > 0 ){
						var mResult = data[0].Se.filter(function (el) { return el.MkId == mMatchResult[0].Id });
						
						for (var i = 0; i < mResult.length; i++) {								
							if(mResult[i].Nm == 'W1') {
								w1SelId = mResult[i].Id ;
								//w1Price = mResult[i].P;
								w1Price = $filter('number')(mResult[i].P, 2);
							
							} else if(mResult[i].Nm == 'X'){
								xSelId = mResult[i].Id ;
								//xPrice = mResult[i].P;
								xPrice = $filter('number')(mResult[i].P, 2);
							
							} else if(mResult[i].Nm == 'W2'){
								w2SelId = mResult[i].Id ;
								//w2Price = mResult[i].P;
								w2Price = $filter('number')(mResult[i].P, 2);
							}
						};
			  									  			  		
			  		$scope.toPMk.push({
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
			      	B:false,
			  		});			  		

			  	}else{
			  		
			  		$scope.toPMk.push({
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
			      	B:false,
				  		});	
			  		}
		  				  	
		    };
		     
	  	};
			data = null;				
		
			sub_loadBlockMatch($scope.BLR) ;
	  		
	  	//document.getElementById("clive2").style.display  = "block";
	  	//document.getElementById("spin_clive2").style.display = "none";

	  	console.log($scope.toPMk);
	  	
	  
			}).error(function(data, status, headers, config) {
				console.log(status);
				data = null;	
			});
 }
 
  $scope.getMatchInfobySport = function (sd,dt) {	  
 		
 		//console.log("getMatchInfobySport");
 		//console.log(sd);
 		//console.log(dt);
 		
 		document.getElementById("spin_clive2").style.display  = "block";
	  document.getElementById("clive2").style.display = "none";
	  
	  $scope.tabDate = dt; 
	    
	   $http({
				method: 'GET', 
				url: s[23].u, 
				params: { 'sd':sd,'dt':dt },
				headers: {'Content-Type': 'application/json; charset=utf-8'} 
		}).success(function(data, status, headers, config) {	
							
			//$scope.PMkC = [];
			$scope.PMk = [];
			$scope.tabCId = "-2";
			
			console.log(data);
			

		//	if(data[0].Mk !== null &&  data[0].Mk !== undefined && data[0].Mk.length > 0){					
		//		for (var j = 0; j < data[0].Mk.length ; j++) {						
		//			$scope.PMkC.push(data[0].Mk[j]);							
		//		}
		//	};
					
			if(data[0].Mt !== null &&  data[0].Mt !== undefined && data[0].Mt.length > 0){
				
				for (var j = 0; j < data[0].Mt.length ; j++) {										
					//var w1Price, w2Price, xPrice ="-";
					//var w1SelId, xSelId, w2SelId ="";										
					
					var w1Price="0"; 
					var w2Price="0";
					var xPrice="0";
					var w1SelId="-1";
					var xSelId="-1";
					var w2SelId="-1";	
							
					var mMatchResult = data[0].Re.filter(function (el) { return el.MId == data[0].Mt[j].Id; });	
															
					if(mMatchResult !== null && mMatchResult !== undefined && mMatchResult.length > 0 ){
						var mResult = data[0].Se.filter(function (el) { return el.MkId == mMatchResult[0].Id });
						
						for (var i = 0; i < mResult.length; i++) {								
							if(mResult[i].Nm == 'W1') {
								w1SelId = mResult[i].Id ;
								//w1Price = mResult[i].P;
								w1Price = $filter('number')(mResult[i].P, 2);
							
							} else if(mResult[i].Nm == 'X'){
								xSelId = mResult[i].Id ;
								//xPrice = mResult[i].P;
								xPrice = $filter('number')(mResult[i].P, 2);
							
							} else if(mResult[i].Nm == 'W2'){
								w2SelId = mResult[i].Id ;
								//w2Price = mResult[i].P;
								w2Price = $filter('number')(mResult[i].P, 2);
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
			      	B:false,
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
			      	B:false,
				  		});	
			  		}
		  				  	
		    };
		     
	  	};
			data = null;				
			
			//$scope.tabDate = "0";
			
		//	console.log($scope.PMk);
   	//	var ss = $scope.PMk.filter(function (el) { return el.CId == cid; })[0]
   	//	console.log(ss);
   		
   	//document.getElementById("selsport1").innerHTML = ss.SN;
	  //document.getElementById("selcomp1").innerHTML = ss.CN;
			
		document.getElementById("spin_clive2").style.display  = "none";
	  document.getElementById("clive2").style.display = "block";
	  	
		}).error(function(data, status, headers, config) {
			console.log(status);
			data = null;	
		});

	  
 }
 
 	function getMatchInfobyCompetition(cid) {	  
 		
 		document.getElementById("spin_clive2").style.display  = "block";
	  document.getElementById("clive2").style.display = "none";
	    
	   $http({
				method: 'GET', 
				url: s[15].u, 
				params: { 'cid' : cid },
				headers: {'Content-Type': 'application/json; charset=utf-8'} 
		}).success(function(data, status, headers, config) {					
			
			//$scope.PMkC = [];
			$scope.PMk = [];
			$scope.tabCId = cid;

			//if(data[0].Mk !== null &&  data[0].Mk !== undefined && data[0].Mk.length > 0){					
			//	for (var j = 0; j < data[0].Mk.length ; j++) {						
			//		$scope.PMkC.push(data[0].Mk[j]);							
			//	}
			//};		
			if(data[0].Mt !== null &&  data[0].Mt !== undefined && data[0].Mt.length > 0){
				
				for (var j = 0; j < data[0].Mt.length ; j++) {										
					//var W1Price, w2Price, xPrice ="-";
					//var w1SelId, xSelId, w2SelId ="";		
													
					var w1Price="0"; 
					var w2Price="0";
					var xPrice="0";
					var w1SelId="-1";
					var xSelId="-1";
					var w2SelId="-1";	
					
					var mMatchResult = data[0].Re.filter(function (el) { return el.MId == data[0].Mt[j].Id; });	
															
					if(mMatchResult !== null && mMatchResult !== undefined && mMatchResult.length > 0 ){
						var mResult = data[0].Se.filter(function (el) { return el.MkId == mMatchResult[0].Id });
						
						for (var i = 0; i < mResult.length; i++) {								
							if(mResult[i].Nm == 'W1') {
								w1SelId = mResult[i].Id ;
								//w1Price = mResult[i].P;
								w1Price = $filter('number')(mResult[i].P, 2);
							
							} else if(mResult[i].Nm == 'X'){
								xSelId = mResult[i].Id ;
								//xPrice = mResult[i].P;
								xPrice = $filter('number')(mResult[i].P, 2);
							
							} else if(mResult[i].Nm == 'W2'){
								w2SelId = mResult[i].Id ;
								//w2Price = mResult[i].P;
								w2Price = $filter('number')(mResult[i].P, 2);
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
			      	B:false,
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
			      	B:false,
				  		});	
			  		}
		  				  	
		    };
		     
	  	};
			data = null;				
			
		//	console.log($scope.PMk);
   		var ss = $scope.PMk.filter(function (el) { return el.CId == cid; })[0]
   	//	console.log(ss);
   		
   	document.getElementById("selsport1").innerHTML = ss.SN;
	  document.getElementById("selcomp1").innerHTML = ss.CN.substring(0,20); 
		document.getElementById("spin_clive2").style.display  = "none";
	  document.getElementById("clive2").style.display = "block";
	  	
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
		$scope.bet = $filter('omit')($scope.bet,'MId ==' + mid);  // delete ID	
		
		for(var r = $scope.bet.length - 1;r >= 0; r--){																	
			if($scope.bet[r].MId == obj.Id){				
					$scope.bet[r].SuM = true ;	
				console.log("$scope.bet[r].Su");										
			};
		};	
			
		//check favorite match and bet match
	}
	
	function finishPreMatch(mid) {		
		$scope.PM = $filter('omit')($scope.PM,'MId ==' + mid);  // delete ID					
		$scope.PMk = $filter('omit')($scope.PMk,'MId ==' + mid);  // delete ID			
		$scope.toPMk = $filter('omit')($scope.toPMk,'MId ==' + mid);  // delete ID	
		$scope.bet = $filter('omit')($scope.bet,'MId ==' + mid);  // delete ID			
	
		for(var r = $scope.bet.length - 1;r >= 0; r--){																	
			if($scope.bet[r].MId == obj.Id){				
					$scope.bet[r].SuM = true ;	
				console.log("$scope.bet[r].Su");										
			};
		};	
		
		//$scope.PMkC = $filter('omit')($scope.PMkC,'MId ==' + mid);  // delete ID			
		//$scope.toPMkC = $filter('omit')($scope.toPMkC,'MId ==' + mid);  // delete ID	
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
				 		//var w1Price, w2Price, xPrice ="-";
						//var w1SelId, xSelId, w2SelId  ="";
							
							var w1Price="0"; 
							var w2Price="0";
							var xPrice="0";
							var w1SelId="-1";
							var xSelId="-1";
							var w2SelId="-1";	
										
		    		for (var j = 0; j < obj.Selections.length; j++) {
							
			    		if(obj.Selections[j].Name == 'W1') {
			    			w1SelId = obj.Selections[j].Id ;
			    			//w1Price = obj.Selections[j].Price ;
			    			w1Price = $filter('number')(obj.Selections[j].Price, 2);
			    		
			    		} else if(obj.Selections[j].Name == 'X') {
								xSelId = obj.Selections[j].Id ;
								//xPrice = obj.Selections[j].Price ;
								xPrice = $filter('number')(obj.Selections[j].Price, 2);
							
							} else if(obj.Selections[j].Name == 'W2') {
								w2SelId = obj.Selections[j].Id ;
								//w2Price = obj.Selections[j].Price ;
								w2Price = $filter('number')(obj.Selections[j].Price, 2);
							}
						};
						
						//console.log("w1Price : " + w1Price);
						//console.log("xPrice : " + xPrice);
						//console.log("w2Price : " + w2Price);
						
						
	      									
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
				      	B:lm.B,
			  			});
				  	};				  						 
					};						
				};
			}
			
			if(mode == "PreMatch" ){	
				
				
				if($scope.pm_mode == "p" ){	
						
						//console.log("$scope.pm_mode == p");
						
					for (var c = 0; c < $scope.PMk.length; c++) {		
								
				 		var pm = $scope.PMk[c];	
				 				 		
					 	if(pm.MkId == obj.Id){	
					 		
					 		//console.log("pre-match market:" + obj.Id);
					 		//console.log("$scope.pm_mode:" + $scope.pm_mode);
					 						 		
					 		//var w1Price, w2Price, xPrice ="-";
							//var w1SelId, xSelId, w2SelId  ="";
							
							var w1Price="0"; 
							var w2Price="0";
							var xPrice="0";
							var w1SelId="-1";
							var xSelId="-1";
							var w2SelId="-1";	
									
			    		for (var j = 0; j < obj.Selections.length; j++) {
								
				    		if(obj.Selections[j].Name == 'W1') {
				    			w1SelId = obj.Selections[j].Id ;
				    			//w1Price = obj.Selections[j].Price ;
				    			w1Price = $filter('number')(obj.Selections[j].Price, 2);
				    		
				    		} else if(obj.Selections[j].Name == 'X') {
									xSelId = obj.Selections[j].Id ;
									//xPrice = obj.Selections[j].Price ;
									xPrice = $filter('number')(obj.Selections[j].Price, 2);
								
								} else if(obj.Selections[j].Name == 'W2') {
									w2SelId = obj.Selections[j].Id ;
									//w2Price = obj.Selections[j].Price ;
									w2Price = $filter('number')(obj.Selections[j].Price, 2);
								}
							};
		      									
							if(w1Price != pm.W1P || xPrice != pm.XP || w2Price != pm.W2P ||  pm.Sus != obj.IsSuspended){							
								
								$scope.PMk = $filter('omit')($scope.PMk,'MkId ==' + obj.Id); 
								
								console.log("omit: 'MkId =='" + obj.Id);
								 								
				        $scope.PMk.push({
				        	Dt:pm.Dt,
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
			      			BW1P:pm.W1P,
					      	BXP:pm.XP,
					      	BW2P:pm.W2P,			      	
					      	W1P:w1Price,
					      	XP:xPrice,
					      	W2P:w2Price,
					      	B:pm.B,
				  			});
				  			
				  			console.log("push: 'MkId =='" + obj.Id);
				  			
					  	};				  						 
						};						
					};
					
				}else if ($scope.pm_mode == "t" ){	
					
					//console.log("$scope.pm_mode == t");
					
					for (var c1 = 0; c1 < $scope.toPMk.length; c1++) {		
								
				 		var topm = $scope.toPMk[c1];	
				 				 		
					 	if(topm.MkId == obj.Id){					 	
					 			
					 		//console.log("pre-match market:" + obj.Id);
					 		//console.log("$scope.pm_mode:" + $scope.pm_mode);
					 		
					 		//var w1Price, w2Price, xPrice ="-";
							//var w1SelId, xSelId, w2SelId  ="";
							
							var w1Price="0"; 
							var w2Price="0";
							var xPrice="0";
							var w1SelId="-1";
							var xSelId="-1";
							var w2SelId="-1";	
											
			    		for (var j = 0; j < obj.Selections.length; j++) {
								
				    		if(obj.Selections[j].Name == 'W1') {
				    			w1SelId = obj.Selections[j].Id ;
				    			//w1Price = obj.Selections[j].Price ;
				    			w1Price = $filter('number')(obj.Selections[j].Price, 2);
				    		
				    		} else if(obj.Selections[j].Name == 'X') {
									xSelId = obj.Selections[j].Id ;
									//xPrice = obj.Selections[j].Price ;
									xPrice = $filter('number')(obj.Selections[j].Price, 2);
								
								} else if(obj.Selections[j].Name == 'W2') {
									w2SelId = obj.Selections[j].Id ;
									//w2Price = obj.Selections[j].Price ;
									w2Price = $filter('number')(obj.Selections[j].Price, 2);
								}
							};
		      									
							if(w1Price != topm.W1P || xPrice != topm.XP || w2Price != topm.W2P ||  topm.Sus != obj.IsSuspended){							
								$scope.toPMk = $filter('omit')($scope.toPMk,'MkId ==' + obj.Id);  
								
								console.log("omit[toPMk]: 'MkId =='" + obj.Id);
					 										
				        $scope.toPMk.push({
				        	Dt:topm.Dt,
					    		SId:topm.SId,
					    		SN:topm.SN,	    		
					    		RId:topm.RId,
					    		RN:topm.RN,
					    		CId:topm.CId,
					    		CN:topm.CN,
					      	MId:topm.MId,
					      	HT:topm.HT,
					      	AT:topm.AT,
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
			      			BW1P:topm.W1P,
					      	BXP:topm.XP,
					      	BW2P:topm.W2P,			      	
					      	W1P:w1Price,
					      	XP:xPrice,
					      	W2P:w2Price,
					      	B:topm.B,
				  			});
				  			
				  			console.log("push[toPMk]: 'MkId =='" + obj.Id);
				  			
					  	};				  						 
						};						
					};
				}
				
			}
			
			//console.log("$scope.tabMId ==" + $scope.tabMId);
			
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
												//BP:mk.Se[n].BP,
											 	BP:$filter('number')(mk.Se[n].BP, 2),
												Id:obj.Selections[j].Id,
												MkId:mk.Se[n].MkId,
												Nm:mk.Se[n].Nm,
												Or:obj.Selections[j].Order,
												//P:obj.Selections[j].Price,	
												P:$filter('number')(obj.Selections[j].Price, 2)												
										});		
										//console.log("mk.Se[n].BP:"+mk.Se[n].BP);
										//console.log("$filter('number')(mk.Se[n].BP, 2):"+$filter('number')(mk.Se[n].BP, 2));
																		
									};
								};
							};
						
							$scope.MK = $filter('omit')($scope.MK,'Id ==' + obj.Id);  	
							
							console.log("omit[MK]: 'MkId =='" + obj.Id);
							
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
						
						console.log("push[MK]: 'MkId =='" + obj.Id);
																
					   sel_tmp = [];
					   
					   sonsole.log($scope.MK);
					   
				  	}
				 };
				 
			  if(newCmarket && obj.IsVisible){ 		 		
				  		getMarketbyMarketId(obj.Id);		
			  };
			};

			for(var r = $scope.bet.length - 1;r >= 0; r--){					
					var betMk = $scope.bet[r];			
											
					if(betMk.Mkid == obj.Id){	
						$scope.bet[r].SuK = obj.IsSuspended;															
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
				      	B:LS_obj.B,	     	
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
				      	B:LS_obj.B,	    	
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
					      RemainingTime: obj.RemainingTime,
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
				  			
				  			case 29: 					  								  		
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
						      IsTimeout : obj.IsTimeout,
				  			});								  		
			  				break;
			  				
			  				case 77: 					  								  		
					   		$scope.liveTop.push({
					   			SId:obj.SportKind,
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
						      IsTimeout : obj.IsTimeout,
				  			});								  		
			  				break;
			  				
				  			
				  		};

		  			}; 		
				  };
				}); 
			};	
			
			for(var r = $scope.bet.length - 1;r >= 0; r--){					
				var betMk = $scope.bet[r];														
				if(betMk.MId == obj.Id){				
					$scope.bet[r].SuM = obj.IsSuspended ;	
					console.log("$scope.bet[r].Su");										
				};
			};	
								
		});	
	};
		
  function sub_loadGetMatch(res) {		  	  	
  	  	  	
  	angular.forEach(res.Objects, function(obj,idx) {						
			
			if(!obj.IsBooked){
					return;
			};
			
			if(mode == "LiveMatch"){ 	
				
				
				var nlm = true;
				
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
					      	B:LS_obj.B,	    	
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
				
			
			} else if(mode == "PreMatch" ){	
					var npm = true;
					
					console.log("sub_loadGetMatch:[tabCid] = "+$scope.tabCId);
					console.log("sub_loadGetMatch:[tabCid] = "+$scope.tabCId);					
					console.log("sub_loadGetMatch:[obj.CompetitionId] = "+obj.CompetitionId);
					console.log("sub_loadGetMatch:[obj.Date] = "+obj.Date);
										
					angular.forEach($scope.PM, function(pm_obj,i3) {
		  			  		
			  		if (pm_obj.MId == obj.Id){			  					  			
			  			
			  			npm = false;			
			  			
			  			if(!obj.IsVisible){	
			  				finishPreMatch(obj.Id);
			  				
			  			} else if(!obj.IsBooked){	  				
			  				finishPreMatch(obj.Id);
			  			
			  			} else if(obj.MatchStatus != '0'){	  				
			  				finishPreMatch(obj.Id);
				
			  			} else if(obj.IsLive) {
			  				finishPreMatch(obj.Id);
			  			}		 
					  };
					});
					
				if(npm && obj.IsVisible && obj.MatchStatus == '0' && obj.IsBooked ){
					
						console.log("sub_loadGetMatch:[tabCid] = "+$scope.tabCId);
						console.log("sub_loadGetMatch:[tabCid] = "+$scope.tabCId);						
						console.log("sub_loadGetMatch:[obj.CompetitionId] = "+obj.CompetitionId);
						console.log("sub_loadGetMatch:[obj.Date] = "+obj.Date);
						
						subLoadPreMatch(obj.Id);	

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
			$scope.betPrice_p = tBetP;
			$scope.betPrice = $filter('number')(tBetP, 2);
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

/*
	$scope.$on('my-accordion:onExpandAnimationEnd', function () {
		// console.log("onExpandAnimationEnd");
	  $scope.tabMId = "0";
	});
*/

	$scope.openSel = function() {
	  var cname = document.getElementById("selsport").className;	  
	  if(cname == "effect_more select open"){
	  	document.getElementById("selsport").className ="effect_more select";
	  }else {
	  	document.getElementById("selsport").className ="effect_more select open";
	  }	  
	};

	$scope.closeSel = function() {
	  var cname = document.getElementById("selsport").className;	  
	  //console.log("closeSel");
	  
	  if(cname == "effect_more select open"){
	  	document.getElementById("selsport").className ="effect_more select";
	  }
	};
	
	$scope.openComp = function() {
	  var cname = document.getElementById("selcomp").className;	  
	  if(cname == "effect_more select open"){
	  	document.getElementById("selcomp").className ="effect_more select";
	  }else {
	  	document.getElementById("selcomp").className ="effect_more select open";
	  }
	};

	$scope.closeComp = function() {
	  var cname = document.getElementById("selcomp").className;	  
	  //console.log("closeSel");
	  
	  if(cname == "effect_more select open"){
	  	document.getElementById("selcomp").className ="effect_more select";
	  }
	};
	
	$scope.selSport = function(sid,sname) {
	  //console.log("sname:"+sname);
	  
	  $scope.selectedSId = sid;
	  $scope.tabCId ="-1"; 
	  //document.getElementById("selsport1").innerHTML = sname;
	  document.getElementById("selsport1").innerHTML = sname;
	  
	  if(sname == "종목 전체"){
	  	document.getElementById("selcomp1").innerHTML ="리그 전체 ";	
	  	$scope.pm_mode = "t"; 

	  } else { 
	  	document.getElementById("selcomp1").innerHTML = "리그 선택";
	  }
	};

	$scope.selComp = function(cid,cname) {		
		$scope.innerTab = [];
		$scope.toggleMId = "";
		$scope.tabMId = "0"; 
	  document.getElementById("selcomp1").innerHTML = cname.substring(0,20);	  
	  //$scope.pm_mode = "p";	  
	  $scope.tabDate = "0";
	  
	  if(cid =="-1"){
	  	
	  	if($scope.selectedSId == "0"){
	  		$scope.pm_mode = "t";
	  		getTodayMatchInfo($scope.date0);
	  			  		
	  	} else {
	  		//console.log("$scope.selectedSId:"+$scope.selectedSId);
		  	$scope.pm_mode = "m";
			  var fdt = $filter('orderBy')($scope.PM.filter(function (el) { return el.SId == $scope.selectedSId; }), "Dt")[0].Dt ;
				$scope.tabDate = fdt; 		  
		  	$scope.getMatchInfobySport($scope.selectedSId,$scope.tabDate);
	  	}

	  } else { 
	  	$scope.pm_mode = "p";
	  	getMatchInfobyCompetition(cid);
	  }
	  
	   //getMatchInfobyCompetition(cid);
	};
	
	$scope.llive_load = function() {
	    var myVar = setTimeout(showPage_llive, 2000);
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
	
	$scope.inner_load_r = function() {
	    var myVar = setTimeout(showPage_inner_r, 2000);
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
  
  $scope.getFavMkId = function(mid,mkid) {		
		$scope.mTyId = "FAV";
		$scope.Fav_mode = true;
	}
	
	$scope.us_mkt = function(mid,mkid) {		
		
		//$scope.savedFavM = [];		
		$('#'+mkid).toggleClass("fa-star fa-star-o");		
		
		$scope.savedFavM = JSON.parse(localStorage.getItem('SFM'));
		
		if($scope.savedFavM  == null)
			$scope.savedFavM = [];
			
		if( $('#'+mkid).hasClass("fa-star-o") ) {

			$scope.savedFavM = $filter('omit')($scope.savedFavM,'mkid ==' + mkid);  // delete 
			
			localStorage.setItem('SFM',JSON.stringify($scope.savedFavM));			
						
		} else { 
			
			$scope.savedFavM.push({
				mid:mid,
				mkid: mkid,
			});			
			localStorage.setItem('SFM',JSON.stringify($scope.savedFavM));		
			$scope.savedFavM = JSON.parse(localStorage.getItem('SFM'));
		}
	};
	
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
	
	$scope.sInfo = function() {
			
		var s = document.sm.k.value;
		//var ss = encodeURIComponent(s);		
		//console.log("s:"+s);
				
		 $http({
				method: 'GET', 
				url: "jsp/getSearchMatch.jsp", 
				params: {'key':s},
				headers: {'Content-Type': 'application/json; charset=utf-8'} 
				
		}).success(function(data, status, headers, config) {				
		
		if(data) {		
			
			//console.log(document.sm.k.value);
			//console.log(data);
		
			$scope.SM = [];

	    angular.forEach(data, function(obj,idx) {      
				$scope.SM.push({
					SId:obj.SID,
					Dt:obj.MDT,
					SN:obj.SN,
					LS:obj.LSTAT,
					HT:obj.HT,
					AT:obj.AT,
					//RId:obj.RId,
					RN:obj.RN,
					//CId:obj.CId,
					CN:obj.CN,
				 	MId:obj.MID,
				});
		  }); 
			
			//console.log($scope.SM);
			
		};
		
		data = null;
		
		}).error(function(data, status, headers, config) {
			console.log(status);
			data = null;
		});
 };

 $scope.getDayLabel = function(lday) { 
	var week = new Array('(일)', '(월)', '(화)', '(수)', '(목)', '(금)', '(토)');  
	var today = new Date(lday).getDay(); 
	var todayLabel = week[today]; 
	return todayLabel; 
}

 $scope.getDay = function(add) { 
 	
 	var date = moment();
	return date.add(1, 'days');

	//var today = new Date(); 
	//var todayLabel = week[today]; 
	//return todayLabel; 
	//return new Date().setDate(today.getDate()+1)
	//return today;
}



 $scope.getMaxBet = function() {			
 	
 	//var selids = $scope.bet.filter(function (el) { return el.Sd});	
 	var selids = $scope.bet.map(function(elem) { return elem.Sd ;})
 	console.log(selids);
 	
 	if(!$scope.ISLG){
		$scope.betH = true;
		$scope.betClick = false;
		return
	}
		
		 $http({
				method: 'POST', 
				url: s[24].u,  
				params: {'sel':selids},
				headers: {'Content-Type': 'application/json; charset=utf-8'} 
			}).success(function(data, status, headers, config) {	
			
			if(data) {		
			
				$scope.betAmt[0] = data.trim();
				console.log($scope.betAmt[0]);
			}
			
				data=null;
			}).error(function(data, status, headers, config) {
				console.log(status);
				data=null;
			});
	
 };
 
 $scope.getMaxBetS = function(sel) {			
 	
 	//var selids = $scope.bet.filter(function (el) { return el.Sd});	
 	//var selids = $scope.bet.map(function(elem) { return elem.Sd ;})
 	console.log(sel);
 	
 	if(!$scope.ISLG){
		$scope.betH = true;
		$scope.betClick = false;
		return
	}
	
 	
		 $http({
				method: 'POST', 
				url: s[24].u,  
				params: {'sel':sel},
				headers: {'Content-Type': 'application/json; charset=utf-8'} 
			}).success(function(data, status, headers, config) {	
			
			if(data) {		
			console.log("data:"+data);
			 angular.forEach($scope.bet, function(b,i) {
  									 
					if (b.Sd == sel){					  			
		  			$scope.bet[i].Amt = data.trim();					  							  		
	  			};
	  		});
			
			console.log(data);
			}
			
			data=null;
			}).error(function(data, status, headers, config) {
				console.log(status);
				data=null;
			});
	
 };
 
$scope.betMode = function(m) {		
	$scope.betM = m
};


$scope.betProcM = function() {		
	
	//console.log("$scope.ISLG:"+$scope.ISLG);
	
	if(!$scope.ISLG){
		$scope.betB = true;
		$scope.betClick = false;
		return
	}
	
	var chbet = 0;
	var betSus = false;
	
	for(var i = $scope.bet.length - 1; i >= 0; i--){  
		//tamt += parseInt($scope.bet[i].Amt);		 
		 if($scope.bet[i].P != $scope.bet[i].BP)
		 	chbet = 1;
		 	
		  if($scope.bet[i].SuM||$scope.bet[i].SuK||$scope.bet[i].B)
		 	betSus = true;
	};		
	
	if(betSus){
		$scope.betK = true;
		$scope.betClick = false;
		return;
	}
	
	if(parseInt($scope.betAmt[0]) > $scope.ubal){
		$scope.betF = true;
		$scope.betClick = false;
		return;
	}
	
	if($scope.betPrice_p > 1000){
		$scope.betJ = true;
		$scope.betClick = false;
		console.log("$scope.betPrice_p:"+$scope.betPrice_p);
		return;
	}
	
	console.log("document.getElementById('cb').checked = "+document.getElementById('cb').checked)
	
	if(!document.getElementById("cb").checked && chbet>0 && !$scope.betConf){
		$scope.betG = true;
		$scope.betClick = false;
		return;
	}
	
	$scope.betConf = false;
	
	var selids = $scope.bet.map(function(elem) { return elem.Sd ;})
	
	 $http({
		method: 'POST', 
		url: s[25].u,  
		params: {'sel':selids,'amt':$scope.betAmt[0]},
		headers: {'Content-Type': 'application/json; charset=utf-8'} 
	}).success(function(data, status, headers, config) {	
	
	if(data) {			
			console.log(data.trim());
			
		if(data.trim() =="1"){			
			//console.log("OK:"+data);
			$scope.getHeader(); 	
			$scope.bet = [];
			
			if($scope.ISLG&&$scope.UID!="-1"){
				$scope.addCart($scope.UID);
			}
			
	  	$scope.betC = true; 
	  	$scope.betE = false;
	  	
	  	
	  } else {
	  	$scope.betD = true; 
	  	$scope.betE = false;
	  }
	}	
		
	data=null;
	}).error(function(data, status, headers, config) {
		console.log(status);
		data=null;
	});
			
 	//console.log(selids);
 	
};


$scope.betProcS = function() {		
	//$scope.betM = m
	
	console.log("$scope.ISLG:"+$scope.ISLG);
	
	if(!$scope.ISLG){
		$scope.betB = true;
		$scope.betClick = false;
		return
	}
	
	var tamt = 0;	
	var chbet = 0;
	var betSus = false;
	//var trate = 1;	
	
	for(var i = $scope.bet.length - 1; i >= 0; i--){  
		tamt += parseInt($scope.bet[i].Amt);
		//trate = trate*($scope.bet[i].P).replace(',','');
				 
		 if($scope.bet[i].P != $scope.bet[i].BP)
		 	chbet = 1;
		 	
		 	if($scope.bet[i].SuM||$scope.bet[i].SuK||$scope.bet[i].B)
		 		betSus = true;
		 		
	};	
	
	if(betSus){
		$scope.betK = true;
		$scope.betClick = false;
		return;
	}
	
	//console.log("tamt:"+tamt);
	//console.log("trate:"+trate);
	//console.log("chbet:"+chbet);
		
	if(tamt > $scope.ubal){
		$scope.betF = true;
		$scope.betClick = false;
		return
	}
		
	console.log("$scope.betConf:"+$scope.betConf);
	console.log("$scope.betG:"+$scope.betG);
	
	console.log("document.getElementById('cb').checked = "+document.getElementById('cb').checked)
	
	if(!document.getElementById("cb").checked && chbet>0 && !$scope.betConf){
		$scope.betG = true;
		$scope.betClick = false;
		return
	}
	
	/*
	if(trate > 1000){
		$scope.betJ = true;
		console.log("trate:"+trate);
		return;
	}
	*/
	
	$scope.betConf = false;
	
	//var tAmt = $scope.bet.map(function(elem) { return elem.Amt ;})	
	//console.log("tAmt:"+tAmt);
	
	var selids = $scope.bet.map(function(elem) { return elem.Sd ;})
	var selamts = $scope.bet.map(function(elem) { return elem.Sd+'P'+elem.Amt;})
	
	//selids = selids.trim();
	//selamts = selamts.trim();
	
 	console.log(selids);
 	console.log(selamts);
 	
 	$http({
		method: 'POST', 
		url: s[26].u,  
		params: {'sel':selids,'amt':selamts},
		headers: {'Content-Type': 'application/json; charset=utf-8'} 
	}).success(function(data, status, headers, config) {	
	
	if(data) {			
		
		console.log(data.trim());
			
		if(data.trim() =="1"){			
			//console.log("OK:"+data);
			$scope.getHeader(); 
			$scope.bet = [];
			
			if($scope.ISLG&&$scope.UID!="-1"){
				$scope.addCart($scope.UID);
			}
			
	  	$scope.betC = true; 
	  	$scope.betE = false;
	  	
	  } else {
	  	$scope.betD = true; 
	  	$scope.betE = false;
	  }
	}
	
	data=null;
	}).error(function(data, status, headers, config) {
		console.log(status);
		data=null;
	});

};

$scope.getHeader = function() {	
	
	 	$http({
		method: 'POST', 
		url: '/login/jsp/get_header.jsp',  
		headers: {'Content-Type': 'application/json; charset=utf-8'} 
	}).success(function(data, status, headers, config) {	
	
		//console.log(data)
		
		$("#uhead").html(data.header);
		
		data=null;
		
	}).error(function(data, status, headers, config) {
		console.log(status);
		data=null;
	});
}

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
	
	function showPage_inner_r() {
	  document.getElementById("spin_inner").style.display  = "block";
	  document.getElementById("pre_inner").style.display = "none";
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

	function openSel() {
	  var cname = document.getElementById("selsport").className;	  
	  if(cname == "effect_more select open"){
	  	document.getElementById("selsport").className ="effect_more select";
	  }
	  //else {
	  //	document.getElementById("selsport").className ="effect_more select open";
	  //}	  
	};



