$(document).ready(function() {
	//Default Action
	// $(".tab_content").hide(); //Hide all content
	$(".tab_content").not(":first-child").hide();
	$("ul.tabs li:first").addClass("active").show(); //Activate first tab
	// $(".tab_content:first").show(); //Show first tab content
	
	//On Click Event
	// $("ul.tabs li").click(function() {
	$("body").on("click","ul.tabs li",function(e){
		e.stopPropagation();
		// console.log("fadein");
		$("ul.tabs li").removeClass("active"); //Remove any "active" class
		$(this).addClass("active"); //Add "active" class to selected tab
		$(".tab_content").hide().removeClass("fading"); //Hide all tab content
		var activeTab = $(this).find("a").attr("href"); //Find the rel attribute value to identify the active tab + content
		// $(activeTab).fadeIn(400,function(){
		// 	$(this).trigger("fadeInComplete");

		// }); //Fade in the active content
		$(activeTab).show().addClass("fading");
		$(activeTab).trigger("fadeInComplete");

		return false;
	});

});



