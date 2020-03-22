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
		<!-- <nav class="manage-tab">
			<ul>
				<li><a href="/bridge/manage-bridge">교량 관리</a></li>
				<li><a href="/bridge/input-bridge">교량 등록</a></li>
			</ul>
		</nav> -->
		<!-- S: 교량 목록 -->
		<div class="list-wrapper">
			<div class="boardHeader" style="margin:0;">
				<h2>교량 관리</h2>
				<div class="button-wrapper-right">
					<button class="point" onclick="location.href='/bridge/input-bridge'">교량 등록</button>
					<button id="deleteSelected" class="basic">선택 삭제</button>
				</div>
			</div>
			<div class="boardList">
				<table>
					<col class="col-number" />
					<col class="col-toggle" />
					<col class="col-name" />
					<thead>
						<tr>
							<th scope="col" class="col-name" style="width:5%; font-weight: bold">
								<input type="checkbox" id="selectAll">
							</th>
							<th scope="col" class="col-number">번호</th>
							<th scope="col" class="col-toggle">교량 명</th>
							<th scope="col" class="col-name">준공년도</th>
							<th scope="col" class="col-name">상태</th>
							<!-- <th scope="col" class="col-name">드론영상</th> -->
							<th scope="col" class="col-name">이동</th>
							<th scope="col" class="col-name">삭제</th>
						</tr>
					</thead>
					<tbody id="transferDataList"></tbody>
				</table>
			</div>
			<ul class="pagination"></ul>
			<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
		</div>
		<!-- E: 교량 목록 -->
		<!-- S: 지도 화면 -->
		<div id="MapContainer" class="map-wrapper"></div>
		<!-- E: 지도 화면 -->
	</div>
</div>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/externlib/ajax-cross-origin/jquery.ajax-cross-origin.min.js"></script>
<script type="text/javascript" src="/externlib/cesium/Cesium.js"></script>
<script type="text/javascript" src="/js/mago3d.js"></script>
<script type="text/javascript" src="/js/mago3d_lx.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/Honam-bms.js"></script>
<script type="text/javascript" src="/js/Geospatial.js"></script>
<script type="text/javascript" src="/js/NumberFormatter.js"></script>
<script type="text/javascript" src="/js/BridgeAttribute.js"></script>
<script type="text/javascript" src="/js/MapControll.js"></script>
<script type="text/javascript" src="/js/MouseControll.js"></script>
<script type="text/javascript" src="/js/SatAnalysisResult.js"></script>
<script type="text/javascript" src="/js/SensorData.js"></script>

<script type="text/javascript">
var viewer = null;
var MAGO3D_INSTANCE;
//TODO: policy 개발 후 변경
var HONAMBMS = HONAMBMS || {
	policy : ${policy}
};

/* //초기 위치 설정
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
//viewer.extend(Cesium.viewerCesiumNavigationMixin, {}); */
var satValueCount = null;

//초기 로딩 설정
$(document).ready(function() {
	 magoStart();
});

function magoStart() {
	var INIT_WEST = 124.67;
	var INIT_SOUTH = 35.72;
	var INIT_EAST = 128.46;
	var INIT_NORTH = 33.77;
	var rectangle = Cesium.Rectangle.fromDegrees(INIT_WEST, INIT_SOUTH, INIT_EAST, INIT_NORTH);
	Cesium.Camera.DEFAULT_VIEW_FACTOR = 0;
	Cesium.Camera.DEFAULT_VIEW_RECTANGLE = rectangle;
	var geoPolicyJson = HONAMBMS.policy;

	var cesiumViewerOption = {};
	cesiumViewerOption.infoBox = false;
	cesiumViewerOption.navigationHelpButton = false;
	cesiumViewerOption.selectionIndicator = false;
	cesiumViewerOption.homeButton = false;
	cesiumViewerOption.fullscreenButton = false;
	cesiumViewerOption.geocoder = false;
	cesiumViewerOption.baseLayerPicker = false;
	cesiumViewerOption.sceneModePicker = false;
	cesiumViewerOption.terrainProvider = (geoPolicyJson.terrainUrl && geoPolicyJson.terrainUrl.length > 0) ? 
			new Cesium.CesiumTerrainProvider({url : geoPolicyJson.terrainUrl}) : new Cesium.EllipsoidTerrainProvider();
	cesiumViewerOption.imageryProvider = new Cesium.ArcGisMapServerImageryProvider({
	    url : 'https://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer'
	});

	MAGO3D_INSTANCE = new Mago3D.Mago3d('MapContainer', geoPolicyJson, {loadend : magoLoadEnd}, cesiumViewerOption);
}

function magoLoadEnd(e) {
	var magoInstance = e;
	viewer = magoInstance.getViewer();
	if(viewer.baseLayerPicker) {
		viewer.baseLayerPicker.destroy();
	}

	initMenu("#bridgeManageMenu");
	$("#selectAll").click(function() {
	    $("input[type=checkbox]").prop("checked", $(this).prop("checked"));
	});
	$("#deleteSelected").click(function() {
		if (confirm('선택된 교량을 정말로 삭제하시겠습니까?')) {
			var gids = new Array();
			$("input[type=checkbox]:checked").each(function() {
				var gid = $(this).data('id');
				if (gid) {
					gids.push(gid);
				}
			});
			if (gids.length > 0) {
				removeBridges(gids);
			} else {
				alert('선택된 교량이 없습니다.');
			}
		}
	});
	getListBridge();
}

