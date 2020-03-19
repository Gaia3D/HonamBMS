<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>
<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>교량 관리 | Honam-BMS</title>
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

		<!-- S: 교량 목록 -->
		<div class="list-wrapper">
			<button>선택 삭제</button>
			<button>전체 삭제</button>
			<table class="list-table scope-col">
				<col class="col-number" />
				<col class="col-toggle" />
				<col class="col-name" />
				<thead>
					<tr>
						<th scope="col" class="col-name" style="width:5%; font-weight: bold">
							<input type="checkbox">
						</th>
						<th scope="col" class="col-number">번호</th>
						<th scope="col" class="col-toggle">교량 명</th>
						<th scope="col" class="col-name">준공년도</th>
						<th scope="col" class="col-name">상태</th>
						<th scope="col" class="col-name">이동</th>
						<th scope="col" class="col-name">수정</th>
						<th scope="col" class="col-name">삭제</th>
					</tr>
				</thead>
				<tbody id="transferDataList"></tbody>
			</table>
			<ul class="pagination"></ul>
			<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
		</div>
		<!-- E: 교량 목록 -->
		<div id="MapContainer" class="map-wrapper"></div>
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
//viewer.extend(Cesium.viewerCesiumNavigationMixin, {});
var satValueCount = null;

//초기 로딩 설정
$(document).ready(function() {

	$("#bridgeManageMenu").addClass("on");

	getListBridge();
	drawBridge();

});

function drawBridge() {
	  <c:if test="${!empty bridgeList }">
	  	<c:forEach var="bridge" items="${bridgeList}" varStatus="status">
			getCentroidBridge("${bridge.gid}","${bridge.brgNam}","${bridge.grade}")
	  	</c:forEach>
	  </c:if>
}

function getCentroidBridge(gid, name, grade) {
	var url = "/bridges/" + gid + "/centroid";
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

function getListBridge(number) {
	var pageNo = (number === undefined) ? 1 : number;
	$.ajax({
	    url: '/bridges',
	    type: "GET",
	    data: {pageNo : pageNo},
		headers: {'X-Requested-With': 'XMLHttpRequest'},
	    dataType: "json",
	    success : function(res) {
	    	if(res.statusCode <= 200) {
	    		var bridges = res.bridgeList;
	    		var pagination = res.pagination;

	    		var html = '';
	    		for (var i = 0; i < bridges.length; i++) {
	    			var bridge = bridges[i];
	    			html += '<tr>';
		    		html += '<td class="col-name"><input type="checkbox"></td>';
		    		var number = pagination.offset + (i + 1);
		    		html += '<td class="col-number">' + number + '</td>';
		    		html += '<td class="col-toggle"><a href="/bridge/modify-bridge/' + bridge.gid + '">' + bridge.brgNam + '</a></td>';
		    		if (bridge.endAmd) {
		    			var endAmd = bridge.endAmd.substring(0,4);
		    		}
		    		html += '<td class="col-name">' + endAmd + '</td>';
					html += '<td class="col-name">' + bridge.grade + '</td>';
					html += '<td class="col-name"><button id="goBridge">이동</button></td>';
					html += '<td class="col-name"><a href="/bridge/modify-bridge/' + bridge.gid + '">수정</a></td>';
					html += '<td class="col-name"><button class="deleteBridge" data-id="' + bridge.gid + '" data-page="' + pageNo + '">삭제</button></td>';
		    		html += '</tr>';
	    		}
		    	$('#transferDataList').html(html);


		    	var html = '<li class="ico first" onClick="getListBridge(' + pagination.firstPage + ')"></li>';
		    	if (pagination.existPrePage) {
		    		html += '<li class="ico forward" onClick="getListBridge(' + pagination.prePageNo + ')"></li>';
		    	}
		    	for (var i = pagination.startPage; i < pagination.endPage + 1; i++) {
					if (pageNo == i) {
						html += '<li class="on"><a href="#">' + i + '</a></li>';
					} else {
						html += '<li onClick="getListBridge(' + i + ')"><a href="#">' + i + '</a></li>';
					}
		    	}
		    	if (pagination.existNextPage) {
		    		html += '<li class="ico back" onClick="getListBridge(' + pagination.nextPageNo + ')"></li>';
		    	}
		    	html += '<li class="ico end" onClick="getListBridge(' + pagination.lastPage + ')"></li>';
		    	$('.pagination').html(html);

		    	$('.deleteBridge').click(function() {
		    		var gid = $(this).data('id');

		    		// 성공하면!
		    		var pageNo = $(this).data('page');
		    		getListBridge(pageNo);

		    	});

	    	}
	    },
	    error : function(request, status, error) {
	        console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
	    }
	});
}
</script>

</body>
</html>