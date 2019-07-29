<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>교량 검색 | Honam-BMS</title>
	<link rel="stylesheet" href="/css/${lang}/style.css">
	<link rel="stylesheet" href="/css/${lang}/honam-bms.css">
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
						<form:hidden path="searchWord" value="brg_nam" />
						<form:hidden path="searchOption" value="1" />
					</li>
					<li class="input-set">
						<label>주소</label>
						<form:select path="sdoCode" name="sdoCode" class="select" style="width: 97px;">
							<option value> 시도 </option>
						</form:select>
						<form:select path="sggCode" name="sggCode" class="select" style="width: 85px;">
							<option value> 시군구 </option>
						</form:select>					
					</li>
					<li class="input-set">
						<label>관리주체</label>
						<form:select path="mng_org" name="mng_org" class="select" style="width: 187px;">
						</form:select>				
					</li>
					<li class="input-set btn">
						<button type="submit" value="search" class="point" id="search">검색</button>
					</li>
				</ul>
			</form:form>
			<!-- E: 교량 검색 입력 폼 -->				
			<!-- S: 교량 목록 -->	
			<div id="projectListHeader" class="count" style="margin-top: 20px; margin-bottom: 5px;">
				전체 <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em> 건
				<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> 페이지
			</div>
			<div class="transferDataList" style="max-height: 650px; overflow-y: auto; height:590px;">
				<table class="list-table scope-col">
					<col class="col-number" />
					<col class="col-toggle" />
					<col class="col-name" />
					<thead>
						<tr>
							<th scope="col" class="col-number" style="width:5%; font-weight: bold"></th>
							<th scope="col" class="col-toggle">교량 명</th>
							<th scope="col" class="col-name">준공년도</th>
							<th scope="col" class="col-name">상태</th>
						</tr>
					</thead>
					<tbody id="transferDataList">
<c:forEach var="bridge" items="${bridgeList}" varStatus="status">
						<tr>
							<td class="col-number">${status.index+1}</td>
							<td class="col-toggle">
								<a href="/bridge/detail-bridge?gid=${bridge.gid}&pageNo=${pagination.pageNo}${pagination.searchParameters}">
									${bridge.brg_nam} 
								</a>	
							</td>
							<td class="col-name">${bridge.end_amd}</td>
							<td class="col-name">${bridge.bridge_grade}</td>
						</tr>
</c:forEach> 
					</tbody>
				</table>
				<%@ include file="/WEB-INF/views/common/pagination.jsp" %>		
			</div>
			<!-- E: 교량 목록 -->		
		</div>
	</div>
	<!-- E: 1depth / 프로젝트 목록 -->
	<!-- S: MAPWRAP -->
	<div id="MapContainer" class="mapWrap">
	</div>
	<!-- E: MAPWRAP -->
</div>
<!-- E: wrap -->
	
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/Honam-BMS.js"></script>
<script type="text/javascript" src="/js/Geospatial.js"></script>
<script type="text/javascript" src="/js/DistrictControll.js"></script>
<script type="text/javascript" src="/js/BridgeAttribute.js"></script>
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
   		
	$(document).ready(function() {
		$("#projectMenu").addClass("on");
		DistrictControll(viewer);
		loadManageOrg();
		drawBridge();
	});

	function drawBridge() {
		  <c:if test="${!empty bridgeList }">
		  	<c:forEach var="bridge" items="${bridgeList}" varStatus="status">
				getCentroidBridge("${bridge.gid}","${bridge.brg_nam}","${bridge.bridge_grade}")
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
	
	function addMarkerBillboards(bridgeName, longitude, latitude, bridgeGrade, cnt) {
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
		
//		if(cnt == 1) {
//			cameraFlyTo(longitude, latitude, 200000, 3);
//		}
		
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
