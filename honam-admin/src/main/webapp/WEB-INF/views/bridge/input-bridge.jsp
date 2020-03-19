<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>
<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>교량 등록 | Honam-BMS</title>
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
	<nav class="heading-wrapper">
		<ul>
			<li>교량 관리</li>
			<li>교량 등록</li>
		</ul>
	</nav>
	<form action="">
		<label for="brgNam">교량명</label>
		<input type="text" id="brgNam" name="brgNam">
		<label for="facNum">시설물번호</label>
		<input type="text" id="facNum" name="facNum">
		<label for="mngOrg">관리주체</label>
		<input type="text" id="mngOrg" name="mngOrg">
		<label for="mngOrg">주소</label>
		<select>
			<option>시도</option>
		</select>
		<select>
			<option>시군구</option>
		</select>

	</form>
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

//초기 로딩 설정
$(document).ready(function() {
	$("#bridgeManageMenu").addClass("on");
	drawBridge();
});

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