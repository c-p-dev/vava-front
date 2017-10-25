
$.urlParam = function(name){
    var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
    // console.log(results);
    if (results==null){
       return null;
    }
    else{
       return decodeURI(results[1]) || 0;
    }
}

function setTabActive(tab){
	// console.log(tab);
	if(tab != null ){
		$("ul.tabs li:first").removeClass("active");
		$(".tab_content").hide(); //Hide all content
		$("a[href*='"+tab+"']").parent('li').addClass("active").show(); //Activate first tab
		$("#"+tab).show(); //Show first tab content

	}else{
		$(".tab_content").hide(); //Hide all content
		$("ul.tabs li:first").addClass("active").show(); //Activate first tab
		$(".tab_content:first").show(); //Show first tab content
	}
}
