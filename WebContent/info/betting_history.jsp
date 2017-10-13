<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "net.vavasoft.dao.GameDao" %>
<%@ page import = "java.text.DecimalFormat" %>
<%@ page import = "java.util.*" %>
<%@ page import = "net.vavasoft.dao.UserDao" %>
<%@ page import = "net.vavasoft.bean.UserBean" %>
<style>
	#bettingHistory1 tbody tr{
	    height: 40px!important;
	    text-align: center!important;
	    border-bottom: solid 1px #2e3032!important;
	    background-color: transparent!important;
	    
	}
	#bettingHistory1 tbody tr td{
		padding:0px!important;      
	}
</style>
<ul class="smk_accordion">
	<li>
		<div class="acc_head"><h3>베팅내역</h3></div>
		<div class="acc_content">
			<div class="acc_content_in_2">
				<div class="bet_search_wrap">
					<table cellspacing="0" cellpadding="0" class="my_search_select">
						<tr>
							<td>
								<select class="input_style02">
									<option>전체</option>
								</select>
							</td>
							<td>
								<select class="input_style02">
									<option>전체</option>
								</select>
							</td>
							<td>
								<input class="input_style04"  placeholder="기간" value="2017-00-00 ~ 2017-00-00">
								<a href="#" onClick="show_over(this);show_layer('depth1');">
									<img src="../images/car_icon.jpg">
								</a>
								<div id="depth1" style="display:none; width:; position:absolute; z-index:100000000; left:530px;top:130px;">
									<table border="0" cellspacing="0" cellpadding="0" class="car_table">
										<tr>
											<td bgcolor="#303030" style="border-radius:3px; padding:5px; box-shadow: 10px 10px 20px -5px rgba(10, 10, 5, 5);">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td>
															<ul class="car_period">
																<li class="select">전체</li>
																<li>최근24시간</li>
																<li>최근3일</li>
																<li>최근7일</li>
															</ul>
														</td>
													</tr>
												</table>
												<table width="100%" border="0" cellspacing="10" cellpadding="0">
													<tr>
														<td>
															<table width="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td><a href="#"><img src="../images/arrow_left.png"></a></td>
																	<td height="30" align="center"><a href="#"><span class="font_style01">2017년 00월</span></a></td>
																	<td align="right"><a href="#"><img src="../images/arrow_right.png"></a></td>
																</tr>
																<tr>
																	<td colspan="3"><img src="../images/cale.jpg" width="100%"></td>
																</tr>
															</table>
															<table border="0" cellpadding="0" cellspacing="1" bgcolor="#242424">
																<tr>
																	<td><a href="#"><span class="cale_off">30</span></a></td>
																	<td><a href="#"><span class="cale_off">30</span></a></td>
																	<td><a href="#"><span class="cale">1</span></a></td>
																	<td><a href="#"><span class="cale">2</span></a></td>
																	<td><a href="#"><span class="cale_on">3</span></a></td>
																	<td><a href="#"><span class="cale">4</span></a></td>
																	<td><a href="#"><span class="cale">5</span></a></td>
																</tr>
																<tr>
																	<td><a href="#"><span class="cale">6</span></a></td>
																	<td><a href="#"><span class="cale">7</span></a></td>
																	<td><a href="#"><span class="cale">8</span></a></td>
																	<td><a href="#"><span class="cale">9</span></a></td>
																	<td><a href="#"><span class="cale">01</span></a></td>
																	<td><a href="#"><span class="cale">11</span></a></td>
																	<td><a href="#"><span class="cale">12</span></a></td>
																</tr>
																<tr>
																	<td><a href="#"><span class="cale">13</span></a></td>
																	<td><a href="#"><span class="cale">14</span></a></td>
																	<td><a href="#"><span class="cale">15</span></a></td>
																	<td><a href="#"><span class="cale">16</span></a></td>
																	<td><a href="#"><span class="cale">17</span></a></td>
																	<td><a href="#"><span class="cale">18</span></a></td>
																	<td><a href="#"><span class="cale">19</span></a></td>
																</tr>
																<tr>
																	<td><a href="#"><span class="cale">20</span></a></td>
																	<td><a href="#"><span class="cale">21</span></a></td>
																	<td><a href="#"><span class="cale">22</span></a></td>
																	<td><a href="#"><span class="cale">23</span></a></td>
																	<td><a href="#"><span class="cale">24</span></a></td>
																	<td><a href="#"><span class="cale">25</span></a></td>
																	<td><a href="#"><span class="cale">26</span></a></td>
																</tr>
																<tr>
																	<td><a href="#"><span class="cale">27</span></a></td>
																	<td><a href="#"><span class="cale">28</span></a></td>
																	<td><a href="#"><span class="cale">29</span></a></td>
																	<td><a href="#"><span class="cale">30</span></a></td>
																	<td><a href="#"><span class="cale_off">1</span></a></td>
																	<td><a href="#"><span class="cale_off">2</span></a></td>
																	<td><a href="#"><span class="cale_off">3</span></a></td>
																</tr>
															</table>
														</td>
														<td>
															<table width="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td><a href="#"><img src="../images/arrow_left.png"></a></td>
																	<td height="30" align="center"><a href="#"><span class="font_style01">2017년 00월</span></a></td>
																	<td align="right"><a href="#"><img src="../images/arrow_right.png"></a></td>
																</tr>
																<tr>
																	<td colspan="3"><img src="../images/cale.jpg" width="100%"></td>
																</tr>
															</table>
															<table border="0" cellpadding="0" cellspacing="1" bgcolor="#242424">
																<tr>
																	<td><a href="#"><span class="cale_off">30</span></a></td>
																	<td><a href="#"><span class="cale_off">30</span></a></td>
																	<td><a href="#"><span class="cale">1</span></a></td>
																	<td><a href="#"><span class="cale">2</span></a></td>
																	<td><a href="#"><span class="cale_on">3</span></a></td>
																	<td><a href="#"><span class="cale">4</span></a></td>
																	<td><a href="#"><span class="cale">5</span></a></td>
																</tr>
																<tr>
																	<td><a href="#"><span class="cale">6</span></a></td>
																	<td><a href="#"><span class="cale">7</span></a></td>
																	<td><a href="#"><span class="cale">8</span></a></td>
																	<td><a href="#"><span class="cale">9</span></a></td>
																	<td><a href="#"><span class="cale">01</span></a></td>
																	<td><a href="#"><span class="cale">11</span></a></td>
																	<td><a href="#"><span class="cale">12</span></a></td>
																</tr>
																<tr>
																	<td><a href="#"><span class="cale">13</span></a></td>
																	<td><a href="#"><span class="cale">14</span></a></td>
																	<td><a href="#"><span class="cale">15</span></a></td>
																	<td><a href="#"><span class="cale">16</span></a></td>
																	<td><a href="#"><span class="cale">17</span></a></td>
																	<td><a href="#"><span class="cale">18</span></a></td>
																	<td><a href="#"><span class="cale">19</span></a></td>
																</tr>
																<tr>
																	<td><a href="#"><span class="cale">20</span></a></td>
																	<td><a href="#"><span class="cale">21</span></a></td>
																	<td><a href="#"><span class="cale">22</span></a></td>
																	<td><a href="#"><span class="cale">23</span></a></td>
																	<td><a href="#"><span class="cale">24</span></a></td>
																	<td><a href="#"><span class="cale">25</span></a></td>
																	<td><a href="#"><span class="cale">26</span></a></td>
																</tr>
																<tr>
																	<td><a href="#"><span class="cale">27</span></a></td>
																	<td><a href="#"><span class="cale">28</span></a></td>
																	<td><a href="#"><span class="cale">29</span></a></td>
																	<td><a href="#"><span class="cale">30</span></a></td>
																	<td><a href="#"><span class="cale_off">1</span></a></td>
																	<td><a href="#"><span class="cale_off">2</span></a></td>
																	<td><a href="#"><span class="cale_off">3</span></a></td>
																</tr>
															</table>
														</td>																			
													</tr>
												</table>
											</td>
										</tr>
									</table>
									<div style="float:right; padding:7px 2px 7px 10px;"><a href="#" onClick="show_layer('depth1','hidden');"><img src="../images/car_close.png"></a></div>
								</div>
							</td>
							<td>
								<a href="#"><span class="btn1">검색</span></a>
							</td>
						</tr>
					</table>
					<!-- <table id="bettingHistory1" cellspacing="0" cellpadding="0" data-scroll-x="true" style="width: 100%!important;">
            		</table> -->
				</div>
				<div class="bet_wrap">
					<table class="acc_list_table" cellspacing="0" cellpadding="0" width="100%">
						<tr>
							<td class="list_table_t" width="5%"><input type="checkbox"></td>
							<td class="list_table_t" width="5%">NO.</td>
							<td class="list_table_t" width="20%">일시</td>
							<td class="list_table_t" width="10%">베팅아이디</td>
							<td class="list_table_t" width="10%">종목</td>
							<td class="list_table_t" width="15%">베팅금액</td>
							<td class="list_table_t" width="5%">배당률</td>
							<td class="list_table_t" width="15%">예상적중금액</td>
							<td class="list_table_t" width="3%">폴더</td>
							<td class="list_table_t">결과</td>
						</tr>
					</table>
					<div class="example1">
						<div class="panel panel-primary"><!-- 1 -->
							<div class="panel-heading" data-acc-link="demo1">
								<table class="acc_list_table_1" cellpadding="0" cellspacing="0" >
									<tr>
										<td class="acc_list_check" width="5%"><input type="checkbox"></td>
										<td class="acc_list_num" width="5%">1</td>
										<td class="acc_list_time" width="20%">2017-05-05 00 : 00 : 00</td>
										<td class="acc_list_id" width="10%">asdfsadf</td>
										<td class="acc_list_event" width="10%">야구</td>
										<td class="acc_list_price1" width="15%"><span class="font_004">100,000,000</span>원</td>
										<td class="acc_list_dividend" width="5%"><span class="font_001">12.12</span>배</td>
										<td class="acc_list_price2" width="15%"><span class="font_002">100,000,000</span>원</td>
										<td class="acc_list_folder" width="3%">3</td>
										<td class="beting_btn">적중</td>
									</tr>
								</table>
							</div>
							<div class="panel-body acc-open" data-acc-content="demo1">
								<div class="bet_dd_p">
									<table class="acc_list_table_in" cellpadding="0" cellspacing="1" >
										<tr>
											<td class="acc_list_table_in_t" width="5%">NO.</td>
											<td class="acc_list_table_in_t" width="15%">경기일시</td>
											<td class="acc_list_table_in_t" width="8%">게임아이디</td>
											<td class="acc_list_table_in_t" width="5%">종목</td>
											<td class="acc_list_table_in_t" width="10%">리그</td>
											<td class="acc_list_table_in_t" width="8%">타입</td>
											<td class="acc_list_table_in_t" width="18%">홈팀</td>
											<td class="acc_list_table_in_t" width="5%">X(무)</td>
											<td class="acc_list_table_in_t" width="18%">원정팀</td>
											<td class="acc_list_table_in_t" width="8%">결과</td>
										</tr>
										<tr>
											<td class="bet_num">1</td>
											<td class="bet_time">2017-05-05 00 : 00 : 00</td>
											<td class="bet_id">sdfsdfsdf</td>
											<td class="bet_event">야구</td>
											<td class="bet_name">KOVO</td>
											<td class="bet_type">핸디캡</td>
											<td class="bet_home bet_select"><!-- 선택시 -->
												<div class="acc_list_in_l">삼성화재</div><div class="acc_list_in_r">1.25</div>
											</td>
											<td class="bet_vs">X(무)</td>
											<td class="bet_loss">
												<div class="acc_list_in_l">삼성화재</div><div class="acc_list_in_r">1.25</div>
											</td>
											<td class="beting_in_btn">적중</td>
										</tr>
										<tr>
											<td class="bet_num">2</td>
											<td class="bet_time">2017-05-05 00 : 00 : 00</td>
											<td class="bet_id">sdfsdfsdf</td>
											<td class="bet_event">야구</td>
											<td class="bet_name">KOVO</td>
											<td class="bet_type">핸디캡</td>
											<td class="bet_home">
												<div class="acc_list_in_l">삼성화재</div><div class="acc_list_in_r">1.25</div>
											</td>
											<td class="bet_vs">X(무)</td>
											<td class="bet_loss">
												<div class="acc_list_in_l">삼성화재</div><div class="acc_list_in_r">1.25</div>
											</td>
											<td class="beting_in_btn"><a href="#"><span class="btn9">취소</span></a></td>
										</tr>
									</table>									
								</div>
							</div>
						</div><!-- 1 -->
						<div class="panel panel-primary"><!-- 1 -->
							<div class="panel-heading" data-acc-link="demo2">
								<table class="acc_list_table_1" cellpadding="0" cellspacing="0" >
									<tr>
										<td class="list_table_center" width="5%"><input type="checkbox"></td>
										<td class="list_table_center" width="5%">1</td>
										<td class="list_table_center" width="20%">2017-05-05 00 : 00 : 00</td>
										<td class="list_table_center" width="10%">asdfsadf</td>
										<td class="list_table_center" width="10%">야구</td>
										<td class="list_table_center" width="15%"><span class="font_004">100,000,000</span>원</td>
										<td class="list_table_center" width="5%"><span class="font_001">12.12</span>배</td>
										<td class="list_table_center" width="15%"><span class="font_002">100,000,000</span>원</td>
										<td class="list_table_center" width="3%">3</td>
										<td class="list_table_center font_009">진행중</td>
									</tr>
								</table>
							</div>
							<div class="panel-body" data-acc-content="demo2">
								<div class="bet_dd_p">
										123
								</div>
							</div>
						</div><!-- 1 -->
						<div class="panel panel-primary"><!-- 1 -->
							<div class="panel-heading" data-acc-link="demo3">
								<table class="acc_list_table_1" cellpadding="0" cellspacing="0" >
									<tr>
										<td class="list_table_center" width="5%"><input type="checkbox"></td>
										<td class="list_table_center" width="5%">1</td>
										<td class="list_table_center" width="20%">2017-05-05 00 : 00 : 00</td>
										<td class="list_table_center" width="10%">asdfsadf</td>
										<td class="list_table_center" width="10%">야구</td>
										<td class="list_table_center" width="15%"><span class="font_004">100,000,000</span>원</td>
										<td class="list_table_center" width="5%"><span class="font_001">12.12</span>배</td>
										<td class="list_table_center" width="15%"><span class="font_002">100,000,000</span>원</td>
										<td class="list_table_center" width="3%">3</td>
										<td class="list_table_center font_010">미적중</td>
									</tr>
								</table>
							</div>
							<div class="panel-body" data-acc-content="demo3">
								<div class="bet_dd_p">
										4
								</div>
							</div>
						</div><!-- 1 -->
					</div>
					<script type="text/javascript">
						$(function() {
							$('.example1').accordion({ multiOpen: false });

						});
					</script>
				</div>
				<div class="left_btn_wrap"><a href="#"><span class="btn7">전체선택</span></a> <a href="#"><span class="btn8">선택삭제</span></a></div>
				<div class="acc_btn_wrap_m"><a href="#"><div class="page"> >> </div></a> <a href="#"><span class="page"> > </span></a> <a href="#"><div class="page_on">1</div></a> <a href="#"><div class="page">2</div></a> <a href="#"><div class="page">3</div></a> <a href="#"><div class="page">4</div></a> <a href="#"><div class="page">5</div></a> <a href="#"><div class="page"> > </div></a> <a href="#"><div class="page"> >> </div></a></div>
			</div>
		</div>
	</li>
	<li>
		<div class="acc_head"><h3>실시간/스포츠북 베팅내역</h3></div>
		<div class="acc_content">
			<div class="acc_content_in_2">
				dsdfsdfsdf
			</div>
		</div>
	</li>
	<li>
		<div class="acc_head"><h3>실시간/스포츠북 베팅내역</h3></div>
		<div class="acc_content">
			<div class="acc_content_in_2">
				dsdfsdfsdf
			</div>
		</div>
	</li>
