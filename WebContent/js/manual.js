$(document).ready(function(){
	
	$(".all").click(function() {
		$(".allgames").click();
    });
	
	$("#game-cat li a.get-manual").on("click",function(e){
		e.preventDefault();
		var man = $(this).attr('data-val');
		$.ajax({
			url : 'jsp/get_manual.jsp',
			data : {man:man},
			method: 'GET',
		}).done(function(data){
			//console.log(data);
			loadManual(data);
		});
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
