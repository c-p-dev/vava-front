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
List<AccountListBean> res = aDao.getUsedMoneyKind(SITEID);
%>
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
									<select class="input_style02" id="money-use-job-select" onChange="selMoney(this.selectedIndex,this.options[this.selectedIndex].value)">
										<option value="ALL" selected>전체</option>
										
								<%
									for (int k=0; k < res.size() ; k++){
									AccountListBean alb = (AccountListBean) res.get(k);
									%>
									
									<option value="<%=alb.getJob()%>"><%=alb.getTitle()%></option>
									
								<%
								}
								%>
							
									</select>
								</td>
								<!--
								<td>
									<select class="input_style02" id="money-use-point-select">
										<option value="ALL">전체</option>
										<option value="M">M</option>
									</select>
								</td>
								-->
								<td>
									<input class="input_style04" id="moneyDateSearch" placeholder="기간" value="2017-00-00 ~ 2017-00-00" readonly>
									<span class="showMoneyDatePkr" style="cursor:pointer"><img src="/images/car_icon.jpg"></span>
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
												<img src="/images/car_close.png" class="closeMoneyPikaday">
											</span>
										</div>
									</div>
								</td>
								<!--
								<td>
									<span class="btn1" id="searchMoneyBtn">검색</span>
								</td>
								-->
							</tr>
						</table>
					</div>
					<div class="my_search_list " id="money-use">
						<table id="moneyUseTable" cellspacing="0" cellpadding="0"  width="100%">
            			</table>
					</div>
				</div>
			</div>
		</div>
	</li>
</ul>
<script>
	
	var $moneyUseTable;
	
	$(document).ready(function(){
	
		var i18n = {
			previousMonth	: '이전 달',
			nextMonth		: '다음 달',
			months 			: ['1월','2월', '3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			weekdays		: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
			weekdaysShort	: ['일', '월', '화', '수', '목', '금', '토'],
		};
		
		var moneyPickerFrom = new Pikaday({ 
			field: document.getElementById('moneyFromDate'), 
			bound: false, 
			container: document.getElementById('moneyFromDateDiv'),
			format: 'YYYY-MM-DD',
      defaultDate: moment().subtract(30,'days').toDate(),
      setDefaultDate : moment().subtract(30,'days').toDate(),
      minDate : moment().subtract(30,'days').toDate(),
      i18n : i18n,
		});

   	var moneyPickerTo = new Pikaday({ 
   		field: document.getElementById('moneyToDate'), 
   		bound: false, 
   		container: document.getElementById('moneyToDateDiv'),
   		format :'YYYY-MM-DD',
   		defaultDate: moment().toDate(),
   		setDefaultDate : moment().toDate(),
   		minDate : moneyPickerFrom.getDate(),
   		onSelect: function() {
  			$("#money-depth2").hide();
  		},	
   		i18n : i18n,
   	});

		$moneyUseTable = $('#moneyUseTable').DataTable({
			ajax: {
			    url: '/cash/jsp/getMoneyHistory.jsp',
			    type: 'post',
			    data: {
			       	job : function(){
			       		return  $("#money-use-job-select").val();
			       	},
			       	fromDate : function(){
			       		return $("#moneyFromDate").val();
			       	}, 
			       	toDate : function(){
			       		return $("#moneyToDate").val();
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
      data   : 'deduct_money',
      title  : '차감 머니',
      width : '17%',
      render : function(data,type,row,meta){
      	var html = (data != 0 || data != "0" ?  '<span class="font_008" style="align:right">'+comma(data)+'</span> 원' : '<span>-</span>' );
      	return html;
      }
      },
      { 
      data   : 'added_money',
      title  : '가산 머니',
      width : '17%',
      render : function(data,type,row,meta){
      	var html = (data != 0 || data != "0" ? '<span class="font_004">'+comma(data)+'</span> 원' : '<span>-</span>' );
      	return html;
      }
      },
      { 
      data   : 'remain_money',
      title  : '잔여 머니',
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
	        var min  = $('#moneyFromDate').val();					        
	        var max  = $('#moneyToDate').val();
	        var max2 =  moment(max).add('days', 1);	        
	        var createdAt = data[0] || 0; // Our date column in the table
	        if((min== ""||max2== "")||( moment(createdAt).isSameOrAfter(min) && moment(createdAt).isSameOrBefore(max2) ) ){
	            return true;
	        }
	        return false;
	    }
		);
		
	function getMoneyDate(){
		var dateFrom = $("#moneyFromDate").val();
    var dateTo = $("#moneyToDate").val();
    $("#moneyDateSearch").val(dateFrom + ' ~ '+ dateTo);
    $moneyUseTable.draw();
	}	
	   getMoneyDate();  	

    $(".money_pikaday_input").on("change",function(e){
    	getMoneyDate();
    });
    
    $("#tab6").on("fadeInComplete", function() {
			$moneyUseTable.columns.adjust().draw();
		});
		
		$(".showMoneyDatePkr").on("click",function(e){
    	e.preventDefault();
    	show_over(this);
    	show_layer('money-depth2');
    });
    
    $(".closeMoneyPikaday, .my_search_list, #money-use-job-select, .input_style02 ").on("click",function(e){
    	e.preventDefault();
    	$("#money-depth2").hide();
    });
             
	});

	
	function comma(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}
	 
	function selMoney(idx,item) {
		if(idx==0)
			$moneyUseTable.columns(1).search("").draw();
		else
			$moneyUseTable.columns(1).search("^" + item + "$", true, false, true).draw();
	}
		
</script>
