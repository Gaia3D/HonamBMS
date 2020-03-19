<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>
<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>교량 상세 | Honam-BMS</title>
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="/css/${lang}/style.css">
	<link rel="stylesheet" href="/css/${lang}/honam-bms.css">
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css">
	<link rel="stylesheet" href="/externlib/cesium/Widgets/widgets.css?cache_version=${cache_version}" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
	<link rel="stylesheet" href="/externlib/geostats/geostats.css">
	<style type="text/css">
	.transferDataList {
		position:relative;
		width:calc(100% - 50px);
		float:left;
		max-height: 300px;
    	overflow-y: auto;
	}
	.heading-wrapper {
		float:left;
		padding: 10px;
	}
	.heading-wrapper h2 {

		padding: 10px;
	}
	</style>
</head>
<body>
<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
<div id="wrap" style="height:calc(100% - 50px); width:100%;">
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	<div class="heading-wrapper">
		<h2>교량 등록</h2>
	</div>
	<div id="MapContainer" style="float:left; height:50%; margin: 0 0 20px 20px; width:calc(100% - 150px);"></div>
	<!-- S: 교량 목록 -->
	<div class="transferDataList">
		<table class="list-table scope-col">
			<col class="col-number" />
			<col class="col-toggle" />
			<col class="col-name" />
			<thead>
				<tr>
					<th scope="col" class="col-number" style="width:5%; font-weight: bold"></th>
					<th scope="col" class="col-toggle">교량 명</th>
					<th scope="col" class="col-name">준공년도</th>
					<th scope="col" class="col-name">상태</th>
				</tr>
			</thead>
			<tbody id="transferDataList">
			<c:forEach var="bridge" items="${bridgeList}" varStatus="status">
				<tr>
					<td class="col-number">${status.index+1}</td>
					<td class="col-toggle">
						<a href="/bridge/detail-bridge?gid=${bridge.gid}&pageNo=${pagination.pageNo}${pagination.searchParameters}">
							${bridge.brgNam}
						</a>
					</td>
					<td class="col-name">${bridge.endAmd.substring(0,4)} </td>
					<td class="col-name">${bridge.grade}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
	</div>
	<!-- E: 교량 목록 -->
</div>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/externlib/ajax-cross-origin/jquery.ajax-cross-origin.min.js"></script>
<script type="text/javascript" src="/externlib/cesium/Cesium.js"></script>
<script type="text/javascript" src="/externlib/mago3d/mago3d.js"></script>
<script type="text/javascript" src="/externlib/mago3d/init.js"></script>

<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/Honam-bms.js"></script>
<script type="text/javascript" src="/js/Geospatial.js"></script>
<script type="text/javascript" src="/js/NumberFormatter.js"></script>
<script type="text/javascript" src="/js/BridgeAttribute.js"></script>
<script type="text/javascript" src="/js/MapControll.js"></script>
<script type="text/javascript" src="/js/MouseControll.js"></script>
<script type="text/javascript" src="/js/SatAnalysisResult.js"></script>
<script type="text/javascript" src="/js/SensorData.js"></script>

<script type="text/javascript">
//초기 위치 설정
var INIT_WEST = 124.67;
var INIT_SOUTH = 35.72;
var INIT_EAST = 128.46;
var INIT_NORTH = 33.77;
var rectangle = Cesium.Rectangle.fromDegrees(INIT_WEST, INIT_SOUTH, INIT_EAST, INIT_NORTH);
Cesium.Camera.DEFAULT_VIEW_FACTOR = 0;
Cesium.Camera.DEFAULT_VIEW_RECTANGLE = rectangle;

var viewer = new Cesium.Viewer('MapContainer', {imageryProvider : imageryProvider, baseLayerPicker : false,
	animation:false, timeline:false, geocoder:false, navigationHelpButton: false, fullscreenButton:false, homeButton: false, sceneModePicker: false });
//viewer.extend(Cesium.viewerCesiumNavigationMixin, {});
var satValueCount = null;

</script>

</body>
</html>