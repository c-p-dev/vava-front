$(document).ready(function(){
	$(".all").click(function() {
		$(".allgames").click();
    });
	
	$(".agtab").click(function() {
		$(".mainag").click();
    });
	$(".mgtab").click(function() {
		$(".mtabs:first li").click();
		
    });
	$(".liclass").click(function() {
		$("#t .tab_content .tab button.tablinks:first ").click(function(){
			$(this).addClass("active");
		});
		$("#t .tab_content .tab button.tablinks:first ").click();
    });
 });

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
 function MGoption(evt, optionName) {
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
