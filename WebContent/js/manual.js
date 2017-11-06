$(document).ready(function(){
	$(".all").click(function() {
		$(".allgames").click();
    });
	$(".agtab").click(function() {
		$(".mainag").click();
    });
	$(".mgtab").click(function() {
		$(".mt1").click();
    });
	$(".mt1").click(function() {
		$("#t .tab_content .tab button.tablinks:first ").click(function(){
			$(this).addClass("active");
		});
		$("#t .tab_content .tab button.tablinks:first ").click();
    });
	$(".mt2").click(function() {
		$("#mgTab2 .tab button.tablinks:first ").click(function(){
			$(this).addClass("active");
		});
		$("#mgTab2 .tab button.tablinks:first ").click();
    });
	$(".mt3").click(function() {
		$("#mgTab3 .tab button.tablinks:first ").click(function(){
			$(this).addClass("active");
		});
		$("#mgTab3 .tab button.tablinks:first ").click();
    });
	$(".mt4").click(function() {
		$("#mgTab4 .tab button.tablinks:first ").click(function(){
			$(this).addClass("active");
		});
		$("#mgTab4 .tab button.tablinks:first ").click();
    });
	$(".mt5").click(function() {
		$("#mgTab5 .tab button.tablinks:first ").click(function(){
			$(this).addClass("active");
		});
		$("#mgTab5 .tab button.tablinks:first ").click();
    });
	$(".mt6").click(function() {
		$("#mgTab6 .tab button.tablinks:first ").click(function(){
			$(this).addClass("active");
		});
		$("#mgTab6 .tab button.tablinks:first ").click();
    });
	$(".a2").click(function() {
		$("#dragon_tiger .tab button.tablinks:first ").click(function(){
			$(this).addClass("active");
		});
		$("#dragon_tiger .tab button.tablinks:first ").click();
    });
	$(".a3").click(function() {
		$("#gen_bac .tab button.tablinks:first ").click(function(){
			$(this).addClass("active");
		});
		$("#gen_bac .tab button.tablinks:first ").click();
    });
	$(".a4").click(function() {
		$("#vip_bac .tab button.tablinks:first ").click(function(){
			$(this).addClass("active");
		});
		$("#vip_bac .tab button.tablinks:first ").click();
    });
	$(".a5").click(function() {
		$("#bid_bac .tab button.tablinks:first ").click(function(){
			$(this).addClass("active");
		});
		$("#bid_bac .tab button.tablinks:first ").click();
    });
	$(".a6").click(function() {
		$("#roulette .tab button.tablinks:first ").click(function(){
			$(this).addClass("active");
		});
		$("#roulette .tab button.tablinks:first ").click();
    });
	$(".a7").click(function() {
		$("#seo_bo .tab button.tablinks:first ").click(function(){
			$(this).addClass("active");
		});
		$("#seo_bo .tab button.tablinks:first ").click();
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
