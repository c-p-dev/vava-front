$(document).ready(function(){
	
	$(".all").click(function() {
		$(".allgames").click();
    });
	
});


function loadManual(data){

	var final_div = '<div id="l-tab1" class="left_tab_con">'+ data + '</div>';
	$(".casino_right").html(spin);
	setTimeout(function(){
		$(".casino_right").hide().html(final_div).fadeIn();
		$(".mtabs .liclass:first").click();
		
	}, 100);

}

function openOption(evt, optionName) {
    var i, tabcontent, tablinks;
    
    tabcontent = document.getElementsByClassName("tabcontent2");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
    document.getElementById(optionName).style.display = "block";
    evt.currentTarget.className += " active";
}
