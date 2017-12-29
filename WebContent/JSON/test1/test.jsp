
<html>
<head>
    <title>VAVASoft JSON Test</title>

    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />   
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.js" type="text/javascript"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
   
</head>
<body>
		<!-- sports -->
    <form id="SportsRequestForm">
        <fieldset>
            <legend>VAVASoft Ajax JSON Request</legend>

                <p>
                    <label for="sportCode">Get Sports List</label><br />
                </p>
                <p>
                    <input id="sportsButton" type="button" value="Submit" />
                </p>
        </fieldset>
    </form>
    <div id="sportsSection">
        <fieldset>
            <legend>Response</legend>
                 <div id="sportsResponse"></div>
        </fieldset>
    </div>   
    
    <form id="RegionsRequestForm">
        <fieldset>
            <legend>VAVASoft Ajax JSON Request</legend>

                <p>
                    <label for="regionCode">Get Regions List</label><br />
                <p>
                    <input id="regionButton" type="button" value="Submit" />
                </p>
        </fieldset>
    </form>
    <div id="regionSection">
        <fieldset>
            <legend>Response</legend>
                 <div id="regionResponse"></div>
        </fieldset>
    </div>   
    
<script>
$(document).ready(function() {

    //Get Sports
    $("#SportsRequestForm").submit(function(e){
           e.preventDefault();
    });
   
    //checks for the button click event
    $("#sportsButton").click(function(e){
          	
            //dataString = $("#ajaxJsonRequestForm").serialize();
           
            //var countryCode = $("input#countryCode").val(); 
            //dataString = "countryCode=" + countryCode;

            $.ajax({
                type: "POST",
                url: "/SportsManager",
                //data: dataString,
                data:{"Command":"GetSports"},
                dataType: "json",
               
                //if received a response from the server
                success: function( data, textStatus, jqXHR) {
                    //our country code was correct so we have some information to display
                     if(data.success){
                     	 alert(data.SportInfo.id);
                         $("#sportsResponse").html("");
                         $("#sportsResponse").append("<b>Id:</b> " + data.SportInfo.id + "<br/>");
                         $("#sportsResponse").append("<b>LangId:</b> " + data.SportInfo.langid + "<br/>");
                         $("#sportsResponse").append("<b>Name:</b> " + data.SportInfo.name + "<br/>");
                         
                     } 
                     //display error message
                     else {
                         $("#sportsResponse").html("<div><b>Country code in Invalid!</b></div>");
                     }
                },
               
                //If there was no resonse from the server
                error: function(jqXHR, textStatus, errorThrown){
                      $("#sportsResponse").html(jqXHR.responseText);
                },
               
                //capture the request before it was sent to server
                beforeSend: function(jqXHR, settings){
                    //adding some Dummy data to the request
                    //settings.data += "&dummyData=whatever";
                    //disable the button until we get the response
                    $('#sportsButton').attr("disabled", true);
                },
               
                //this is called after the response or error functions are finsihed
                //so that we can take some action
                complete: function(jqXHR, textStatus){
                    //enable the button 
                    $('#sportsButton').attr("disabled", false);
                }
     
            });        
    });
    


		//Get Sports
    $("#RegionRequestForm").submit(function(e){
           e.preventDefault();
    });
   
    //checks for the button click event
    $("#regionButton").click(function(e){
          	
            //dataString = $("#ajaxJsonRequestForm").serialize();
           
            //var countryCode = $("input#countryCode").val(); 
            //dataString = "countryCode=" + countryCode;

            $.ajax({
                type: "POST",
                url: "/SportsManager",
                //data: dataString,
                data:{"Command":"GetRegions"},
                dataType: "json",
               
                //if received a response from the server
                success: function( data, textStatus, jqXHR) {
                    //our country code was correct so we have some information to display
                     if(data.success){
                     	 alert(data.SportInfo.id);
                         $("#regionResponse").html("");
                         $("#regionResponse").append("<b>Sports ID:</b> " + data.SportInfo.id + "<br/>");
                         $("#regionResponse").append("<b>Lang ID:</b> " + data.SportInfo.langid + "<br/>");
                         $("#regionResponse").append("<b>Sport Name:</b> " + data.SportInfo.name + "<br/>");
                         
                     } 
                     //display error message
                     else {
                         $("#regionResponse").html("<div><b>Country code in Invalid!</b></div>");
                     }
                },
               
                //If there was no resonse from the server
                error: function(jqXHR, textStatus, errorThrown){
                     console.log("ERROR " + textStatus);
                      $("#regionResponse").html(jqXHR.responseText);
                },
               
                //capture the request before it was sent to server
                beforeSend: function(jqXHR, settings){
                    //adding some Dummy data to the request
                    //settings.data += "&dummyData=whatever";
                    //disable the button until we get the response
                    $('#sportsButton').attr("disabled", true);
                },
               
                //this is called after the response or error functions are finsihed
                //so that we can take some action
                complete: function(jqXHR, textStatus){
                    //enable the button 
                    $('#sportsButton').attr("disabled", false);
                }
     
            });        
    });
    
});

</script>

</body>
</html>

