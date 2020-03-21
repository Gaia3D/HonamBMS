<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>
<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>교량 수정 | Honam-BMS</title>
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
			<form id="updateBridgeForm">
				<input type="hidden" id="geom" name="geom" value="${bridge.geom}">
				<input type="hidden" id="latitude" name="latitude" value="${bridge.latitude}">
				<input type="hidden" id="longitude" name="longitude" value="${bridge.longitude}">

				<div class="form-inline">
					<label for="brgNam">교량명</label>
					<input type="text" id="brgNam" name="brgNam" value="${bridge.brgNam}">
					<label for="facNum">시설물번호</label>
					<input type="text" id="facNum" name="facNum" value="${bridge.facNum}">
				</div>

				<div class="form-inline">
					<label for="mngOrg">관리주체</label>
					<input type="text" id="mngOrg" name="mngOrg" value="${bridge.mngOrg}">
				</div>

				<div class="form-inline">
					<label>주소</label>
				</div>
				<div class="form-inline">
					<label for="sdoCode">* 시도</label>
					<select id="sdoCode" name="facSido"></select>
					<label for="sggCode">* 시군구</label>
					<select id="sggCode" name="facSgg"></select>
				</div>

				<div class="form-inline">
					<label for="facSido">읍면동</label>
					<input type="text" id="facEmd" name="facEmd" value="${bridge.facEmd}">
					<label for="facSido">리</label>
					<input type="text" id="facRi" name="facRi" value="${bridge.facRi}">
				</div>

				<div class="form-inline">
					<label for="facGra">종별</label>
					<input type="radio" name="facGra" value="1종" ${bridge.facGra eq '1종' ? 'checked' : ''}>
					<label for="facGra1">1종</label>
					<input type="radio" name="facGra" value="2종" ${bridge.facGra eq '2종' ? 'checked' : ''}>
					<label for="facGra2">2종</label>
				</div>

				<div class="form-inline">
					<label for="endAmd">준공년도</label>
					<input type="text" id="endAmd" name="endAmd" value="${bridge.endAmd}">
					<label for="dsnWet">설계하중</label>
					<input type="text" id="dsnWet" name="dsnWet" value="${bridge.dsnWet}">
				</div>

				<div class="form-inline">
				<label for="brgLen">연장 (m)</label>
				<input type="text" id="brgLen" name="brgLen" value="${bridge.brgLen}">
				<label for="brgHit">교고 (m)</label>
				<input type="text" id="brgHit" name="brgHit" value="${bridge.brgHit}">
				</div>

				<div class="form-inline">
				<label for="effWid">유효폭 (m)</label>
				<input type="text" id="effWid" name="effWid" value="${bridge.effWid}">
				<label for="totWid">총폭 (m)</label>
				<input type="text" id="totWid" name="totWid" value="${bridge.totWid}">
				</div>

				<div class="form-inline">
				<label for="spaCnt">경간수</label>
				<input type="text" id="spaCnt" name="spaCnt" value="${bridge.spaCnt}">
				<label for="maxLen">최대경간장 (m)</label>
				<input type="text" id="maxLen" name="maxLen" value="${bridge.maxLen}">
				</div>

				<div class="form-inline">
				<label for="traCnt">교통량</label>
				<input type="text" id="traCnt" name="traCnt" value="${bridge.traCnt}">
				</div>

				<div class="form-inline">
				<label for="uspRep">상부 형식</label>
				<input type="text" id="uspRep" name="uspRep" value="${bridge.uspRep}">
				<label for="dpiRep">하부 형식</label>
				<input type="text" id="dpiRep" name="dpiRep" value="${bridge.dpiRep}">
				</div>

				<div class="form-inline">
				<label for="bridgeLcc">내하성능</label>
				<input type="text" id="bridgeLcc" name="bridgeLcc" value="${bridge.bridgeLcc}">
				<label for="bridgeCm">유지관리 목표성능</label>
				<input type="text" id="bridgeCm" name="bridgeCm" value="${bridge.bridgeCm}">
				</div>

				<div class="form-inline">
				<label for="grade">교량등급</label>
				<select id="grade" name="grade">
					<option>교량등급</option>
					<option value="A" ${bridge.grade eq 'A' ? 'selected' : ''}>A</option>
					<option value="B" ${bridge.grade eq 'B' ? 'selected' : ''}>B</option>
					<option value="C" ${bridge.grade eq 'C' ? 'selected' : ''}>C</option>
					<option value="D" ${bridge.grade eq 'D' ? 'selected' : ''}>D</option>
				</select>
				</div>

				<div class="form-inline">
					<label for="dronFile">드론영상</label><input type="file" id="files" name="files" multiple>
					<button type="button">전체삭제</button>
				</div>
				<ul>
					<li>1.png<button type="button">삭제</button></li>
					<li>2.png<button type="button">삭제</button></li>
					<li>3.png<button type="button">삭제</button></li>
				</ul>

				<div class="form-inline">
					<button type="button" id="updateBridge" class="point" title="수정">수정</button>
					<button type="button" id="goBridgeList" class="point" title="목록">목록</button>
				</div>
			</form>
		</div>
		<div id="MapContainer" class="map-wrapper">
			<div class="map-button-wrapper">
				<button id="drawBridge" class="draw">다시 그리기</button>
			</div>
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
<script type="text/javascript" src="/js/Honam-bms.js"></script>
<script type="text/javascript" src="/js/Geospatial.js"></script>
<script type="text/javascript" src="/js/NumberFormatter.js"></script>
<script type="text/javascript" src="/js/BridgeAttribute.js"></script>
<script type="text/javascript" src="/js/MapControll.js"></script>
<script type="text/javascript" src="/js/MouseControll.js"></script>
<script type="text/javascript" src="/js/SatAnalysisResult.js"></script>
<script type="text/javascript" src="/js/SensorData.js"></script>
<script type="text/javascript" src="/js/GeometryDrawer.js"></script>

