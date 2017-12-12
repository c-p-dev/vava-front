package bc4;

import java.io.UnsupportedEncodingException;
import java.nio.ByteBuffer;
import java.sql.*;
import javax.sql.*;
import java.sql.*;

import javax.json.Json;
import javax.json.JsonObject;
//import javax.json.Json;
//import javax.json.JsonObject;
import javax.naming.*;
import java.util.*;
import org.json.JSONArray;
import org.json.JSONObject;

import bean.*;

public class BetConManager2 {

 	Context initContext;
 	Context envContext;
 	DataSource ds;
 	
	public BetConManager2(){
			 	
	 	try {
			initContext = new InitialContext();
	
		 	envContext = (Context)initContext.lookup("java:/comp/env");
		 	ds = (DataSource)envContext.lookup("jdbc/ibet");
	 	
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	}

	CallableStatement cs = null;
	
	
	public StringBuffer getMarketCategory() throws SQLException{
		 
		  Connection con = null;
		  PreparedStatement pstmt = null;		  
		  ResultSet rs = null;		  
		  String mk_cat = "";
		  String win_lose = "";
		  String over_under = "";
		  String handi = "";
		  String combi = "";
		  String etc = "";
		  
		  StringBuffer sb = new StringBuffer(""); 
		  
		  String query = "select keyname,json  as mk_cat from bc_json "+
				  		 " where keyname='MKTYPE_WINLOSE' or keyname='MKTYPE_OVERUNDER' or keyname='MKTYPE_HANDICAP' or keyname='MKTYPE_COMBI' or keyname='MKTYPE_ETC'";

		  try{	      	

			 	con = ds.getConnection();			 	
			 	
			 	pstmt = con.prepareStatement(query);	
		        rs = pstmt.executeQuery();
		        		        
		        
		        while(rs.next()){
		        	
		        	if(rs.getString("keyname").equals("MKTYPE_WINLOSE")){
		        		win_lose = rs.getString("mk_cat");
		        	
		        	} else if(rs.getString("keyname").equals("MKTYPE_OVERUNDER")){
		        		over_under = rs.getString("mk_cat");
		        	
		        	} else if(rs.getString("keyname").equals("MKTYPE_HANDICAP")){
		        		handi = rs.getString("mk_cat");
		        	
		  			} else if(rs.getString("keyname").equals("MKTYPE_COMBI")){
		  				combi = rs.getString("mk_cat");
		        	
					} else if(rs.getString("keyname").equals("MKTYPE_ETC")){
						etc = rs.getString("mk_cat");
					
					}
		        	//mk_cat += rs.getString("mk_cat");
		        }
		        rs.close();
		        pstmt.close();
		        con.close();		        
		        
		        //if(mk_cat.length() > 2)
		        //	mk_cat = mk_cat.substring(0, mk_cat.length()-1); //(json_mk.length()-1);
				        	
	        	sb.append("[{\"WL\":\""+win_lose+"\",\"OU\":\""+over_under+"\",\"HD\":\""+handi+"\",\"CB\":\""+combi+"\",\"ETC\":\""+etc+"\"}]");
		        
	        	//Debug.out(sb.toString());
		         
		  }catch(Exception e){
			  //Debug.out("[getMarketCategory] : " + e.getMessage());
		
	      }finally{
	    	  if(rs!=null) rs.close();
	     	  if(pstmt!=null)  pstmt.close();
	     	  if(con!=null) con.close();
	    	}
		  
	  return sb;
		
	}
	
	public StringBuffer getLiveMatches() throws SQLException{
		
		  Connection con = null;
		  //PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  String match = "";
		  String result = "";
		  String sele = "";
		  String market = "";
		  String stat = "";
		  Statement stmt= null;
		  
		  StringBuffer sb = new StringBuffer(""); 
		  
		  String query = " SELECT '{\"Id\":\"'+CAST(A.match_id as varchar(10))+'\",\"CId\":\"'+CAST(A.compet_id as varchar(10))+'\",\"CN\":\"'+CNAME+'\","+
					"\"SId\":\"'+CAST(A.sport_id as varchar(10))+'\",\"SN\":\"'+SNAME+'\",\"RId\":\"'+CAST(A.region_id as varchar(10))+'\",\"RN\":\"'+RNAME+'\","+
					//" \"LiveStatus\":\"'+CAST(A.live_stat as varchar(1))+'\",\"MatchStatus\":\"'+CAST(A.match_stat as varchar(1))+'\","+
					//" \"IsLiveAvailable\":\"'+CASE WHEN live_stat = 0 THEN 'true' ELSE 'false' END+'\","+
					//" \"IsVisible\":'+CASE WHEN visible ='T' THEN 'true' ELSE 'false' END+', "+
					"\"Sus\":'+CASE WHEN suspend ='T' THEN 'true' ELSE 'false' END+',"+
					//" \"IsLive\":\"'+CASE WHEN live ='T' THEN 'true' ELSE 'false' END+'\","+
					//" \"IsStarted\":\"'+CASE WHEN match_start ='T' THEN 'true' ELSE 'false' END+'\", "+
					"\"HT\":\"'+home_name+'\","+
					"\"HD\":\"'+CAST(home_team_id as varchar(10))+'\","+
					"\"AD\":\"'+CAST(away_team_id as varchar(10))+'\","+
					"\"AT\":\"'+away_name+'\"},' AS match  "+
					" FROM bc_match A ,"+
					" (SELECT SPORT_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE SPORT_NAME END  AS SNAME "+
					" FROM bc_sport A LEFT OUTER JOIN BC_TRANS B ON A.SPORT_NAMEID = B.NAMEID) B,"+						
					" (SELECT REGION_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE REGION_NAME END AS RNAME "+
					" FROM  BC_REGION A LEFT OUTER JOIN BC_TRANS B ON A.REGION_NAMEID = B.NAMEID) C,"+						
					" (SELECT COMPET_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE COMPET_NAME END AS CNAME "+
					" FROM BC_COMPETITION A LEFT OUTER JOIN BC_TRANS B ON A.NAMEID = B.NAMEID) D "+						
					" WHERE A.sport_id = B.SPORT_ID  AND A.region_id = C.REGION_ID AND A.compet_id = D.COMPET_ID "+
					" AND live='T' and a.live_stat='1' AND a.visible='T'  AND a.booked='T' and A.home_name is not null and A.away_name is not null";

		  String query2 = " SELECT '{\"MId\":\"'+CAST(A.MATCH_ID as varchar(10))+'\",\"Sc\":\"'+SCORE+'\",\"Pe\":\"'+isnull(CAST(PERIOD as varchar(10)),'') +'\","+
				  	"\"Cur\":\"'+isnull(CAST(CUR_MIN as varchar(50)),'') +'\","+
				  	"\"Rem\":\"'+isnull(REMAIN_TIME,'')+'\",\"ET\":\"'+isnull(EVENT_TYPE,'')+'\",\"Inf\":\"'+GAME_INFO+'\"},' as stat "+  
				  	" FROM BC_MATCH A, BC_STAT B  WHERE  A.MATCH_ID = B.MATCH_ID and home_name is not null and away_name is not null"+
				  	" AND live='T' and a.live_stat='1' AND a.visible='T'  AND a.booked='T'";

		  
		  String query3 =" DECLARE @list varchar(MAX) "+
				  		" SELECT @list = JSON FROM BC_JSON WHERE KEYNAME='MARKET_TYPE' "+		  
				  		" SELECT '{\"Id\":'+CAST(A.MARKET_ID as varchar(10))+',\"M\":\"'+CAST(B.MATCH_ID as varchar(10))+'\","+
				  		"\"V\":'+CASE WHEN A.visible ='T' THEN 'true' ELSE 'false' END +',"+
				  		"\"S\":'+CASE WHEN A.suspend ='T' THEN 'true' ELSE 'false' END +'},' as market "+
		  				" FROM BC_MARKET A,  BC_MATCH B "+
		  				" WHERE A.MATCH_ID = B.MATCH_ID and home_name is not null and away_name is not null AND MARKET_TYPE_ID in "+
		  				" (SELECT splitdata FROM SplitString(@list,',')) "+ 
		  				" AND B.live='T' and B.live_stat='1' AND B.visible='T'  AND B.booked='T' "+  
		  				" AND A.visible='T' AND A.suspend = 'F' ";

		  
		  String query4 = " SELECT  '{\"Id\":'+CAST(A.MARKET_ID as varchar(10))+',\"MId\":'+CAST(B.MATCH_ID as varchar(10))+', "+
				  		"\"Sus\":'+CASE WHEN A.suspend ='T' THEN 'true' ELSE 'false' END+',"+
				  		"\"Vis\":'+CASE WHEN A.visible ='T' THEN 'true' ELSE 'false' END+'},' "+ 
				  		" as result "+ 
				  		" FROM BC_MARKET A ,BC_match b "+
				  		" WHERE  B.live='T' and B.live_stat='1' AND B.visible='T'  AND B.booked='T'  "+
				  		//" AND A.visible='T' AND A.suspend = 'F' and home_name is not null and away_name is not null"+
				  		//" AND A.visible='T' and home_name is not null and away_name is not null"+
				  		" AND home_name is not null and away_name is not null"+
				  		" and a.MATCH_ID = b.MATCH_ID AND (MARKET_TYPE_ID ='377' or MARKET_TYPE_ID='399' or MARKET_TYPE_ID='2434' or MARKET_TYPE_ID='4475' "+
				  		" OR MARKET_TYPE_ID='5488' OR MARKET_TYPE_ID='5498'   OR MARKET_TYPE_ID='8774' OR MARKET_TYPE_ID='6544' "+
				  		" OR MARKET_TYPE_ID='6564' OR MARKET_TYPE_ID='8750' OR MARKET_TYPE_ID='8763' OR MARKET_TYPE_ID='9775' "+
				  		" OR MARKET_TYPE_ID='10829' or MARKET_TYPE_ID='9321')  ";
		 
		  String query5 = " SELECT  '{\"Id\":\"'+CAST(C.SEL_ID as varchar(10))+'\",\"MId\":'+CAST(B.MATCH_ID as varchar(10))+',\"MkId\":\"'+CAST(C.Market_Id as varchar(10))+'\","+
				  		"\"Nm\":\"'+CAST(C.sel_name as varchar(10))+'\",\"P\":\"'+CAST(C.sel_price as varchar(10))+'\","+
				  		"\"Sus\":'+CASE WHEN A.suspend ='T' THEN 'true' ELSE 'false' END+',"+
				  		"\"Vis\":'+CASE WHEN A.visible ='T' THEN 'true' ELSE 'false' END+'},' as selection "+ 
				  		" FROM BC_MARKET A ,BC_match b, bc_selection c "+
				  		" WHERE  B.live='T' and B.live_stat='1' AND B.visible='T'  AND B.booked='T' "+ 
				  		" AND A.visible='T' and a.market_id = c.market_id and home_name is not null and away_name is not null"+
				  		" and a.MATCH_ID = b.MATCH_ID AND (MARKET_TYPE_ID ='377' or MARKET_TYPE_ID='399' or MARKET_TYPE_ID='2434' or MARKET_TYPE_ID='4475' "+
				  		" OR MARKET_TYPE_ID='5488' OR MARKET_TYPE_ID='5498'   OR MARKET_TYPE_ID='8774' OR MARKET_TYPE_ID='6544' "+
				  		" OR MARKET_TYPE_ID='6564' OR MARKET_TYPE_ID='8750' OR MARKET_TYPE_ID='8763' OR MARKET_TYPE_ID='9775' "+
				  		" OR MARKET_TYPE_ID='10829' or MARKET_TYPE_ID='9321') ";

		  
		  //Debug.out("query1 : " + query);	
		  //Debug.out("query2 : " + query2);	
		  //Debug.out("query3 : " + query3);	
		  //Debug.out("query4 : " + query4);	
		  //Debug.out("query5 : " + query4);

		  try{	      	
			 	//Context initContext = new InitialContext();
			 	//Context envContext = (Context)initContext.lookup("java:/comp/env");
			 	//DataSource ds = (DataSource)envContext.lookup("jdbc/ibet");
			 				 	
			 	con = ds.getConnection();			 	
			 	
			 	//pstmt = con.prepareStatement(query);		
			 	stmt = con.createStatement();
		        rs = stmt.executeQuery(query);	
		        
		        while(rs.next()){
		        	match += rs.getString("match");
		        }
		        rs.close();
		        //stmt.close();
		        
		        if(match.length() > 2)
		        	match = match.substring(0, match.length()-1); //(json_mk.length()-1);				        	
	        	sb.append("[{\"Mt\": ["+match+"]");	        	
		        
		        //pstmt = con.prepareStatement(query2);
		        rs = stmt.executeQuery(query2);		
		        
	        	 while(rs.next()){
	        		 stat += rs.getString("stat");
	        	 }	        	 
	        	 rs.close();
	        	 //pstmt.close();
	
	        	if(stat.length() > 2)
	        		stat = stat.substring(0, stat.length()-1); //(json_mk.length()-1);
				        	
	        	sb.append(",\"St\": ["+stat+"]");
				        	
	        	//pstmt = con.prepareStatement(query3);
	        	rs = stmt.executeQuery(query3);
		        
	        	while(rs.next()){
	        		market += rs.getString("market");
		        }
		        
	        	rs.close();
	        	//pstmt.close();
	        	
	        	if(market.length() > 2)
	        		market = market.substring(0, market.length()-1); //(json_mk.length()-1);
	
	        	sb.append(",\"Mk\": ["+market+"]");
	        	
	        	//pstmt = con.prepareStatement(query4);
	        	rs = stmt.executeQuery(query4);
		        
	        	while(rs.next()){
	        		result += rs.getString("result");
		        }
		        
	        	rs.close();
	        	//pstmt.close();
	        	
	        	if(result.length() > 2)
	        		result = result.substring(0, result.length()-1); //(json_mk.length()-1);
	
	        	sb.append(",\"Re\": ["+result+"]");
	        	
	        	//pstmt = con.prepareStatement(query5);
	        	rs = stmt.executeQuery(query5);
		        
	        	while(rs.next()){
	        		sele += rs.getString("selection");
		        }
		        
	        	rs.close();
	        	stmt.close();
	        	
	        	if(sele.length() > 2)
	        		sele = sele.substring(0, sele.length()-1); //(json_mk.length()-1);
	
	        	sb.append(",\"Se\": ["+sele+"]}]");	        	
	        	
		        con.close();
		        
		        //Debug.out("getLiveMatches : " + sb.toString());
		        
		  }catch(Exception e){
			  //Debug.out("[getLiveMatches] : " + e.getMessage());
		
	      }finally{
	     	 // if(cs!=null) cs.close();
	     	  if(rs!=null) rs.close();	     	 
	     	  if(stmt!=null)  stmt.close();
	     	  if(con!=null) con.close();
	    	}
		  
	  return sb;
		
	}
	
	
	public StringBuffer subLoadLiveMatch(String mid ) throws SQLException{
		
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  String match = "";
		  String result = "";
		  String sele = "";
		  String market = "";
		  String stat = "";
		  
		  
		  StringBuffer sb = new StringBuffer(""); 
		  
		  String query = " SELECT '{\"Id\":\"'+CAST(A.match_id as varchar(10))+'\",\"CId\":\"'+CAST(A.compet_id as varchar(10))+'\",\"CN\":\"'+CNAME+'\", "+
					" \"SId\":\"'+CAST(A.sport_id as varchar(10))+'\",\"SN\":\"'+SNAME+'\",\"RId\":\"'+CAST(A.region_id as varchar(10))+'\",\"RN\":\"'+RNAME+'\", "+
				//	" \"LiveStatus\":\"'+CAST(A.live_stat as varchar(1))+'\",\"MatchStatus\":\"'+CAST(A.match_stat as varchar(1))+'\","+
				//	" \"IsLiveAvailable\":\"'+CASE WHEN live_stat = 0 THEN 'true' ELSE 'false' END+'\","+
				//	" \"IsVisible\":'+CASE WHEN visible ='T' THEN 'true' ELSE 'false' END+', "+
					" \"Sus\":'+CASE WHEN suspend ='T' THEN 'true' ELSE 'false' END+',"+
				//	" \"IsLive\":\"'+CASE WHEN live ='T' THEN 'true' ELSE 'false' END+'\","+
				//	" \"IsStarted\":\"'+CASE WHEN match_start ='T' THEN 'true' ELSE 'false' END+'\", "+
					" \"HT\":\"'+home_name+'\","+
					"\"HD\":\"'+CAST(home_team_id as varchar(10))+'\","+
					"\"AD\":\"'+CAST(away_team_id as varchar(10))+'\","+
					" \"AT\":\"'+away_name+'\"},' AS match  "+
					" FROM bc_match A ,"+
					" (SELECT SPORT_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE SPORT_NAME END  AS SNAME "+
					" FROM bc_sport A LEFT OUTER JOIN BC_TRANS B ON A.SPORT_NAMEID = B.NAMEID) B,"+						
					" (SELECT REGION_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE REGION_NAME END AS RNAME "+
					" FROM  BC_REGION A LEFT OUTER JOIN BC_TRANS B ON A.REGION_NAMEID = B.NAMEID) C,"+						
					" (SELECT COMPET_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE COMPET_NAME END AS CNAME "+
					" FROM BC_COMPETITION A LEFT OUTER JOIN BC_TRANS B ON A.NAMEID = B.NAMEID) D "+						
					" WHERE A.sport_id = B.SPORT_ID  AND A.region_id = C.REGION_ID AND A.compet_id = D.COMPET_ID "+
					" AND a.match_id='"+mid+"' and A.home_name is not null and A.away_name is not null";

		  String query2 = " SELECT '{\"MId\":\"'+CAST(A.MATCH_ID as varchar(10))+'\",\"Sco\":\"'+SCORE+'\",\"Pe\":\"'+isnull(CAST(PERIOD as varchar(10)),'') +'\","+
				  	" \"Cur\":\"'+isnull(CAST(CUR_MIN as varchar(50)),'') +'\","+
				  	" \"Rem\":\"'+isnull(REMAIN_TIME,'')+'\",\"ET\":\"'+isnull(EVENT_TYPE,'')+'\",\"Inf\":\"'+GAME_INFO+'\"},' as stat "+  
				  	" FROM BC_MATCH A, BC_STAT B  WHERE  A.MATCH_ID = B.MATCH_ID and home_name is not null and away_name is not null"+
				  	" AND a.match_id='"+mid+"' AND a.visible='T'  AND a.booked='T'";

		  
		  String query3 =" DECLARE @list varchar(MAX) "+
				  		" SELECT @list = JSON FROM BC_JSON WHERE KEYNAME='MARKET_TYPE' "+		  
				  		" SELECT '{\"Id\":'+CAST(A.MARKET_ID as varchar(10))+',\"M\":\"'+CAST(B.MATCH_ID as varchar(10))+'\","+
				  		"	\"V\":'+CASE WHEN A.visible ='T' THEN 'true' ELSE 'false' END +',"+
				  		"	\"S\":'+CASE WHEN A.suspend ='T' THEN 'true' ELSE 'false' END +'},' as market "+
		  				" FROM BC_MARKET A,  BC_MATCH B "+
		  				" WHERE A.MATCH_ID = B.MATCH_ID and home_name is not null and away_name is not null AND MARKET_TYPE_ID in "+
		  				" (SELECT splitdata FROM SplitString(@list,',')) "+ 
		  				" AND B.match_id='"+mid+"' AND B.visible='T'  AND B.booked='T' "+  
		  				" AND A.visible='T' AND A.suspend = 'F' ";

		  
		  String query4 = " SELECT  '{\"Id\":'+CAST(A.MARKET_ID as varchar(10))+',\"MId\":'+CAST(B.MATCH_ID as varchar(10))+',"+
				  		"\"Sus\":'+CASE WHEN A.suspend ='T' THEN 'true' ELSE 'false' END+',"+
				  		"\"Vis\":'+CASE WHEN A.visible ='T' THEN 'true' ELSE 'false' END+'},' as result "+ 
				  		" FROM BC_MARKET A ,BC_match b "+
				  		" WHERE B.match_id='"+mid+"' AND B.visible='T'  AND B.booked='T'  "+
				  		" AND A.visible='T' AND A.suspend = 'F' and home_name is not null and away_name is not null"+
				  		" and a.MATCH_ID = b.MATCH_ID AND (MARKET_TYPE_ID ='377' or MARKET_TYPE_ID='399' or MARKET_TYPE_ID='2434' or MARKET_TYPE_ID='4475' "+
				  		" OR MARKET_TYPE_ID='5488' OR MARKET_TYPE_ID='5498'   OR MARKET_TYPE_ID='8774' OR MARKET_TYPE_ID='6544' "+
				  		" OR MARKET_TYPE_ID='6564' OR MARKET_TYPE_ID='8750' OR MARKET_TYPE_ID='8763' OR MARKET_TYPE_ID='9775' "+
				  		" OR MARKET_TYPE_ID='10829' or MARKET_TYPE_ID='9321')  ";
		 
		  String query5 = " SELECT  '{\"Id\":\"'+CAST(C.SEL_ID as varchar(10))+'\",\"MId\":'+CAST(B.MATCH_ID as varchar(10))+',\"MkId\":\"'+CAST(C.Market_Id as varchar(10))+'\", "+
				  		" \"Nm\":\"'+CAST(C.sel_name as varchar(10))+'\",\"P\":\"'+CAST(C.sel_price as varchar(10))+'\", "+
				  		"  \"Sus\":'+CASE WHEN A.suspend ='T' THEN 'true' ELSE 'false' END+', "+
				  		" \"Vis\":'+CASE WHEN A.visible ='T' THEN 'true' ELSE 'false' END+'},' as selection "+ 
				  		" FROM BC_MARKET A ,BC_match b, bc_selection c "+
				  		" WHERE  B.match_id='"+mid+"'  AND B.visible='T'  AND B.booked='T' "+ 
				  		" AND A.visible='T' and a.market_id = c.market_id and home_name is not null and away_name is not null"+
				  		" and a.MATCH_ID = b.MATCH_ID AND (MARKET_TYPE_ID ='377' or MARKET_TYPE_ID='399' or MARKET_TYPE_ID='2434' or MARKET_TYPE_ID='4475' "+
				  		" OR MARKET_TYPE_ID='5488' OR MARKET_TYPE_ID='5498'   OR MARKET_TYPE_ID='8774' OR MARKET_TYPE_ID='6544' "+
				  		" OR MARKET_TYPE_ID='6564' OR MARKET_TYPE_ID='8750' OR MARKET_TYPE_ID='8763' OR MARKET_TYPE_ID='9775' "+
				  		" OR MARKET_TYPE_ID='10829' or MARKET_TYPE_ID='9321') ";

		  
		 // //Debug.out("query1 : " + query);	
		 // //Debug.out("query2 : " + query2);	
		 // //Debug.out("query3 : " + query3);	
		 // //Debug.out("query4 : " + query4);	
		 // //Debug.out("query5 : " + query4);

		  try{	      	
			 	//Context initContext = new InitialContext();
			 	//Context envContext = (Context)initContext.lookup("java:/comp/env");
			 	//DataSource ds = (DataSource)envContext.lookup("jdbc/ibet");
			 				 	
			 	con = ds.getConnection();			 	
			 				 
			 	pstmt = con.prepareStatement(query);				 	
		        rs = pstmt.executeQuery();	
		        
		        while(rs.next()){
		        	match += rs.getString("match");
		        }
		        rs.close();
		        pstmt.close();
		        
		        if(match.length() > 2)
		        	match = match.substring(0, match.length()-1); //(json_mk.length()-1);				        	
	        	sb.append("[{\"Mt\": ["+match+"]");
	        	
		        
		        pstmt = con.prepareStatement(query2);
		        rs = pstmt.executeQuery();		
		        
	        	 while(rs.next()){
	        		 stat += rs.getString("stat");
	        	 }	        	 
	        	 rs.close();
	        	 pstmt.close();
	
	        	if(stat.length() > 2)
	        		stat = stat.substring(0, stat.length()-1); //(json_mk.length()-1);
				        	
	        	sb.append(",\"St\": ["+stat+"]");
				        	
	        	pstmt = con.prepareStatement(query3);
	        	rs = pstmt.executeQuery();
		        
	        	while(rs.next()){
	        		market += rs.getString("market");
		        }
		        
	        	rs.close();
	        	pstmt.close();
	        	
	        	if(market.length() > 2)
	        		market = market.substring(0, market.length()-1); //(json_mk.length()-1);
	
	        	sb.append(",\"Mk\": ["+market+"]");
	        	
	        	pstmt = con.prepareStatement(query4);
	        	rs = pstmt.executeQuery();
		        
	        	while(rs.next()){
	        		result += rs.getString("result");
		        }
		        
	        	rs.close();
	        	pstmt.close();
	        	
	        	if(result.length() > 2)
	        		result = result.substring(0, result.length()-1); //(json_mk.length()-1);
	
	        	sb.append(",\"Re\": ["+result+"]");
	        	
	        	pstmt = con.prepareStatement(query5);
	        	rs = pstmt.executeQuery();
		        
	        	while(rs.next()){
	        		sele += rs.getString("selection");
		        }
		        
	        	rs.close();
	        	pstmt.close();
	        	
	        	if(sele.length() > 2)
	        		sele = sele.substring(0, sele.length()-1); //(json_mk.length()-1);
	
	        	sb.append(",\"Se\": ["+sele+"]}]");	        	
	        	
		        con.close();
		        
		        ////Debug.out("getLiveMatches : " + sb.toString());
		        
		  }catch(Exception e){
			  //Debug.out("[getLiveMatches] : " + e.getMessage());
		
	      }finally{
	     	 // if(cs!=null) cs.close();
	     	  if(rs!=null) rs.close();	     	 
	     	  if(pstmt!=null)  pstmt.close();
	     	  if(con!=null) con.close();
	    	}
		  
	  return sb;
		
	}
	
	
	public StringBuffer getPreMatchCnt() throws SQLException{
		
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  String match = "";
		  StringBuffer sb = new StringBuffer(""); 
		  
		  String query = " SELECT '{\"Id\":\"'+CAST(match_id as varchar(10))+'\",\"CId\":\"'+CAST(compet_id as varchar(10))+'\"},' AS match  "+
					" FROM bc_match WHERE match_stat='0' AND visible='T' AND booked='T' "+
					" and convert(char(8),match_date,112) >= convert(char(8),getdate(),112) "+
					" and convert(char(8),match_date,112) <= convert(char(8),getdate()+6,112) "+
					" and home_name is not null and away_name is not null";
		 
		  ////Debug.out("[getPreMatches] :" + query);		
		  
		  try{	      	
			 	Context initContext = new InitialContext();
			 	Context envContext = (Context)initContext.lookup("java:/comp/env");
			 	DataSource ds = (DataSource)envContext.lookup("jdbc/ibet");
			 				 	
			 	con = ds.getConnection();			 	
			 	
			 	pstmt = con.prepareStatement(query);
		        rs = pstmt.executeQuery();
		        		        
		        while(rs.next()){		        	
		        	match += rs.getString("match");
		        }

		        rs.close();
		        pstmt.close();
		        con.close();
		        
		        if(match.length() > 2)
		        	match = match.substring(0, match.length()-1); //(json_mk.length()-1);				        	
	        	sb.append("["+match+"]");
	        	
	        	////Debug.out("[getPreMatches] : " + sb.toString());
			  		    
		  }catch(Exception e){
			  //Debug.out("[getPreMatches] : " + e.getMessage());
		
	      }finally{
	     	  if(cs!=null) cs.close();
	     	  if(rs!=null) rs.close();
	     	  if(pstmt!=null)  pstmt.close();
	     	  if(con!=null) con.close();
	    	}
		  
	  return sb;
		
	}
	
	
	public StringBuffer getPreMatches() throws SQLException{
		
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  String match = "";
		  StringBuffer sb = new StringBuffer(""); 

		  String query = " SELECT '{\"Id\":\"'+CAST(A.match_id as varchar(10))+'\",\"CId\":\"'+CAST(A.compet_id as varchar(10))+'\",\"CN\":\"'+CNAME+'\", "+
					" \"SId\":\"'+CAST(A.sport_id as varchar(10))+'\",\"Dt\":\"'+convert(char(10),match_date,120)+'\",\"SN\":\"'+SNAME+'\",\"RId\":\"'+CAST(A.region_id as varchar(10))+'\",\"RN\":\"'+RNAME+'\"},' AS match  "+
					" FROM bc_match A ,"+
					" (SELECT SPORT_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE SPORT_NAME END  AS SNAME "+
					" FROM bc_sport A LEFT OUTER JOIN BC_TRANS B ON A.SPORT_NAMEID = B.NAMEID) B,"+						
					" (SELECT REGION_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE REGION_NAME END AS RNAME "+
					" FROM  BC_REGION A LEFT OUTER JOIN BC_TRANS B ON A.REGION_NAMEID = B.NAMEID) C,"+						
					" (SELECT COMPET_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE COMPET_NAME END AS CNAME "+
					" FROM BC_COMPETITION A LEFT OUTER JOIN BC_TRANS B ON A.NAMEID = B.NAMEID) D "+						
					" WHERE A.sport_id = B.SPORT_ID  AND A.region_id = C.REGION_ID AND A.compet_id = D.COMPET_ID "+
					//" AND live='T' and a.live_stat='1' AND a.visible='T'  AND a.booked='T' ";
					" AND a.match_stat='0' AND a.visible='T'  AND a.booked='T' "+
					" and convert(char(8),match_date,112) >= convert(char(8),getdate(),112) "+
					" and convert(char(8),match_date,112) <= convert(char(8),getdate()+6,112) "+
					" and home_name is not null and away_name is not null";
		  
		 // //Debug.out("[getPreMatches] :" + query);		
		  
		  try{	      	
			 	//Context initContext = new InitialContext();
			 	//Context envContext = (Context)initContext.lookup("java:/comp/env");
			 	//DataSource ds = (DataSource)envContext.lookup("jdbc/ibet");
			 				 	
			 	con = ds.getConnection();			 	
			 	
			 	pstmt = con.prepareStatement(query);
		        rs = pstmt.executeQuery();
		        		        
		        while(rs.next()){		        	
		        	match += rs.getString("match");
		        }

		        rs.close();
		        pstmt.close();
		        con.close();
		        
		        if(match.length() > 2)
		        	match = match.substring(0, match.length()-1); //(json_mk.length()-1);				        	
	        	sb.append("["+match+"]");
	        	
	        	////Debug.out("[getPreMatches] : " + sb.toString());
			  		    
		  }catch(Exception e){
			  //Debug.out("[getPreMatches] : " + e.getMessage());
		
	      }finally{
	     	  if(cs!=null) cs.close();
	     	  if(rs!=null) rs.close();
	     	  if(pstmt!=null)  pstmt.close();
	     	  if(con!=null) con.close();
	    	}
		  
	  return sb;
		
	}
	
	
	public StringBuffer subLoadPreMatch(String mid) throws SQLException{
		
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  String match = "";
		  StringBuffer sb = new StringBuffer(""); 

		  String query = " SELECT '{\"Id\":\"'+CAST(A.match_id as varchar(10))+'\",\"CId\":\"'+CAST(A.compet_id as varchar(10))+'\",\"CN\":\"'+CNAME+'\", "+
					" \"SId\":\"'+CAST(A.sport_id as varchar(10))+'\",\"Dt\":\"'+convert(char(10),match_date,120)+'\",\"SN\":\"'+SNAME+'\",\"RId\":\"'+CAST(A.region_id as varchar(10))+'\",\"RN\":\"'+RNAME+'\"},' AS match  "+
					" FROM bc_match A ,"+
					" (SELECT SPORT_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE SPORT_NAME END  AS SNAME "+
					" FROM bc_sport A LEFT OUTER JOIN BC_TRANS B ON A.SPORT_NAMEID = B.NAMEID) B,"+						
					" (SELECT REGION_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE REGION_NAME END AS RNAME "+
					" FROM  BC_REGION A LEFT OUTER JOIN BC_TRANS B ON A.REGION_NAMEID = B.NAMEID) C,"+						
					" (SELECT COMPET_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE COMPET_NAME END AS CNAME "+
					" FROM BC_COMPETITION A LEFT OUTER JOIN BC_TRANS B ON A.NAMEID = B.NAMEID) D "+						
					" WHERE A.sport_id = B.SPORT_ID  AND A.region_id = C.REGION_ID AND A.compet_id = D.COMPET_ID "+
					" AND a.match_id='"+mid+"'";
		  
		  ////Debug.out("[getPreMatches] :" + query);		
		  
		  try{	      	
			 	Context initContext = new InitialContext();
			 	Context envContext = (Context)initContext.lookup("java:/comp/env");
			 	DataSource ds = (DataSource)envContext.lookup("jdbc/ibet");
			 				 	
			 	con = ds.getConnection();			 	
			 	
			 	pstmt = con.prepareStatement(query);
		        rs = pstmt.executeQuery();
		        		        
		        while(rs.next()){		        	
		        	match += rs.getString("match");
		        }

		        rs.close();
		        pstmt.close();
		        con.close();
		        
		        if(match.length() > 2)
		        	match = match.substring(0, match.length()-1); //(json_mk.length()-1);				        	
	        	sb.append("["+match+"]");
	        	
	        	////Debug.out("[getPreMatches] : " + sb.toString());
			  		    
		  }catch(Exception e){
			  //Debug.out("[getPreMatches] : " + e.getMessage());
		
	      }finally{
	     	  if(cs!=null) cs.close();
	     	  if(rs!=null) rs.close();
	     	  if(pstmt!=null)  pstmt.close();
	     	  if(con!=null) con.close();
	    	}
		  
	  return sb;
		
	}
	
	public StringBuffer getTodayMatchInfo(String dt) throws SQLException{
		 
		  Connection con = null;
		  PreparedStatement pstmt = null;		  
		  ResultSet rs = null;		  
		  String match = "";
		  String result = "";
		  String sele = "";
		  String market = "";
		  //String stat = "";
		  
		  StringBuffer sb = new StringBuffer(""); 

		  String query = " SELECT '{\"Id\":\"'+CAST(A.match_id as varchar(10))+'\",\"CId\":\"'+CAST(A.compet_id as varchar(10))+'\",\"CN\":\"'+CNAME+'\","+
					"\"Dt\":\"'+convert(char(16),MATCH_DATE,120)+'\",\"SId\":\"'+CAST(A.sport_id as varchar(10))+'\",\"SN\":\"'+SNAME+'\",\"RId\":\"'+CAST(A.region_id as varchar(10))+'\",\"RN\":\"'+RNAME+'\","+
					"\"Sus\":'+CASE WHEN suspend ='T' THEN 'true' ELSE 'false' END+',"+
					"\"HT\":\"'+home_name+'\","+
					"\"AT\":\"'+away_name+'\"},' AS match  "+
					" FROM bc_match A ,"+
					" (SELECT SPORT_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE SPORT_NAME END  AS SNAME "+
					" FROM bc_sport A LEFT OUTER JOIN BC_TRANS B ON A.SPORT_NAMEID = B.NAMEID) B,"+						
					" (SELECT REGION_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE REGION_NAME END AS RNAME "+
					" FROM  BC_REGION A LEFT OUTER JOIN BC_TRANS B ON A.REGION_NAMEID = B.NAMEID) C,"+						
					" (SELECT COMPET_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE COMPET_NAME END AS CNAME "+
					" FROM BC_COMPETITION A LEFT OUTER JOIN BC_TRANS B ON A.NAMEID = B.NAMEID) D "+						
					" WHERE A.sport_id = B.SPORT_ID  AND A.region_id = C.REGION_ID AND A.compet_id = D.COMPET_ID "+
					//" AND a.compet_id='"+cid+"' 
					" AND a.match_stat='0' AND a.visible='T'  AND a.booked='T' "+
					//" and convert(char(8),match_date,112) >= convert(char(8),getdate(),112) "+
					//" and convert(char(8),match_date,112) <= convert(char(8),getdate()+6,112) "+
					" and convert(char(10),match_date,120) = '"+dt+"' "+
					" and home_name is not null and away_name is not null";		  
		  
		  /*
		  String query2 =" DECLARE @list varchar(MAX) "+
				  		" SELECT @list = JSON FROM BC_JSON WHERE KEYNAME='MARKET_TYPE' "+		  
				  		" SELECT '{\"Id\":'+CAST(A.MARKET_ID as varchar(10))+',\"M\":\"'+CAST(B.MATCH_ID as varchar(10))+'\","+
				  		" \"V\":'+CASE WHEN A.visible ='T' THEN 'true' ELSE 'false' END +',"+
				  		" \"S\":'+CASE WHEN A.suspend ='T' THEN 'true' ELSE 'false' END +'},' as market "+
		  				" FROM BC_MARKET A,  BC_MATCH B "+
		  				" WHERE A.MATCH_ID = B.MATCH_ID AND MARKET_TYPE_ID in "+
		  				" (SELECT splitdata FROM SplitString(@list,',')) "+ 
		  				//" AND B.compet_id='"+cid+"' AND B.match_stat='0' AND B.visible='T'  AND B.booked='T' "+ 
		  				" AND B.match_stat='0' AND B.visible='T'  AND B.booked='T' "+ 
		  				" AND A.visible='T' AND A.suspend = 'F' "+
		  				//" and convert(char(8),match_date,112) >= convert(char(8),getdate(),112) "+
						//" and convert(char(8),match_date,112) <= convert(char(8),getdate()+6,112) "+
						//" and convert(char(8),match_date,112) = convert(char(8),getdate(),112) "+
						" and convert(char(10),match_date,120) = '"+dt+"' "+
		  				"and home_name is not null and away_name is not null";
		  */
		  
		  String query3 = " SELECT  '{\"Id\":'+CAST(A.MARKET_ID as varchar(10))+',\"MId\":'+CAST(B.MATCH_ID as varchar(10))+', "+
				  		"	\"Sus\":'+CASE WHEN A.suspend ='T' THEN 'true' ELSE 'false' END+'},' "+
				  		//" \"IsVisible\":'+CASE WHEN A.visible ='T' THEN 'true' ELSE 'false' END+'},' as result "+ 
				  		" as result "+ 
				  		" FROM BC_MARKET A ,BC_match b "+
				  		//" WHERE  B.compet_id='"+cid+"' AND B.match_stat='0' AND B.visible='T'  AND B.booked='T'  "+
				  		" WHERE B.match_stat='0' AND B.visible='T'  AND B.booked='T'  "+
				  		" AND A.visible='T' "+
				  		//" and convert(char(8),match_date,112) >= convert(char(8),getdate(),112) "+
						//" and convert(char(8),match_date,112) <= convert(char(8),getdate()+6,112) "+
						//" and convert(char(8),match_date,112) = convert(char(8),getdate(),112) "+
						" and convert(char(10),match_date,120) = '"+dt+"' "+
				  		" and home_name is not null and away_name is not null"+
				  		" and a.MATCH_ID = b.MATCH_ID AND (MARKET_TYPE_ID ='377' or MARKET_TYPE_ID='399' or MARKET_TYPE_ID='2434' or MARKET_TYPE_ID='4475' "+
				  		" OR MARKET_TYPE_ID='5488' OR MARKET_TYPE_ID='5498'   OR MARKET_TYPE_ID='8774' OR MARKET_TYPE_ID='6544' "+
				  		" OR MARKET_TYPE_ID='6564' OR MARKET_TYPE_ID='8750' OR MARKET_TYPE_ID='8763' OR MARKET_TYPE_ID='9775' "+
				  		" OR MARKET_TYPE_ID='10829' or MARKET_TYPE_ID='9321')  ";
		 
		  String query4 = " SELECT  '{\"Id\":\"'+CAST(C.SEL_ID as varchar(10))+'\",\"MId\":'+CAST(B.MATCH_ID as varchar(10))+',\"MkId\":\"'+CAST(C.Market_Id as varchar(10))+'\", "+
				  		" \"Nm\":\"'+CAST(C.sel_name as varchar(10))+'\",\"P\":\"'+CAST(C.sel_price as varchar(10))+'\", "+
				  		"  \"Sus\":'+CASE WHEN A.suspend ='T' THEN 'true' ELSE 'false' END+'},' "+
				  		//" \"IsVisible\":'+CASE WHEN A.visible ='T' THEN 'true' ELSE 'false' END+'},' as selection "+ 
				  		" as selection "+ 
				  		" FROM BC_MARKET A ,BC_match b, bc_selection c "+
				  		//" WHERE  B.compet_id='"+cid+"' AND B.match_stat='0' AND B.visible='T'  AND B.booked='T' "+ 
				  		" WHERE B.match_stat='0' AND B.visible='T'  AND B.booked='T' "+ 
				  		" AND A.visible='T' and a.market_id = c.market_id "+
				  		//" and convert(char(8),match_date,112) >= convert(char(8),getdate(),112) "+
						//" and convert(char(8),match_date,112) <= convert(char(8),getdate()+6,112) "+
						//" and convert(char(8),match_date,112) = convert(char(8),getdate(),112) "+
						" and convert(char(10),match_date,120) = '"+dt+"' "+
				  		" and home_name is not null and away_name is not null"+
				  		" and a.MATCH_ID = b.MATCH_ID AND (MARKET_TYPE_ID ='377' or MARKET_TYPE_ID='399' or MARKET_TYPE_ID='2434' or MARKET_TYPE_ID='4475' "+
				  		" OR MARKET_TYPE_ID='5488' OR MARKET_TYPE_ID='5498'   OR MARKET_TYPE_ID='8774' OR MARKET_TYPE_ID='6544' "+
				  		" OR MARKET_TYPE_ID='6564' OR MARKET_TYPE_ID='8750' OR MARKET_TYPE_ID='8763' OR MARKET_TYPE_ID='9775' "+
				  		" OR MARKET_TYPE_ID='10829' or MARKET_TYPE_ID='9321') ";
		  
		  //Debug.out("[getTodayMatchInfo] query: " + query);		
		  ////Debug.out("[getTodayMatchInfo] query2: " + query2);	
		  //Debug.out("[getTodayMatchInfo] query3: " + query3);	
		  //Debug.out("[getTodayMatchInfo] query4: " + query4);
		  
		  try{	      	
			 	//Context initContext = new InitialContext();
			 	//Context envContext = (Context)initContext.lookup("java:/comp/env");
			 	//DataSource ds = (DataSource)envContext.lookup("jdbc/ibet");
			 				 	
			 	con = ds.getConnection();			 	
			 	
			 	pstmt = con.prepareStatement(query);	
		        rs = pstmt.executeQuery();
		        		        
		        while(rs.next()){
		        	match += rs.getString("match");
		        }
		        rs.close();
		        pstmt.close();
		        
		        if(match.length() > 2)
		        	match = match.substring(0, match.length()-1); //(json_mk.length()-1);
				        	
	        	sb.append("[{\"Mt\": ["+match+"]");
		        
	        	/*
		        //pstmt2.setString(1, rs.getString("MATCH_ID"));
		        pstmt = con.prepareStatement(query2);
		        rs = pstmt.executeQuery();
			        
	        	 while(rs.next()){
	        		 market += rs.getString("market");
	        	 }
	        	 
	        	 rs.close();
	        	 pstmt.close();

	        	if(market.length() > 2)
	        		market = market.substring(0, market.length()-1); //(json_mk.length()-1);
				        	
	        	sb.append(",\"Mk\": ["+market+"]");
	        	*/

	        	pstmt = con.prepareStatement(query3);
	        	rs = pstmt.executeQuery();
		        
	        	while(rs.next()){
	        		result += rs.getString("result");
		        }
		        
	        	rs.close();
	        	pstmt.close();
	        	
	        	if(result.length() > 2)
	        		result = result.substring(0, result.length()-1); //(json_mk.length()-1);

	        	sb.append(",\"Re\": ["+result+"]");
	        	
	        	pstmt = con.prepareStatement(query4);
	        	rs = pstmt.executeQuery();
		        
	        	while(rs.next()){
	        		sele += rs.getString("selection");
		        }
		        
	        	rs.close();
	        	pstmt.close();
	        	con.close();
	        	
	        	if(sele.length() > 2)
	        		sele = sele.substring(0, sele.length()-1); //(json_mk.length()-1);

	        	sb.append(",\"Se\": ["+sele+"]}]");	       	

	        	////Debug.out("getMatchInfobyCompetition : " + sb.toString());	
		        
		  }catch(Exception e){
			  //Debug.out("[getTodayMatchInfo] : " + e.getMessage());
		
	      }finally{
	    	  if(rs!=null) rs.close();
	     	  if(pstmt!=null)  pstmt.close();
	     	  if(con!=null) con.close();
	    	}
		  
	  return sb;
		
	}
	
	public StringBuffer getMatchInfobySport(String sid,String dt) throws SQLException{
		 
		  Connection con = null;
		  PreparedStatement pstmt = null;		  
		  ResultSet rs = null;		  
		  String match = "";
		  String result = "";
		  String sele = "";
		  String market = "";
		  //String stat = "";
		  
		  StringBuffer sb = new StringBuffer(""); 

		  String query = " SELECT '{\"Id\":\"'+CAST(A.match_id as varchar(10))+'\",\"CId\":\"'+CAST(A.compet_id as varchar(10))+'\",\"CN\":\"'+CNAME+'\","+
					"\"Dt\":\"'+convert(char(16),MATCH_DATE,120)+'\",\"SId\":\"'+CAST(A.sport_id as varchar(10))+'\",\"SN\":\"'+SNAME+'\",\"RId\":\"'+CAST(A.region_id as varchar(10))+'\",\"RN\":\"'+RNAME+'\","+
					//" \"LiveStatus\":\"'+CAST(A.live_stat as varchar(1))+'\",\"MatchStatus\":\"'+CAST(A.match_stat as varchar(1))+'\","+
					//" \"IsLiveAvailable\":\"'+CASE WHEN live_stat = 0 THEN 'true' ELSE 'false' END+'\","+
					//" \"IsVisible\":'+CASE WHEN visible ='T' THEN 'true' ELSE 'false' END+', "+
					"\"Sus\":'+CASE WHEN suspend ='T' THEN 'true' ELSE 'false' END+',"+
					//" \"IsLive\":\"'+CASE WHEN live ='T' THEN 'true' ELSE 'false' END+'\","+
					//" \"IsStarted\":\"'+CASE WHEN match_start ='T' THEN 'true' ELSE 'false' END+'\", "+
					"\"HT\":\"'+home_name+'\","+
					"\"AT\":\"'+away_name+'\"},' AS match  "+
					" FROM bc_match A ,"+
					" (SELECT SPORT_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE SPORT_NAME END  AS SNAME "+
					" FROM bc_sport A LEFT OUTER JOIN BC_TRANS B ON A.SPORT_NAMEID = B.NAMEID) B,"+						
					" (SELECT REGION_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE REGION_NAME END AS RNAME "+
					" FROM  BC_REGION A LEFT OUTER JOIN BC_TRANS B ON A.REGION_NAMEID = B.NAMEID) C,"+						
					" (SELECT COMPET_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE COMPET_NAME END AS CNAME "+
					" FROM BC_COMPETITION A LEFT OUTER JOIN BC_TRANS B ON A.NAMEID = B.NAMEID) D "+						
					" WHERE A.sport_id = B.SPORT_ID  AND A.region_id = C.REGION_ID AND A.compet_id = D.COMPET_ID "+
					//" AND live='T' and a.live_stat='1' AND a.visible='T'  AND a.booked='T' ";
					" AND a.sport_id='"+sid+"' AND a.match_stat='0' AND a.visible='T'  AND a.booked='T' "+
					//" and convert(char(8),match_date,112) >= convert(char(8),getdate(),112) "+
					" and convert(char(10),match_date,120) = '"+dt+"'"+
					" and home_name is not null and away_name is not null";		  
		  
		  /*
		  String query2 =" DECLARE @list varchar(MAX) "+
				  		" SELECT @list = JSON FROM BC_JSON WHERE KEYNAME='MARKET_TYPE' "+		  
				  		" SELECT '{\"Id\":'+CAST(A.MARKET_ID as varchar(10))+',\"M\":\"'+CAST(B.MATCH_ID as varchar(10))+'\","+
				  		" \"V\":'+CASE WHEN A.visible ='T' THEN 'true' ELSE 'false' END +',"+
				  		" \"S\":'+CASE WHEN A.suspend ='T' THEN 'true' ELSE 'false' END +'},' as market "+
		  				" FROM BC_MARKET A,  BC_MATCH B "+
		  				" WHERE A.MATCH_ID = B.MATCH_ID AND MARKET_TYPE_ID in "+
		  				" (SELECT splitdata FROM SplitString(@list,',')) "+ 
		  				" AND B.sport_id='"+sid+"' AND B.match_stat='0' AND B.visible='T'  AND B.booked='T' "+  
		  				" AND A.visible='T' AND A.suspend = 'F' "+
		  				//" and convert(char(8),match_date,112) >= convert(char(8),getdate(),112) "+
						//" and convert(char(8),match_date,112) <= convert(char(8),getdate()+6,112) "+
						" and convert(char(10),match_date,120) = '"+dt+"'"+
		  				"and home_name is not null and away_name is not null";
		  */
		  
		  String query3 = " SELECT  '{\"Id\":'+CAST(A.MARKET_ID as varchar(10))+',\"MId\":'+CAST(B.MATCH_ID as varchar(10))+', "+
				  		"	\"Sus\":'+CASE WHEN A.suspend ='T' THEN 'true' ELSE 'false' END+'},' "+
				  		//" \"IsVisible\":'+CASE WHEN A.visible ='T' THEN 'true' ELSE 'false' END+'},' as result "+ 
				  		" as result "+ 
				  		" FROM BC_MARKET A ,BC_match b "+
				  		" WHERE  B.sport_id='"+sid+"' AND B.match_stat='0' AND B.visible='T'  AND B.booked='T'  "+
				  		" AND A.visible='T' "+
				  		//" and convert(char(8),match_date,112) >= convert(char(8),getdate(),112) "+
						//" and convert(char(8),match_date,112) <= convert(char(8),getdate()+6,112) "+
						" and convert(char(10),match_date,120) = '"+dt+"'"+
				  		" and home_name is not null and away_name is not null"+
				  		" and a.MATCH_ID = b.MATCH_ID AND (MARKET_TYPE_ID ='377' or MARKET_TYPE_ID='399' or MARKET_TYPE_ID='2434' or MARKET_TYPE_ID='4475' "+
				  		" OR MARKET_TYPE_ID='5488' OR MARKET_TYPE_ID='5498'   OR MARKET_TYPE_ID='8774' OR MARKET_TYPE_ID='6544' "+
				  		" OR MARKET_TYPE_ID='6564' OR MARKET_TYPE_ID='8750' OR MARKET_TYPE_ID='8763' OR MARKET_TYPE_ID='9775' "+
				  		" OR MARKET_TYPE_ID='10829' or MARKET_TYPE_ID='9321')  ";
		 
		  String query4 = " SELECT  '{\"Id\":\"'+CAST(C.SEL_ID as varchar(10))+'\",\"MId\":'+CAST(B.MATCH_ID as varchar(10))+',\"MkId\":\"'+CAST(C.Market_Id as varchar(10))+'\", "+
				  		" \"Nm\":\"'+CAST(C.sel_name as varchar(10))+'\",\"P\":\"'+CAST(C.sel_price as varchar(10))+'\", "+
				  		"  \"Sus\":'+CASE WHEN A.suspend ='T' THEN 'true' ELSE 'false' END+'},' "+
				  		//" \"IsVisible\":'+CASE WHEN A.visible ='T' THEN 'true' ELSE 'false' END+'},' as selection "+ 
				  		" as selection "+ 
				  		" FROM BC_MARKET A ,BC_match b, bc_selection c "+
				  		" WHERE  B.sport_id='"+sid+"' AND B.match_stat='0' AND B.visible='T'  AND B.booked='T' "+ 
				  		" AND A.visible='T' and a.market_id = c.market_id "+
				  		//" and convert(char(8),match_date,112) >= convert(char(8),getdate(),112) "+
						//" and convert(char(8),match_date,112) <= convert(char(8),getdate()+6,112) "+
						" and convert(char(10),match_date,120) = '"+dt+"'"+
				  		" and home_name is not null and away_name is not null"+
				  		" and a.MATCH_ID = b.MATCH_ID AND (MARKET_TYPE_ID ='377' or MARKET_TYPE_ID='399' or MARKET_TYPE_ID='2434' or MARKET_TYPE_ID='4475' "+
				  		" OR MARKET_TYPE_ID='5488' OR MARKET_TYPE_ID='5498'   OR MARKET_TYPE_ID='8774' OR MARKET_TYPE_ID='6544' "+
				  		" OR MARKET_TYPE_ID='6564' OR MARKET_TYPE_ID='8750' OR MARKET_TYPE_ID='8763' OR MARKET_TYPE_ID='9775' "+
				  		" OR MARKET_TYPE_ID='10829' or MARKET_TYPE_ID='9321') ";
		  
		  //Debug.out("[getMatchInfobySport] query: " + query);		
		//  //Debug.out("[getMatchInfobySport] query2: " + query2);	
		  //Debug.out("[getMatchInfobySport] query3: " + query3);	
		  //Debug.out("[getMatchInfobySport] query4: " + query4);
		  
		  try{	      	
			 	//Context initContext = new InitialContext();
			 	//Context envContext = (Context)initContext.lookup("java:/comp/env");
			 	//DataSource ds = (DataSource)envContext.lookup("jdbc/ibet");
			 				 	
			 	con = ds.getConnection();			 	
			 	
			 	pstmt = con.prepareStatement(query);	
		        rs = pstmt.executeQuery();
		        		        
		        while(rs.next()){
		        	match += rs.getString("match");
		        }
		        rs.close();
		        pstmt.close();
		        
		        if(match.length() > 2)
		        	match = match.substring(0, match.length()-1); //(json_mk.length()-1);
				        	
	        	sb.append("[{\"Mt\": ["+match+"]");
		        
	        	/*
		        //pstmt2.setString(1, rs.getString("MATCH_ID"));
		        pstmt = con.prepareStatement(query2);
		        rs = pstmt.executeQuery();
			        
	        	 while(rs.next()){
	        		 market += rs.getString("market");
	        	 }
	        	 
	        	 rs.close();
	        	 pstmt.close();

	        	if(market.length() > 2)
	        		market = market.substring(0, market.length()-1); //(json_mk.length()-1);
				        	
	        	sb.append(",\"Mk\": ["+market+"]");
	        	*/

	        	pstmt = con.prepareStatement(query3);
	        	rs = pstmt.executeQuery();
		        
	        	while(rs.next()){
	        		result += rs.getString("result");
		        }
		        
	        	rs.close();
	        	pstmt.close();
	        	
	        	if(result.length() > 2)
	        		result = result.substring(0, result.length()-1); //(json_mk.length()-1);

	        	sb.append(",\"Re\": ["+result+"]");
	        	
	        	pstmt = con.prepareStatement(query4);
	        	rs = pstmt.executeQuery();
		        
	        	while(rs.next()){
	        		sele += rs.getString("selection");
		        }
		        
	        	rs.close();
	        	pstmt.close();
	        	con.close();
	        	
	        	if(sele.length() > 2)
	        		sele = sele.substring(0, sele.length()-1); //(json_mk.length()-1);

	        	sb.append(",\"Se\": ["+sele+"]}]");	       	

	        	////Debug.out("getMatchInfobyCompetition : " + sb.toString());	
		        
		  }catch(Exception e){
			  //Debug.out("[getMatchInfobySport] : " + e.getMessage());
		
	      }finally{
	    	  if(rs!=null) rs.close();
	     	  if(pstmt!=null)  pstmt.close();
	     	  if(con!=null) con.close();
	    	}
		  
	  return sb;
		
	}
	
	public StringBuffer getMatchInfobyCompetition(String cid) throws SQLException{
				 
		  Connection con = null;
		  PreparedStatement pstmt = null;		  
		  ResultSet rs = null;		  
		  String match = "";
		  String result = "";
		  String sele = "";
		  String market = "";
		  //String stat = "";
		  
		  StringBuffer sb = new StringBuffer(""); 

		  String query = " SELECT '{\"Id\":\"'+CAST(A.match_id as varchar(10))+'\",\"CId\":\"'+CAST(A.compet_id as varchar(10))+'\",\"CN\":\"'+CNAME+'\","+
					"\"Dt\":\"'+convert(char(16),MATCH_DATE,120)+'\",\"SId\":\"'+CAST(A.sport_id as varchar(10))+'\",\"SN\":\"'+SNAME+'\",\"RId\":\"'+CAST(A.region_id as varchar(10))+'\",\"RN\":\"'+RNAME+'\","+
					//" \"LiveStatus\":\"'+CAST(A.live_stat as varchar(1))+'\",\"MatchStatus\":\"'+CAST(A.match_stat as varchar(1))+'\","+
					//" \"IsLiveAvailable\":\"'+CASE WHEN live_stat = 0 THEN 'true' ELSE 'false' END+'\","+
					//" \"IsVisible\":'+CASE WHEN visible ='T' THEN 'true' ELSE 'false' END+', "+
					"\"Sus\":'+CASE WHEN suspend ='T' THEN 'true' ELSE 'false' END+',"+
					//" \"IsLive\":\"'+CASE WHEN live ='T' THEN 'true' ELSE 'false' END+'\","+
					//" \"IsStarted\":\"'+CASE WHEN match_start ='T' THEN 'true' ELSE 'false' END+'\", "+
					"\"HT\":\"'+home_name+'\","+
					"\"AT\":\"'+away_name+'\"},' AS match  "+
					" FROM bc_match A ,"+
					" (SELECT SPORT_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE SPORT_NAME END  AS SNAME "+
					" FROM bc_sport A LEFT OUTER JOIN BC_TRANS B ON A.SPORT_NAMEID = B.NAMEID) B,"+						
					" (SELECT REGION_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE REGION_NAME END AS RNAME "+
					" FROM  BC_REGION A LEFT OUTER JOIN BC_TRANS B ON A.REGION_NAMEID = B.NAMEID) C,"+						
					" (SELECT COMPET_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE COMPET_NAME END AS CNAME "+
					" FROM BC_COMPETITION A LEFT OUTER JOIN BC_TRANS B ON A.NAMEID = B.NAMEID) D "+						
					" WHERE A.sport_id = B.SPORT_ID  AND A.region_id = C.REGION_ID AND A.compet_id = D.COMPET_ID "+
					//" AND live='T' and a.live_stat='1' AND a.visible='T'  AND a.booked='T' ";
					" AND a.compet_id='"+cid+"' AND a.match_stat='0' AND a.visible='T'  AND a.booked='T' "+
					" and convert(char(8),match_date,112) >= convert(char(8),getdate(),112) "+
					" and convert(char(8),match_date,112) <= convert(char(8),getdate()+6,112) "+
					" and home_name is not null and away_name is not null";		  
		  
		  /*
		  String query2 =" DECLARE @list varchar(MAX) "+
				  		" SELECT @list = JSON FROM BC_JSON WHERE KEYNAME='MARKET_TYPE' "+		  
				  		" SELECT '{\"Id\":'+CAST(A.MARKET_ID as varchar(10))+',\"M\":\"'+CAST(B.MATCH_ID as varchar(10))+'\","+
				  		" \"V\":'+CASE WHEN A.visible ='T' THEN 'true' ELSE 'false' END +',"+
				  		" \"S\":'+CASE WHEN A.suspend ='T' THEN 'true' ELSE 'false' END +'},' as market "+
		  				" FROM BC_MARKET A,  BC_MATCH B "+
		  				" WHERE A.MATCH_ID = B.MATCH_ID AND MARKET_TYPE_ID in "+
		  				" (SELECT splitdata FROM SplitString(@list,',')) "+ 
		  				" AND B.compet_id='"+cid+"' AND B.match_stat='0' AND B.visible='T'  AND B.booked='T' "+  
		  				" AND A.visible='T' AND A.suspend = 'F' "+
		  				" and convert(char(8),match_date,112) >= convert(char(8),getdate(),112) "+
						" and convert(char(8),match_date,112) <= convert(char(8),getdate()+6,112) "+
		  				"and home_name is not null and away_name is not null";
		  */
		  
		  String query3 = " SELECT  '{\"Id\":'+CAST(A.MARKET_ID as varchar(10))+',\"MId\":'+CAST(B.MATCH_ID as varchar(10))+', "+
				  		"	\"Sus\":'+CASE WHEN A.suspend ='T' THEN 'true' ELSE 'false' END+'},' "+
				  		//" \"IsVisible\":'+CASE WHEN A.visible ='T' THEN 'true' ELSE 'false' END+'},' as result "+ 
				  		" as result "+ 
				  		" FROM BC_MARKET A ,BC_match b "+
				  		" WHERE  B.compet_id='"+cid+"' AND B.match_stat='0' AND B.visible='T'  AND B.booked='T'  "+
				  		" AND A.visible='T' "+
				  		" and convert(char(8),match_date,112) >= convert(char(8),getdate(),112) "+
						" and convert(char(8),match_date,112) <= convert(char(8),getdate()+6,112) "+
				  		" and home_name is not null and away_name is not null"+
				  		" and a.MATCH_ID = b.MATCH_ID AND (MARKET_TYPE_ID ='377' or MARKET_TYPE_ID='399' or MARKET_TYPE_ID='2434' or MARKET_TYPE_ID='4475' "+
				  		" OR MARKET_TYPE_ID='5488' OR MARKET_TYPE_ID='5498'   OR MARKET_TYPE_ID='8774' OR MARKET_TYPE_ID='6544' "+
				  		" OR MARKET_TYPE_ID='6564' OR MARKET_TYPE_ID='8750' OR MARKET_TYPE_ID='8763' OR MARKET_TYPE_ID='9775' "+
				  		" OR MARKET_TYPE_ID='10829' or MARKET_TYPE_ID='9321')  ";
		 
		  String query4 = " SELECT  '{\"Id\":\"'+CAST(C.SEL_ID as varchar(10))+'\",\"MId\":'+CAST(B.MATCH_ID as varchar(10))+',\"MkId\":\"'+CAST(C.Market_Id as varchar(10))+'\", "+
				  		" \"Nm\":\"'+CAST(C.sel_name as varchar(10))+'\",\"P\":\"'+CAST(C.sel_price as varchar(10))+'\", "+
				  		"  \"Sus\":'+CASE WHEN A.suspend ='T' THEN 'true' ELSE 'false' END+'},' "+
				  		//" \"IsVisible\":'+CASE WHEN A.visible ='T' THEN 'true' ELSE 'false' END+'},' as selection "+ 
				  		" as selection "+ 
				  		" FROM BC_MARKET A ,BC_match b, bc_selection c "+
				  		" WHERE  B.compet_id='"+cid+"' AND B.match_stat='0' AND B.visible='T'  AND B.booked='T' "+ 
				  		" AND A.visible='T' and a.market_id = c.market_id "+
				  		" and convert(char(8),match_date,112) >= convert(char(8),getdate(),112) "+
						" and convert(char(8),match_date,112) <= convert(char(8),getdate()+6,112) "+
				  		" and home_name is not null and away_name is not null"+
				  		" and a.MATCH_ID = b.MATCH_ID AND (MARKET_TYPE_ID ='377' or MARKET_TYPE_ID='399' or MARKET_TYPE_ID='2434' or MARKET_TYPE_ID='4475' "+
				  		" OR MARKET_TYPE_ID='5488' OR MARKET_TYPE_ID='5498'   OR MARKET_TYPE_ID='8774' OR MARKET_TYPE_ID='6544' "+
				  		" OR MARKET_TYPE_ID='6564' OR MARKET_TYPE_ID='8750' OR MARKET_TYPE_ID='8763' OR MARKET_TYPE_ID='9775' "+
				  		" OR MARKET_TYPE_ID='10829' or MARKET_TYPE_ID='9321') ";
		  
		 // //Debug.out("[getMatchInfobyCompetition] query: " + query);		
		 // //Debug.out("[getMatchInfobyCompetition] query2: " + query2);	
		 // //Debug.out("[getMatchInfobyCompetition] query3: " + query3);	
		 // //Debug.out("[getMatchInfobyCompetition] query4: " + query4);
		  
		  try{	      	
			 	//Context initContext = new InitialContext();
			 	//Context envContext = (Context)initContext.lookup("java:/comp/env");
			 	//DataSource ds = (DataSource)envContext.lookup("jdbc/ibet");
			 				 	
			 	con = ds.getConnection();			 	
			 	
			 	pstmt = con.prepareStatement(query);	
		        rs = pstmt.executeQuery();
		        		        
		        while(rs.next()){
		        	match += rs.getString("match");
		        }
		        rs.close();
		        pstmt.close();
		        
		        if(match.length() > 2)
		        	match = match.substring(0, match.length()-1); //(json_mk.length()-1);
				        	
	        	sb.append("[{\"Mt\": ["+match+"]");
		        
	        	/*
		        //pstmt2.setString(1, rs.getString("MATCH_ID"));
		        pstmt = con.prepareStatement(query2);
		        rs = pstmt.executeQuery();
			        
	        	 while(rs.next()){
	        		 market += rs.getString("market");
	        	 }
	        	 
	        	 rs.close();
	        	 pstmt.close();

	        	if(market.length() > 2)
	        		market = market.substring(0, market.length()-1); //(json_mk.length()-1);
				        	
	        	sb.append(",\"Mk\": ["+market+"]");
	        	*/

	        	pstmt = con.prepareStatement(query3);
	        	rs = pstmt.executeQuery();
		        
	        	while(rs.next()){
	        		result += rs.getString("result");
		        }
		        
	        	rs.close();
	        	pstmt.close();
	        	
	        	if(result.length() > 2)
	        		result = result.substring(0, result.length()-1); //(json_mk.length()-1);

	        	sb.append(",\"Re\": ["+result+"]");
	        	
	        	pstmt = con.prepareStatement(query4);
	        	rs = pstmt.executeQuery();
		        
	        	while(rs.next()){
	        		sele += rs.getString("selection");
		        }
		        
	        	rs.close();
	        	pstmt.close();
	        	con.close();
	        	
	        	if(sele.length() > 2)
	        		sele = sele.substring(0, sele.length()-1); //(json_mk.length()-1);

	        	sb.append(",\"Se\": ["+sele+"]}]");	       	

	        	////Debug.out("getMatchInfobyCompetition : " + sb.toString());	
		        
		  }catch(Exception e){
			  //Debug.out("[getMatchInfobyCompetition] : " + e.getMessage());
		
	      }finally{
	    	  if(rs!=null) rs.close();
	     	  if(pstmt!=null)  pstmt.close();
	     	  if(con!=null) con.close();
	    	}
		  
	  return sb;
		
	}
	
	
	public StringBuffer getMatchInfobyMatchId(String mid) throws SQLException{
		 
		  Connection con = null;
		  PreparedStatement pstmt = null;		  
		  ResultSet rs = null;		  
		  String match = "";
		  String result = "";
		  String sele = "";
		  String market = "";
		  //String stat = "";
		  
		  StringBuffer sb = new StringBuffer(""); 

		  String query = " SELECT '{\"Id\":\"'+CAST(A.match_id as varchar(10))+'\",\"CId\":\"'+CAST(A.compet_id as varchar(10))+'\",\"CN\":\"'+CNAME+'\","+
					"\"Dt\":\"'+convert(char(16),MATCH_DATE,120)+'\",\"SId\":\"'+CAST(A.sport_id as varchar(10))+'\",\"SN\":\"'+SNAME+'\",\"RId\":\"'+CAST(A.region_id as varchar(10))+'\",\"RN\":\"'+RNAME+'\","+
					//" \"LiveStatus\":\"'+CAST(A.live_stat as varchar(1))+'\",\"MatchStatus\":\"'+CAST(A.match_stat as varchar(1))+'\","+
					//" \"IsLiveAvailable\":\"'+CASE WHEN live_stat = 0 THEN 'true' ELSE 'false' END+'\","+
					//" \"IsVisible\":'+CASE WHEN visible ='T' THEN 'true' ELSE 'false' END+', "+
					"\"Sus\":'+CASE WHEN suspend ='T' THEN 'true' ELSE 'false' END+',"+
					//" \"IsLive\":\"'+CASE WHEN live ='T' THEN 'true' ELSE 'false' END+'\","+
					//" \"IsStarted\":\"'+CASE WHEN match_start ='T' THEN 'true' ELSE 'false' END+'\", "+
					"\"HT\":\"'+home_name+'\","+
					"\"AT\":\"'+away_name+'\"}' AS match  "+
					" FROM bc_match A ,"+
					" (SELECT SPORT_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE SPORT_NAME END  AS SNAME "+
					" FROM bc_sport A LEFT OUTER JOIN BC_TRANS B ON A.SPORT_NAMEID = B.NAMEID) B,"+						
					" (SELECT REGION_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE REGION_NAME END AS RNAME "+
					" FROM  BC_REGION A LEFT OUTER JOIN BC_TRANS B ON A.REGION_NAMEID = B.NAMEID) C,"+						
					" (SELECT COMPET_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE COMPET_NAME END AS CNAME "+
					" FROM BC_COMPETITION A LEFT OUTER JOIN BC_TRANS B ON A.NAMEID = B.NAMEID) D "+						
					" WHERE A.sport_id = B.SPORT_ID  AND A.region_id = C.REGION_ID AND A.compet_id = D.COMPET_ID "+
					//" AND live='T' and a.live_stat='1' AND a.visible='T'  AND a.booked='T' ";
					" AND a.match_id='"+mid+"'";		  
		  		
		  
		  ////Debug.out("[getMatchInfobyMatchId] query: " + query);		

		  
		  try{	      	
 	
			 	con = ds.getConnection();			 	
			 	
			 	pstmt = con.prepareStatement(query);	
		        rs = pstmt.executeQuery();
		        		        
		        if(rs.next()){
		        	sb.append("[{\"Mt\":"+rs.getString("match")+"}]");
		        }
		        rs.close();
		        pstmt.close();		        
	        	con.close();
	        
	        	////Debug.out("getMatchInfobyMatchId : " + sb.toString());	
		        
		  }catch(Exception e){
			  //Debug.out("[getMatchInfobyMatchId] : " + e.getMessage());
		
	      }finally{
	    	  if(rs!=null) rs.close();
	     	  if(pstmt!=null)  pstmt.close();
	     	  if(con!=null) con.close();
	    	}
		  
	  return sb;
		
	}
	
	public StringBuffer getMarketbyMatchId(String mid) throws SQLException{
					 
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  StringBuffer sb = new StringBuffer("["); 
		  StringBuffer sb2 = new StringBuffer("");

		  String query1 = "DECLARE @list varchar(MAX)  "+
				  	" SELECT @list = JSON FROM BC_JSON WHERE KEYNAME='MARKET_TYPE'  "+
				  	"SELECT '{\"Id\":\"'+Cast(a.Market_Id As Varchar(10))+'\",\"Sq\":'+CAST(SEQUENCE as varchar(10))+',\"MId\":'+CAST(a.match_id as varchar(10))+',\"MTyId\":\"'+CAST(MARKET_TYPE_ID as varchar(10)) +'\","+
				  	" \"Vis\":'+CASE WHEN a.visible ='T' THEN 'true' ELSE 'false' END+',"+
				  	" \"Sus\":'+CASE WHEN a.Suspend ='T' THEN 'true' ELSE 'false' END+',"+
				  	" \"Nm\":\"'+replace(replace(replace(replace(replace(market_name,'{sw}',SEQUENCE),'{pw}',POINT_SEQ),'{s}',SEQUENCE),'W1',home_name),'W2',away_name)+'\"},' "+
		  			" as market FROM bc_Market a, bc_match b "+
		  			" where a.MATCH_ID = '"+mid+"' and MARKET_TYPE_ID in (SELECT splitdata FROM SplitString(@list,',')) and a.match_id = b.match_id and  a.VISIBLE='T' And a.Suspend = 'F' ";
		  /*
		  String query2 =  " DECLARE @list varchar(MAX) "+
				  		" SELECT @list = JSON FROM BC_JSON WHERE KEYNAME='MARKET_TYPE' "+
				  		" SELECT  '{\"Id\":'+CAST(sel_id AS VARCHAR(10))+',\"MkId\":'+CAST(A.Market_Id AS VARCHAR(10))+',\"BP\":\"'+CAST(SEL_PRICE as varchar(10))+'\",\"P\":\"'+CAST(SEL_PRICE as varchar(10))+'\","+
				  		" \"Nm\":\"'+ replace(replace(sel_name,'{h}',B.HANDICAP),'{-h}',B.HANDICAP*-1)+'\",\"Or\":'+CAST(SEL_ORDER AS VARCHAR(10)) +'},' "+
				  		" as sel from bc_selection a, (SELECT MARKET_ID,HANDICAP FROM bc_market WHERE MARKET_TYPE_ID in (SELECT splitdata FROM SplitString(@list,',')) "+
				  		" and MATCH_ID = '"+mid+"'  AND suspend = 'F' AND visible='T'  ) B "+
				  		" where a.MARKET_ID = B.MARKET_ID ";
		 */
		  String query2 =  " DECLARE @list varchar(MAX) "+
			  		" SELECT @list = JSON FROM BC_JSON WHERE KEYNAME='MARKET_TYPE' "+
			  		" SELECT  '{\"Id\":'+CAST(sel_id AS VARCHAR(10))+',\"MkId\":'+CAST(A.Market_Id AS VARCHAR(10))+',\"BP\":\"'+CAST(SEL_PRICE as varchar(10))+'\",\"P\":\"'+CAST(SEL_PRICE as varchar(10))+'\","+
			  		" \"Nm\":\"'+ replace(replace(replace(replace(replace(replace(sel_name,'{h}',B.HANDICAP),'{-h}',B.HANDICAP*-1),'{hv}',isnull(home_value,'')),'{av}',isnull(away_value,'')),'W1',home_name),'W2',away_name)+'\",\"Or\":'+CAST(SEL_ORDER AS VARCHAR(10)) +'},' "+
			  		" as sel from bc_selection a, (SELECT MATCH_ID,MARKET_ID,HANDICAP FROM bc_market WHERE MARKET_TYPE_ID in (SELECT splitdata FROM SplitString(@list,',')) "+
			  		" and MATCH_ID = '"+mid+"'  AND suspend = 'F' AND visible='T'  ) B, "+
			  		" (SELECT MATCH_ID,home_name,away_name from bc_match  where MATCH_ID = '"+mid+"') C " +
			  		" where a.MARKET_ID = B.MARKET_ID and B.MATCH_ID = C.MATCH_ID "+
			  		"and SEL_PRICE !='0.00' and SEL_PRICE !='101.00'";
		  

		  
		  //Debug.out("[getMarketbyMatchId] : " + query1);
		  //Debug.out("[getMarketbyMatchId] : " + query2);
		  		  		  
		  try{	      	
			 	//Context initContext = new InitialContext();
			 	//Context envContext = (Context)initContext.lookup("java:/comp/env");
			 	//DataSource ds = (DataSource)envContext.lookup("jdbc/ibet");
			 				 	
			 	con = ds.getConnection();			 
			 	pstmt = con.prepareStatement(query1);	        
		        rs = pstmt.executeQuery();
		        		        
		        while(rs.next()){
		        	sb.append(rs.getString("market"));	 
		        }				  	
  
		        rs.close();
		        pstmt.close();
		        
		        pstmt = con.prepareStatement(query2);	
		        //pstmt.setString(1, mid);
		        rs = pstmt.executeQuery();
		        		        
		        while(rs.next()){
		        	sb2.append(rs.getString("sel"));	 
		        }				  	
  
		        rs.close();
		        pstmt.close();
		        con.close();
		        
		        if(sb2.length() > 2)		        	
		        	sb2.deleteCharAt(sb2.length()-1);	
		        
		        sb.append("{\"Se\": ["+sb2.toString()+"]}]");		        
		        sb2 = null;
		        
		  }catch(Exception e){
			  //Debug.out("[getMarketbyMatchId] : " + e.getMessage());
		
	      }finally{
	     	  if(rs!=null) rs.close();
	     	  if(pstmt!=null)  pstmt.close();
	     	  if(con!=null) con.close();
	    	}
		  
	  return sb;
		
	}
		
	
	public StringBuffer getValidMarketType() throws SQLException{

		Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  StringBuffer sb = new StringBuffer(""); 

		  //String query1 = "SELECT '\"'+ replace(JSON, ',' ,'\",\"') +'\"' as JSON  FROM BC_JSON WHERE KEYNAME='MARKET_TYPE'";
		  String query1 = "SELECT JSON  as JSON  FROM BC_JSON WHERE KEYNAME='MARKET_TYPE'";
		  
		  //Debug.out("[getValidMarketType] : " + query1);
		  
		  try{	      	
			 	//Context initContext = new InitialContext();
			 	//Context envContext = (Context)initContext.lookup("java:/comp/env");
			 	//DataSource ds = (DataSource)envContext.lookup("jdbc/ibet");
			 				 	
			 	con = ds.getConnection();			 
			 	pstmt = con.prepareStatement(query1);	        
		        rs = pstmt.executeQuery();
		        		        
		        if(rs.next()){        	
		        	sb.append(rs.getString("JSON"));	 
		        }				  	
 
		        rs.close();
		        pstmt.close();		        
		        con.close();
		        
		        ////Debug.out("[getValidMarketType] : " + sb.toString());
		        
		  }catch(Exception e){
			  //Debug.out("[getValidMarketTtype] : " + e.getMessage());
		
	      }finally{
	     	  if(rs!=null) rs.close();
	     	  if(pstmt!=null)  pstmt.close();
	     	  if(con!=null) con.close();
	    	}
		  
	  return sb;
		
	}	


	public StringBuffer getFavMatch(String sid,String uid) throws SQLException{
				 
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  String fav = "";
		  StringBuffer sb = new StringBuffer(""); 
		
		  String query = " SELECT '{\"Id\":\"'+CAST(A.match_id as varchar(10))+'\",\"CN\":\"'+CNAME+'\", "+
					" \"SId\":\"'+CAST(A.sport_id as varchar(10))+'\",\"SN\":\"'+SNAME+'\",\"RId\":\"'+CAST(A.region_id as varchar(10))+'\",\"RN\":\"'+RNAME+'\", "+				
					"  \"Dt\":\"' +cast(convert(char(16),match_date,120) AS VARCHAR(16)) +'\",\"HT\":\"'+home_name+'\",  "+
					" \"AT\":\"'+away_name+'\"},' AS fav  "+
					" FROM bc_match A ,"+
					" (SELECT SPORT_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE SPORT_NAME END  AS SNAME "+
					" FROM bc_sport A LEFT OUTER JOIN BC_TRANS B ON A.SPORT_NAMEID = B.NAMEID) B,"+						
					" (SELECT REGION_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE REGION_NAME END AS RNAME "+
					" FROM  BC_REGION A LEFT OUTER JOIN BC_TRANS B ON A.REGION_NAMEID = B.NAMEID) C,"+						
					" (SELECT COMPET_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE COMPET_NAME END AS CNAME "+
					" FROM BC_COMPETITION A LEFT OUTER JOIN BC_TRANS B ON A.NAMEID = B.NAMEID) D, "+		
					" MATCH_FAVOR G "+
					" WHERE A.sport_id = B.SPORT_ID  AND A.region_id = C.REGION_ID AND A.compet_id = D.COMPET_ID "+
					" AND A.MATCH_ID = G.MATCH_ID AND G.USE_FLAG='T'AND (A.match_stat = '0' OR A.match_stat = '1') AND G.USER_ID ='"+uid+"'";

		  	////Debug.out("[getFavMatch] query :" + query);
		  	
		  	try{	
		  		
			 	//Context initContext = new InitialContext();
			 	//Context envContext = (Context)initContext.lookup("java:/comp/env");
			 	//DataSource ds = (DataSource)envContext.lookup("jdbc/ibet");
			 				 	
			 	con = ds.getConnection();			 
			
			 	pstmt = con.prepareStatement(query);
			 	rs = pstmt.executeQuery();
		        
		        while(rs.next()){
		        	fav += rs.getString("fav");
		        }
		        
		        rs.close();
		        pstmt.close();
		        con.close();
		        
		        if(fav.length() > 2)
		        	fav = fav.substring(0, fav.length()-1); //(json_mk.length()-1);
				        	
	        	sb.append("["+fav+"]");
	        	
	        	////Debug.out("[getFavMatch] sb :" + sb.toString());
	        	
		        con.close();
		        ////Debug.out("[getValidMarketType] : " + sb.toString());
		        
		  }catch(Exception e){
			  //Debug.out("[getFavMatch] : " + e.getMessage());
		
	      }finally{
	
	     	  if(pstmt!=null)  pstmt.close();
	     	  if(con!=null) con.close();
	    	}
		  
	  return sb;
		
	}

	//use
	public StringBuffer setFavMatch(String sid,String uid,String mid,String f) throws SQLException{
				 
		Connection con = null;
		  //String json_matches = ""; 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int r_up = -1;
		int r_ins = -1;
		String flag = "";
		String fav = "";
		
		StringBuffer sb = new StringBuffer(""); 
		  
		if(f.equals("1"))
			flag="T";
		else
			flag="F";
	  
	  	String query1 = "UPDATE MATCH_FAVOR SET USE_FLAG = ?,REG_DATE=GETDATE() WHERE SITE_ID = ? AND USER_ID=? AND MATCH_ID=?";
	  	
	  	String query2 = "INSERT INTO MATCH_FAVOR(SITE_ID,USER_ID,MATCH_ID,USE_FLAG,REG_DATE) VALUES(?,?,?,?,GETDATE())";
	  	
		String query3 = " SELECT '{\"Id\":\"'+CAST(A.match_id as varchar(10))+'\",\"CN\":\"'+CNAME+'\", "+
					" \"SId\":\"'+CAST(A.sport_id as varchar(10))+'\",\"SN\":\"'+SNAME+'\",\"RId\":\"'+CAST(A.region_id as varchar(10))+'\",\"RN\":\"'+RNAME+'\", "+				
					"  \"Dt\":\"' + cast(convert(char(16),match_date,120) AS VARCHAR(16)) +'\",\"HT\":\"'+home_name+'\",  "+
					" \"AT\":\"'+away_name+'\"},' AS fav  "+
					" FROM bc_match A ,"+
					" (SELECT SPORT_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE SPORT_NAME END  AS SNAME "+
					" FROM bc_sport A LEFT OUTER JOIN BC_TRANS B ON A.SPORT_NAMEID = B.NAMEID) B,"+						
					" (SELECT REGION_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE REGION_NAME END AS RNAME "+
					" FROM  BC_REGION A LEFT OUTER JOIN BC_TRANS B ON A.REGION_NAMEID = B.NAMEID) C,"+						
					" (SELECT COMPET_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE COMPET_NAME END AS CNAME "+
					" FROM BC_COMPETITION A LEFT OUTER JOIN BC_TRANS B ON A.NAMEID = B.NAMEID) D, "+		
					" MATCH_FAVOR G "+
					" WHERE A.sport_id = B.SPORT_ID  AND A.region_id = C.REGION_ID AND A.compet_id = D.COMPET_ID "+
					" AND A.MATCH_ID = G.MATCH_ID AND G.USE_FLAG='T'AND (A.match_stat = '0' OR A.match_stat = '1') AND G.USER_ID ='"+uid+"'";

	  	////Debug.out("[setFavMatch] query3 :" + query3);
	  	
	  	try{	
	  		
		 	//Context initContext = new InitialContext();
		 	//Context envContext = (Context)initContext.lookup("java:/comp/env");
		 	//DataSource ds = (DataSource)envContext.lookup("jdbc/ibet");
		 				 	
		 	con = ds.getConnection();			 
		 	pstmt = con.prepareStatement(query1);	
		 	
		 	pstmt.setString(1,flag);
		 	pstmt.setString(2,sid);
		 	pstmt.setString(3,uid);
		 	pstmt.setString(4,mid);			 	
		 	r_up = pstmt.executeUpdate();		
		 	pstmt.close(); 
		 	
		 	////Debug.out("[setFavMatch] r_up : "+r_up);
		 	
		 	if(r_up < 1){
		 	
		 		pstmt = con.prepareStatement(query2);	
			 	
			 	pstmt.setString(1,sid);
			 	pstmt.setString(2,uid);
			 	pstmt.setString(3,mid);
			 	pstmt.setString(4,flag);
			 	
			 	r_ins = pstmt.executeUpdate();	
			 	////Debug.out("[setFavMatch] r_ins : "+r_ins);
			 	pstmt.close(); 
			 	
		 	}
		 	
		 	pstmt = con.prepareStatement(query3);
		 	rs = pstmt.executeQuery();
	        
	        while(rs.next()){
	        	fav += rs.getString("fav");
	        }
	        
	        rs.close();
	        pstmt.close();
	        con.close();
	        
	        if(fav.length() > 2)
	        	fav = fav.substring(0, fav.length()-1); //(json_mk.length()-1);
			        	
        	sb.append("["+fav+"]");
        	
        	////Debug.out("[setFavMatch] sb :" + sb.toString());
        	
	        con.close();
	        ////Debug.out("[getValidMarketType] : " + sb.toString());
	        
	  }catch(Exception e){
		  //Debug.out("[setFavMatch] : " + e.getMessage());
	
      }finally{

     	  if(pstmt!=null)  pstmt.close();
     	  if(con!=null) con.close();
    	}
	  
  return sb;
		
	}
		
	//use
	public StringBuffer getMarketbyMarketId(String mkid) throws SQLException{
		
		Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  StringBuffer sb = new StringBuffer(""); 
		  //StringBuffer sb2 = new StringBuffer("");
		  
		  String sele = "";

		  String query1 = "DECLARE @list varchar(MAX)  "+
				  	" SELECT @list = JSON FROM BC_JSON WHERE KEYNAME='MARKET_TYPE'  "+
				  	"SELECT '{\"Id\":\"'+Cast(a.Market_Id As Varchar(10))+'\",\"Sq\":'+CAST(SEQUENCE as varchar(10))+',\"MId\":'+CAST(a.match_id as varchar(10))+',\"MTyId\":\"'+CAST(MARKET_TYPE_ID as varchar(10)) +'\","+
				  	" \"Vis\":'+CASE WHEN a.visible ='T' THEN 'true' ELSE 'false' END+',"+
				  	" \"Sus\":'+CASE WHEN a.Suspend ='T' THEN 'true' ELSE 'false' END+',"+
				  	" \"Nm\":\"'+replace(replace(replace(replace(replace(market_name,'{sw}',SEQUENCE),'{pw}',POINT_SEQ),'{s}',SEQUENCE),'W1',home_name),'W2',away_name) +'\"' "+
		  			" as market FROM bc_Market a, bc_match b "+
		  			" where a.Market_Id = '"+mkid+"' and MARKET_TYPE_ID in (SELECT splitdata FROM SplitString(@list,',')) and a.match_id = b.match_id "; //and  VISIBLE='T' And Suspend = 'F' ";
		  
		  String query2 =  " DECLARE @list varchar(MAX) "+
				  		" SELECT @list = JSON FROM BC_JSON WHERE KEYNAME='MARKET_TYPE' "+
				  		" SELECT  '{\"Id\":'+CAST(sel_id AS VARCHAR(10))+',\"MkId\":'+CAST(A.Market_Id AS VARCHAR(10))+',\"BP\":\"'+CAST(SEL_PRICE as varchar(10))+'\",\"P\":\"'+CAST(SEL_PRICE as varchar(10))+'\","+
				  		" \"Nm\":\"'+ replace(replace(replace(replace(replace(replace(sel_name,'{h}',B.HANDICAP),'{-h}',B.HANDICAP*-1),'{hv}',isnull(home_value,'')),'{av}',isnull(away_value,'')),'W1',home_name),'W2',away_name)+'\",\"Or\":'+CAST(SEL_ORDER AS VARCHAR(10)) +'},' "+
				  		" as sel from bc_selection a, "+
				  	//	" (SELECT MATCH_ID,MARKET_ID,HANDICAP FROM bc_market WHERE MARKET_TYPE_ID in (SELECT splitdata FROM SplitString(@list,',')) and Market_Id = '"+mkid+"' ) B, "+
				  		" (SELECT bb.home_name,bb.away_name, aa.MATCH_ID,aa.MARKET_ID,HANDICAP FROM bc_market aa, bc_match bb WHERE MARKET_TYPE_ID in (SELECT splitdata FROM SplitString(@list,',')) "+
				  		" and aa.Market_Id = '"+mkid+"' and aa.match_id = bb.match_id ) B " +
				  		" where a.MARKET_ID = B.MARKET_ID and SEL_PRICE !='0.00' and SEL_PRICE !='101.00'";

		  
		  
		  //Debug.out("[getMarketbyMarketId] : " + query1);
		  //Debug.out("[getMarketbyMarketId] : " + query2);
		  		  		  
		  try{	      	
			 	//Context initContext = new InitialContext();
			 	//Context envContext = (Context)initContext.lookup("java:/comp/env");
			 	//DataSource ds = (DataSource)envContext.lookup("jdbc/ibet");
			 				 	
			 	con = ds.getConnection();			 
			 	pstmt = con.prepareStatement(query1);	        
		        rs = pstmt.executeQuery();
		        		        
		        if(rs.next()){
		        	sb.append(rs.getString("market"));	 
		        }				  	

		        rs.close();
		        pstmt.close();
		        
		        pstmt = con.prepareStatement(query2);	
		        //pstmt.setString(1, mid);
		        rs = pstmt.executeQuery();
		        		        
		        while(rs.next()){
		        	//sb.append(rs.getString("sel"));	 
		        	sele += rs.getString("sel");
		        }				  	

		        rs.close();
		        pstmt.close();
		        con.close();
		        
		        if(sele.length() > 2)
		        	sele = sele.substring(0, sele.length()-1); //(json_mk.length()-1);
		        
		        //sb2.deleteCharAt(sb2.length()-1);	
		        sb.append(",\"Se\": ["+sele+"]}");		        
		        //sb2 = null;
		        
		  }catch(Exception e){
			  //Debug.out("[getMarketbyMarketId] : " + e.getMessage());
		
	      }finally{
	     	  if(rs!=null) rs.close();
	     	  if(pstmt!=null)  pstmt.close();
	     	  if(con!=null) con.close();
	    	}
		  
	  return sb;
		
	}
	
	
	//use
	public StringBuffer getStatusbyMatchId(String mid,String sid) throws SQLException{
		
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  StringBuffer sb = new StringBuffer(""); 
		  String query1 ="";

		  if(sid.equals("4")) { //tennis		  

			  query1 = "SELECT '{\"EventId\":\"'+CAST(match_id as varchar(10))+'\",\"EventTypeId\":\"'+ISNULL(cast(EVENT_TYPEID as varchar(10)),'')+'\",\"AcesScore\":\"'+ISNULL(ACE_SCORE,'')+'\",\"DoubleFaultScore\":\"'+ISNULL(DBL_FAULT,'')+'\",\"GameScore\":\"'+ISNULL(GAME_SCORE,'')+'\",\"Info\":\"'+ISNULL(GAME_INFO,'')+'\",\"Period\":\"'+ISNULL(CAST(PERIOD as varchar(3)),'')+'\",\"Score\":\"'+ISNULL(SCORE,'')+'\",\"Server\":\"'+ISNULL(CAST(server  as varchar(1)),'')+'\", "+
					  " \"Set1Score\":\"'+ISNULL(SET1_SCORE,'')+'\",\"Set2Score\":\"'+ISNULL(SET2_SCORE,'')+'\",\"Set3Score\":\"'+ISNULL(SET3_SCORE,'')+'\",\"Set4Score\":\"'+ISNULL(SET4_SCORE,'')+'\",\"Set5Score\":\"'+ISNULL(SET5_SCORE,'')+'\",\"SetCount\":\"'+ISNULL(cast(SET_CNT as varchar(3)),'')+'\",\"SetScore\":\"'+ISNULL(SET_SCORE,'')+'\",\"Side\":\"'+ISNULL(cast(SIDE as char(1)),'')+'\"}' "+
			  		  " as stat from  bc_STAT  WHERE match_id = '"+mid+"'";

			  
		  	} else if(sid.equals("1")) { //soccer
			  
			  query1 = " SELECT '{\"EventId\":\"'+CAST(match_id as varchar(10))+'\",\"EventTypeId\":\"'+ISNULL(cast(EVENT_TYPEID as varchar(10)),'')+'\",\"CornerScore\":\"'+ISNULL(CORNER_SCORE,'')+'\",\"CurrentMinute\":\"'+ISNULL(cast(CUR_MIN AS VARCHAR(20)),'')+'\",\"DangerousAttackScore\":\"'+ISNULL(DANG_ATCK,'')+'\",\"EventType\":\"'+ISNULL(EVENT_TYPE,'')+'\", "+
				        " \"FreeKickScore\":\"'+ISNULL(FREEKICK_SCORE,'')+'\",\"Info\":\"'+ISNULL(GAME_INFO,'')+'\",\"PenaltyScore\":\"'+ISNULL(PENALTY_SCORE,'')+'\",\"Period\":\"'+ISNULL(cast(PERIOD AS VARCHAR(2)),'')+'\",\"RedcardScore\":\"'+ISNULL(RED_SCORE,'')+'\", "+
				        " \"Score\":\"'+ISNULL(SCORE,'')+'\",\"Set1CornerScore\":\"'+ISNULL(SET1_CORNER_SCORE,'')+'\",\"Set1RedCardScore\":\"'+ISNULL(SET1_RED_SCORE,'')+'\",\"Set1Score\":\"'+ISNULL(SET1_SCORE,'')+'\",\"Set1YellowCardScore\":\"'+ISNULL(SET1_YELLOW_SCORE,'')+'\", "+
				        " \"Set2CornerScore\":\"'+ISNULL(SET2_CORNER_SCORE,'')+'\",\"Set2RedCardScore\":\"'+ISNULL(SET2_RED_SCORE,'')+'\",\"Set2Score\":\"'+ISNULL(SET2_SCORE,'')+'\",\"Set2YellowCardScore\":\"'+ISNULL(SET2_YELLOW_SCORE,'')+'\", "+
				        " \"Set3Score\":\"'+ISNULL(SET3_SCORE,'')+'\",\"Set4Score\":\"'+ISNULL(SET4_SCORE,'')+'\",\"Set5Score\":\"'+ISNULL(SET5_SCORE,'')+'\",\"ShotOffTargetScore\":\"'+ISNULL(SHOT_OFF_TG,'')+'\",\"ShotOnTargetScore\":\"'+ISNULL(SHOT_ON_TG,'')+'\", "+
				        " \"Side\":\"'+ISNULL(cast(SIDE as varchar(1)),'')+'\",\"YellowcardScore\":\"'+ISNULL(YELLOW_SCORE,'')+'\"}' "+  
						 " as stat from  bc_STAT   WHERE match_id = '"+mid+"'";
				 
		  	} else if(sid.equals("5")) { //volleyball
			 
			  query1 = 	" SELECT '{\"EventId\":\"'+CAST(match_id as varchar(10))+'\",\"EventTypeId\":\"'+ISNULL(cast(EVENT_TYPEID as varchar(10)),'')+'\",\"EventType\":\"'+ISNULL(EVENT_TYPE,'')+'\",\"Info\":\"'+ISNULL(GAME_INFO,'')+'\",\"Period\":\"'+ISNULL(CAST(PERIOD  as varchar(2)),'') +'\",\"PeriodScore\":\"'+ISNULL(PERIOD_SCORE,'')+'\",\"Score\":\"'+ISNULL(SCORE,'')+'\",\"Server\":\"'+ISNULL(CAST(server  as varchar(1)),'')+'\", "+
					  " \"Set1Score\":\"'+ISNULL(SET1_SCORE,'')+'\",\"Set2Score\":\"'+ISNULL(SET2_SCORE,'')+'\",\"Set3Score\":\"'+ISNULL(SET3_SCORE,'')+'\",\"Set4Score\":\"'+ISNULL(SET4_SCORE,'')+'\",\"Set5Score\":\"'+ISNULL(SET5_SCORE,'')+'\",\"Side\":\"'+ISNULL(cast(SIDE as varchar(1)),'')+'\"}' "+
					  " as stat from  bc_STAT   WHERE match_id = '"+mid+"'";
			
			} else if(sid.equals("6")) { //volleyball
				 
				  query1 = 	" SELECT '{\"EventId\":\"'+CAST(match_id as varchar(10))+'\",\"EventTypeId\":\"'+ISNULL(cast(EVENT_TYPEID as varchar(10)),'')+'\",\"EventType\":\"'+ISNULL(EVENT_TYPE,'')+'\",\"Info\":\"'+ISNULL(GAME_INFO,'')+'\",\"Period\":\"'+ISNULL(CAST(PERIOD  as varchar(2)),'') +'\",\"PeriodScore\":\"'+ISNULL(PERIOD_SCORE,'')+'\",\"Score\":\"'+ISNULL(SCORE,'')+'\",\"Server\":\"'+ISNULL(CAST(server  as varchar(1)),'')+'\", "+
						  " \"RemainingTime\":\"'+ISNULL(REMAIN_TIME,'')+'\", \"Set1Score\":\"'+ISNULL(SET1_SCORE,'')+'\",\"Set2Score\":\"'+ISNULL(SET2_SCORE,'')+'\",\"Set3Score\":\"'+ISNULL(SET3_SCORE,'')+'\",\"Set4Score\":\"'+ISNULL(SET4_SCORE,'')+'\",\"Set5Score\":\"'+ISNULL(SET5_SCORE,'')+'\",\"Side\":\"'+ISNULL(cast(SIDE as varchar(1)),'')+'\"}' "+
						  " as stat from  bc_STAT   WHERE match_id = '"+mid+"'";
				  
		  	} else if(sid.equals("11")) { //baseball
			 
			 query1 = 	"SELECT '{\"EventId\":\"'+CAST(match_id as varchar(10))+'\",\"EventTypeId\":\"'+ISNULL(cast(EVENT_TYPEID as varchar(10)),'')+'\",\"EventType\":\"'+ISNULL(EVENT_TYPE,'')+'\",\"Info\":\"'+ISNULL(GAME_INFO,'')+'\",\"Period\":\"'+ISNULL(CAST(PERIOD  as varchar(2)),'') +'\",\"Score\":\"'+ISNULL(SCORE,'')+'\", "+
						" \"Set1Score\":\"'+ISNULL(SET1_SCORE,'')+'\",\"Set2Score\":\"'+ISNULL(SET2_SCORE,'')+'\",\"Set3Score\":\"'+ISNULL(SET3_SCORE,'')+'\",\"Set4Score\":\"'+ISNULL(SET4_SCORE,'')+'\",\"Set5Score\":\"'+ISNULL(SET5_SCORE,'')+'\",\"Set6Score\":\"'+ISNULL(SET6_SCORE,'')+'\", "+ 
						" \"Set7Score\":\"'+ISNULL(SET7_SCORE,'')+'\",\"Set8Score\":\"'+ISNULL(SET8_SCORE,'')+'\",\"Set9Score\":\"'+ISNULL(SET9_SCORE,'')+'\",\"Set10Score\":\"'+ISNULL(SET10_SCORE,'')+'\",\"Side\":\"'+ISNULL(cast(SIDE as varchar(1)),'')+'\"}' "+
						" as stat from  bc_STAT WHERE match_id = '"+mid+"'";

		 
		  	} else if(sid.equals("2")) { //icehockey	
			 query1 = 	"SELECT '{\"EventId\":\"'+CAST(match_id as varchar(10))+'\",\"EventTypeId\":\"'+ISNULL(cast(EVENT_TYPEID as varchar(10)),'')+'\",\"EventType\":\"'+ISNULL(EVENT_TYPE,'')+'\",\"ExtraTimeScore\":\"'+ISNULL(EXT_TIME_SCORE,'')+'\",\"Info\":\"'+ISNULL(GAME_INFO,'')+'\",\"Period\":\"'+ISNULL(CAST(PERIOD  as varchar(2)),'')+'\",\"PeriodScore\":\"'+ISNULL(PERIOD_SCORE,'')+'\", "+ 
					 	" \"RemainingTime\":\"'+ISNULL(REMAIN_TIME,'')+'\",\"Score\":\"'+ISNULL(SCORE,'')+'\",\"Set1Score\":\"'+ISNULL(SET1_SCORE,'')+'\",\"Set2Score\":\"'+ISNULL(SET2_SCORE,'')+'\",\"Set3Score\":\"'+ISNULL(SET3_SCORE,'')+'\",\"Side\":\"'+ISNULL(cast(SIDE as varchar(1)),'')+'\"}' "+
					 	" as stat from bc_STAT WHERE match_id = '"+mid+"'";
			  
		  	} else if(sid.equals("3")) { //basketball	

			 query1 =  "SELECT '{\"EventId\":\"'+CAST(match_id as varchar(10))+'\",\"EventTypeId\":\"'+ISNULL(cast(EVENT_TYPEID as varchar(10)),'')+'\",\"EventType\":\"'+ISNULL(EVENT_TYPE,'')+'\",\"ExtraTimeScore\":\"'+ISNULL(EXT_TIME_SCORE,'')+'\",\"Info\":\"'+ISNULL(GAME_INFO,'')+'\",\"Period\":\"'+ISNULL(CAST(PERIOD  as varchar(2)),'')+'\",\"QuarterScore\":\"'+ISNULL(QUAT_SCORE,'')+'\", "+ 
					 	" \"RemainingTime\":\"'+ISNULL(REMAIN_TIME,'')+'\",\"Score\":\"'+ISNULL(SCORE,'')+'\",\"Server\":\"'+ISNULL(CAST(server  as varchar(1)),'')+'\",\"Set1Score\":\"'+ISNULL(SET1_SCORE,'')+'\",\"Set2Score\":\"'+ISNULL(SET2_SCORE,'')+'\",\"Set3Score\":\"'+ISNULL(SET3_SCORE,'')+'\",\"Set4Score\":\"'+ISNULL(SET4_SCORE,'')+'\",\"Set5Score\":\"'+ISNULL(SET5_SCORE,'')+'\",\"Side\":\"'+ISNULL(cast(SIDE as varchar(1)),'')+'\"}' "+
					 	" as stat from bc_STAT WHERE match_id = '"+mid+"'";	
			 
		  	} else if(sid.equals("29")) { //handball	
				 query1 = 	"SELECT '{\"EventId\":\"'+CAST(match_id as varchar(10))+'\",\"EventTypeId\":\"'+ISNULL(cast(EVENT_TYPEID as varchar(10)),'')+'\",\"EventType\":\"'+ISNULL(EVENT_TYPE,'')+'\",\"ExtraTimeScore\":\"'+ISNULL(EXT_TIME_SCORE,'')+'\",\"Info\":\"'+ISNULL(GAME_INFO,'')+'\",\"Period\":\"'+ISNULL(CAST(PERIOD  as varchar(2)),'')+'\",\"PeriodScore\":\"'+ISNULL(PERIOD_SCORE,'')+'\", "+ 
						 	" \"RemainingTime\":\"'+ISNULL(REMAIN_TIME,'')+'\",\"Score\":\"'+ISNULL(SCORE,'')+'\",\"Set1Score\":\"'+ISNULL(SET1_SCORE,'')+'\",\"Set2Score\":\"'+ISNULL(SET2_SCORE,'')+'\",\"Set3Score\":\"'+ISNULL(SET3_SCORE,'')+'\",\"Side\":\"'+ISNULL(cast(SIDE as varchar(1)),'')+'\"}' "+
						 	" as stat from bc_STAT WHERE match_id = '"+mid+"'";
				 
		  	} else if(sid.equals("77")) { //handball	
				 query1 = 	"SELECT '{\"EventId\":\"'+CAST(match_id as varchar(10))+'\",\"EventTypeId\":\"'+ISNULL(cast(EVENT_TYPEID as varchar(10)),'')+'\",\"EventType\":\"'+ISNULL(EVENT_TYPE,'')+'\",\"ExtraTimeScore\":\"'+ISNULL(EXT_TIME_SCORE,'')+'\",\"Info\":\"'+ISNULL(GAME_INFO,'')+'\",\"Period\":\"'+ISNULL(CAST(PERIOD  as varchar(2)),'')+'\",\"PeriodScore\":\"'+ISNULL(PERIOD_SCORE,'')+'\", "+ 
						 	" \"RemainingTime\":\"'+ISNULL(REMAIN_TIME,'')+'\",\"Score\":\"'+ISNULL(SCORE,'')+'\",\"Set1Score\":\"'+ISNULL(SET1_SCORE,'')+'\",\"Set2Score\":\"'+ISNULL(SET2_SCORE,'')+'\",\"Set3Score\":\"'+ISNULL(SET3_SCORE,'')+'\",\"Side\":\"'+ISNULL(cast(SIDE as varchar(1)),'')+'\"}' "+
						 	" as stat from bc_STAT WHERE match_id = '"+mid+"'";
		  	}

		  
		  ////Debug.out("[getStatusbyMatchId] : " + query1);
		  
		  		
		  try{	      	
			 	//Context initContext = new InitialContext();
			 	//Context envContext = (Context)initContext.lookup("java:/comp/env");
			 	//DataSource ds = (DataSource)envContext.lookup("jdbc/ibet");
			 				 	
			 	con = ds.getConnection();			 
			 	pstmt = con.prepareStatement(query1);	        
		        rs = pstmt.executeQuery();
		        		        
		        if(rs.next()){
		        	sb.append(rs.getString("stat"));	 
		        }				  	
 
		        rs.close();
		        pstmt.close();		        
		        con.close();
		        
		        
		  }catch(Exception e){
			  //Debug.out("[getStatusbyMatchId] : " + e.getMessage());
		
	      }finally{
	     	  //if(cs!=null) cs.close();
	     	  if(rs!=null) rs.close();
	     	  if(pstmt!=null)  pstmt.close();
	     	  if(con!=null) con.close();
	    	}
		  
	  return sb;
		
	}

	
	public  List<MatchResultBean> getAllMatchResult() throws SQLException{
		
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		 // StringBuffer sb = new StringBuffer(""); 
		  String query1 ="";
		  
		  //HashMap<String, Object> mr = new HashMap<String, Object>();
		  //Vector mr = new Vector();
		  
		  List<MatchResultBean> mr = new ArrayList<MatchResultBean>();
		  
		  query1 =" select convert(char(8),match_date,112) MT,convert(char(16),match_date,120) MT3, match_date MDT,A.sport_id as SId,SNAME as SN,A.region_id as RId,RNAME as RN,A.compet_id as CId,CNAME as CN,home_name as HN,away_name as AN,a.market_id as MKID,a.match_id as MId,E.score as SC,F.cnt as CNT " +
					" from bc_match a,bc_stat e, " +
					" (SELECT SPORT_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE SPORT_NAME END  AS SNAME FROM bc_sport A LEFT OUTER JOIN BC_TRANS B ON A.SPORT_NAMEID = B.NAMEID) B, " +						
					" (SELECT REGION_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE REGION_NAME END AS RNAME FROM  BC_REGION A LEFT OUTER JOIN BC_TRANS B ON A.REGION_NAMEID = B.NAMEID) C, " +	 					
					"(SELECT COMPET_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE COMPET_NAME END AS CNAME FROM BC_COMPETITION A LEFT OUTER JOIN BC_TRANS B ON A.NAMEID = B.NAMEID) D , " +					
					"(select b.match_id,count(*) cnt from bc_match a, bc_market b  where  a.match_id = b.match_id "+
					" and  convert(char(8),match_date,112) <=  convert(char(8),getdate(),112)  "+
					" and convert(char(8),match_date,112) >=  convert(char(8),getdate()-7,112)  "+
					" and a.booked='t' and a.visible='t' group by b.match_id ) F "+						
					" where  A.sport_id = B.SPORT_ID  AND A.region_id = C.REGION_ID AND A.compet_id = D.COMPET_ID and " +
					" a.match_id = e.match_id and " +
					" a.match_id = F.match_id and " +
					" e.match_id = F.match_id and " +
					" convert(char(8),match_date,112) <=  convert(char(8),getdate(),112) " +
					" and convert(char(8),match_date,112) >=  convert(char(8),getdate()-6,112) " +
					" and booked='t' and visible='t' and match_stat='2' " +
					" order by match_date desc,A.sport_id,A.region_id,A.compet_id ";
	 
		  	//Debug.out("[getAllMatchResult] : " + query1);
	  
		
		  try{	      	
			 	//Context initContext = new InitialContext();
			 	//Context envContext = (Context)initContext.lookup("java:/comp/env");
			 	//DataSource ds = (DataSource)envContext.lookup("jdbc/ibet");
			 				 	
			 	con = ds.getConnection();			 
			 	pstmt = con.prepareStatement(query1);	        
		        rs = pstmt.executeQuery();
		        
		        while(rs.next()){
		        			        
		        	MatchResultBean mrb = new MatchResultBean();
		        
		        	mrb.setMdate(rs.getString("MT"));
		        	mrb.setMdate3(rs.getString("MT3"));
		        	mrb.setMid(rs.getString("MId"));
		        	mrb.setSid(rs.getString("SId"));
		        	mrb.setSname(rs.getString("SN"));
		        	mrb.setRid(rs.getString("RId"));
		        	mrb. setRname(rs.getString("RN"));
		        	mrb.setCid(rs.getString("CId"));
		        	mrb.setCname(rs.getString("CN"));
		        	mrb.setHteam(rs.getString("HN"));
		        	mrb.setAteam(rs.getString("AN"));
		        	mrb.setMkid(rs.getString("MKID"));
		        	mrb.setScore(rs.getString("SC"));
		        	mrb.setMcount(rs.getString("CNT"));
		        	
		        	mr.add(mrb); 
		        }				  	
	
		        rs.close();
		        pstmt.close();		        
		        con.close();
		        
	        
		  	}catch(Exception e){
			  //Debug.out("[getAllMatchResult] : " + e.getMessage());
		
		    }finally{
		   	  if(rs!=null) rs.close();
		   	  if(pstmt!=null)  pstmt.close();
		   	  if(con!=null) con.close();
		  	}
	  
		  return mr;
	
	}
	

	public  List<MarketListBean> getMarketList(String mid) throws SQLException{
		
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  String query1 ="";
		  
		  //HashMap<String, Object> mr = new HashMap<String, Object>();
		  //Vector mr = new Vector();
		  
		  List<MarketListBean> mr = new ArrayList<MarketListBean>();
		  
		  query1 =" DECLARE @list varchar(MAX) "+
				  " SELECT @list = JSON FROM BC_JSON WHERE KEYNAME='MARKET_TYPE' "+
				  " select market_type_id,market_id, match_id, market_name FROM bc_Market  where MATCH_ID = '"+mid+"' and MARKET_TYPE_ID in (SELECT splitdata FROM SplitString(@list,',')) ";

	 
		  	////Debug.out("[getMarketList] : " + query1);
	  
		  try{	      	
			 	//Context initContext = new InitialContext();
			 	//Context envContext = (Context)initContext.lookup("java:/comp/env");
			 	//DataSource ds = (DataSource)envContext.lookup("jdbc/ibet");
			 				 	
			 	con = ds.getConnection();			 
			 	pstmt = con.prepareStatement(query1);	        
		        rs = pstmt.executeQuery();
		        
		        while(rs.next()){
		        			        
		        	MarketListBean mlb = new MarketListBean();
		        
		        	mlb.setMarketType(rs.getString("market_type_id"));
		        	mlb.setMkid(rs.getString("market_id"));
		        	mlb.setMid(rs.getString("match_id"));
		        	mlb.setMkname(rs.getString("market_name"));
		          	
		        	mr.add(mlb); 
		        }				  	
	
		        rs.close();
		        pstmt.close();		        
		        con.close();
		        
	        
		  	}catch(Exception e){
			  //Debug.out("[getAllMatchResult] : " + e.getMessage());
		
		    }finally{
		   	  if(rs!=null) rs.close();
		   	  if(pstmt!=null)  pstmt.close();
		   	  if(con!=null) con.close();
		  	}
	  
		  return mr;
	}
	

	public  List<SelectionBean> getSelectionList(String mid) throws SQLException{
		
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  String query1 ="";
		  
		  //HashMap<String, Object> mr = new HashMap<String, Object>();
		  //Vector mr = new Vector();
		  
		  List<SelectionBean> slb = new ArrayList<SelectionBean>();
		  
		  query1 =" DECLARE @list varchar(MAX) "+
				  "	SELECT @list = JSON FROM BC_JSON WHERE KEYNAME='MARKET_TYPE' "+
				  " select a.market_id,replace(replace(replace(replace(sel_name,'{h}',a.handicap),'{-h}',-a.handicap),'{hv}',isnull(home_value,'')),'{av}',isnull(away_value,'')) sel_name,sel_order,outcome,b.handicap,a.handicap "+
				  " from bc_selection as b, bc_Market a where b.market_id in ( a. market_id)  and MATCH_ID = '"+mid+"' " +
				  "	and MARKET_TYPE_ID in (SELECT splitdata FROM SplitString(@list,','))";
		  	
		  	////Debug.out("[getSelectionList] : " + query1);
	  
		  try{	      	
			 	//Context initContext = new InitialContext();
			 	//Context envContext = (Context)initContext.lookup("java:/comp/env");
			 	//DataSource ds = (DataSource)envContext.lookup("jdbc/ibet");
			 				 	
			 	con = ds.getConnection();			 
			 	pstmt = con.prepareStatement(query1);	        
		        rs = pstmt.executeQuery();
		        
		        while(rs.next()){
		        			        
		        	SelectionBean sl = new SelectionBean();
		        
		        	sl.setMkid(rs.getString("market_id"));
		        	sl.setSelName(rs.getString("sel_name"));
		        	sl.setSelOrder(rs.getString("sel_order"));
		        	sl.setOutcome(rs.getString("outcome"));
		          	
		        	slb.add(sl); 
		        }				  	
	
		        rs.close();
		        pstmt.close();		        
		        con.close();
		        
	        
		  	}catch(Exception e){
			  //Debug.out("[getSelectionList] : " + e.getMessage());
		
		    }finally{
		   	  if(rs!=null) rs.close();
		   	  if(pstmt!=null)  pstmt.close();
		   	  if(con!=null) con.close();
		  	}
	  
		  return slb;
	}
	
	
	
	public  List<MatchListBean> getFavoriteMatch() throws SQLException{
		
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		 // StringBuffer sb = new StringBuffer(""); 
		  String query1 ="";
		  
		  //HashMap<String, Object> mr = new HashMap<String, Object>();
		  //Vector mr = new Vector();
		  
		  List<MatchListBean> ml = new ArrayList<MatchListBean>();
		  
		  query1 ="  select top 10 convert(char(19),match_date,120) MT,A.sport_id as SId,SNAME as SN,A.region_id as RId,RNAME as RN,A.compet_id as CId,CNAME as CN,home_team_id HID, away_team_id AID,"+
				  " home_name as HN,away_name as AN,a.match_id as MId "+
				" from bc_match a, "+
				" (SELECT SPORT_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE SPORT_NAME END  AS SNAME FROM bc_sport A LEFT OUTER JOIN BC_TRANS B ON A.SPORT_NAMEID = B.NAMEID) B, "+ 					
				" (SELECT REGION_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE REGION_NAME END AS RNAME FROM  BC_REGION A LEFT OUTER JOIN BC_TRANS B ON A.REGION_NAMEID = B.NAMEID) C, "+  					
				" (SELECT COMPET_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE COMPET_NAME END AS CNAME FROM BC_COMPETITION A LEFT OUTER JOIN BC_TRANS B ON A.NAMEID = B.NAMEID) D "+				
				" where  A.sport_id = B.SPORT_ID  AND A.region_id = C.REGION_ID AND A.compet_id = D.COMPET_ID and  popular='T' "+
				" and a.match_stat='0' and a.match_date >= getdate()" +
				" order by match_date ";
		  	 
		  	////Debug.out("[getFavoriteMatch] : " + query1);
	  
		
		  try{	      	
			 	//Context initContext = new InitialContext();
			 	//Context envContext = (Context)initContext.lookup("java:/comp/env");
			 	//DataSource ds = (DataSource)envContext.lookup("jdbc/ibet");
			 				 	
			 	con = ds.getConnection();			 
			 	pstmt = con.prepareStatement(query1);	        
		        rs = pstmt.executeQuery();
		        
		        while(rs.next()){
		        			        
		        	MatchListBean mlb = new MatchListBean();
		        
		        	mlb.setMdate(rs.getString("MT"));
		        	mlb.setMid(rs.getString("MId"));
		        	mlb.setSid(rs.getString("SId"));
		        	mlb.setSname(rs.getString("SN"));
		        	mlb.setRid(rs.getString("RId"));
		        	mlb. setRname(rs.getString("RN"));
		        	mlb.setCid(rs.getString("CId"));
		        	mlb.setCname(rs.getString("CN"));
		        	mlb.setHteam(rs.getString("HN"));
		        	mlb.setAteam(rs.getString("AN"));
		        	mlb.setHId(rs.getString("HID"));
		        	mlb.setAId(rs.getString("AID"));
		        	
		        	ml.add(mlb); 
		        }				  	
	
		        
		        rs.close();
		        pstmt.close();		        
		        con.close();
		        		        
		  	}catch(Exception e){
			  //Debug.out("[getFavoriteMatch] : " + e.getMessage());
		
		    }finally{
		   	  if(rs!=null) rs.close();
		   	  if(pstmt!=null)  pstmt.close();
		   	  if(con!=null) con.close();
		  	}
	  
		  return ml;
	
	}
	
	
	public  List<DepositListBean> getDepositList() throws SQLException{
		
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		 // StringBuffer sb = new StringBuffer(""); 
		  String query1 ="";
		  
		  //HashMap<String, Object> mr = new HashMap<String, Object>();
		  //Vector mr = new Vector();
		  
		  List<DepositListBean> dl = new ArrayList<DepositListBean>();
		  
		  //query1 ="select top 20 chid as CD,userid as UD,convert(char(16),regdate,120) as CT,money_req as MN from charge_lst order by chdate desc ";
		  
		  query1 =" select * from (select top 20 chid as CD,SUBSTRING(userid,0,3)+replicate('*',len(userid)-3)+SUBSTRING(userid,LEN(userid),LEN(userid))  as UD, " +
				 " convert(char(19),regdate,120) as CT,money_req as MN from charge_lst WHERE chdate > DATEADD(minute, -10, GETDATE()) order by chdate desc ) a " +
				 " union  " +
				 " select * from (select top 20 chid as CD,userid as UD,convert(char(19),regdate,120) as CT,money_req as MN from charge_lst2 order by REGdate desc) b " +
				 " order by CT desc ";

				 
		  ////Debug.out("[getDepositList] : " + query1);
	  
		
		  try{	      	
			 	//Context initContext = new InitialContext();
			 	//Context envContext = (Context)initContext.lookup("java:/comp/env");
			 	//DataSource ds = (DataSource)envContext.lookup("jdbc/ibet");
			 				 	
			 	con = ds.getConnection();			 
			 	pstmt = con.prepareStatement(query1);	        
		        rs = pstmt.executeQuery();
		        
		        while(rs.next()){
		        			        
		        	DepositListBean dlb = new DepositListBean();
		        
		        	dlb.setChid(rs.getString("CD"));
		        	dlb.setUid(rs.getString("UD"));
		        	dlb.setChdt(rs.getString("CT"));
		        	dlb.setMoney(rs.getString("MN"));
		        	
		        	dl.add(dlb); 
		        }				  	
	
		        rs.close();
		        pstmt.close();		        
		        con.close();
		        
	        
		  	}catch(Exception e){
			  //Debug.out("[getFavoriteMatch] : " + e.getMessage());
		
		    }finally{
		   	  if(rs!=null) rs.close();
		   	  if(pstmt!=null)  pstmt.close();
		   	  if(con!=null) con.close();
		  	}
	  
		  return dl;
	
	}
	
	
	public StringBuffer getMainLiveMatch() throws SQLException{
		
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  String match = "";
		  String result = "";
		  String sele = "";
		  String market = "";
		  //String stat = "";
		  
		  
		  StringBuffer sb = new StringBuffer(""); 
		  
		  String query1 = " SELECT '{\"Id\":\"'+CAST(A.match_id as varchar(10))+'\",\"CId\":\"'+CAST(A.compet_id as varchar(10))+'\",\"CN\":\"'+CNAME+'\","+
					"\"SId\":\"'+CAST(A.sport_id as varchar(10))+'\",\"SN\":\"'+SNAME+'\",\"RId\":\"'+CAST(A.region_id as varchar(10))+'\",\"RN\":\"'+RNAME+'\","+
					"\"Sus\":'+CASE WHEN suspend ='T' THEN 'true' ELSE 'false' END+',"+
					"\"HT\":\"'+home_name+'\","+
					"\"AT\":\"'+away_name+'\"},' AS match  "+
					" FROM bc_match A ,"+
					" (SELECT SPORT_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE SPORT_NAME END  AS SNAME "+
					" FROM bc_sport A LEFT OUTER JOIN BC_TRANS B ON A.SPORT_NAMEID = B.NAMEID) B,"+						
					" (SELECT REGION_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE REGION_NAME END AS RNAME "+
					" FROM  BC_REGION A LEFT OUTER JOIN BC_TRANS B ON A.REGION_NAMEID = B.NAMEID) C,"+						
					" (SELECT COMPET_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE COMPET_NAME END AS CNAME "+
					" FROM BC_COMPETITION A LEFT OUTER JOIN BC_TRANS B ON A.NAMEID = B.NAMEID) D "+						
					" WHERE A.sport_id = B.SPORT_ID  AND A.region_id = C.REGION_ID AND A.compet_id = D.COMPET_ID "+
					" AND live='T' and a.live_stat='1' AND a.visible='T'  AND a.booked='T' and A.home_name is not null and A.away_name is not null order by home_name";
		  
		  String query2 =" DECLARE @list varchar(MAX) "+
				  		" SELECT @list = JSON FROM BC_JSON WHERE KEYNAME='MARKET_TYPE' "+		  
				  		" SELECT '{\"Id\":'+CAST(A.MARKET_ID as varchar(10))+',\"M\":\"'+CAST(B.MATCH_ID as varchar(10))+'\","+
				  		"\"V\":'+CASE WHEN A.visible ='T' THEN 'true' ELSE 'false' END +',"+
				  		"\"S\":'+CASE WHEN A.suspend ='T' THEN 'true' ELSE 'false' END +'},' as market "+
		  				" FROM BC_MARKET A, (select * from BC_MATCH where live='T' and live_stat='1' AND visible='T' and booked='T' and home_name is not null and away_name is not null ) B "+
		  				" WHERE A.MATCH_ID = B.MATCH_ID AND MARKET_TYPE_ID in "+
		  				" (SELECT splitdata FROM SplitString(@list,',')) "+ 
		  				//" AND B.live='T' and B.live_stat='1' AND B.visible='T'  AND B.booked='T' "+  
		  				" AND A.visible='T' AND A.suspend = 'F' ";
		 
		  String query3 = " SELECT  '{\"Id\":'+CAST(A.MARKET_ID as varchar(10))+',\"MId\":'+CAST(B.MATCH_ID as varchar(10))+',"+
			  		"\"Sus\":'+CASE WHEN A.suspend ='T' THEN 'true' ELSE 'false' END+',"+
			  		"\"Vis\":'+CASE WHEN A.visible ='T' THEN 'true' ELSE 'false' END+'},' "+ 
			  		" as result "+ 
			  		" FROM BC_MARKET A , (select * from BC_MATCH where live='T' and live_stat='1' AND visible='T' and booked='T' and home_name is not null and away_name is not null ) b "+
			  		" WHERE a.MATCH_ID = b.MATCH_ID "+ //and a.market_id = b.market_id"; 
			  		" and (MARKET_TYPE_ID ='377' or MARKET_TYPE_ID='399' or MARKET_TYPE_ID='2434' or MARKET_TYPE_ID='4475' "+
			  		" OR MARKET_TYPE_ID='5488' OR MARKET_TYPE_ID='5498'   OR MARKET_TYPE_ID='8774' OR MARKET_TYPE_ID='6544' "+
			  		" OR MARKET_TYPE_ID='6564' OR MARKET_TYPE_ID='8750' OR MARKET_TYPE_ID='8763' OR MARKET_TYPE_ID='9775' "+
			  		" OR MARKET_TYPE_ID='10829' or MARKET_TYPE_ID='9321')";
		 
		  String query4 = " SELECT  '{\"Id\":\"'+CAST(C.SEL_ID as varchar(10))+'\",\"MId\":'+CAST(B.MATCH_ID as varchar(10))+',\"MkId\":\"'+CAST(C.Market_Id as varchar(10))+'\","+
				  		"\"Nm\":\"'+CAST(C.sel_name as varchar(10))+'\",\"P\":\"'+CAST(C.sel_price as varchar(10))+'\"},' as selection"+
				  		//"  \"Sus\":'+CASE WHEN A.suspend ='T' THEN 'true' ELSE 'false' END+', "+
				  		//" \"Vis\":'+CASE WHEN A.visible ='T' THEN 'true' ELSE 'false' END+'},' as selection "+ 				  		
						 " from BC_MARKET A, (select * from BC_MATCH where live='T' and live_stat='1' AND visible='T' and booked='T' and home_name is not null and away_name is not null ) b, bc_selection c "+
					  	//" WHERE  B.live='T' and B.live_stat='1' AND B.visible='T'  AND B.booked='T' "+ 
					  	//" AND A.visible='T' and a.market_id = c.market_id and b.market_id = c.market_id and home_name is not null and away_name is not null"+
					  	" WHERE a.MATCH_ID = b.MATCH_ID and a.market_id = c.market_id "  + //b.market_id = c.market_id ";
					  	" and (MARKET_TYPE_ID ='377' or MARKET_TYPE_ID='399' or MARKET_TYPE_ID='2434' or MARKET_TYPE_ID='4475' "+
				  		" OR MARKET_TYPE_ID='5488' OR MARKET_TYPE_ID='5498'   OR MARKET_TYPE_ID='8774' OR MARKET_TYPE_ID='6544' "+
				  		" OR MARKET_TYPE_ID='6564' OR MARKET_TYPE_ID='8750' OR MARKET_TYPE_ID='8763' OR MARKET_TYPE_ID='9775' "+
				  		" OR MARKET_TYPE_ID='10829' or MARKET_TYPE_ID='9321')";
				  		//" from BC_MARKET A ,BC_match b, bc_selection c "+
				  		//" WHERE  B.live='T' and B.live_stat='1' AND B.visible='T'  AND B.booked='T' "+ 
				  		//" AND A.visible='T' and a.market_id = c.market_id and b.market_id = c.market_id and home_name is not null and away_name is not null"+
				  		//" and a.MATCH_ID = b.MATCH_ID ";
				  		  
		  ////Debug.out("query1 : " + query1);	
		  ////Debug.out("query2 : " + query2);	
		  ////Debug.out("query3 : " + query3);	
		  ////Debug.out("query4 : " + query4);	

		  try{	      	
			 	//Context initContext = new InitialContext();
			 	//Context envContext = (Context)initContext.lookup("java:/comp/env");
			 	//DataSource ds = (DataSource)envContext.lookup("jdbc/ibet");
			 				 	
			 	con = ds.getConnection();			 	
			 				 
			 	pstmt = con.prepareStatement(query1);				 	
		        rs = pstmt.executeQuery();	
		        
		        while(rs.next()){
		        	match += rs.getString("match");
		        }
		        rs.close();
		        pstmt.close();
		        
		        if(match.length() > 2)
		        	match = match.substring(0, match.length()-1); //(json_mk.length()-1);				        	
	        	sb.append("[{\"Mt\":["+match+"]");
	        					        	
	        	pstmt = con.prepareStatement(query2);
	        	rs = pstmt.executeQuery();
		        
	        	while(rs.next()){
	        		market += rs.getString("market");
		        }
		        
	        	rs.close();
	        	pstmt.close();
	        	
	        	if(market.length() > 2)
	        		market = market.substring(0, market.length()-1); //(json_mk.length()-1);
	
	        	sb.append(",\"Mk\":["+market+"]");
	        	
	        	pstmt = con.prepareStatement(query3);
	        	rs = pstmt.executeQuery();
		        
	        	while(rs.next()){
	        		result += rs.getString("result");
		        }
		        
	        	rs.close();
	        	pstmt.close();
	        	
	        	if(result.length() > 2)
	        		result = result.substring(0, result.length()-1); //(json_mk.length()-1);
	
	        	sb.append(",\"Re\":["+result+"]");
	        	
	        	pstmt = con.prepareStatement(query4);
	        	rs = pstmt.executeQuery();
		        
	        	while(rs.next()){
	        		sele += rs.getString("selection");
		        }
		        
	        	rs.close();
	        	pstmt.close();
	        	con.close();
	        	
	        	if(sele.length() > 2)
	        		sele = sele.substring(0, sele.length()-1); //(json_mk.length()-1);
	
	        	sb.append(",\"Se\":["+sele+"]}]");	        	
	        	
		        
		        
		        //Debug.out("getMainLiveMatch : " + sb.toString());
		        
		  }catch(Exception e){
			  //Debug.out("[getMainLiveMatch] : " + e.getMessage());
		
	      }finally{
	     	 // if(cs!=null) cs.close();
	     	  if(rs!=null) rs.close();	     	 
	     	  if(pstmt!=null)  pstmt.close();
	     	  if(con!=null) con.close();
	    	}
		  
	  return sb;
		
	}


	public StringBuffer getMainPreMatch(String sid,String min) throws SQLException{
		
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  String match = "";
		  String result = "";
		  String sele = "";
		  String market = "";
		  String stat = "";
		  
		  String add_query1 = " and b.sport_id = '"+sid+"' ";
		  String add_query2 = " and match_date<=DATEADD(minute, "+min+", getdate()) ";
		  
		  if(sid.equals("0")){
			  add_query1 = "";
		  }
		  
		  if(min.equals("0")){
			  add_query2 = "";
		  }
		  
		  StringBuffer sb = new StringBuffer(""); 
		  
		  String query1 = " SELECT top 10  '{\"Id\":\"'+CAST(b.match_id as varchar(10))+'\",\"Dt\":\"'+convert(char(5),match_date,108)+'\",\"CId\":\"'+CAST(b.compet_id as varchar(10))+'\",\"CN\":\"'+CNAME+'\", "+
					" \"SId\":\"'+CAST(b.sport_id as varchar(10))+'\",\"SN\":\"'+SNAME+'\",\"RId\":\"'+CAST(b.region_id as varchar(10))+'\",\"RN\":\"'+RNAME+'\", "+
					" \"Sus\":'+CASE WHEN suspend ='T' THEN 'true' ELSE 'false' END+',"+
					" \"HT\":\"'+home_name+'\",  "+
					" \"AT\":\"'+away_name+'\"},' AS match  "+
					" FROM bc_match B ,"+
					" (SELECT SPORT_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE SPORT_NAME END  AS SNAME "+
					" FROM bc_sport A LEFT OUTER JOIN BC_TRANS B ON A.SPORT_NAMEID = B.NAMEID) E,"+						
					" (SELECT REGION_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE REGION_NAME END AS RNAME "+
					" FROM  BC_REGION A LEFT OUTER JOIN BC_TRANS B ON A.REGION_NAMEID = B.NAMEID) C,"+						
					" (SELECT COMPET_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE COMPET_NAME END AS CNAME "+
					" FROM BC_COMPETITION A LEFT OUTER JOIN BC_TRANS B ON A.NAMEID = B.NAMEID) D "+						
					" WHERE b.sport_id = E.SPORT_ID  AND b.region_id = C.REGION_ID AND b.compet_id = D.COMPET_ID "+
					//" AND live='T' and a.live_stat='1' AND a.visible='T'  AND a.booked='T' and A.home_name is not null and A.away_name is not null";
					" and b.match_stat='0' "+add_query1+" and b.match_date >= getdate() "+add_query2+" and home_name is not null and away_name is not null order by match_date ";
		  
		  String query2 =" DECLARE @list varchar(MAX) "+
				  		" SELECT @list = JSON FROM BC_JSON WHERE KEYNAME='MARKET_TYPE' "+		  
				  		" SELECT '{\"Id\":'+CAST(A.MARKET_ID as varchar(10))+',\"M\":\"'+CAST(B.MATCH_ID as varchar(10))+'\","+
				  		"	\"V\":'+CASE WHEN A.visible ='T' THEN 'true' ELSE 'false' END +', "+
				  		"	\"S\":'+CASE WHEN A.suspend ='T' THEN 'true' ELSE 'false' END +'},' as market "+
		  				" FROM BC_MARKET A,  ( select top 10  * from BC_MATCH b where match_stat='0' "+add_query1+" and match_date >= getdate() "+add_query2+" and home_name is not null and away_name is not null order by match_date ) B "+
		  				" WHERE A.MATCH_ID = B.MATCH_ID and home_name is not null and away_name is not null AND MARKET_TYPE_ID in "+
		  				" (SELECT splitdata FROM SplitString(@list,',')) ";
		  				//" AND B.live='T' and B.live_stat='1' AND B.visible='T'  AND B.booked='T' "+  
		  				//" AND A.visible='T' AND A.suspend = 'F' ";
		  				//" and b.match_stat='0' "+add_query+" and b.match_date >= getdate()  order by match_date ";
		  
		  String query3 = " SELECT '{\"Id\":'+CAST(A.MARKET_ID as varchar(10))+',\"MId\":'+CAST(B.MATCH_ID as varchar(10))+', "+
			  		"\"Sus\":'+CASE WHEN A.suspend ='T' THEN 'true' ELSE 'false' END+',"+
			  		"\"Vis\":'+CASE WHEN A.visible ='T' THEN 'true' ELSE 'false' END+'},' "+ 
			  		" as result "+ 
			  		" FROM BC_MARKET A ,(select top 10 * from BC_MATCH b where match_stat='0' "+add_query1+" and match_date >= getdate() "+add_query2+" and home_name is not null and away_name is not null order by match_date) b "+
			  		" WHERE a.MATCH_ID = b.MATCH_ID "+ //and a.market_id = b.market_id";
			  		//" and b.match_stat='0' "+add_query+" and b.match_date >= getdate()  order by match_date ";
			  		" AND (MARKET_TYPE_ID ='377' or MARKET_TYPE_ID='399' or MARKET_TYPE_ID='2434' or MARKET_TYPE_ID='4475' "+
				  		" OR MARKET_TYPE_ID='5488' OR MARKET_TYPE_ID='5498'   OR MARKET_TYPE_ID='8774' OR MARKET_TYPE_ID='6544' "+
				  		" OR MARKET_TYPE_ID='6564' OR MARKET_TYPE_ID='8750' OR MARKET_TYPE_ID='8763' OR MARKET_TYPE_ID='9775' "+
				  		" OR MARKET_TYPE_ID='10829' or MARKET_TYPE_ID='9321')";
		  
		  String query4 = " SELECT '{\"Id\":\"'+CAST(C.SEL_ID as varchar(10))+'\",\"MId\":'+CAST(B.MATCH_ID as varchar(10))+',\"MkId\":\"'+CAST(C.Market_Id as varchar(10))+'\", "+
				  		" \"Nm\":\"'+CAST(C.sel_name as varchar(10))+'\",\"P\":\"'+CAST(C.sel_price as varchar(10))+'\"},' as selection"+
				  		//"  \"Sus\":'+CASE WHEN A.suspend ='T' THEN 'true' ELSE 'false' END+', "+
				  		//" \"Vis\":'+CASE WHEN A.visible ='T' THEN 'true' ELSE 'false' END+'},' as selection "+ 				  		
						 " from BC_MARKET A, (select top 10 * from BC_MATCH b where match_stat='0' "+add_query1+" and match_date >= getdate() "+add_query2+" and home_name is not null and away_name is not null order by match_date) b, bc_selection c "+
					  	//" WHERE  B.live='T' and B.live_stat='1' AND B.visible='T'  AND B.booked='T' "+ 
					  	//" AND A.visible='T' and a.market_id = c.market_id and b.market_id = c.market_id and home_name is not null and away_name is not null"+
					  	//" WHERE b.market_id = c.market_id ";
				  		" WHERE a.MATCH_ID = b.MATCH_ID and a.market_id = c.market_id "  +
				  		" and (MARKET_TYPE_ID ='377' or MARKET_TYPE_ID='399' or MARKET_TYPE_ID='2434' or MARKET_TYPE_ID='4475' "+
					  		" OR MARKET_TYPE_ID='5488' OR MARKET_TYPE_ID='5498'   OR MARKET_TYPE_ID='8774' OR MARKET_TYPE_ID='6544' "+
					  		" OR MARKET_TYPE_ID='6564' OR MARKET_TYPE_ID='8750' OR MARKET_TYPE_ID='8763' OR MARKET_TYPE_ID='9775' "+
					  		" OR MARKET_TYPE_ID='10829' or MARKET_TYPE_ID='9321')";
					  	//" and b.match_stat='0' "+add_query+" and b.match_date >= getdate()  order by match_date ";
			  		
				  		//" from BC_MARKET A ,BC_match b, bc_selection c "+
				  		//" WHERE  B.live='T' and B.live_stat='1' AND B.visible='T'  AND B.booked='T' "+ 
				  		//" AND A.visible='T' and a.market_id = c.market_id and b.market_id = c.market_id and home_name is not null and away_name is not null"+
				  		//" and a.MATCH_ID = b.MATCH_ID ";
				  		  
		  ////Debug.out("query1 : " + query1);	
		  ////Debug.out("query2 : " + query2);	
		  ////Debug.out("query3 : " + query3);	
		  ////Debug.out("query4 : " + query4);	

		  try{	      	
			 	//Context initContext = new InitialContext();
			 	//Context envContext = (Context)initContext.lookup("java:/comp/env");
			 	//DataSource ds = (DataSource)envContext.lookup("jdbc/ibet");
			 				 	
			 	con = ds.getConnection();		 	
			 	
			 	pstmt = con.prepareStatement(query1);				 	
		        rs = pstmt.executeQuery();	
		        
		        while(rs.next()){
		        	match += rs.getString("match");
		        }
		        rs.close();
		        pstmt.close();
		        
		        if(match.length() > 2)
		        	match = match.substring(0, match.length()-1); //(json_mk.length()-1);				        	
	        	sb.append("[{\"Mt\": ["+match+"]");
	        					        	
	        	pstmt = con.prepareStatement(query2);
	        	rs = pstmt.executeQuery();
		        
	        	while(rs.next()){
	        		market += rs.getString("market");
		        }
		        
	        	rs.close();
	        	pstmt.close();
	        	
	        	if(market.length() > 2)
	        		market = market.substring(0, market.length()-1); //(json_mk.length()-1);
	
	        	sb.append(",\"Mk\": ["+market+"]");
	        	
	        	pstmt = con.prepareStatement(query3);
	        	rs = pstmt.executeQuery();
		        
	        	while(rs.next()){
	        		result += rs.getString("result");
		        }
		        
	        	rs.close();
	        	pstmt.close();
	        	
	        	if(result.length() > 2)
	        		result = result.substring(0, result.length()-1); //(json_mk.length()-1);
	
	        	sb.append(",\"Re\": ["+result+"]");
	        	
	        	pstmt = con.prepareStatement(query4);
	        	rs = pstmt.executeQuery();
		        
	        	while(rs.next()){
	        		sele += rs.getString("selection");
		        }
		        
	        	rs.close();
	        	pstmt.close();
	        	
	        	if(sele.length() > 2)
	        		sele = sele.substring(0, sele.length()-1); //(json_mk.length()-1);
	
	        	sb.append(",\"Se\": ["+sele+"]}]");	        	
	        	
		        con.close();
		        
		        ////Debug.out("getMainPreMatch : " + sb.toString());
		        
		  }catch(Exception e){
			  //Debug.out("[getMainPreMatch] : " + e.getMessage());
		
	      }finally{
	     	 // if(cs!=null) cs.close();
	     	  if(rs!=null) rs.close();	     	 
	     	  if(pstmt!=null)  pstmt.close();
	     	  if(con!=null) con.close();
	    	}
		  
	  return sb;
		
	}
	
	
	
	public List<BettingListBean> getBetList(String mid) throws SQLException{
		
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  
		  List<BettingListBean> bl = new ArrayList<BettingListBean>();
		  
		  String query1 = " select bgid,bet_money,expect_rate,expect_money,sel_cnt,bgresult,convert(char(19),betdate,120) as betdate from bc_bet_grp where viewtype='Y' and userid='"+mid+"' ";
		  
		  /*
		  String query2 =" select txt,bgid,count(*) cnt from  bc_trans a2, ( "+
						" select a1.sport_nameid,b1.* from bc_sport a1, ( "+
						" select aaa.sport_id,bbb.* from bc_match aaa, (  "+
						" select aa.match_id,bb.* from bc_market aa, ( "+
						" select b.bgid,market_id,b.sel_id  from bc_selection a,(select bgid,sel_id from bc_bet_sel where bgid in (select bgid from bc_bet_grp where userid='matthew' )) b "+
						" where a.sel_id = b.sel_id ) bb where aa.market_id = bb.market_id ) bbb where aaa.match_id=bbb.match_id ) b1 "+
						" where a1.sport_id = b1.sport_id ) b2 "+
						" where a2.nameid = b2.sport_nameid "+
						" group by txt,bgid";
		   */
		  
		  try{	      	
			 				 	
			 	con = ds.getConnection();			
			 	
			 	pstmt = con.prepareStatement(query1);				 	
		        rs = pstmt.executeQuery();	
		     		        
	        	while(rs.next()){
	        		
    			        
		        	BettingListBean blb = new BettingListBean();
		        
		        	blb.setBgid(rs.getString("bgid"));
		        	blb.setBmoney(rs.getString("bet_money"));
		        	blb.setErate(rs.getString("expect_rate"));
		        	blb.setEmoney(rs.getString("expect_money"));
		        	blb.setScnt(rs.getString("sel_cnt"));
		        	blb.setBresult(rs.getString("bgresult"));
		        	blb.setBdate(rs.getString("betdate"));
		        	blb.setSelected(false);
		        	
		        	
		        	bl.add(blb); 
		        }		

		        
	        	rs.close();
	        	pstmt.close();
		        con.close();
		        
		        ////Debug.out("getMainPreMatch : " + sb.toString());
		        
		  }catch(Exception e){
			  //Debug.out("[getMainPreMatch] : " + e.getMessage());
		
	      }finally{
	     	 // if(cs!=null) cs.close();
	     	  if(rs!=null) rs.close();	     	 
	     	  if(pstmt!=null)  pstmt.close();
	     	  if(con!=null) con.close();
	    	}
		  
	  return bl;
		
	}
	
	public List<BettingSName> getBetSNames(String mid) throws SQLException{
		
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  
		  List<BettingSName> bs = new ArrayList<BettingSName>();
		  
		  String query1 =" select txt,bgid from  bc_trans a2, ( "+
						" select a1.sport_nameid,b1.* from bc_sport a1, ( "+
						" select aaa.sport_id,bbb.* from bc_match aaa, (  "+
						" select aa.match_id,bb.* from bc_market aa, ( "+
						" select b.bgid,market_id,b.sel_id  from bc_selection a,(select bgid,sel_id from bc_bet_sel where bgid in (select bgid from bc_bet_grp where userid='"+mid+"' )) b "+
						" where a.sel_id = b.sel_id ) bb where aa.market_id = bb.market_id ) bbb where aaa.match_id=bbb.match_id ) b1 "+
						" where a1.sport_id = b1.sport_id ) b2 "+
						" where a2.nameid = b2.sport_nameid ";
		  try{	      	
			 				 	
			 	con = ds.getConnection();		 	
			 	
			 	pstmt = con.prepareStatement(query1);				 	
		        rs = pstmt.executeQuery();	
		     		        
	        	while(rs.next()){	        		
  			        
	        		BettingSName bsn = new BettingSName();
		        
	        		bsn.setBgid(rs.getString("bgid"));
	        		bsn.setSNames(rs.getString("txt"));
		        	
	        		bs.add(bsn); 
		        }		

		        
	        	rs.close();
	        	pstmt.close();
		        con.close();
		        
		        ////Debug.out("getMainPreMatch : " + sb.toString());
		        
		  }catch(Exception e){
			  //Debug.out("[getMainPreMatch] : " + e.getMessage());
		
	      }finally{
	     	 // if(cs!=null) cs.close();
	     	  if(rs!=null) rs.close();	     	 
	     	  if(pstmt!=null)  pstmt.close();
	     	  if(con!=null) con.close();
	    	}
		  
	  return bs;
		
	}
	
	
	public boolean detBetList(String[] bid,String st,String mid) throws SQLException{
		
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  //ResultSet rs = null;
		  boolean ret = false;
		  String query1 ="";
		  
		  StringBuilder sb = new StringBuilder();
		  //  if(bid.length <= 0) return sb.toString();
		    for(int ctr = 0; ctr < bid.length - 1; ++ctr) {
		        sb.append("?,");
		    }
		  sb.append("?");
		    
		  //String query1 ="update bc_bet_grp set viewtype='N' where userid='matthew' and bgid IN ? ";
		  if(st.equals("SP")){
			  query1 ="update bc_bet_grp set viewtype='N' where userid='"+mid+"' and bgid IN (" + sb.toString() + ")";
			  
		  } else if(st.equals("SC")){
			  query1 ="update spincube_lst set viewtype='N' where userid='"+mid+"' and scid IN (" + sb.toString() + ")";
		  
		  } else if(st.equals("MG")){
			  query1 ="update micro_game set viewtype='N' where userid='"+mid+"' and mgid IN (" + sb.toString() + ")";
			  
		  }  else if(st.equals("AG")){
			  query1 ="update asiagame_lst set viewtype='N' where userid='"+mid+"' and agid IN (" + sb.toString() + ")";
		  }
		  
		  //Debug.out("query1 : " + query1);
		  
		  try{	      	
			 				 	
			 	con = ds.getConnection();		 	
			 	
			 	pstmt = con.prepareStatement(query1);	
			 	
			 	for(int idx = 0; idx < bid.length; idx++) {
			 		pstmt.setString(idx+1, bid[idx]);
			 	}
			 	
			 	//Array sqlArray = con.createArrayOf("String", bid);
			 	//pstmt.setArray(1, sqlArray);
			 	//pstmt.setString(0,bid);
			 	int result = pstmt.executeUpdate();
		        
		     		        
	        	if(result > 0){	        		
	        		ret = true;
	        		
	        		//BettingSName bsn = new BettingSName();
		        
	        		//bsn.setBgid(rs.getString("bgid"));
	        		//bsn.setSNames(rs.getString("txt"));
		        	
	        		//bs.add(bsn); 
		        }		

		        
	        	//rs.close();
	        	pstmt.close();
		        con.close();
		        
		        //Debug.out("return :" + ret);
		        
		        ////Debug.out("getMainPreMatch : " + sb.toString());
		        
		  }catch(Exception e){
			  //Debug.out("[detBetList] : " + e.getMessage());
		
	      }finally{
	     	 // if(cs!=null) cs.close();
	     	 // if(rs!=null) rs.close();	     	 
	     	  if(pstmt!=null)  pstmt.close();
	     	  if(con!=null) con.close();
	    	}
		  
	  return ret;
		
	}
	
	
	public  List<BetSelList> getBetDetail(String bid) throws SQLException{
		
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  String query1 ="";
		  
		  //HashMap<String, Object> mr = new HashMap<String, Object>();
		  //Vector mr = new Vector();
		  
		  List<BetSelList> bs = new ArrayList<BetSelList>();
		 
  		  //match
		  query1 =" select * from ("+
				  " select aa.match_id,compet_id,convert(char(19),match_date,120) match_date,sport_id,region_id,home_name,away_name,cc.*,bb.market_name from bc_match aa, bc_market bb, ( "+
				  " select b.bgid,b.sel_id,bsresult,a.market_id,sel_name,sel_price  from bc_selection a,(select bgid,sel_id,bsresult from bc_bet_sel where bgid = '"+bid+"') b  "+
				  " where a.sel_id = b.sel_id) cc "+
				  " where aa.match_id=bb.match_id and bb.market_id = cc.market_id "+
				"  ) aaa,"+
				" (SELECT SPORT_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE SPORT_NAME END  AS SNAME "+
				" FROM bc_sport A LEFT OUTER JOIN BC_TRANS B ON A.SPORT_NAMEID = B.NAMEID) BBB,	"+					
				" (SELECT REGION_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE REGION_NAME END AS RNAME "+
				" FROM  BC_REGION A LEFT OUTER JOIN BC_TRANS B ON A.REGION_NAMEID = B.NAMEID) CCC,"+						
				" (SELECT COMPET_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE COMPET_NAME END AS CNAME "+
				" FROM BC_COMPETITION A LEFT OUTER JOIN BC_TRANS B ON A.NAMEID = B.NAMEID) DDD "+
				" WHERE AAA.sport_id = BBB.SPORT_ID  AND AAA.region_id = CCC.REGION_ID AND AAA.compet_id = DDD.COMPET_ID ";
		

		  try{	      	
			 	con = ds.getConnection();			 
			 	pstmt = con.prepareStatement(query1);	        
		        rs = pstmt.executeQuery();
		        
		        while(rs.next()){
		        			        
		        	BetSelList bsl = new BetSelList();
		        
		        	
		        	bsl.setBgid(rs.getString("bgid")); 
		        	bsl.setSelId(rs.getString("sel_id")); 
		        	bsl.setBresult(rs.getString("bsresult"));	
		        	bsl.setSelName(rs.getString("sel_name"));
		        	bsl.setSelPrice(rs.getString("sel_price"));		
		        	bsl.setMkid(rs.getString("market_id"));		
		        	bsl.setMkName(rs.getString("market_name"));		
		        	bsl.setMid(rs.getString("match_id"));		        	
		        	//bsl.setMName(rs.getString("SNAME"));	
		        	bsl.setCid(rs.getString("compet_id"));		   
		        	bsl.setCName(rs.getString("CNAME"));			        	
		        	bsl.setSid(rs.getString("sport_id"));	
		        	bsl.setSName(rs.getString("SNAME"));		        	
		        	bsl.setRid(rs.getString("region_id"));
		        	bsl.setRName(rs.getString("RNAME"));
		        	bsl.setMDt(rs.getString("match_date"));		        	
		        	bsl.setHt(rs.getString("home_name"));		        	
		        	bsl.setAt(rs.getString("away_name"));		        	
		          	
		        	bs.add(bsl); 
		        }				  	
	
		        rs.close();
		        pstmt.close();		        
		        con.close();
		        
	        
		  	}catch(Exception e){
			  //Debug.out("[getSelectionList] : " + e.getMessage());
		
		    }finally{
		   	  if(rs!=null) rs.close();
		   	  if(pstmt!=null)  pstmt.close();
		   	  if(con!=null) con.close();
		  	}
	  
		  return bs;
	}
	




	public List<BettingListBean_SC> getBetList_SC(String mid) throws SQLException{
		
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  
		  List<BettingListBean_SC> bl_sc = new ArrayList<BettingListBean_SC>();


		 String query1 = " select scid, siteid, userid, job, token, money, convert(char(19),regdate,120) regdate from spincube_lst where viewtype='Y' and userid='"+mid+"'  order by regdate desc ";
		  
		  try{	      	
			 				 	
		 	con = ds.getConnection();		 	
		 	
		 	pstmt = con.prepareStatement(query1);				 	
	        rs = pstmt.executeQuery();	
		     		        
	      	while(rs.next()){

		      	BettingListBean_SC blb_sc = new BettingListBean_SC();
			        
		      	blb_sc.setBgid(rs.getString("scid"));
		      	blb_sc.setBmoney(rs.getString("money"));
		      	blb_sc.setJob(rs.getString("job"));
		      	blb_sc.setRegdt(rs.getString("regdate"));
			        	
		      	bl_sc.add(blb_sc); 
		    }		
	
		        
	      	rs.close();
	      	pstmt.close();
		    con.close();

		  }catch(Exception e){
			  //Debug.out("[getBetList_SC] : " + e.getMessage());
		
	    }finally{
	   	  if(rs!=null) rs.close();	     	 
	   	  if(pstmt!=null)  pstmt.close();
	   	  if(con!=null) con.close();
	  	}
		  
	return bl_sc;
		
	}

	public List<BettingListBean_SC> getBetList_MG(String mid) throws SQLException{
		
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  
		  List<BettingListBean_SC> bl_sc = new ArrayList<BettingListBean_SC>();


		 String query1 = " select mgid, siteid, userid, job, money, convert(char(19),regdate,120) regdate from micro_game where viewtype='Y' and userid='"+mid+"'  order by regdate desc ";
		  
		  try{	      	
			 				 	
		 	con = ds.getConnection();		 	
		 	
		 	pstmt = con.prepareStatement(query1);				 	
	        rs = pstmt.executeQuery();	
		     		        
	      	while(rs.next()){

		      	BettingListBean_SC blb_sc = new BettingListBean_SC();
			        
		      	blb_sc.setBgid(rs.getString("mgid"));
		      	blb_sc.setBmoney(rs.getString("money"));
		      	blb_sc.setJob(rs.getString("job"));
		      	blb_sc.setRegdt(rs.getString("regdate"));
			        	
		      	bl_sc.add(blb_sc); 
		    }		
	
		        
	      	rs.close();
	      	pstmt.close();
		    con.close();

		  }catch(Exception e){
			  //Debug.out("[getBetList_SC] : " + e.getMessage());
		
	    }finally{
	   	  if(rs!=null) rs.close();	     	 
	   	  if(pstmt!=null)  pstmt.close();
	   	  if(con!=null) con.close();
	  	}
		  
	return bl_sc;
		
	}
	
	

	public List<BettingListBean_SC> getBetList_AG(String mid) throws SQLException{
		
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  
		  List<BettingListBean_SC> bl_sc = new ArrayList<BettingListBean_SC>();

		  String query1 = " select agid, siteid, userid, transactiontype, value,netamount,validbetamount, convert(char(19),bettime,120) bettime from asiagame_lst where viewtype='Y' and userid='matthew'  order by bettime desc ";

		  try{	      	
			 				 	
		 	con = ds.getConnection();		 	
		 	
		 	pstmt = con.prepareStatement(query1);				 	
	        rs = pstmt.executeQuery();	
		     		        
	      	while(rs.next()){

		      	BettingListBean_SC blb_sc = new BettingListBean_SC();
			        
		      	blb_sc.setBgid(rs.getString("agid"));
		      	blb_sc.setBmoney(rs.getString("value"));
		      	blb_sc.setRmoney(rs.getString("netamount"));
		      	blb_sc.setJob(rs.getString("transactiontype"));
		      	blb_sc.setRegdt(rs.getString("bettime"));
			        	
		      	bl_sc.add(blb_sc); 
		    }		
	
		        
	      	rs.close();
	      	pstmt.close();
		    con.close();

		  }catch(Exception e){
			  //Debug.out("[getBetList_SC] : " + e.getMessage());
		
	    }finally{
	   	  if(rs!=null) rs.close();	     	 
	   	  if(pstmt!=null)  pstmt.close();
	   	  if(con!=null) con.close();
	  	}
		  
	return bl_sc;
		
	}
	
	public  List<MatchSearchResultBean> getSearchMatch(String key) throws SQLException{
		
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		 // StringBuffer sb = new StringBuffer(""); 
		  String query1 ="";
		  
		  //HashMap<String, Object> mr = new HashMap<String, Object>();
		  //Vector mr = new Vector();
		  
		  List<MatchSearchResultBean> msr = new ArrayList<MatchSearchResultBean>();
		  
		  
		  query1 ="  SELECT match_id,convert(char(16),MATCH_DATE,120) match_date,A.sport_id,live,home_name, away_name, SNAME,RNAME,CNAME FROM bc_match A , " +
				  " (SELECT SPORT_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE SPORT_NAME END  AS SNAME " +
				  " FROM bc_sport A LEFT OUTER JOIN BC_TRANS B ON A.SPORT_NAMEID = B.NAMEID) B,	" +					
				  " (SELECT REGION_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE REGION_NAME END AS RNAME " +
				  " FROM  BC_REGION A LEFT OUTER JOIN BC_TRANS B ON A.REGION_NAMEID = B.NAMEID) C,	" +					
				  " (SELECT COMPET_ID,CASE WHEN LEN(TXT) > 0 THEN TXT ELSE COMPET_NAME END AS CNAME " +
				  " FROM BC_COMPETITION A LEFT OUTER JOIN BC_TRANS B ON A.NAMEID = B.NAMEID) D 	" +					
				  " WHERE A.sport_id = B.SPORT_ID  AND A.region_id = C.REGION_ID AND A.compet_id = D.COMPET_ID " +
				  " AND ((MATCH_STAT ='0' AND MATCH_DATE > GETDATE()) OR (LIVE_STAT ='1' AND MATCH_STAT ='1')) AND a.visible='T'  AND a.booked='T' and A.home_name is not null and A.away_name is not null " +
				  " AND (A.home_name LIKE '%"+key+"%' OR A.away_name LIKE '%"+key+"%') " +
				  //" --AND MATCH_DATE > GETDATE() " +
				  "  ORDER BY MATCH_DATE ";
	 
		  	//Debug.out("[getSearchMatch] : " + query1);
	  
		
		  try{	      	
			 	con = ds.getConnection();			 
			 	pstmt = con.prepareStatement(query1);	        
		        rs = pstmt.executeQuery();
		        
		        while(rs.next()){
		        			        
		        	MatchSearchResultBean msrb = new MatchSearchResultBean();
		        
		        	msrb.setMdate(rs.getString("match_date"));
		        	msrb.setMid(rs.getString("match_id"));
		        	msrb.setSid(rs.getString("sport_id"));
		        	msrb.setSname(rs.getString("SNAME"));
		        	msrb.setRname(rs.getString("RNAME"));
		        	msrb.setCname(rs.getString("CNAME"));
		        	msrb.setHteam(rs.getString("home_name"));
		        	msrb.setAteam(rs.getString("away_name"));
		        	msrb.setLstat(rs.getString("live"));
		       
		        	msr.add(msrb); 
		        }				  	
	
		        rs.close();
		        pstmt.close();		        
		        con.close();
		        
	        
		  	}catch(Exception e){
			  //Debug.out("[getSearchMatch] : " + e.getMessage());
		
		    }finally{
		   	  if(rs!=null) rs.close();
		   	  if(pstmt!=null)  pstmt.close();
		   	  if(con!=null) con.close();
		  	}
	  
		  return msr;
	
	}
	
	public  String getMaxBetAmt(String sid,String uid,String sel) throws SQLException{
		
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  String amt ="0";

		  String query1 ="select top 1 dbo.fnMaxBet(?,?,?) amt from bc_sport ";
		  String query2 ="select top 1 dbo.fnMaxBet("+sel+","+sid+","+uid+") amt from bc_sport ";

		  //Debug.out("[getMaxBetAmt] : " + query2);
		  //Debug.out("[sel] : " + sel);
	  		
		  try{	      	
				con = ds.getConnection();			 
			 	pstmt = con.prepareStatement(query1);				 	
			 	pstmt.setString(1,sel);
			 	pstmt.setString(2,sid);
			 	pstmt.setString(3,uid);
			 	
		        rs = pstmt.executeQuery();
		        
		        if(rs.next()){     
		        	amt = rs.getString("amt");
		        }				  	
	
		        rs.close();
		        pstmt.close();		        
		        con.close();
		        
	        
		  	}catch(Exception e){
			  //Debug.out("[getMaxBetAmt] : " + e.getMessage());
		
		    }finally{
		   	  if(rs!=null) rs.close();
		   	  if(pstmt!=null)  pstmt.close();
		   	  if(con!=null) con.close();
		  	}
	  
		  return amt;
	
	}
	

	public String setBet(String sid,String uid,String sel) throws SQLException{
		
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  String amt ="0";

		  String query1 ="select top 1 dbo.fnMaxBet(?,?,?) amt from bc_sport ";
		  String query2 ="select top 1 dbo.fnMaxBet("+sel+","+sid+","+uid+") amt from bc_sport ";

		  //Debug.out("[getMaxBetAmt] : " + query2);
		  //Debug.out("[sel] : " + sel);
	  		
		  try{	      	
				con = ds.getConnection();			 
			 	pstmt = con.prepareStatement(query1);				 	
			 	pstmt.setString(1,sel);
			 	pstmt.setString(2,sid);
			 	pstmt.setString(3,uid);
			 	
		        rs = pstmt.executeQuery();
		        
		        if(rs.next()){     
		        	amt = rs.getString("amt");
		        }				  	
	
		        rs.close();
		        pstmt.close();		        
		        con.close();
		        
	        
		  	}catch(Exception e){
			  //Debug.out("[getMaxBetAmt] : " + e.getMessage());
		
		    }finally{
		   	  if(rs!=null) rs.close();
		   	  if(pstmt!=null)  pstmt.close();
		   	  if(con!=null) con.close();
		  	}
	  
		  return amt;
	
	}
	
	public String setMultiBet(String sid,String uid,String sel,String amt, String ips) throws SQLException{
		
		  Connection con = null;
		  String result ="0";
		  
		  //Debug.out("[setMultiBet] : " + sel);
		  //Debug.out("[setMultiBet] : " + amt);
	  		
		  try{	      	
				con = ds.getConnection();	
				
				CallableStatement cs = con.prepareCall("{call SetBetMulti(?,?,?,?,?,?)}");
				cs.registerOutParameter(1, java.sql.Types.LONGNVARCHAR);
			    cs.setString(2,sid);
			    cs.setString(3,uid);
			    cs.setString(4,sel);
			    cs.setString(5,ips);
			    cs.setString(6,amt);			   
			    cs.execute();
			    
			    result = (String) cs.getObject(1);	
			    
		        con.close();
	        
		  	}catch(Exception e){
			  //Debug.out("[setMultiBet] : " + e.getMessage());
			  result = "-1";
		
		    }finally{
		   	  if(con!=null) con.close();
		  	}
	  
		  return result;
	
	}
	
	public String setSingleBet(String sid,String uid,String sel,String selamt, String ips) throws SQLException{
		
		  Connection con = null;
		  String result ="0";
		  
		  //Debug.out("[setSingleBet] : " + sel);
		  //Debug.out("[setSingleBet] : " + selamt);
	  		
		  try{	      	
				con = ds.getConnection();	

				CallableStatement cs = con.prepareCall("{call SetBetSingle(?,?,?,?,?,?)}");
				
				cs.registerOutParameter(1, java.sql.Types.LONGNVARCHAR);
			    cs.setString(2,sid);
			    cs.setString(3,uid);
			    cs.setString(4,sel);
			    cs.setString(5,selamt);
			    cs.setString(6,ips);
			    cs.execute();
			    
		        result = (String) cs.getObject(1);		
		        
		        con.close();
		        
		  	}catch(Exception e){
			  //Debug.out("[setSingleBet] : " + e.getMessage());
			  result = "-1";
		
		    }finally{
		   	  if(con!=null) con.close();
		  	}
	  
		  return result;
	
	}
	
	
	public String getUserBalance(String sid,String uid) throws SQLException{
		
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  String bal ="0";
	
		  String query1 ="select money from user_mst where userid='"+uid+"'and siteid='"+sid+"' ";

		  //Debug.out("[getUserBalance] : " + query1);

		  try{	      	
				con = ds.getConnection();			 
			 	pstmt = con.prepareStatement(query1);				 				 	
		        rs = pstmt.executeQuery();
		        
		        if(rs.next()){     
		        	bal = rs.getString("money");
		        }				  	
	
		        rs.close();
		        pstmt.close();		        
		        con.close();
		        
	        
		  	}catch(Exception e){
			  //Debug.out("[getMaxBetAmt] : " + e.getMessage());
		
		    }finally{
		   	  if(rs!=null) rs.close();
		   	  if(pstmt!=null)  pstmt.close();
		   	  if(con!=null) con.close();
		  	}
	  
		  return bal;
	
	}
	
	public List<CartSelList> getCart(String selid) throws SQLException{
		
		  Connection con = null;
		  PreparedStatement pstmt = null;
		  ResultSet rs = null;
		  //String bal ="0";
		  
		  String selids = selid.substring(0,selid.length()-1);
		  
		  String query1 ="select a.sel_id Sd,a.sel_price P,b.suspend susK, b.visible viK,c.suspend susM,c.visible viM,c.booked bookM, c.live_stat statL,c.match_stat statM,c.live live  "+
					" from bc_selection a, bc_market b,  bc_match c "+
					" where a.market_id = b.market_id and b.match_id = c.match_id "+
					" and a.sel_id in ("+selids+")";

		  //Debug.out("[getCart] : " + query1);
		  
		  List<CartSelList> csl = new ArrayList<CartSelList>();
		  
		  try{	      	
				con = ds.getConnection();			 
			 	pstmt = con.prepareStatement(query1);				 				 	
		        rs = pstmt.executeQuery();
		        
		        while(rs.next()){     
		        	
		        	CartSelList cs = new CartSelList();
		        	
		        	cs.setSelid(rs.getString("Sd"));
		        	cs.setSelprice(rs.getString("P"));
		        	cs.setKsus(rs.getString("susK"));
		        	cs.setKvis(rs.getString("viK"));
		        	cs.setMsus(rs.getString("susM"));
		        	cs.setMvis(rs.getString("viM"));
		        	cs.setMbook(rs.getString("bookM"));
		        	cs.setLstat(rs.getString("statL"));
		        	cs.setMstat(rs.getString("statM"));
		        	cs.setLive(rs.getString("live"));
		        	
		        	csl.add(cs); 

		        }

		        rs.close();
		        pstmt.close();		        
		        con.close();
		        
	        
		  	}catch(Exception e){
			  //Debug.out("[getCart] : " + e.getMessage());
		
		    }finally{
		   	  if(rs!=null) rs.close();
		   	  if(pstmt!=null)  pstmt.close();
		   	  if(con!=null) con.close();
		  	}
	  
		  return csl;
	
	}
}


