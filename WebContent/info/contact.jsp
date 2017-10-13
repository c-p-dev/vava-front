<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	input.btn5{
	    border-width: 0px!important;
   	 	border-radius: 5px!important;
	}
</style>
<ul class="smk_accordion">
	<li>
		<div class="acc_head"><h3>1:1문의</h3></div>
		<div class="acc_content" style="display: inline-block!important;width: 100%!important;">
			<div class="acc_content_in_2">
				<div class="inquiry_wrap">
				</div>
				<div class="inquiry_select_wrap">
					<form id="messageFrom">
						<table  width="100%" cellpadding="0" cellspacing="0">
							<tr>
								<td style="padding:0 10px 0 0">
									<input class="inquiry_input" name="txt" id="txt">
								</td>
								<td>
									<!-- <a href="#"><span class="btn5">전송</span></a> -->
									<!-- <button class="btn5" id="sendMsgBtn">전송</button> -->
									<input type="submit" value="전송" class="btn5">
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</li>
</ul>

<!-- message sent success modal -->
<div id="messageModal" class="bg_mask_pop2">
	<div class="bg_mask_pop_title">
		<span class="popup_logo"><img src="/images/popup_logo.png"></span>
		<span class="popup_close closemessageModal"><img src="/images/popup_close.png"></span>
	</div>
	<div class="bg_mask_pop2_in">
		<div class="pop_icon_center">
			<img src="/images/check_icon.png">
		</div>
		<div class="pop_text">
			메시지 전송 됨! <br>
		</div>
		<div class="btn_wrap">
			<!-- <a href="${baeUrl}"></a> -->
			<span class="btn3 closemessageModal" >확인</span>
		</div>
	</div>
</div>

<script>
	$(document).ready(function(){
		loadMessage();
		
		$('#messageModal').popup({
	      	transition: 'all 0.3s',
	      	scrolllock: true,
	      	onclose:function(){
	    		resetMessageForm();
	    		loadMessage();
	    	}
	    });

	    $(".closemessageModal").on("click",function(){
	    	$('#messageModal').popup("hide");
	    });

	    setInterval(function() {
    		loadMessage();
		}, 60 * 1000);  // load messages every minute

	    $("#messageFrom").validate({
			// debug: true,
	  		errorClass: 'form1-invalid',
	    	validClass: 'form1-valid',
		    onfocusout: false,
		    onkeyup :false,
		    onclick : false,
	  		rules: {
			    txt :{
					required:true,
					minlength:1,
				},
				
			},
			messages: {
			    txt :{
					required:"Text is required",
				},
			},
			errorPlacement: function(error, element) {

			},
			submitHandler: function(form) {
				var data = $("#messageFrom").serializeJSON();
			   	submitMessage(data)
		  	}

		});
		
	});

	function loadMessage(){
		$.ajax({
			url : '${baseUrl}process/info/getMessages.jsp',
			data : {},
			method: 'POST',
		}).done(function(data){ 
			drawMessages(data);
			
		});
	}

	function drawMessages(data){
		// alert("load Messages");
		var data = data.trim();
		var obj = JSON.parse(data);
		$(".inquiry_wrap").html("");
		$.each( obj, function(index, el) {
			console.log(index);
			var html  = '<div class="inquiry"> <div class="inquiry_admin"> <span class="admin_tag"><img src="../images/admin_tag.jpg"></span> <div class="inquiry_text">' + el.txt+ '</div> <div class="admin_date">'+el.send_date+'</div></div></div>'; 
			if(el.class_name == "inquiry_user"){
				html = '<div class="inquiry"> <div class="inquiry_user"> <span class="user_tag"><img src="../images/user_tag.jpg"></span> <div class="inquiry_text"> '+el.txt+' </div> <div class="user_date">'+el.send_date+'</div> </div> </div>'; 
			}
			$(".inquiry_wrap").append(html);
	
		});
	}

	function submitMessage(data){
		$.ajax({
			url : '${baseUrl}process/info/setMessage.jsp',
			data : data,
			method: 'POST',
		}).done(function(data){
			if(data){
				$('#messageModal').popup("show");
			}
		});
	}

	function resetMessageForm(){
		$("#messageFrom")[0].reset();
	}
</script>