<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.text.DecimalFormat"%> 
<%@page import="java.util.*"%>
<%@page import="dao.UserDao"%>
<%@page import="bean.UserBean"%>
<%@page import="dao.AccountDao"%>
<%@page import="bean.AccountListBean"%>
<%@ include file="/inc/session.jsp"%>
<%
	AccountDao aDao = new AccountDao();
	List<AccountListBean> res = aDao.getPointKind(SITEID);
%>
<style>
	.dataTables_wrapper .dataTables_filter {
		float: right;
		text-align: right;
		visibility: hidden;
	}
</style>

<ul class="smk_accordion">
	<li>
		<div><h3>포인트사용내역</h3></div>
		<div class="acc_content">
			<div class="acc_content_in_2">
				<div class="float_inline">
					<div class="my_search_wrap">
						<table cellspacing="0" cellpadding="0" class="my_search_select">
							<tr>
								<td>
									<select class="input_style02" id="divisionSelect" onChange="selPoint(this.selectedIndex,this.options[this.selectedIndex].value)">
										<option value="ALL" selected>전체</option>
										<%
											for (int k=0; k < res.size() ; k++){
												AccountListBean alb = (AccountListBean) res.get(k);
										%>
											<option value="<%=alb.getJob()%>"><%=alb.getTitle()%></option>
									
										<% } %>
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
							</tr>
						</table>
					</div>
					<div class="my_search_list" id="point-use" >
						<table id="pointUseTable" cellspacing="0" cellpadding="0" width="100%">
            			</table>
					</div>
				</div>
			</div>
		</div>
	</li>
</ul>
<script>
	
	var $pointUseTable;

	$(document).ready(function(){
		
		var i18n = {
			previousMonth	: '이전 달',
			nextMonth		: '다음 달',
			months 			: ['1월','2월', '3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			weekdays		: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
			weekdaysShort	: ['일', '월', '화', '수', '목', '금', '토'],
		};

		var pickerFrom = new Pikaday({ 
			field: document.getElementById('fromDate'), 
			bound: false, 
			container: document.getElementById('fromDateDiv'),
			format: 'YYYY-MM-DD',
		    defaultDate: moment().subtract(30,'days').toDate(),
		    setDefaultDate : moment().subtract(30,'days').toDate(),
		    minDate : moment().subtract(30,'days').toDate(),
		    i18n : i18n,
		});

	   	var pickerTo = new Pikaday({ 
	   		field: document.getElementById('toDate'), 
	   		bound: false, 
	   		container: document.getElementById('toDateDiv'),
	   		format :'YYYY-MM-DD',
	   		i18n : i18n,
	   		onSelect: function() {
	  			$("#depth2").hide();
	  		},	
	   		defaultDate: moment().toDate(),
	   		setDefaultDate : moment().toDate(),
	   		minDate : pickerFrom.getDate(),
	   		maxDate : moment().toDate(),
	   	});

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
			searching: true,
			bInfo : false,
			lengthChange: false,
			autowWidth:false,
			scrollX: false,
			pageLength: 10,
			columns : [
				{ 
					data   : 'regdate',
					title  : '일시',
					width : '20%',
				},
				{ 
					data   : 'job',
					title  : '구분',
					visible: false,
				},
				{ 
					data   : 'job_kor',
					title  : '구분',
				},
				{ 
					data   : 'deduct_point',
					title  : '차감 포인트',
					width : '17%',
					render : function(data,type,row,meta){
						var html = (data != 0 || data != "0" ?  '<span class="font_008" style="align:right">'+comma(data)+'</span> 원' : '<span>-</span>' );
						return html;
					}
				},
				{ 
					data   : 'added_point',
					title  : '가산 포인트',
					width : '17%',
					render : function(data,type,row,meta){
						var html = (data != 0 || data != "0" ? '<span class="font_004">'+comma(data)+'</span> 원' : '<span>-</span>' );
						return html;
					}
				},
				{ 
					data   : 'remain_point',
					title  : '잔여 포인트',
					width : '17%',
					render : function(data,type,row,meta){
						var html = '<span class="font_002">'+comma(data)+'</span> 원</td>';
						return html;
					}          	

				},
			],
			order: [[ 0, "desc" ]] ,         
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
		});
		
		$.fn.dataTable.ext.search.push(
		    function( settings, data, dataIndex ) {
		        var min  = $('#fromDate').val();					        
		        var max  = $('#toDate').val();
		        var max2 =  moment(max).add('days', 1);
		        
		        var createdAt = data[0] || 0; // Our date column in the table

		        if((min== ""||max2== "")||( moment(createdAt).isSameOrAfter(min) && moment(createdAt).isSameOrBefore(max2) ) ){
		            return true;
		        }
		        return false;
	    });
	
		function getDate(){
			var dateFrom = $("#fromDate").val();
		  	var dateTo = $("#toDate").val();
		  	$("#dateSearch").val(dateFrom + ' ~ '+ dateTo);
		  	$pointUseTable.draw();
		}
		
		getDate();
	
		$(".pikaday_input").on("change",function(e){
			getDate();			
	  	});
 			       	 							
	 	$("#tab5").on("fadeInComplete", function() {
			$pointUseTable.columns.adjust().draw();	
		});
			
	    $(".showDatePkr").on("click",function(e){
	    	e.preventDefault();
	    	show_over(this);
	    	show_layer('depth2');
	    });


	    $(".closePikaday, .my_search_list, #divisionSelect, .input_style02 ").on("click",function(e){
	    	e.preventDefault();
	    	$("#depth2").hide();
	    });
   
	});

	function comma(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}
	
	function selPoint(idx,item) {
		if(idx==0)
			$pointUseTable.columns(1).search("").draw();
		else
			$pointUseTable.columns(1).search("^" + item + "$", true, false, true).draw();
	}
	
</script>
