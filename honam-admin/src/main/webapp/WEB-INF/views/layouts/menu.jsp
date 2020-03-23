<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav id="nav">
	<ul>
		<li id="bridgeMenu" class="bridge" title="교량" onclick="goPage('/bridge/list-bridge', this);"></li>
		<li id="bridgegroupMenu" class="schedule" title="교량그룹" onclick="goPage('/bridge/bridge-groups', this);"></li>
		<li id="bridgeManageMenu" class="device" title="교량관리" onclick="goPage('/bridge/manage-bridge', this);"></li>
		<!-- <li id="userMenu" class="log" title="사용자" onclick="goPage('/user/list', this);"></li> -->
		<li id="configMenu" class="setup" title="환경설정" onclick="goPage('/policy', this);"></li>
	</ul>
</nav>