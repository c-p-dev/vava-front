
$(document).ready(function() {

	//Default Action
	$(".left_tab_con").hide(); //Hide all content
	$("ul.l_tabs li:first").addClass("active").show(); //Activate first tab
	$(".left_tab_con:first").show(); //Show first tab content
	
	//On Click Event
	$("ul.l_tabs li").click(function() {
		$("ul.l_tabs li").removeClass("active"); //Remove any "active" class
		$(this).addClass("active"); //Add "active" class to selected tab
		$(".left_tab_con").hide(); //Hide all tab content
		var activeTab = $(this).find("a").attr("href"); //Find the rel attribute value to identify the active tab + content
		$(activeTab).fadeIn(); //Fade in the active content
		return false;
	});

});