<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<%@page import="bean.*"%>
<%@page import="dao.*"%>
<%@ page import="bc4.BetConManager2" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import ="java.util.HashMap" %>
<%@ include file="/inc/session.jsp"%>


<%
	Gson gson = new Gson();
	BetConManager2 bm = new BetConManager2();
	List<BettingListBean> bl = bm.getBetList(SITEID,UID);
	List<BettingSName> bs = bm.getBetSNames(SITEID,UID);
	
	ArrayList<Object> ar = new ArrayList<Object>();
	HashMap<String, Object> hsm = new HashMap<String, Object>();
	
	for (int k=0; k < bl.size() ; k++){
		String fn = "다폴더";
		String etc = " 외";
		String fullsname = "";
	    BettingListBean blb = (BettingListBean) bl.get(k);

		if(blb.getScnt().equals("1")){
			fn = "싱글";
			etc = "";
		}
		
		String sname="";
		for (int i = 0; i < bs.size(); i++){		
		
			BettingSName bsn = bs.get(i);			
			boolean chk = false;
						
			if(bsn.getBgid().equals(blb.getBgid())){	
					
					
				sname = bsn.getSNames();
				fullsname = fullsname+" "+sname;
					
			}
		}
		sname = sname + etc;
		blb.setSname(sname);
		blb.setFullsname(fullsname);
		blb.setFn(fn);
		blb.setBmoney(dfrmt.format(Integer.parseInt(bl.get(k).getBmoney())));
		blb.setEmoney(dfrmt.format(Integer.parseInt(bl.get(k).getEmoney())));
		
		ar.add(blb);
		
	}
	
	out.println(gson.toJson(ar).toString());
%>




