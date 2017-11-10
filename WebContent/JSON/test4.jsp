<%@page contentType="text/html;charset=euc-kr"%>


<%@page import="org.json.simple.JSONObject"%>


<html>
 <head>
  <title> jquery Ajax test </title>
  <script type="text/javascript" src="/js/jquery-2.2.2.js"></script>
  <script type="text/javascript">

    $(document).ready(function(){
      $("#button").click(function(){
          callAjax();
      });
    });

    function callAjax(){
        //var dataString = $("form").serialize(); //파라미터 직렬화 times=10&id=abc&comment=def
        //$("#postedParam").text("afterParameter:"+dataString); //

        $.ajax({
	        type: "POST",
	        //url : "http://localhost:8080/AjaxPrograming/temp/test.jsp",
	        url : "test4-1.jsp",
	        //data: dataString, //서버로 보낼 데이터 data변수(form객체 컬렉션)
	        data:{"Command":"GetSports"},
	        //data: JSON.stringify({"Command":"GetSports"}),
	        //data: request:JSON.stringify({"Command" : "GetSports"}),
	        dataType: 'json',
	        success: whenSuccess, //성공시 callback함수 지정
	        error: whenError //실패시 callback함수 지정
     	});
    }
		
    // 성공시 호출될 함수
    function whenSuccess(resdata){
        //$("#ajaxReturn").html(resdata);
        //alert(resdata.get("Command"));
        //alert("ok");
        console.log(resdata);
    }

    

    // 실패시 호출될 함수
    function whenError(){
        alert("Error");
    }

  </script>

 </head>

 <body>

 <div style="width:500px;margin:auto;margin-top:200px;">

	 <form id="form">

	 	 <div>

	     	<label>name</label><input name="number" value="10">

	     </div>

	     <div style="margin-top:20px;">

	     	<label>value</label><input name="id">

	     </div>


	     <div style="margin-top:20px;">

	     	<input id="button" type="button" value="버튼">

	     </div>

	 </form>

	 <div id="postedParam">beforeParameter</div>

	 <div id="ajaxReturn">ajaxReturnOutput</div>

 </div>

 </body>

</html>
