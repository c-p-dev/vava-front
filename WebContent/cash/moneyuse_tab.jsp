<%@ include file="/inc/session.jsp"%>
<%@ include file="/inc/session_checker.jsp"%>

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

<ul class="smk_accordion ">
	<li>
		<div class="accordion_title"><h3>머니사용내역</h3></div>
		<div class="acc_content">
			<div class="acc_content_in_2">
				<div class="float_inline">
					<div class="my_search_wrap">
						<table cellspacing="0" cellpadding="0" class="my_search_select">
							<tr>
								<td>
									<select class="input_style02" id="money-use-job-select">
										<option value="ALL" selected>전체</option>
										<option value="POINT2MONEY">POINT2MONEY</option>
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
									<select class="input_style02" id="money-use-point-select">
										<option value="ALL">전체</option>
										<option value="M">M</option>
									</select>
								</td>
								<td>
									<input class="input_style04" id="moneyDateSearch" placeholder="기간" value="2017-00-00 ~ 2017-00-00" readonly>
									<span class="showMoneyDatePkr"><img src="../images/car_icon.jpg"></span>
									<div id="money-depth2" style="display:none; width:; position:absolute; z-index:100000000; left:530px;top:130px;">
										<table border="0" cellspacing="0" cellpadding="0" class="car_table">
											<tr>
												<td id="moneyFromDateDiv" bgcolor="#303030" style="border-radius:3px; padding:5px; box-shadow: 10px 10px 20px -5px rgba(10, 10, 5, 5);">
													<input type="text" id="moneyFromDate" class="hidden money_pikaday_input" style="display: none;" >
												</td>
												<td id="moneyToDateDiv" bgcolor="#303030" style="border-radius:3px; padding:5px; box-shadow: 10px 10px 20px -5px rgba(10, 10, 5, 5);">
													<input type="text" id="moneyToDate" class="hidden money_pikaday_input"  style="display: none;">
												</td>
											</tr>
											
										</table>
										<div style="float:right; padding:7px 2px 7px 10px;">
											<span id="closeMoneyPikaday" class="closeMoneyPikaday" >
												<img src="../images/car_close.png" class="closeMoneyPikaday">
											</span>
										</div>
									</div>
								</td>
								<td>
									<span class="btn1" id="searchMoneyBtn">검색</span>
								</td>
							</tr>
						</table>
					</div>
					<div class="my_search_list " id="money-use">
						<table id="moneyUseTable" cellspacing="0" cellpadding="0" data-scroll-x="true" style="width: 100%!important;">
            			</table>
					</div>
				</div>
			</div>
		</div>
	</li>
</ul>
<script>
	$(document).ready(function(){
		var $moneyUseTable;

		var moneyPickerFrom = new Pikaday({ 
			field: document.getElementById('moneyFromDate'), 
			bound: false, 
			container: document.getElementById('moneyFromDateDiv'),
			format: 'YYYY-MM-DD',
	        defaultDate: moment().toDate(),
	        setDefaultDate : moment().toDate(),
	        onSelect: function() {
	        	// console.log(this.getDate());
	        	// console.log(moneyPickerTo);
	        	// console.log(moneyPickerTo.minDate);
	            moneyPickerTo.setMinDate(this.getDate());
	            moneyPickerTo.setDate(this.getDate());
	        },
	        minDate : moment().subtract(30,'days').toDate()
		});

       	var moneyPickerTo = new Pikaday({ 
       		field: document.getElementById('moneyToDate'), 
       		bound: false, 
       		container: document.getElementById('moneyToDateDiv'),
       		format :'YYYY-MM-DD',
       		defaultDate: moment().toDate(),
       		setDefaultDate : moment().toDate(),
       		minDate : moneyPickerFrom.getDate(),
       	});

       	getMoneyDate();

		$moneyUseTable = $('#moneyUseTable').DataTable({
			ajax: {
			    url: '/cash/jsp/getMoneyHistory.jsp',
			    type: 'post',
			    data: {
			       	job : function(){
			       		return  $("#money-use-job-select").val();
			       	},
			       	moneypoint : function(){
			       		return  $("#money-use-point-select").val();
			       	},
			       	fromDate : function(){
			       		return $("#moneyFromDate").val();
			       	}, 
			       	toDate : function(){
			       		return $("#moneyToDate").val();
			       	} 
			    }
			},
			bProcessing: true,
			sAjaxDataProp:"",
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
                        title  : '게임종류',
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

   		
   		$("#tab6").on("fadeInComplete", function() {
    		
		  	$moneyUseTable.columns.adjust().draw();
			
		});

        $(".money_pikaday_input").on("change",function(e){
        	getMoneyDate();
        });

        $("#searchMoneyBtn").on("click",function(e){
        	e.preventDefault();
        	$moneyUseTable.ajax.reload();
        	$("#money-depth2").hide();
        });

        $(".closeMoneyPikaday, .my_search_list, #money-use-job-select, .input_style02 ").on("click",function(e){
        	e.preventDefault();
        	$("#money-depth2").hide();
        });
        $(".showMoneyDatePkr").on("click",function(e){
        	e.preventDefault();
        	show_over(this);
        	show_layer('money-depth2');
        	
        });
        
	});

	function getMoneyDate(){
		var dateFrom = $("#moneyFromDate").val();
    	var dateTo = $("#moneyToDate").val();
    	$("#moneyDateSearch").val(dateFrom + ' ~ '+ dateTo);
	}
</script>