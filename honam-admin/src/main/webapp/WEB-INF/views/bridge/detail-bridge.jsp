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
			height:100%;opt
		}		
	</style>
</head>

<body>
<%@ include file="/WEB-INF/views/layouts/header.jsp" %>

<div id="wrap" style="height:94.7%; width: 100%;">
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	
	<!-- S: 1depth / 교량 목록 -->
	<div id="leftMenuArea" class="subWrap">
		<!-- S: 교량 명, 목록가기, 닫기 -->
		<div class="subHeader">
			<h2>${bridge.brg_nam}</h2>
			<div class="ctrlBtn">
				<a href="/bridge/list-bridge?${searchParameters}" style="padding-top:3px; font-size:13px; color: #fff;">목록 보기</a>
			</div>
		</div>
		<!-- E: 교량 명, 목록가기, 닫기 -->	
		<!-- S: 교량 상세 정보 -->
		<ul id="projectInfo" class="projectInfo">
			<li title="주소"><label>주소 : </label>
				${bridge.fac_sido} ${bridge.fac_sgg} ${bridge.fac_emd} ${bridge.fac_ri}
			</li>
			<li title="관리주체"><label>관리주체 : </label>
				${bridge.mng_org}
			</li>
			<li class="half" title="종별"><label>종별 : </label>
				${bridge.fac_gra}
			</li>
			<li class="half" title="준공년도"><label>준공년도 : </label>
				${bridge.end_amd.substring(0,4)}
			</li>
			<li class="half" title="연장"><label>연장(m) : </label>
				${bridge.brg_len}
			</li>
			<li class="half" title="폭"><label>폭(m) : </label>
				${bridge.tot_wid}
			</li>
			<li title="유지관리 목표성능"><label>유지관리 목표성능 : </label>
				${bridge.bridge_cm} 
			</li>
			<li title="내하성능"><label>내하성능 : </label>
				${bridge.bridge_lcc} 
			</li>
			
			<li title="교량등급"><label>교량등급 : </label>
				${bridge.bridge_grade}
			</li>
		</ul>
		<div class="alignCenter">
			<button type="button" class="basic" onclick="viewBridgeInfo();" />교량 상세정보</button>
		</div>
		<!-- E: 교량 상세 정보 -->
		<!-- S: 교량  레이어 -->	
		<br>		
		<ul class="listLayer">
			<hr><h3 style="margin: 8px;">Layers</h3><hr>
			
			<li class="imageLayer on" >
				<p>3차원 교량 모델</p>
			</li>
			<li class="imageLayer" >
				<p>위성 영상</p>
			</li>
			<li class="imageLayer" >
				<p>접촉식 센서</p> 
			</li>
			<li class="imageLayer" >
				<p>드론 영상</p>
			</li>
		</ul>		
		<!-- E: 교량  레이어 -->		
	</div>
	<!-- E: 1depth / 프로젝트 목록 -->
	
	<div id="MapContainer" class="mapWrap">
		<div class="ctrlBtn">
			<button type="button" class="divide" title="화면분할">화면분할</button>
			<button type="button" class="fullscreen" title="전체화면">전체화면</button>
		</div>
		
		<div class="compass">
			<button id="mapCtrlCompass" type="button" title="compass">compass</button>
		</div>
				
		<div class="zoom" >
			<button id="mapCtrlZoomIn" type="button" class="zoomin">확대</button>
			<button id="mapCtrlReset" type="button" class="reset">원위치</button>
			<button id="mapCtrlZoomOut" type="button"  class="zoomout">축소</button>
		</div>
			
		<div class="mapInfo">
			<span id="positionDD">127.156797°, 38.012334°</span>
			<span><label>고도: </label><span id="positionAlt"><!--10m--></span></span>
		</div>
		<%@ include file="/WEB-INF/views/bridge/bridgeInfo.jsp" %>
	</div>
	
	<!-- E: MAPWRAP -->