function addMarkerBillboards(bridgeList) {
	viewer.entities.removeAll();
	for(var i=0; i< bridgeList.length;i++) {
		var bridge = bridgeList[i];
		var markerImage = "/images/${lang}/"+bridge.grade+".png";
		viewer.entities.add({
			name : bridge.brgNam,
	        position : Cesium.Cartesian3.fromDegrees(parseFloat(bridge.longitude), parseFloat(bridge.latitude), 0),
	        billboard : {
	            image : markerImage,
	            width : 35,
	            height : 35,
	            disableDepthTestDistance : Number.POSITIVE_INFINITY,
	            scaleByDistance : new Cesium.NearFarScalar(10000, 1.5, 1000000, 0.0)
	        },
	        label : {
	        	fillColor : Cesium.Color.fromCssColorString('#242424'),
	            font : "12pt",
	            scaleByDistance : new Cesium.NearFarScalar(25000, 1.0, 50000, 0.0),
	            pixelOffset : new Cesium.Cartesian2(5, 30),
	            style: Cesium.LabelStyle.FILL,
	            outlineWidth: 1,
	            text : bridge.brgNam,
	            showBackground : true,
	            backgroundColor : Cesium.Color.fromCssColorString('#EDEDED')
	        }
	    });
	}
}

function gotoFlyBridge(longitude, latitude) {
	viewer.camera.flyTo({
	    destination : Cesium.Cartesian3.fromDegrees(longitude, latitude, 200)
	});
}

function addBridgesTable(bridges, pagination, pageNo) {
	var html = '';
	for (var i = 0; i < bridges.length; i++) {
		var bridge = bridges[i];
		html += '<tr>';
		html += '<td class="col-name"><input type="checkbox" data-id="' + bridge.gid + '"></td>';
		var number = pagination.offset + (i + 1);
		html += '<td class="col-number">' + number + '</td>';
		html += '<td class="col-toggle ellipsis" style="max-width:100px;"><a href="/bridge/modify-bridge/' + bridge.gid + '">' + bridge.brgNam + '</a></td>';
		var endAmd = '';
		if (bridge.endAmd) {
			endAmd = bridge.endAmd.substring(0,4);
		}
		html += '<td class="col-name">' + endAmd + '</td>';
		html += '<td class="col-name">' + bridge.grade + '</td>';
		/* html += '<td class="col-name"><a href="/bridge/modify-bridge-layer/' + bridge.gid + '">수정</a></td>'; */
		html += '<td class="col-name"><button class="intd" onclick="gotoFlyBridge(' + bridge.longitude + ', ' + bridge.latitude + ')">이동</button></td>';
		html += '<td class="col-name"><button class="intd deleteBridge" data-id="' + bridge.gid + '" data-page="' + pageNo + '">삭제</button></td>';
		html += '</tr>';
	}
	$('#transferDataList').html(html);
}

function addBridgesPaging(pagination, pageNo) {
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
}

function removeBridge(gid, pageNo) {
	$.ajax({
	    url: '/bridges/' + gid,
	    type: "DELETE",
		headers: {'X-Requested-With': 'XMLHttpRequest'},
	    dataType: "json",
	    success : function(res) {
	    	if(res.statusCode <= 200) {
				alert("교량을 성공적으로 삭제 하였습니다.");
				getListBridge(pageNo);
			} else {
				alert(JS_MESSAGE[res.errorCode]);
				console.log("---- " + res.message);
			}
	    },
	    error : function(request, status, error) {
	    	alert(JS_MESSAGE["ajax.error.message"]);
	    }
	});
}

function removeBridges(gids) {
	var formData = new FormData();
	formData.append('gids', gids);
	$.ajax({
	    url: '/bridges',
	    type: "DELETE",
	    data : formData,
	    processData: false,
		contentType: false,
		headers: {'X-Requested-With': 'XMLHttpRequest'},
	    dataType: "json",
	    success : function(res) {
	    	if(res.statusCode <= 200) {
				alert("선택된 교량을 성공적으로 삭제 하였습니다.");
				getListBridge();
			} else {
				alert(JS_MESSAGE[res.errorCode]);
				console.log("---- " + res.message);
			}
	    },
	    error : function(request, status, error) {
	    	alert(JS_MESSAGE["ajax.error.message"]);
	    }
	});
}

function getListBridge(number) {
	var pageNo = (number === undefined) ? 1 : number;
	$.ajax({
	    url: '/bridges',
	    type: "GET",
	    data: { 'pageNo' : pageNo},
		headers: {'X-Requested-With': 'XMLHttpRequest'},
	    dataType: "json",
	    success : function(res) {
	    	if(res.statusCode <= 200) {
	    		var bridges = res.bridgeList;
	    		var pagination = res.pagination;
	    		addMarkerBillboards(bridges);
	    		addBridgesTable(bridges, pagination, pageNo);
	    		addBridgesPaging(pagination, pageNo);
		    	$("input[type=checkbox]").click(function() {
		    	    if (!$(this).prop("checked")) {
		    	        $("#selectAll").prop("checked", false);
		    	    }
		    	});
		    	$('.deleteBridge').click(function() {
		    		if (confirm('교량을 정말로 삭제하시겠습니까?')) {
		    			var gid = $(this).data('id');
			    		var pageNo = $(this).data('page');
			    		removeBridge(gid, pageNo);
		    		}
		    	});
	    	} else {
				//alert(JS_MESSAGE[res.errorCode]);
				console.log("---- " + res.message);
			}
	    },
	    error : function(request, status, error) {
	    	alert(JS_MESSAGE["ajax.error.message"]);
	    }
	});
}
</script>

</body>
</html>