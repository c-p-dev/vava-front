<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" />
<jsp:useBean id="bean" class="net.vavasoft.bean.UserBean" />
<%@page import="net.vavasoft.dao.GameDao, net.vavasoft.bean.GameBean, java.util.*"%>

<%
	boolean checkSession = false;
	// UserBean currentUser = (UserBean) session.getAttribute("currentSessionUser");
	bean = (net.vavasoft.bean.UserBean) session.getAttribute("currentSessionUser");
	if(session.getAttribute("currentSessionUser") != null){
		checkSession = true;
		out.print(bean.getNick());  
	}
	
	GameDao game_dao			= new GameDao();
	List<GameBean> game_list	= game_dao.getRacingGames();
%>

<div id="contents_wrap">
	<div class="contents">
		
	</div>
</div>

<jsp:include page="../footer.jsp" />