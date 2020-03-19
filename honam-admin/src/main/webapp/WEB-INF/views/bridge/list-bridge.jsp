<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>교량 검색 | Honam-BMS</title>
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="/css/${lang}/style.css">
	<link rel="stylesheet" href="/css/${lang}/honam-bms.css">
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css">
	<link rel="stylesheet" href="/externlib/cesium/Widgets/widgets.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
</head>

<body>
<%@ include file="/WEB-INF/views/layouts/header.jsp" %>

<div id="wrap">
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>

	<!-- S: 1depth / 프로젝트 목록 -->
	<div id= "leftMenuArea" class="subWrap">
		<div id="bridgeContent">
			<!-- S: 프로젝트 제목, 목록가기, 닫기 -->
			<div class="subHeader">
				<h2>교량 검색 </h2>
				<div id="menuCloseButton" class="ctrlBtn">
					<button type="button" title="닫기" class="close">닫기</button>
				</div>
			</div>
			<!-- E: 프로젝트 제목, 목록가기, 닫기 -->
	
			<div class="subContents">
				<!-- S: 교량 검색 입력 폼 -->
				<form:form id="searchForm" modelAttribute="bridge" method="post" action="/bridge/list-bridge" onsubmit="return searchCheck();">
					<ul class="projectSearch input-group row">
						<li class="input-set">
							<label for="searchWord">교량명</label>
							<form:input path="searchValue" type="search" size="25" cssClass="m" />
							<form:hidden path="searchWord" value="brgNam" />
							<form:hidden path="searchOption" value="1" />
						</li>
						<li class="input-set">
							<label>주소</label>
							<form:select path="sdoCode" name="sdoCode" class="select" style="width: 97px;">
								<option value=""> 시도 </option>
							</form:select>
							<form:select path="sggCode" name="sggCode" class="select" style="width: 85px;">
								<option value=""> 시군구 </option>
							</form:select>
						</li>
						<li class="input-set">
							<label>관리주체</label>
							<form:select path="mngOrg" name="mngOrg" class="select" style="width: 187px;">
							</form:select>
						</li>
						<li class="input-set btn">
							<button type="submit" value="search" class="point" id="search">검색</button>
						</li>
					</ul>
				</form:form>
				<!-- E: 교량 검색 입력 폼 -->
				<!-- S: 교량 목록 -->
				<div id="bridgeListTable">
					<%@ include file="/WEB-INF/views/bridge/list-bridge-template.jsp" %>	
				</div>
				<!-- E: 교량 목록 -->
			</div>
		</div>
		<div id="bridgeGroupContent" style="display: none;">
			<%@ include file="/WEB-INF/views/bridge-group/list.jsp" %>
		</div>
		<div id="bridgeManageContent" style="display: none;">
		</div>
		<div id="configContent" style="display: none;">
		</div>
	</div>
	<!-- E: 1depth / 프로젝트 목록 -->
	<!-- S: MAPWRAP -->
	<div id="MapContainer" class="mapWrap" >
		<div class="mapInfo">
			<span id="positionDD">127.156797°, 38.012334°</span>
			<span><label>고도: </label><span id="positionAlt"><!--10m--></span></span>
		</div>
	</div>
	<!-- E: MAPWRAP -->
</div>
<!-- E: wrap -->

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/externlib/cesium/Cesium.js"></script>
<script type="text/javascript" src="/externlib/handlebars-4.1.2/handlebars.js"></script>
<script type="text/javascript" src="/js/${lang}/handlebarsHelper.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/Honam-bms.js"></script>
<script type="text/javascript" src="/js/Geospatial.js"></script>
<script type="text/javascript" src="/js/DistrictControll.js"></script>
<script type="text/javascript" src="/js/NumberFormatter.js"></script>
<script type="text/javascript" src="/js/MapControll.js"></script>
<script type="text/javascript" src="/js/MouseControll.js"></script>
<script type="text/javascript" src="/js/BridgeAttribute.js"></script>
<script type="text/javascript">
	// 초기 위치 설정
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


   	// 초기 로딩 설정
	$(document).ready(function() {
		$("#bridgeMenu").addClass("on");
		DistrictControll(viewer);
		MouseControll(viewer,null,null);
		MapControll(viewer);
		loadManageOrg();
		getListBridge();
// 		drawBridge();
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

//		if(cnt == 1) {
//			cameraFlyTo(longitude, latitude, 200000, 3);
//		}

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
	
	function getListBridge() {
		$.ajax({
			url: '/bridges',
			type: 'GET',
			headers: {'X-Requested-With': 'XMLHttpRequest'},
			dataType: 'json',
			success: function(res){
				if(res.statusCode <= 200) {
					res.pagination.pageList = [];
					var start = res.pagination.startPage;
					var end = res.pagination.endPage;
					for(i = start; i <= end; i++) {
						res.pagination.pageList.push(i);
					}
					var template = Handlebars.compile($("#templateBridgeList").html());
					var htmlList = template(res);
					$("#bridgeListTable").html("");
					$("#bridgeListTable").append(htmlList);
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

</script>
</body>
</html>
