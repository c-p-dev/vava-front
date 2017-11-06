<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.dt-txt{
		overflow-y: scroll!important;
	    height: 100px!important;
	    background: #202122!important;
	    /*padding: 25px 10px 25px 10px!important;*/
	    padding:0px!important;
	    /*text-align: left!important;*/
	    /*transition: all 0.1s ease;*/
	}
	div.slider {
	    display: none;
	    text-align: left!important; 
		/*padding: 25px 10px 25px 10px!important;*/
		padding-left:10px!important;
	}
	#qnaDt tbody tr{
		cursor: pointer;
	}
</style>
<ul class="smk_accordion">
	<li>
		<div class="acc_head"><h3>쪽지함</h3></div>
		<div class="acc_content">
			<div class="acc_content_in_2">
				<table id="qnaDt" cellspacing="0" cellpadding="0" data-scroll-x="true" style="width: 100%!important;">
            	</table>
				<!-- <table  width="100%" cellpadding="0" cellspacing="0" class="memo_table_title">
					<tr>
						<td width="55%">제목</td>
						<td>보낸이</td>
						<td width="15%">수신일시</td>
						<td width="15%">확인일시</td>
					</tr>
				</table>
				<ul class="popup_accordion">
					<li>
						<a>
							<table width="100%" cellpadding="0" cellspacing="0" class="meno_table">
								<tr>
									<td  width="55%" class="meno_table_left">제목입니다.</td>
									<td class="list_table_center">홍길동</td>
									<td  width="15%" class="meno_table_center">07.07.17</td>
									<td  width="15%" class="meno_table_center">07.07.17</td>
								</tr>
							</table>
						</a>
						<div>
							<table width="100%" cellpadding="0" cellspacing="0" class="meno_table_in">
								<tr>
									<td>제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.니다. 제목입니다.제목입니다. 제목입니다. 제목</td>
								</tr>
							</table>
						</div>
					</li>
					<li>
						<a>
							<table width="100%" cellpadding="0" cellspacing="0" class="meno_table">
								<tr>
									<td  width="55%" class="meno_table_left">제목입니다.</td>
									<td class="list_table_center">홍길동</td>
									<td  width="15%" class="meno_table_center">07.07.17</td>
									<td  width="15%" class="meno_table_center">07.07.17</td>
								</tr>
							</table>
						</a>
						<div>
							<table width="100%" cellpadding="0" cellspacing="0" class="meno_table_in">
								<tr>
									<td>제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제목입니다. 제목입니다. 제목입니다. 제목입니다.제</td>
								</tr>
							</table>
						</div>
					</li>
					<li>
						<a>
							<table width="100%" cellpadding="0" cellspacing="0" class="meno_table">
								<tr>
									<td  width="55%" class="meno_table_left">제목입니다.</td>
									<td class="list_table_center">홍길동</td>
									<td  width="15%" class="meno_table_center">07.07.17</td>
									<td  width="15%" class="meno_table_center">07.07.17</td>
								</tr>
							</table>
						</a>
						<div>
							<table width="100%" cellpadding="0" cellspacing="0" class="meno_table_in">
								<tr>
									<td>제목입니다. </td>
								</tr>
							</table>
						</div>
					</li>
				</ul> -->
				<!-- <script>
					
					(function($) {
						$('.popup_accordion > li:eq(0) a').addClass('active').next().slideDown();

						$('.popup_accordion a').click(function(j) {
							var dropDown = $(this).closest('li').find('div');

							$(this).closest('.popup_accordion').find('div').not(dropDown).slideUp();

							if ($(this).hasClass('active')) {
								$(this).removeClass('active');
							} else {
								$(this).closest('.popup_accordion').find('a.active').removeClass('active');
								$(this).addClass('active');
							}

							dropDown.stop(false, true).slideToggle();

							j.preventDefault();
						});
					})(jQuery);
				</script> -->
				<div class="acc_btn_wrap_m">
					<!-- <a href="#" onClick="layer_pop_mask('close','bg_mask_pop6');return false;">
						<span class="btn2c">확인</span>
					</a> 
					<a href="#">
						<span class="btn2">삭제</span>
					</a> -->
				</div>
			</div>
		</div>
	</li>
</ul>
<script>
	$(document).ready(function(){

		var $qnaDt;
		$qnaDt = $('#qnaDt').DataTable({
			ajax : 'jsp/getQnaList.jsp',
			sAjaxDataProp:"",
			searching: false,
			bInfo : false,
			lengthChange: false,
			autowWidth:true,
            columns : [
            	{ 
                    data   : 'title',
                    title  : '제목',	
                },
                { 
                    data   : 'userid',
                    title  : '보낸이',
                },
                { 
                    data   : 'ansdate',
                    title  : '수신일시',
                },
                { 
                    data   : 'regdate',
                    title  : '확인일시',
                }
        
            ],
        	pagingType: "full_numbers",
        	pageLength: 10,
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
                
            },
            createdRow: function ( row, data, index ) {       
            	if(index == 0){
            		var thisRow = $qnaDt.row(row);
            		thisRow.child(childRowFormat(data.txt),'dt-txt').show();
            		$(thisRow.child()).find('.slider').show();
            	}
        	}
        });

		$(".dt-qna-tab").on("click",function(){
			setTimeout(function() {
   			  	$qnaDt.columns.adjust().draw();
			}, 100);
			
		});

        $('#qnaDt tbody').on('click', 'tr', function () {
	        var row = $qnaDt.row(this);
	        if(!$(this).hasClass('dt-txt')){
	        	$('#qnaDt tbody').find('.slider').slideUp(function(){
					$(this).closest('tr').hide();
	        	});

	        	row.child(childRowFormat(row.data().txt),'dt-txt').show();
    			$(row.child()).find('.slider').stop(false, true).slideToggle();
	        }
	    });


	});


	function childRowFormat(d){
		return '<div class="slider">' + d + '</div>';
	}
</script>