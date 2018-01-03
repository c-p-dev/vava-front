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
	List<BettingListBean_SC> bl_mg = bm.getBetList_MG(SITEID,UID);
	
	ArrayList<Object> ar = new ArrayList<Object>();
	
	for (int m=0; m < bl_mg.size() ; m++){
		BettingListBean_SC blb_mg = (BettingListBean_SC) bl_mg.get(m);		
		blb_mg.setBmoney(dfrmt.format(Integer.parseInt(blb_mg.getBmoney())));
		ar.add(blb_mg);
	}

	out.println(gson.toJson(ar).toString());
%>


