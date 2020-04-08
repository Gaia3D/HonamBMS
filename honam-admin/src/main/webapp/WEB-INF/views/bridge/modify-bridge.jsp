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
		<!-- <nav class="manage-tab">
			<ul>
				<li><a href="/bridge/manage-bridge">교량 관리</a></li>
				<li><a href="/bridge/input-bridge">교량 등록</a></li>
			</ul>
		</nav> -->
		<div class="list-wrapper">
			<div class="boardHeader" style="margin-top:0;">
				<h2>교량 수정</h2>
				<div class="button-wrapper-right">
					<button id="expandAll" class="basic">모두 펼치기</button>
					<button id="closedAll" class="basic">모두 접기</button>
				</div>
			</div>
			<form id="updateBridgeForm">
				<input type="hidden" id="geom" name="geom" value="${bridge.geom}">
				<input type="hidden" id="latitude" name="latitude" value="${bridge.latitude}">
				<input type="hidden" id="longitude" name="longitude" value="${bridge.longitude}">
				<input type="hidden" id="facSido" name="facSido">
				<input type="hidden" id="facSgg" name="facSgg">

				<div class="form-group">
					<h3 class="on">교량 정보<span class="collapse-icon">icon</span></h3>
					<div class="form-inline">
						<label for="brgNam">* 교량명</label>
						<input type="text" id="brgNam" name="brgNam" value="${bridge.brgNam}">
						<label for="facNum">* 시설물번호</label>
						<input type="text" id="facNum" name="facNum" value="${bridge.facNum}">
					</div>
					<div class="form-inline">
						<label for="mngOrg">관리주체</label>
						<input type="text" id="mngOrg" name="mngOrg" value="${bridge.mngOrg}">
					</div>
				</div>

				<div class="form-group">
					<h3 class="on">주소<span class="collapse-icon">icon</span></h3>
					<div class="form-inline">
						<label for="sdoCode">* 시도</label>
						<select id="sdoCode"></select>
						<label for="sggCode">* 시군구</label>
						<select id="sggCode"></select>
					</div>
					<div class="form-inline">
						<label for="facSido">읍면동</label>
						<input type="text" id="facEmd" name="facEmd" value="${bridge.facEmd}">
						<label for="facSido">리</label>
						<input type="text" id="facRi" name="facRi" value="${bridge.facRi}">
					</div>
				</div>

				<div class="form-group">
					<h3 class="on">상세 정보<span class="collapse-icon">icon</span></h3>
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
						<label for="bridgeLcc">위성기반 상태평가</label>
						<select id="satGrage" name="satGrade">
							<option>위성기반 상태평가</option>
							<option value="1" ${bridge.satGrade eq '양호' ? 'selected' : ''}>양호</option>
							<option value="2" ${bridge.satGrade eq '주의' ? 'selected' : ''}>주의</option>
							<option value="3" ${bridge.satGrade eq '점검필요' ? 'selected' : ''}>점검필요</option>
						</select>
					</div>
				</div>
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
<script type="text/javascript" src="/js/GeometryDrawer.js"></script>

<script type="text/javascript">
var viewer = null;
var MAGO3D_INSTANCE;
//TODO: policy 개발 후 변경
var HONAMBMS = HONAMBMS || {
	policy : ${policy}
};

