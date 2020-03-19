<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@page import="honam.domain.Key"%>
<%@page import="honam.domain.UserSession"%>

<div id="header">
	<h1><span>호남지역 중소교량의 멀티스케일 Mock-Up 시스템</span></h1>

	<ul class="gnb">
		<li>
			도움말
		</li>
		<li>
<%
	UserSession userSession = (UserSession) request.getSession().getAttribute(Key.USER_SESSION.name());
	if (userSession != null && userSession.getUserId() != null && !"".equals(userSession.getUserId())) {
%>		
			<a href="/sign/signout" title="Sign out">Sign out</a>
<% 
	} else { %>
			<a href="/sign/signin">Sign in</a>
<% 
	} %>
		</li>
	</ul>
</div>
