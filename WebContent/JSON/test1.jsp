

<script type="text/javascript" src="../../js/jquery-2.2.2.js"></script>

<script >

$(document).ready(function(){
	alert("a")
    loadData();
});
 

function loadData()
{

    var data ={};
    data.q = 'test';
    data.apikey = '947f96c9d2518613faae766eed75bca030ad67d7';
    data.result = '10';
    data.output = 'json';
    data.callback = "jsonp_callback";
             
    $.ajax({

        url: "http://apis.daum.net/search/image"
        , crossDomain: true
        , dataType: "jsonp"
        , type: 'GET'
        , data: data
        , error: function( jqXHR, textStatus, errorThrown ) {
            alert( textStatus + ", " + errorThrown );
        }
    });

}

 

function jsonp_callback( data ){
    alert("!!!");
}

</script>