var satValueCount = null;
var drawer;
var satValueCount = null;
var isSdoInit = false;
var isSggInit = false;

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
	drawer = new CesiumPolygonDrawer(viewer);
	if(viewer.baseLayerPicker) {
		viewer.baseLayerPicker.destroy();
	}
	initMenu("#bridgeManageMenu");
	getListSdo();
	drawOrginalBridge();

	$('#expandAll').click(function() {
		$('.form-group h3:not(.on)').click();
	});

	$('#closedAll').click(function() {
		$('.form-group h3.on').click();
	});

	$('#drawBridge').click(function() {
		var active = $(this).hasClass('on');
		if(!active) {
			$(this).addClass('on');
			drawer.active = true;
		} else {
			$(this).removeClass('on');
			drawer.active = false;
		}
	});

	$('.form-group h3').click(function() {
		$(this).toggleClass('on');
		$(this).siblings().toggle();
	});

	$("#sdoCode").on("change", function() {
		var sdoCode = $("#sdoCode").val();
		if(sdoCode) {
			getListSgg(sdoCode);
		}
	});

	$('#updateBridge').click(function() {
		if (!validation()) return false;
		var form = $('#updateBridgeForm')[0];
		var formData = new FormData(form);
		$.ajax({
			url: '/bridges/' + '${bridge.gid}',
			type: 'POST',
			headers: {"X-Requested-With": "XMLHttpRequest"},
			data: formData,
			processData: false,
			contentType: false,
			dataType: 'json',
			success: function(res) {
				if(res.statusCode <= 200) {
					alert("교량을 성공적으로 수정 하였습니다.");
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
}

function drawOrginalBridge() {
	var orgGeom = $('#geom').val();
	var polygons = wktToCoordinates(orgGeom, 'MULTIPOLYGON');
	for(var i=0,len=polygons.length;i<len;i++) {
		var polygon = polygons[i];
		var cartesians = [];
		var centerx =0;
		var centery =0;
		var centerz =0;
		for(var j=0,coordCnt=polygon.length;j<coordCnt;j++) {
			var coordArr = polygon[j];
			var cart = Cesium.Cartesian3.fromDegrees(coordArr[0], coordArr[1], 0);
			centerx += cart.x;
			centery += cart.y;
			centerz += cart.z;
			cartesians.push(cart);
		}
		var center = new Cesium.Cartesian3(centerx/coordCnt,centery/coordCnt,centerz/coordCnt);
		var entity = viewer.entities.add({
            name : 'original' + i,
            position : center,
            polygon: {
                hierarchy: cartesians,
                material: new Cesium.ColorMaterialProperty(Cesium.Color.BLUE.withAlpha(0.4))
            },
            label : {
	        	fillColor : Cesium.Color.fromCssColorString('#242424'),
	            font : "12pt",
	            scaleByDistance : new Cesium.NearFarScalar(5000, 1.0, 25000, 0.0),
	            pixelOffset : new Cesium.Cartesian2(0, 30),
	            style: Cesium.LabelStyle.FILL,
	            outlineWidth: 1,
	            text : $('#brgNam').val(),
	            showBackground : true,
	            backgroundColor : Cesium.Color.fromCssColorString('#EDEDED'),
	            heightReference : Cesium.HeightReference.CLAMP_TO_GROUND
	        }
        });
		drawer.drawedEntity = entity;
	}

	var flyLat = parseFloat($('#latitude').val());
	var flyLon = parseFloat($('#longitude').val());

	viewer.camera.flyTo({
		destination : Cesium.Cartesian3.fromDegrees(flyLon, flyLat, 500)
	})
}

//시도 목록
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

                if (!isSdoInit) {
                	$('#sdoCode option').each(function() {
                		if ($(this).text() == '${bridge.facSido}') {
                			$(this).prop("selected", true).trigger('change');
                			isSdoInit = true;
                			return false;
                		}
                	});
                }

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

                if (!isSggInit) {
                	$('#sggCode option').each(function() {
                		if ($(this).text() == '${bridge.facSgg}') {
                			$(this).prop("selected", true).trigger('change');
                			isSggInit = true;
                			return false;
                		}
                	});
                }

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

//입력폼 유효성 검사
function validation() {

	// 교량 그리기
	var wktFlag = false;
	if (drawer != null) {
		try {
			$('input[name="geom"]').val(drawer.getPositionWKT());
			wktFlag = true;
		} catch (e) {
			alert('교량 영역을 그려주세요!');
			return false;
		}
	}
	if (!wktFlag) {
		alert('교량 영역을 그려주세요!');
		return false;
	}

	// 시도/시군구 선택
	if ($('#sdoCode').val()) {
		var facSido = $('#sdoCode option:selected').text();
		$('input[name="facSido"]').val(facSido);
	} else {
		alert('시도를 선택해주세요!');
		return false;
	}
	if ($('#sggCode').val()) {
		var facSido = $('#sggCode option:selected').text();
		$('input[name="facSgg"]').val(facSido);
	} else {
		alert('시군구를 선택해주세요!');
		return false;
	}

	return true;
}

</script>

</body>
</html>