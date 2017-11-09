
<%@page contentType="text/html;charset=euc-kr"%>

<%@page import="org.json.simple.JSONObject"%>

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

<!DOCTYPE html>

<html>
<head>

<script type="text/javascript" src="/js/jquery-2.2.2.js"></script>
<script type="text/javascript">

	/* $(function() {

		$("select").on("change", function() {

			location.href = "?num=" + $(this).val();

			//document.numForm.submit();

		});

	}); */

	function myFunction() {

		var num = $("select").val();

		location.href = "?num=" + num;

	}




	function ajaxGo() {
	
		jQuery.ajax({

			type : "GET",
			url : "test3.jsp", 
			data : {
				num : $("select[name=num]").val();
				//console.log(num);
			},

			datatype : "JSON",
			success : function(obj) {
				var data = JSON.parse(obj);
				//console.log(data);
				$("div #num").text(data.num);
				$("div #msg").text(data.msg);
				//alert("success");
			},

			complete : function(data) {// 응답이 종료되면 실행, 잘 사용하지않는다
				
	//alert("complete");
				console.log(data);

			},

			error : function(xhr, status, error) {
				//alert("ERROR!!!");
					alert("error");
			}

			//alert(num);

		});

	}

</script>

<title>Insert title here</title>

</head>

<body>

	<!-- <a href="?num=3">3</a> -->

	<form name="numForm">

		<select name="num" onchange="ajaxGo()">

			<option value="1">1</option>

			<option value="2">2</option>

			<option value="3">3</option>

			<option value="4">4</option>

			<option value="5">5</option>

			<option value="6">6</option>

		</select>

	</form>

	<div>

		숫자 <span id="num"></span> -> <span id="msg"></span>

	</div>

</body>

</html>

