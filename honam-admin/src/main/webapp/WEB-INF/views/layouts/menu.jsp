<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="nav">
	<ul>
		<!-- <li class="menu" title="메뉴"><span>메뉴</span></li> -->
		<li id="bridgeMenu" class="bridge" title="교량" onclick="goPage('/bridge/list-bridge');"><span>교량</span></li>
		<li id="bridgegroupMenu" class="bridgegroup" title="교량그룹" onclick="goPage('/bridgegroup/list-bridgegroup');"><span>교량 그룹</span></li>
		<li id="configMenu" class="setup" title="환경설정" onclick="goPage('/config/modify-policy');"><span>환경설정</span></li>
	</ul>
</div>