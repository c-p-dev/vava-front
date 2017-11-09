

public AdminInfoBean checkUser(String aid,String apass,String mlevel) throws SQLException{
       
	
	  AdminInfoBean aib = new AdminInfoBean();
	  Connection con = null;
	  PreparedStatement pstmt = null;
	  ResultSet rs = null;
	  
	  	
		try{
      	
	 	Context initContext = new InitialContext();
	 	Context envContext = (Context)initContext.lookup("java:/comp/env");
	 	DataSource ds = (DataSource)envContext.lookup("jdbc/bgcbus");
			 	
	 	con = ds.getConnection();
		    
       	String  query = "SELECT ADMIN_ID,ADMIN_PASS,USE_FLAG,ADMIN_NM,ADMIN_LEVEL FROM ADMIN_MST WHERE ADMIN_ID = ? and ADMIN_LEVEL = ? ";
       	      	
      	pstmt = con.prepareStatement(query);
        pstmt.clearParameters();
        pstmt.setString(1,aid);
        pstmt.setString(2,mlevel);
	    		
    	rs = pstmt.executeQuery();

  		if(rs.next()){
  			
  			if(rs.getString("ADMIN_PASS").equals(apass)){
  				
  				if(rs.getString("USE_FLAG").equals("1")){
  					
      					aib.setAid(rs.getString("ADMIN_ID"));
      					aib.setAname(rs.getString("ADMIN_NM"));
      					aib.setLevel(rs.getString("ADMIN_LEVEL"));
      					aib.setResult(1); // flag
      					
  				}else{
  					
      				  aib.setAid(rs.getString("ADMIN_ID"));
      					aib.setAname(rs.getString("ADMIN_NM"));
      					aib.setLevel(rs.getString("ADMIN_LEVEL"));
      					aib.setResult(2); //
  				}
  				
  			}else{
  				
  				aib.setResult(9); //WRONG PASSWORD
  			}

  		}else{
  			
  			aib.setResult(-1); //WRONG ID
  		}

        rs.close();
        pstmt.close();
        con.close();

      	return aib;

		}catch(Exception e){
        
       	return null;

    }finally{
    	if(rs != null) rs.close();
    	if(pstmt!=null) pstmt.close();
    	if(con!=null) con.close();
    }
}

