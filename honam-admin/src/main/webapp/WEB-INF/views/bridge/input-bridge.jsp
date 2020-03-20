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
			<form id="insertBridgeForm">
				<input type="hidden" id="geom" name="geom">

				<div class="form-inline">
					<label for="brgNam">* 교량명</label>
					<input type="text" id="brgNam" name="brgNam">
					<label for="facNum">* 시설물번호</label>
					<input type="text" id="facNum" name="facNum">
				</div>

				<div class="form-inline">
					<label for="mngOrg">관리주체</label>
					<input type="text" id="mngOrg" name="mngOrg">
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
					<input type="text" id="facEmd" name="facEmd">
					<label for="facSido">리</label>
					<input type="text" id="facRi" name="facRi">
				</div>

				<div class="form-inline">
					<label for="facGra">종별</label>
					<input type="radio" id="facGra1" name="facGra" value="1종" checked="checked">
					<label for="facGra1">1종</label>
					<input type="radio" id="facGra2" name="facGra" value="2종">
					<label for="facGra2">2종</label>
				</div>

				<div class="form-inline">
					<label for="endAmd">준공년도</label>
					<input type="text" id="endAmd" name="endAmd">
					<label for="dsnWet">설계하중</label>
					<input type="text" id="dsnWet" name="dsnWet">
				</div>

				<div class="form-inline">
					<label for="brgLen">연장 (m)</label>
					<input type="text" id="brgLen" name="brgLen">
					<label for="brgHit">교고 (m)</label>
					<input type="text" id="brgHit" name="brgHit">
				</div>

				<div class="form-inline">
					<label for="effWid">유효폭 (m)</label>
					<input type="text" id="effWid" name="effWid">
					<label for="totWid">총폭 (m)</label>
					<input type="text" id="totWid" name="totWid">
				</div>

				<div class="form-inline">
					<label for="spaCnt">경간수</label>
					<input type="text" id="spaCnt" name="spaCnt">
					<label for="maxLen">최대경간장 (m)</label>
					<input type="text" id="maxLen" name="maxLen">
				</div>

				<div class="form-inline">
					<label for="traCnt">교통량</label>
					<input type="text" id="traCnt" name="traCnt">
				</div>

				<div class="form-inline">
					<label for="uspRep">상부 형식</label>
					<input type="text" id="uspRep" name="uspRep">
					<label for="dpiRep">하부 형식</label>
					<input type="text" id="dpiRep" name="dpiRep">
				</div>

				<div class="form-inline">
					<label for="bridgeLcc">내하성능</label>
					<input type="text" id="bridgeLcc" name="bridgeLcc">
					<label for="bridgeCm">유지관리 목표성능</label>
					<input type="text" id="bridgeCm" name="bridgeCm">
				</div>

				<div class="form-inline">
					<label for="grade">교량등급</label>
					<select id="grade" name="grade">
						<option>교량등급</option>
						<option value="A">A</option>
						<option value="B">B</option>
						<option value="C">C</option>
						<option value="D">D</option>
					</select>
				</div>

				<div class="form-inline">
					<label for="files">드론영상</label>
				</div>

				<div class="form-inline">
  					<input type="file" id="files" name="files" multiple>
				</div>

				<div class="form-inline">
					<button type="button" id="insertBridge" class="point" title="등록">등록</button>
					<button type="button" id="goBridgeList" class="point" title="목록">목록</button>
				</div>
			</form>
		</div>

		<div id="MapContainer" class="map-wrapper">
			<div class="map-button-wrapper">
				<button id="drawBridge" class="draw">그리기</button>
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
var satValueCount = null;
var drawer = null;
//초기 로딩 설정
$(document).ready(function() {

	$("#bridgeManageMenu").addClass("on");
	getListSdo();

	$('#drawBridge').click(function() {
		$(this).toggleClass("on");
		if (drawer != null) {
			if (drawer.active) {
				drawer.active = false;
			} else {
				drawer.active = true;
			}
		} else {
			drawer = new CesiumPolygonDrawer(viewer);
			drawer.active = true;
			drawer.drawing = true;
		}
	});

	$("#sdoCode").on("change", function() {
		var sdoCode = $("#sdoCode").val();
		if(sdoCode) {
			getListSgg(sdoCode);
		}
	});

	$('#insertBridge').click(function() {
		if (!validation()) return false;
		var form = $('#insertBridgeForm')[0];
		var formData = new FormData(form);
		$.ajax({
			url: '/bridges/input-bridge',
			type: 'POST',
			headers: {"X-Requested-With": "XMLHttpRequest"},
			data: formData,
			processData: false,
			contentType: false,
			dataType: 'json',
			success: function(res) {
				if(res.statusCode <= 200) {
					console.log("---- " + res);
				} else {
					alert(JS_MESSAGE[res.errorCode]);
					console.log("---- " + res.message);
				}
			},
			error: function(request, status, error) {
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	});

	$('#goBridgeList').click(function() {
		location.href = '/bridge/manage-bridge';
	});

});

// 시도 목록
function getListSdo() {
	$.ajax({
        url: "/bridges/sdos",
        type: "GET",
        dataType: "json",
        success : function(res) {
        	if(res.statusCode <= 200) {
                var sdoList = res.sdoList;
                var content = "<option value=''> 시도 </option>";
                for(var i=0, len=sdoList.length; i < len; i++) {
                    var sdo = sdoList[i];
                	content += '<option value=' + sdo.sdoCode + '>' + sdo.name + '</option>';
                }
                $('#sdoCode').html(content);
        	} else {
				alert(JS_MESSAGE[res.errorCode]);
				console.log("---- " + res.message);
			}
        },
        error: function(request, status, error) {
			alert(JS_MESSAGE["ajax.error.message"]);
		}
    });
}

// 시도에 해당하는 시군구 목록
function getListSgg(bjcd) {
	$.ajax({
        url: "/bridges/sdos/" + bjcd + "/sggs",
        type: "GET",
        dataType: "json",
        success : function(res) {
        	if(res.statusCode <= 200) {
                var sggList = res.sggList;
                $('#sggCode').empty()
                var content = "<option value=''> 시군구 </option>";
                for(var i=0, len=sggList.length; i < len; i++) {
                    var sgg = sggList[i];
                	content += '<option value=' + sgg.sggCode + '>' + sgg.name + '</option>';
                }
                $('#sggCode').html(content);
        	} else {
				alert(JS_MESSAGE[res.errorCode]);
				console.log("---- " + res.message);
			}
        },
        error: function(request, status, error) {
			alert(JS_MESSAGE["ajax.error.message"]);
		}
    });
}

// 입력폼 유효성 검사
function validation() {
	var wktFlag = false;
	if (drawer != null && drawer.getPositionWKT()) {
		wktFlag = true;
		$('input[name="geom"]').val(drawer.getPositionWKT());
	}
	if (!wktFlag) {
		alert('교량 영역을 그려주세요!');
		return false;
	}
	return true;
}

</script>

</body>
</html>