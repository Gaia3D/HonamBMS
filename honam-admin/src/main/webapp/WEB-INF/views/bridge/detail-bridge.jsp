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
	<link rel="stylesheet" href="/externlib/cesium-1.59/Widgets/widgets.css?cache_version=${cache_version}" /> 
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
	<script type="text/javascript" src="/externlib/jquery-3.4.1/jquery.js"></script>
	<script type="text/javascript" src="/externlib/cesium-1.59/Cesium.js"></script>
	<script type="text/javascript" src="/externlib/jquery-3.4.1/fixedheadertable.js"></script>
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
	<div id="leftMenuArea" class="subWrap">
		<!-- S: 프로젝트 제목, 목록가기, 닫기 -->
		<div class="subHeader">
			<h2>${bridge.brg_nam}</h2>
			<div class="ctrlBtn">
				<a href="/bridge/list-bridge?${searchParameters}" style="padding-top:3px; font-size:13px; color: #fff;">목록 보기</a>
			</div>
		</div>
		<!-- E: 프로젝트 제목, 목록가기, 닫기 -->
		
		<!-- S: 프로젝트 정보 -->

		<!-- E: 프로젝트 정보 -->
				
		<div class="subContents">
		</div>
	</div>
	<!-- E: 1depth / 프로젝트 목록 -->
	
	<div id="MapContainer" class="mapWrap">
	
	</div>
	
	<!-- E: MAPWRAP -->
</div>
<!-- E: wrap -->
	
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/Honam-BMS.js"></script>
<script type="text/javascript" src="/js/Geospatial.js"></script>
<script type="text/javascript">
	// TODO 데이터가 없을때 layer 예외 처리도 해야 함
	
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
	

  	$(document).ready(function() {
		$("#projectMenu").addClass("on");
		getCentroidBridge("${bridge.gid}","${bridge.brg_nam}","${bridge.bridge_grade}")
	});
  	
  	function getCentroidBridge(gid, name, grade) {
		var url = "./" + gid + "/centroid"; 
		var cnt = null;

	  $.ajax({
	      url: url,
	      type: "GET",
	      dataType: "json",
	      success : function(msg) {
	          if(msg.result === "success") {
	        	  cameraFlyTo(msg.longitude,  msg.latitude, 500, 3);
	        	  addMarkerBillboards(name, msg.longitude,  msg.latitude, grade)
	          }
	      },
	      error : function(request, status, error) {
	          //alert(JS_MESSAGE["ajax.error.message"]);
	          console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
	      }
	  });
	}
  	
	function addMarkerBillboards(bridgeName, longitude, latitude, bridgeGrade) {
		var markerImage = null; 
		if(bridgeGrade == 'A'){
			markerImage = '/images/${lang}/A.png';
		} else if(bridgeGrade == 'B') {
			markerImage = '/images/${lang}/B.png';
		} else if(bridgeGrade == 'C') {
			markerImage = '/images/${lang}/C.png';
		} else if(bridgeGrade == 'D') {
			markerImage = '/images/${lang}/D.png';
		} else if(bridgeGrade == 'E') {
			markerImage = '/images/${lang}/E.png';
		} else {
			markerImage = '/images/${lang}/X.png';
		}
			
		viewer.entities.add({
			name : bridgeName,
	        position : Cesium.Cartesian3.fromDegrees(parseFloat(longitude), parseFloat(latitude), 40),
	        billboard : {
	            image : markerImage,
	            width : 25, // default: undefined
	            height : 25, // default: undefined
	            disableDepthTestDistance : Number.POSITIVE_INFINITY
	            /* image : '../images/Cesium_Logo_overlay.png', // default: undefined
	            show : true, // default
	            pixelOffset : new Cesium.Cartesian2(0, -50), // default: (0, 0)
	            eyeOffset : new Cesium.Cartesian3(0.0, 0.0, 0.0), // default
	            horizontalOrigin : Cesium.HorizontalOrigin.CENTER, // default
	            verticalOrigin : Cesium.VerticalOrigin.BOTTOM, // default: CENTER
	            scale : 2.0, // default: 1.0
	            color : Cesium.Color.LIME, // default: WHITE
	            rotation : Cesium.Math.PI_OVER_FOUR, // default: 0.0
	            alignedAxis : Cesium.Cartesian3.ZERO, // default
	            width : 100, // default: undefined
	            height : 25 // default: undefined */
	        }
	    });
	}
  	
</script>
</body>
</html>
