<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="java.text.DecimalFormat"%> 
<%@page import="java.util.*"%>
<%@page import="dao.UserDao"%>
<%@page import="bean.UserBean"%>

<%--
	 ********************************
	 *  HTML CODE STARTS FROM HERE  *
	 ********************************
--%>
<ul class="smk_accordion">
	<li>
		<div clas "><h3>포인트사용내역</h3></div>
		<div class="acc_content">
			<div class="acc_content_in_2">
				<div class="float_inline">
					<div class="my_search_wrap">
						<table cellspacing="0" cellpadding="0" class="my_search_select">
							<tr>
								<td>
									<select class="input_style02" id="divisionSelect">
										<option value="ALL">전체</option>
										<option value="POINT2MONEY" selected>POINT2MONEY</option>
										<option value="ADMIN">ADMIN</option>
										<option value="ADMIN_BET_CANCEL">ADMIN_BET_CANCEL</option>
										<option value="AG_BET">AG_BET</option>
										<option value="AG_HIT">AG_HIT</option>
										<option value="BC_BET">BC_BET</option>
										<option value="BC_BET_CANCEL">BC_BET_CANCEL</option>
										<option value="BC_HIT">BC_HIT</option>
										<option value="BC_RE_CALC">BC_RE_CALC</option>
										<option value="CHARGE">CHARGE</option>
										<option value="CHARGE_CANCEL">CHARGE_CANCEL</option>
										<option value="MICRO_DEPOSIT">MICRO_DEPOSIT</option>
										<option value="MICRO_WITHDRAW">MICRO_WITHDRAW</option>
										<option value="WITHDRAW">WITHDRAW</option>
									</select>
								</td>
								<td>
									<input class="input_style04" id="dateSearch" placeholder="기간" value="2017-00-00 ~ 2017-00-00" readonly>
									<span class="showDatePkr"><img src="/images/car_icon.jpg"></span>
									<div id="depth2" style="display:none; width:; position:absolute; z-index:100000000; left:530px;top:130px;">
										<table border="0" cellspacing="0" cellpadding="0" class="car_table">
											<tr>
												<td id="fromDateDiv" bgcolor="#303030" style="border-radius:3px; padding:5px; box-shadow: 10px 10px 20px -5px rgba(10, 10, 5, 5);">
													<input type="text" id="fromDate" class="hidden pikaday_input" style="display: none;" >
												</td>
												<td id="toDateDiv" bgcolor="#303030" style="border-radius:3px; padding:5px; box-shadow: 10px 10px 20px -5px rgba(10, 10, 5, 5);">
													<input type="text" id="toDate" class="hidden pikaday_input"  style="display: none;">
												</td>
											</tr>
											
										</table>
										<div style="float:right; padding:7px 2px 7px 10px;">
											<span id="closePikaday" class="closePikaday" >
												<img src="/images/car_close.png" class="closePikaday">
											</span>
										</div>
									</div>
								</td>
								<td>
									<span class="btn1" id="searchPointBtn">검색</span>
								</td>
							</tr>
						</table>
						
					</div>
					<div class="my_search_list" id="point-use" >
						<table id="pointUseTable" cellspacing="0" cellpadding="0" data-scroll-x="true" style="width: 100%!important;">
            			</table>
					</div>
				</div>
			</div>
		</div>
	</li>
</ul>
<script>
	

	$(document).ready(function(){

		var $pointUseTable;

		var pickerFrom = new Pikaday({ 
			field: document.getElementById('fromDate'), 
			bound: false, 
			container: document.getElementById('fromDateDiv'),
			format: 'YYYY-MM-DD',
	        defaultDate: moment().toDate(),
	        setDefaultDate : moment().toDate(),
	        onSelect: function() {
	        	// console.log(this.getDate());
	        	// console.log(pickerTo);
	        	// console.log(pickerTo.minDate);
	            pickerTo.setMinDate(this.getDate());
	            pickerTo.setDate(this.getDate());
	        },
	        minDate : moment().subtract(30,'days').toDate()
		});

       	var pickerTo = new Pikaday({ 
       		field: document.getElementById('toDate'), 
       		bound: false, 
       		container: document.getElementById('toDateDiv'),
       		format :'YYYY-MM-DD',
       		defaultDate: moment().toDate(),
       		setDefaultDate : moment().toDate(),
       		minDate : pickerFrom.getDate(),
       	});

       	getDate();

		$pointUseTable = $('#pointUseTable').DataTable({
			ajax: {
			    url: '/cash/jsp/getPointUsed.jsp',
			    type: 'post',
			    data: {
			       	job : function(){
			       		return  $("#divisionSelect").val();
			       	},
			       	fromDate : function(){
			       		return $("#fromDate").val();
			       	}, 
			       	toDate : function(){
			       		return $("#toDate").val();
			       	} 
			    }
			    
			},
			sAjaxDataProp:"",
			bProcessing: true,
			searching: false,
			bInfo : false,
			lengthChange: false,
			autowWidth:true,
			pageLength: 10,
            columns : [
                	{ 
                        data   : 'regdate',
                        title  : '일시',

                    },
                    { 
                        data   : 'job',
                        title  : '구분',
                    },
                    { 
                        data   : 'deduct_point',
                        title  : '가산포인트',
                        render : function(data,type,row,meta){
                        	var html = (data != 0 || data != "0" ?  '<span class="font_008">'+data+'</span> 원' : "");
                        	return html;
                        }
                    },
                    { 
                        data   : 'added_point',
                        title  : '가산포인트',
                        render : function(data,type,row,meta){
                        	var html = (data != 0 || data != "0" ? '<span class="font_004">'+data+'</span> 원' : "");
                        	return html;
                        }
                    },
                    { 
                        data   : 'remain_point',
                        title  : '잔여포인트',
                        render : function(data,type,row,meta){
                        	var html = '<span class="font_002">'+data+'</span>원</td>';
                        	return html;
                        }
                       	
                       
                    },
                ],
        	pagingType: "full_numbers",
            language: {
			    paginate: {
			      	previous: "<",
			      	next: ">",
			      	first: "<<",
			      	last: ">>",
			    },
			    emptyTable: "결과가 없습니다.",
			},
            rowCallback : function(row , data , index) {
                
            },
            drawCallback: function( settings ) {
                
            }
        });



   		$("#point-use").hide();
   		$("#point-use").before('<div class="spn" id="point-use-spn" style="width:100%!important;">'+lgSpin+'</div>');

   		$("#tab5").on("fadeInComplete", function() {
    		setTimeout(function() {
    			$("#point-use-spn").remove();
    			$("#point-use").show();
			  	$pointUseTable.columns.adjust().draw();
			}, 300);
    		
		});

        $("#showCalendarBtn").on("click",function(e){
        	e.preventDefault();
        	show_over(this);
        	show_layer('depth1');
        });

        $(".showDatePkr").on("click",function(e){
        	e.preventDefault();
        	show_over(this);
        	show_layer('depth2');
        	
        });

        $(".pikaday_input").on("change",function(e){
        	getDate();
        });

        $(".closePikaday, .my_search_list, #divisionSelect, .input_style02 ").on("click",function(e){
        	e.preventDefault();
        	$("#depth2").hide();
        });
        $("#searchPointBtn").on("click",function(e){
        	e.preventDefault();
        	$pointUseTable.ajax.reload();
        	$("#depth2").hide();
        });
	});

	function getDate(){
		var dateFrom = $("#fromDate").val();
    	var dateTo = $("#toDate").val();
    	$("#dateSearch").val(dateFrom + ' ~ '+ dateTo);
	}
</script>