</div>
<!-- E: wrap -->
	
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/Honam-bms.js"></script>
<script type="text/javascript" src="/js/Geospatial.js"></script>
<script type="text/javascript" src="/js/NumberFormatter.js"></script>
<script type="text/javascript" src="/js/MapControll.js"></script>
<script type="text/javascript" src="/js/MouseControll.js"></script>
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
	var EsriTerrain =  new Cesium.ArcGISTiledElevationTerrainProvider({
        url: 'https://elevation3d.arcgis.com/arcgis/rest/services/WorldElevation3D/Terrain3D/ImageServer'
    });
	        
   	Cesium.Ion.defaultAccesToken = '${cesiumIonToken}';
   	var viewer = new Cesium.Viewer('MapContainer', {imageryProvider : imageryProvider, baseLayerPicker : true, terrainProvider : EsriTerrain, 
   		animation:false, timeline:false, geocoder:false, navigationHelpButton: false, fullscreenButton:false, homeButton: false, sceneModePicker: false });
   	viewer.scene.globe.depthTestAgainstTerrain = false;
	
  	$(document).ready(function() {
		$("#projectMenu").addClass("on");
		getCentroidBridge("${bridge.gid}","${bridge.brg_nam}","${bridge.bridge_grade}")
		$("#bridgeInfoLayer").hide();
		MouseControll(viewer);
		MapControll(viewer);
	});
  	
  	function getCentroidBridge(gid, name, grade) {
		var url = "./" + gid + "/centroid"; 
		var cnt = null;
		
		//해당 교량으로 이동
		$.ajax({
		    url: url,
		    type: "GET",
		    dataType: "json",
		    success : function(msg) {
		        if(msg.result === "success") {
		      	  cameraFlyTo(msg.longitude,  msg.latitude, 1000, 3);
		        }
		    },
		    error : function(request, status, error) {
		        //alert(JS_MESSAGE["ajax.error.message"]);
		        console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
		    }
		});

		// 해당 교량에 해당되는 영역을 폴리곤으로 표시
	  	var now = new Date();
	    var rand = ( now - now % 5000) / 5000;
	  	var queryString = "brg_nam = '" + name + "'";
	    var provider = new Cesium.WebMapServiceImageryProvider({
	        url : "http://localhost:8080/geoserver/honambms/wms",
	        layers : 'honambms:bridge',
	        parameters : {
	            service : 'WMS'
	            ,version : '1.1.1'
	            ,request : 'GetMap'
	            ,transparent : 'true'
	            ,format : 'image/png'
	            ,time : 'P2Y/PRESENT'
	            ,rand:rand
	            ,maxZoom : 25
	            ,maxNativeZoom : 23
	            ,CQL_FILTER: queryString
	        },
	        enablePickFeatures : false
	    });
	    
	    DISTRICT_PROVIDER = viewer.imageryLayers.addImageryProvider(provider);
	}
  	
  	function viewBridgeInfo() {
  		var bridgeInfoHtml = "<li><label>교량명</label>" + "${bridge.brg_nam}" + "</li>" +
  								"<li><label>관리주체</label>" + "${bridge.mng_org}" + "</li>" +
  								"<li><label>주소</label>" + "${bridge.fac_sido} ${bridge.fac_sgg} ${bridge.fac_emd} ${bridge.fac_ri}" + "</li>" +
  								"<li><label>종별</label>" + "${bridge.fac_gra}" + "</li>" +
  								"<li><label>준공년도</label>" + "${bridge.end_amd.substring(0,4)}" + "</li>" +
  								"<li><label>설계하중</label>" + "${bridge.dsn_wet}" + "</li>" +
  								"<li><label>연장 (m)</label>" + "${bridge.brg_len}" + "</li>" +
  								"<li><label>교고 (m)</label>" + "${bridge.brg_hit}" + "</li>" +
  								"<li><label>유효폭 (m)</label>" + "${bridge.eff_wid}" + "</li>" +
  								"<li><label>총폭 (m)</label>" + "${bridge.tot_wid}" + "</li>" +
  								"<li><label>경간수</label>" + "${bridge.spa_cnt}" + "</li>" +
  								"<li><label>최대경간장 (m)</label>" + "${bridge.max_len}" + "</li>" +
  								"<li><label>교통량</label>" + "${bridge.tra_cnt}" + "</li>" +
  								"<li><label>상부 형식</label>" + "${bridge.usp_rep}" + "</li>" +
  								"<li><label>하부 형식</label>" + "${bridge.dpi_rep}" + "</li>" +
  								"<li><label>내하성능</label>" + "${bridge.bridge_lcc}" + "</li>" +
  								"<li><label>유지관리 목표성능</label>" + "${bridge.bridge_cm}" + "</li>" +
  								"<li><label>교량등급</label>" + "${bridge.bridge_grade}" + "</li>"
		$("#bridgeInfo").html(bridgeInfoHtml);
		$("#bridgeInfoLayer").show();
  	}
  	function closeBridgeInfo() {
   		$("#bridgeInfoLayer").hide();
   	}
</script>
</body>
</html>
