<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="honam.domain.CacheManager"%>
<%@page import="honam.domain.UserSession"%>

<div id="header">
	<h1><span>호남지역 중소교량의 멀티스케일 Mock-Up 시스템</span></h1>

	<ul class="gnb">
		<li>
			도움말
		</li>
		<li>
<%
	UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
	if(userSession != null && userSession.getUser_id() != null && !"".equals(userSession.getUser_id())) {
%>		
			<a href="/login/logout" style="color: #fff;">로그 아웃</a>
<% } else { %>
			<a href="/login/login" style="color: #fff;">로그인</a>
<% } %>
		</li>
	</ul>
</div>
