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
	List<BettingListBean_SC> bl_ag = bm.getBetList_AG(SITEID,UID);
	
	ArrayList<Object> ar = new ArrayList<Object>();
	
	for (int n=0; n < bl_ag.size() ; n++){
		BettingListBean_SC blb_ag = (BettingListBean_SC) bl_ag.get(n);	
		blb_ag.setBmoney(dfrmt.format(Integer.parseInt(blb_ag.getBmoney())));
		blb_ag.setRmoney(dfrmt.format(Integer.parseInt(blb_ag.getRmoney())));
		ar.add(blb_ag);
	}

	out.println(gson.toJson(ar).toString());
%>


