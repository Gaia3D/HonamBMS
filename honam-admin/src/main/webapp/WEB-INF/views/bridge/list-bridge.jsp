<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>교량 목록 | Honam-BMS</title>
	<link rel="stylesheet" href="/css/${lang}/style.css">
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css">
	<link rel="stylesheet" href="/externlib/cesium-1.59/Widgets/widgets.css?cache_version=${cache_version}" /> 
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
	<script type="text/javascript" src="/externlib/jquery-3.4.1/jquery.js"></script>
	<script type="text/javascript" src="/externlib/cesium-1.59/Cesium.js"></script>
	<style>
		.mapWrap {
			min-width: 1420px;
			padding-left: 391px;
			height:100%;
		}
	</style>
</head>

<body>
<%@ include file="/WEB-INF/views/layouts/header.jsp" %>

<div id="wrap" style="height:94.7%; width: 100%;">
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	
	<!-- S: 1depth / 프로젝트 목록 -->
	<div id= "leftMenuArea" class="subWrap">
		<!-- S: 프로젝트 제목, 목록가기, 닫기 -->
		<div class="subHeader">
			<h2>교량 목록 </h2>
			<div id="menuCloseButton" class="ctrlBtn">
				<button type="button" title="닫기" class="close">닫기</button>
			</div>
		</div>
		<!-- E: 프로젝트 제목, 목록가기, 닫기 -->
				
		<div class="subContents">
			<form:form id="searchForm" modelAttribute="bridge" method="post" action="/bridge/list-bridge" onsubmit="return searchCheck();">
				<ul class="projectSearch input-group row">
					<li class="input-set">
						<label for="search_word">교량 명</label>
						<form:input path="searchValue" type="search" size="25" cssClass="m" />
						<form:hidden path="searchWord" value="brg" />
						<form:hidden path="searchOption" value="1" />
					</li>
					<li class="input-set">
						<label>주소</label>
						<select id="sdoList" name="sdoList" class="select" style="width: 97px;">
							<option value>시도</option>
						</select>
						<select id="sggList" name="sggList" class="select" style="width: 85px;">
							<option value>시군구</option>
						</select>					
					</li>
					<li class="input-set">
						<label>관리주체</label>
						<select id="aaa" name="sdolist" class="select" style="width: 187px;">
							<option>전라남도</option>	
						</select>				
					</li>
					<li class="input-set btn">
						<button type="submit" value="search" class="point" id="search">검색</button>
					</li>
				</ul>
			</form:form>
			
			
			<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
		</div>
		<!-- E: 영상목록 -->
	</div>
	<!-- E: 1depth / 프로젝트 목록 -->
	<div id="MapContainer" class="mapWrap">
	</div>
	<!-- E: MAPWRAP -->
</div>
<!-- E: wrap -->
	
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/honam-bms.js"></script>
<script type="text/javascript" src="/js/geospatial.js"></script>
<script type="text/javascript" src="/js/DistrictControll.js"></script>
<script type="text/javascript">
	// 초기 위치 설정
	var INIT_WEST = 126.0;
	var INIT_SOUTH = 32.0;
	var INIT_EAST = 130.0;
	var INIT_NORTH = 39.0;
	var rectangle = Cesium.Rectangle.fromDegrees(INIT_WEST, INIT_SOUTH, INIT_EAST, INIT_NORTH);
	Cesium.Camera.DEFAULT_VIEW_FACTOR = 1;
	Cesium.Camera.DEFAULT_VIEW_RECTANGLE = rectangle;
	var worldTerrain = Cesium.createWorldTerrain({
	    requestWaterMask: false,
	    requestVertexNormals: true
	});		
	        
   	Cesium.Ion.defaultAccesToken = '${cesiumIonToken}';
   	var viewer = new Cesium.Viewer('MapContainer', {imageryProvider : imageryProvider, baseLayerPicker : true, animation:false, timeline:false, fullscreenButton:false, terrainProvider : worldTerrain});
   	viewer.scene.globe.depthTestAgainstTerrain = false;
    
	DistrictControll(viewer);
    var bridgeGroupLayers = viewer.imageryLayers;
	bridgeGroupLayers.addImageryProvider(new Cesium.WebMapServiceImageryProvider({
	    url : 'http://localhost:8080/geoserver/honambms/wms',
	    layers : 'honambms:BridgeGroup',
	    parameters : {
			service : 'WMS'
				,version : '1.3.0'
				,request : 'GetMap'
				,transparent : 'true'
				,tiled : 'true'
				,format : 'image/png'
	    }
		//,proxy: new Cesium.DefaultProxy('/proxy/')
		,enablePickFeatures: false
	}));
	
	// TODO: policy에 추가
	var INTERVAL_TIME = 5000; 
	$(document).ready(function() {
		$("#projectMenu").addClass("on");

	});

    
</script>
</body>
</html>
