<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import = "dao.GameDao"%>
<%@ page import = "bean.GameBean"%>
<%@ page import = "bean.GameMenuBean"%>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.*" %>


<%

	GameDao game_dao = new GameDao();
	Gson gson = new Gson();
	String game_provider = request.getParameter("gp");
	GameMenuBean gmb = game_dao.getGameByProvider(Integer.parseInt(game_provider));
	out.println(gson.toJson(gmb).toString());


%>
