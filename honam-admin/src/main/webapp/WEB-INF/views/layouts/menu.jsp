<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav id="nav">
	<ul>
		<li id="bridgeMenu" class="bridge" title="교량"><a href="/bridge/list-bridge">교량</a></li>
		<li id="bridgegroupMenu" class="schedule" title="교량그룹" onclick="goPage('/bridge-groups');"></li>
		<li id="bridgeManageMenu" class="bridge" title="교량관리"><a href="/bridge/manage-bridge">교량관리</a></li>
		<li id="configMenu" class="setup" title="환경설정"><a href="/config/modify-policy">환경설정</a></li>
	</ul>
</nav>