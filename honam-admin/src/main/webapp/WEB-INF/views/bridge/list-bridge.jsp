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
				<form:form id="searchForm" modelAttribute="bridge" method="get" action="#" onsubmit="return false;">
					<ul class="projectSearch input-group row">
						<li class="input-set">
							<label>행정구역</label>
							<form:select path="sdoCode" name="sdoCode" class="select" style="width: 97px;">
							</form:select>
							<form:select path="sggCode" name="sggCode" class="select" style="width: 94px;">
								<option value=""> 시군구 </option>
							</form:select>
						</li>
						<li class="input-set">
							<label>관리주체</label>
							<form:select path="mngOrg" name="mngOrg" class="select" style="width: 196px;">
							</form:select>
						</li>
						<li class="input-set">
							<label>검색대상</label>
							<form:select path="bridgeType" name="bridgeType" class="select" style="width: 196px;">
								<option value="">전체</option>
								<option value="model">3D교량 모델 </option>
								<option value="sensor">접촉식센서</option>
								<option value="sat">위성영상</option>
								<option value="drone">드론영상</option>
							</form:select>
						</li>
						<li class="input-set">
							<label for="searchWord">교량명</label>
							<form:input path="brgNam" type="search" size="25" cssClass="m" />
						</li>
						<li class="input-set btn">
							<button type="submit" value="search" class="point" id="search" onClick="getListBridge();">검색</button>
						</li>
					</ul>
				</form:form>
				<!-- E: 교량 검색 입력 폼 -->
				<!-- S: 교량 목록 -->
				<div id="bridgeListTable"></div>
				<%@ include file="/WEB-INF/views/bridge/list-bridge-template.jsp" %>	
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
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/Honam-bms.js"></script>
<script type="text/javascript" src="/js/NumberFormatter.js"></script>
<script type="text/javascript" src="/js/MouseControll.js"></script>
<!-- <script type="text/javascript" src="/js/Geospatial.js"></script> -->
<!-- <script type="text/javascript" src="/js/DistrictControll.js"></script> -->
<!-- <script type="text/javascript" src="/js/MapControll.js"></script> -->
<!-- <script type="text/javascript" src="/js/BridgeAttribute.js"></script> -->
<script type="text/javascript">
	var viewer = null;
	
   	// 초기 로딩 설정
	$(document).ready(function() {
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
		
	   	viewer = new Cesium.Viewer('MapContainer', {imageryProvider : imageryProvider, baseLayerPicker : false,
	   		animation:false, timeline:false, geocoder:false, navigationHelpButton: false, fullscreenButton:false, homeButton: false, sceneModePicker: false });
	   	var satValueCount = null;
	   	
	   	MouseControll(viewer,null,null);
		getListSdo();
	   	getListManageOrg();
		getListBridge();
		getListCentroidBridge();
// 		DistrictControll(viewer);
// 		MapControll(viewer);
// 		drawBridge();
	});
   	
	$("#sdoCode").on("change", function() {
		var sdoCode = $("#sdoCode").val();
		if(sdoCode) {
			getListSgg(sdoCode);		
		}
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
	
	// 관리주체 목록 로딩
	function getListManageOrg() {
		var url = "/bridges/manage";
		$.ajax({
		    url: url,
		    type: "GET",
		    dataType: "json",
		    success : function(res) {
		    	if(res.statusCode <= 200) {
		            var bridgeList = res.bridgeList;
		            var content = "<option value=''>전체</option>";
		            for(var i=0, len=bridgeList.length; i < len; i++) {
		                var bridge = bridgeList[i];
		                content += '<option value=' + bridge.mngOrg + '>' + bridge.mngOrg + '</option>';
		            }
		            $('#mngOrg').html(content);
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

	function getListCentroidBridge() {
		$.ajax({
		    url: "/bridges/centroids",
		    type: "GET",
		    dataType: "json",
		    success : function(res) {
		    	if(res.statusCode <= 200) {
		      	  addMarkerBillboards(res.bridgeList);
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

	function addMarkerBillboards(bridgeList) {
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
		            fillColor : {
		                rgba : [0, 0, 0, 255]
		            },
		            font : "12pt Lucida Console",
		            scaleByDistance : new Cesium.NearFarScalar(25000, 1.0, 50000, 0.0),
		            pixelOffset : new Cesium.Cartesian2(5, 30),
		            style: "FILL",
		            text : bridge.brgNam,
		            showBackground : true,
		            backgroundColor : {
		                rgba : [112, 89, 57, 200]
		            }
		        }
		    });
		}
	}
	
	// 교량 목록 로드
	function getListBridge(number) {
		var pageNo = (number === undefined) ? 1 : number;
		var parms = {
				pageNo : pageNo,
				brgNam : $("#brgNam").val(),
				sdoCode : $("#sdoCode").val(),
				sggCode : $("#sggCode").val(),
				mngOrg : $("#mngOrg").val(),
				bridgeType : $("#bridgeType").val()
		}
		$.ajax({
			url: '/bridges',
			type: 'GET',
			data: parms,
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
