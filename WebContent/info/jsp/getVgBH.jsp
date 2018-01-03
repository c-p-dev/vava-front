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
	List<BettingListBean_SC> bl_sc = bm.getBetList_SC(SITEID,UID);
	
	ArrayList<Object> ar = new ArrayList<Object>();
	
	for (int j=0; j < bl_sc.size() ; j++){
		BettingListBean_SC blb_sc = (BettingListBean_SC) bl_sc.get(j);	
		blb_sc.setBmoney(dfrmt.format(Integer.parseInt(blb_sc.getBmoney())));
		ar.add(blb_sc);
	}

	out.println(gson.toJson(ar).toString());
%>


