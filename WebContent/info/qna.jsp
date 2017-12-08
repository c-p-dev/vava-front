<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
	.dt-txt{
		/*overflow-y: scroll!important;*/
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
		transition: all .2s ease-in-out;
	}
	#qnaDt tbody tr td.dt-txt {
	    text-align: left!important;
    	padding-left: 10px!important;
	}
	table#qnaDt tbody tr:hover {
		/*background: #2e3334!important;*/
		background: #293133!important;
	}

	table.dataTable thead th{ 
	    color: #c1c3c4;
	    background: #2e3334;
	    height: 40px;
	    text-align: center;
	    /*border-bottom: solid 1px #000000!important;*/
	    border-right: solid 1px #1c2021;
	    font-size: 12px!important;
	    font-family: Nanum Gothic, 굴림, 돋음, Dotum, Arial, Helvetica, sans-serif!important;
	    color: #c1c3c4!important;
	}
	table.dataTable thead th:first-child{
	    /*border-left: solid 1px #2e3032!important;*/
	    border-left: solid 1px #1c2021!important;

	}
	table.dataTable tbody tr {
	    background-color: transparent!important;
	    background: #262a2b!important;
	}
	table.dataTable tbody td {
	    padding: 0px!important;
	    text-align: center!important;
	    /*border-bottom: solid 1px #1c2021!important;*/
	    border-left: solid 1px #1c2021!important;
	    height: 35px!important;
	    border-right: solid 1px #1c2021!important;
	    font-size: 12px!important;
	    font-family: Nanum Gothic, 굴림, 돋음, Dotum, Arial, Helvetica, sans-serif!important;



	}
	table#qnaDT.dataTable.no-footer thead{
		display: none;
	}
</style>
<ul class="smk_accordion">
	<li>
		<div class="acc_head"><h3>쪽지함</h3></div>
		<div class="acc_content">
			<div class="acc_content_in_2">
				<div class="float_inline">
					<div class="my_search_wrap">						
					</div>
					<div class="my_search_list" id="qna-div" style="margin:0px" >
						<table id="qnaDt" class="" cellspacing="0" cellpadding="0" data-scroll-x="true" style="width: 100%!important;">
            			</table>
					</div>
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
			bProcessing: true,
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
            	//console.log(row);
            	$(row).addClass('s_close');
            	// if(index == 0){
            	// 	var thisRow = $qnaDt.row(row);
            	// 	thisRow.child(childRowFormat(data.txt),'dt-txt').show();
            	// 	$(thisRow.child()).find('.slider').show();
            	// }
        	}
        });

		

   		$("#tab4").on("fadeInComplete", function() {
    		setTimeout(function() {
  
			  	$qnaDt.columns.adjust().draw();
			}, 100);
    		
		});

        $('#qnaDt tbody').on('click', 'tr', function () {
	        var row = $qnaDt.row(this);
	        if($(this).hasClass('s_close')){

	        	row.child(childRowFormat(row.data().txt),'dt-txt').show();
    			$(row.child()).find('.slider').stop(false, true).slideToggle();

    			$(this).removeClass('s_close');
    			$(this).addClass('s_open');

	        }else{

	        	row.child(childRowFormat(row.data().txt),'dt-txt').hide();
	        	$(row.child()).find('.slider').stop(false, true).slideToggle();

	        	$(this).removeClass('s_open');
    			$(this).addClass('s_close');
	        }

	        // if(!$(this).hasClass('dt-txt'))
	        // if(!$(this).hasClass('dt-txt')){
	        	// $('#qnaDt tbody').find('.slider').slideUp(function(){
					// $(this).closest('tr').hide();
	        	// });

	        	// row.child(childRowFormat(row.data().txt),'dt-txt').show();
    			// $(row.child()).find('.slider').stop(false, true).slideToggle();
	        // }
	    });


	});


	function childRowFormat(d){
		// return '<div class="slider">' + d + '</div>';
		return  d;

	}
</script>