<%@page contentType="text/html;charset=UTF-8"%>


<script language="javascript">
	
	function checkSubmit(form) {	
		
		document.form1.action="proc_setName.jsp"
		document.form1.submit();
	}
   	
</script>	
    
<form name="form1" method="post" action="javascript:checkSubmit(this)">
                                  
	<div>
		<div>
	       &nbsp;
	   	</div>	
	   	<div>
	       &nbsp;
	   	</div>	
	   	<div>
	       &nbsp;
	   	</div>	
	    <div>
	       <label><span></span>ID</label> :  <input name="uid" type="text"/>
	   	</div>    
	   <div>
	       &nbsp;
	   	</div>	   	
	   	<div>
	       <label><span></span>NAME</label> :  <input name="uname" type="text"/>
	   	</div> 
	   	<div>
	       &nbsp;
	   	</div>	
	   	<div>
	       <label><span></span>REG DATE</label> :  <input name="regdate" value="20170908" type="text"/>
	   	</div> 
	   	<div>
	       &nbsp;
	   	</div>	
	   	<div>
	       <label><span></span>LEVEL</label> :  <input name="ulevel"  value="1" type="text"/>
	   	</div> 
	   	<div>
	       &nbsp;
	   	</div>	
	   	<div>
	       <label><span></span>BAL</label> :  <input name="balance" value="0" type="text"/>
	   	</div>        
	   	       
	   	<div>
	       &nbsp;
	   	</div>	
	   	     
	<button type="submit">Register</a></button>                                           
  <button type="reset">Cancel</button>
                                                          
	</div>

</form>
                        
                        