</ul>
<script>
	$(document).ready(function(){
		var $dataTable1;
		var siteJson = [
	        {row_num: 1, date:'2017-05-05 00: 00: 00',betid:'asdfsadf',event:'야구',amount_bet:'100,000,000',dividend_rate:'12.12배',estimate_hit_amount:'100,000,000',folder:'3',ordering:1,result:'적중'},
	        {row_num: 2, date:'2017-05-05 00: 00: 00',betid:'asdfsadf',event:'야구',amount_bet:'100,000,000',dividend_rate:'12.12배',estimate_hit_amount:'100,000,000',folder:'3',ordering:1,result:'적중'},
	        {row_num: 3, date:'2017-05-05 00: 00: 00',betid:'asdfsadf',event:'야구',amount_bet:'100,000,000',dividend_rate:'12.12배',estimate_hit_amount:'100,000,000',folder:'3',ordering:1,result:'적중'},
	        {row_num: 4, date:'2017-05-05 00: 00: 00',betid:'asdfsadf',event:'야구',amount_bet:'100,000,000',dividend_rate:'12.12배',estimate_hit_amount:'100,000,000',folder:'3',ordering:1,result:'적중'},
	        {row_num: 5, date:'2017-05-05 00: 00: 00',betid:'asdfsadf',event:'야구',amount_bet:'100,000,000',dividend_rate:'12.12배',estimate_hit_amount:'100,000,000',folder:'3',ordering:1,result:'적중'},
	        {row_num: 6, date:'2017-05-05 00: 00: 00',betid:'asdfsadf',event:'야구',amount_bet:'100,000,000',dividend_rate:'12.12배',estimate_hit_amount:'100,000,000',folder:'3',ordering:1,result:'적중'},
	        {row_num: 7, date:'2017-05-05 00: 00: 00',betid:'asdfsadf',event:'야구',amount_bet:'100,000,000',dividend_rate:'12.12배',estimate_hit_amount:'100,000,000',folder:'3',ordering:1,result:'적중'},
	        {row_num: 8, date:'2017-05-05 00: 00: 00',betid:'asdfsadf',event:'야구',amount_bet:'100,000,000',dividend_rate:'12.12배',estimate_hit_amount:'100,000,000',folder:'3',ordering:1,result:'적중'},
	        {row_num: 9, date:'2017-05-05 00: 00: 00',betid:'asdfsadf',event:'야구',amount_bet:'100,000,000',dividend_rate:'12.12배',estimate_hit_amount:'100,000,000',folder:'3',ordering:1,result:'적중'},
	        {row_num: 10, date:'2017-05-05 00: 00: 00',betid:'asdfsadf',event:'야구',amount_bet:'100,000,000',dividend_rate:'12.12배',estimate_hit_amount:'100,000,000',folder:'3',ordering:1,result:'적중'},
	           
	    ];
		$dataTable1 = $('#bettingHistory1').DataTable({
			// ajax : 'process/application/charge/getChargeList.jsp',
			// bProcessing: true,
			data : siteJson ,
			sAjaxDataProp:"",
			searching: false,
			bInfo : false,
			lengthChange: false,
			autowWidth:true,
            columns : [
                	{ 
                        data   : 'row_num',
                        title  : '<input type="checkbox">',
                        render : function( data , type , row , meta ){ 
        						return '<input type="checkbox" data-row="'+meta.row+'">'; 
							}	

                    },
                    { 
                        data   : 'row_num',
                        title  : 'NO',

                    },
                    { 
                        data   : 'date',
                        title  : '일시',
                    },
                    { 
                        data   : 'betid',
                        title  : '베팅아이디',
                       
                    },
                    { 
                        data   : 'event',
                        title  : '종목',
                    },
                    { 
                        data   : 'amount_bet',
                        title  : '베팅금액',
                        render : function(data , type , row , meta){
                        		return '<span class="font_004">'+data+'</span>원'; 
                        }
                    },
                    { 
                        data   : 'dividend_rate',
                        title  : '배당률',
                    },
                    { 
                        data   : 'estimate_hit_amount',
                        title  : '예상적중금액',
                        render : function(data , type , row , meta){
                        		return '<span class="font_002">'+data+'</span>원'; 
                        }
                    },
                    { 
                        data   : 'folder',
                        title  : '폴더',
                    },
                    { 
                        data   : 'result',
                        title  : '결과',
                    },

                ],
        	pagingType: "full_numbers",
        	pageLength: 4,
            language: {
			    paginate: {
			      	previous: "<",
			      	next: ">",
			      	first: "<<",
			      	last: ">>",
			    }
			},
            rowCallback : function(row , data , index) {
                
            },
            drawCallback: function( settings ) {
                
            }
        });

		$(".dt-bet-div").on("click",function(){
	    	setTimeout(function() {
			  	$dataTable1.columns.adjust().draw();
			}, 100);
	    });


	    $('#bettingHistory1 tbody').on('click', 'td', function () {
	        var tr = $(this).closest('tr');
	        var row = $dataTable1.row( tr );
	 
	        if ( row.child.isShown() ) {
	            // This row is already open - close it
	            row.child.hide();
	            tr.removeClass('shown');
	        }
	        else {
	            // Open this row
	            row.child('asdasdasdasd').show();
	            tr.addClass('shown');
	        }
	    });

	});

	function drawSubTable(){
		
	}
</script>