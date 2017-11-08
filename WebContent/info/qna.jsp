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
				<table id="qnaDt" class="table table-striped table-bordered" cellspacing="0" cellpadding="0" data-scroll-x="true" style="width: 100%!important;">
            	</table>
				<div class="acc_btn_wrap_m">
				</div>
			</div>
		</div>
	</li>
</ul>
<script>
	$(document).ready(function(){

		var $qnaDt;
		$qnaDt = $('#qnaDt').DataTable({
			ajax : '/info/jsp/getQnaList.jsp',
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
			    },
			    emptyTable: "결과가 없습니다.",
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