<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "dao.UserDao"%>
<%@ page import = "dao.MessageDao"%>
<%@ page import = "bean.MessageBean"%>

<%@ page import = "com.google.gson.Gson" %>
<%@ page import ="java.util.HashMap" %>

<%@ include file="/inc/session.jsp"%>


<%
    
    if(checkSession){
        MessageDao mDao = new MessageDao();
        MessageBean mBean = new MessageBean();

        mBean.setRecv_userid(UID);
        mBean.setSend_siteid(Integer.parseInt(SITEID));

        int count = mDao.countMsg(mBean);

        Gson gson = new Gson();
        HashMap<String, Object> hsm = new HashMap<String, Object>();
        
        hsm.put("count",count);
        out.println(gson.toJson(hsm).toString());
    }
   
	
%>