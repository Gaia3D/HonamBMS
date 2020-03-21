<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>
<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>환경설정 | Honam-BMS</title>
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="/css/${lang}/style.css">
	<link rel="stylesheet" href="/css/${lang}/honam-bms.css">
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css">
	<link rel="stylesheet" href="/externlib/cesium/Widgets/widgets.css?cache_version=${cache_version}" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
	<link rel="stylesheet" href="/externlib/geostats/geostats.css">
</head>
<body>
<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
<div class="wrapper">
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	<div class="contents-wrapper">
		<nav class="manage-tab">
			<ul>
				<li><a href="/bridge/manage-bridge">교량 관리</a></li>
				<li><a href="/bridge/input-bridge">교량 등록</a></li>
			</ul>
		</nav>
		<div class="list-wrapper">
			<form id="policyForm">
			</form>
		</div>
	</div>
</div>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/externlib/ajax-cross-origin/jquery.ajax-cross-origin.min.js"></script>
<script type="text/javascript" src="/externlib/cesium/Cesium.js"></script>
<script type="text/javascript" src="/externlib/mago3d/mago3d.js"></script>
<script type="text/javascript" src="/externlib/mago3d/init.js"></script>

<script type="text/javascript" src="/js/${lang}/common.js"></script>

<script type="text/javascript">

</script>

</body>
</html>