<script type="text/javascript">
//초기 위치 설정
var INIT_WEST = 124.67;
var INIT_SOUTH = 35.72;
var INIT_EAST = 128.46;
var INIT_NORTH = 33.77;
var rectangle = Cesium.Rectangle.fromDegrees(INIT_WEST, INIT_SOUTH, INIT_EAST, INIT_NORTH);
Cesium.Camera.DEFAULT_VIEW_FACTOR = 0;
Cesium.Camera.DEFAULT_VIEW_RECTANGLE = rectangle;

var imageryProvider = new Cesium.ArcGisMapServerImageryProvider({
	url: 'https://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer',
	enablePickFeatures: false
});

var viewer = new Cesium.Viewer('MapContainer', {imageryProvider : imageryProvider, baseLayerPicker : false,
	animation:false, timeline:false, geocoder:false, navigationHelpButton: false, fullscreenButton:false, homeButton: false, sceneModePicker: false });
viewer.scene.globe.depthTestAgainstTerrain = true;
//viewer.extend(Cesium.viewerCesiumNavigationMixin, {});
var drawer = new CesiumPolygonDrawer(viewer);
var satValueCount = null;

//초기 로딩 설정
$(document).ready(function() {
	$("#bridgeManageMenu").addClass("on");
	
	
	drawOrginalBridge();

	$('#drawBridge').click(function() {
		var active = $(this).hasClass('on');
		if(!active) {
			$(this).addClass('on');
			drawer.active = true;
		}else {
			$(this).removeClass('on');
			drawer.active = false;
		}
		
	});
});


function drawOrginalBridge() {
	var orgGeom = $('#geom').val();
	var polygons = wktToCoordinates(orgGeom, 'MULTIPOLYGON');
	for(var i=0,len=polygons.length;i<len;i++) {
		var polygon = polygons[i];
		var cartesians = [];
		for(var j=0,coordCnt=polygon.length;j<coordCnt;j++) {
			var coordArr = polygon[j];
			cartesians.push(Cesium.Cartesian3.fromDegrees(coordArr[0], coordArr[1], 0));
		}
		
		var entity = viewer.entities.add({
            name : 'original' + i,
            polygon: {
                hierarchy: cartesians,
                material: new Cesium.ColorMaterialProperty(Cesium.Color.BLUE.withAlpha(0.8))
            }
        });
	}

	var flyLat = parseFloat($('#latitude').val());
	var flyLon = parseFloat($('#longitude').val()); 

	viewer.camera.flyTo({
		destination : Cesium.Cartesian3.fromDegrees(flyLon, flyLat, 500)
	})
}
	// function
function drawBridge() {
	  <c:if test="${!empty bridgeList }">
	  	<c:forEach var="bridge" items="${bridgeList}" varStatus="status">
			getCentroidBridge("${bridge.gid}","${bridge.brgNam}","${bridge.grade}")
	  	</c:forEach>
	  </c:if>
}

function getCentroidBridge(gid, name, grade) {
	var url = "./" + gid + "/centroid";
	var cnt = null;

	$.ajax({
	    url: url,
	    type: "GET",
	    dataType: "json",
	    success : function(msg) {
	        if(msg.result === "success") {
	      	  cnt++;
	      	  addMarkerBillboards(name, msg.longitude,  msg.latitude, grade, cnt);
	        }
	    },
	    error : function(request, status, error) {
	        //alert(JS_MESSAGE["ajax.error.message"]);
	        console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
	    }
	});
}

function addMarkerBillboards(bridgeName, longitude, latitude, grade, cnt) {
	var markerImage = null;
	if(grade == 'A'){
		markerImage = '/images/${lang}/A.png';
	} else if(grade == 'B') {
		markerImage = '/images/${lang}/B.png';
	} else if(grade == 'C') {
		markerImage = '/images/${lang}/C.png';
	} else if(grade == 'D') {
		markerImage = '/images/${lang}/D.png';
	} else if(grade == 'E') {
		markerImage = '/images/${lang}/E.png';
	} else {
		markerImage = '/images/${lang}/X.png';
	}

//	if(cnt == 1) {
//		cameraFlyTo(longitude, latitude, 200000, 3);
//	}

	viewer.entities.add({
		name : bridgeName,
        position : Cesium.Cartesian3.fromDegrees(parseFloat(longitude), parseFloat(latitude), 0),
        billboard : {
            image : markerImage,
            width : 35, // default: undefined/
            height : 35, // default: undefined
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