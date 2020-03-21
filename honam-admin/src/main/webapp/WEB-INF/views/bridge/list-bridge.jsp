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
<div id="loadingWrap">
	<div class="loading">
		<span class="spinner"></span>
	</div>
</div>
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
		<div id ="bridgeDetailContent" style="display:none;">
			<div id="BridgeDetailInfoArea"></div>
			<%@ include file="/WEB-INF/views/bridge/detail-bridge-template.jsp" %>
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
	<%@ include file="/WEB-INF/views/layouts/toolbar.jsp" %>
</div>
<!-- E: wrap -->

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/externlib/cesium/Cesium.js"></script>
<script type="text/javascript" src="/externlib/handlebars-4.1.2/handlebars.js"></script>
<script type="text/javascript" src="/externlib/moment-2.22.2/moment-with-locales.min.js"></script>
<script type="text/javascript" src="/js/mago3d.js"></script>
<script type="text/javascript" src="/js/mago3d_lx.js"></script>
<script type="text/javascript" src="/js/${lang}/handlebarsHelper.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/Honam-bms.js"></script>
<script type="text/javascript" src="/js/NumberFormatter.js"></script>
<script type="text/javascript" src="/js/MouseControll.js"></script>
<script type="text/javascript" src="/js/MapControll.js"></script>
<!-- <script type="text/javascript" src="/js/Geospatial.js"></script> -->
<!-- <script type="text/javascript" src="/js/DistrictControll.js"></script> -->
<!-- <script type="text/javascript" src="/js/BridgeAttribute.js"></script> -->
<script type="text/javascript">
	var viewer = null;
	//TODO: policy 개발 후 변경 
	var HONAMBMS = HONAMBMS || {
		policy : ${policy}
	};
	
   	// 초기 로딩 설정
	$(document).ready(function() {
		/* 
		
		var imageryProvider = new Cesium.ArcGisMapServerImageryProvider({
			url: 'https://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer',
			enablePickFeatures: false
		});
		
	   	viewer = new Cesium.Viewer('MapContainer', {imageryProvider : imageryProvider, baseLayerPicker : false,
	   		animation:false, timeline:false, geocoder:false, navigationHelpButton: false, fullscreenButton:false, homeButton: false, sceneModePicker: false }); */

   		magoStart();
	   	
// 		DistrictControll(viewer);
// 		MapControll(viewer);
	});
   	
	$("#sdoCode").on("change", function() {
		var sdoCode = $("#sdoCode").val();
		if(sdoCode) {
			getListSgg(sdoCode);		
		}
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
		cesiumViewerOption.terrainProvider = new Cesium.EllipsoidTerrainProvider();
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
		
		//
		var satValueCount = null;
	   	
	   	MouseControll(viewer,null,null);
	   	MapControll(viewer);
	   	
	   	dataGroupList();
	   	
		getListSdo();
	   	getListManageOrg();
		getListBridge();
		getListCentroidBridge();
		initBridgeLayer();
	}
	
	// 시도 목록
	function getListSdo() {
		$.ajax({
	        url: "/bridges/sdos",
	        type: "GET",
	        dataType: "json",
	        success : function(msg) {
	        	if(msg.statusCode <= 200) {
	                var sdoList = msg.sdoList;
	                var content = "<option value=''> 시도 </option>";
	                for(var i=0, len=sdoList.length; i < len; i++) {
	                    var sdo = sdoList[i];
                    	content += '<option value=' + sdo.sdoCode + '>' + sdo.name + '</option>';
	                }
	                $('#sdoCode').html(content);
	        	} else {
	        		if(msg.errorCode === "user.session.empty") {
	        			//alert(JS_MESSAGE[msg.errorCode]);
	        			location.href = "/sign/signin";
	        			return;
	        		} else {
	        			alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);	        			
	        		}
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
	        success : function(msg) {
	        	if(msg.statusCode <= 200) {
	                var sggList = msg.sggList;
	                $('#sggCode').empty()
	                var content = "<option value=''> 시군구 </option>";
	                for(var i=0, len=sggList.length; i < len; i++) {
	                    var sgg = sggList[i];
                    	content += '<option value=' + sgg.sggCode + '>' + sgg.name + '</option>';
	                }
	                $('#sggCode').html(content);
	        	} else {
	        		if(msg.errorCode === "user.session.empty") {
	        			//alert(JS_MESSAGE[msg.errorCode]);
	        			location.href = "/sign/signin";
	        			return;
	        		} else {
	        			alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);	        			
	        		}
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
	
	function getBridgeInfo(gid, longitude, latitude) {
		$.ajax({
	        url: "/bridges/" + gid,
	        type: "GET",
	        dataType: "json",
	        success : function(msg) {
	        	if(msg.statusCode <= 200) {
	        		var template = Handlebars.compile($("#templateBridgeDetail").html());
					var htmlList = template(msg.bridge);
					$("#BridgeDetailInfoArea").html("");
					$("#BridgeDetailInfoArea").append(htmlList);
	        		gotoFlyBridge(longitude, latitude);
	        		viewBridgeInfo();
	        		addSensorData(msg.sensorList);
	        	} else {
					alert(JS_MESSAGE[msg.errorCode]);
					console.log("---- " + msg.message);
				}
	        },
	        error: function(request, status, error) {
				alert(JS_MESSAGE["ajax.error.message"]);
			}
	    });
	}
	
	function gotoFlyBridge(longitude, latitude) {
		viewer.camera.flyTo({
		    destination : Cesium.Cartesian3.fromDegrees(longitude, latitude, 200)
		});
	}
	
	function viewBridgeDetailInfo() {
		$("#bridgeInfoLayer").show();
	}
	function closeBridgeDetailInfo() {
		$("#bridgeInfoLayer").hide();
	}
	
	function viewBridgeInfo() {
		$("#bridgeContent").hide();
		$("#bridgeDetailContent").show();
	}
	
	function viewBridgeList() {
		$("#bridgeContent").show();
		$("#bridgeDetailContent").hide();
	}
	
	function initBridgeLayer() {
		var imageryLayers = viewer.imageryLayers;
		if(imageryLayers.length > 0) {
			// 기본 provider, bridge를 제외하고 모두 삭제
			while(imageryLayers.length > 2) {
				imageryLayers.remove(imageryLayers.get(2));
			}
		}
		var geoserverDataUrl = HONAMBMS.policy.geoserverDataUrl;
		var geoserverDataWorkspace = HONAMBMS.policy.geoserverDataWorkspace;
		var provider = new Cesium.WebMapServiceImageryProvider({
	        url : geoserverDataUrl + "/wms",
	        layers : [geoserverDataWorkspace + ':'+ "bridge"],
	        minimumLevel:2,
	        maximumLevel : 20,
	        parameters : {
	            service : 'WMS'
	            ,version : '1.1.1'
	            ,request : 'GetMap'
	            ,transparent : 'true'
	            ,format : 'image/png'
	            ,time : 'P2Y/PRESENT'
	        },
	        enablePickFeatures : false
	    });
		
		viewer.imageryLayers.addImageryProvider(provider);
	}
	
	function addSensorData(sensorList) {
		if(sensorList.length === 0) return;
		var viewer = MAGO3D_INSTANCE.getViewer();
		for(var i=0; i< sensorList.length;i++) {
			var sensorType = sensorList[i].sensorType;
			var x = sensorList[i].lonWgs;
			var y = sensorList[i].latWgs;
			var z = sensorList[i].z;
			var color;
			if(sensorType === "ACC") {
				color = Cesium.Color.RED;
			} else if(sensorType === "STR") {
				color = Cesium.Color.GREEN;
			} else {
				color = Cesium.Color.BLUE;
			}
			viewer.entities.add({
				position : Cesium.Cartesian3.fromDegrees(x, y, z),
				point : new Cesium.PointGraphics({
					pixelSize : 10,
					heightReference : Cesium.HeightReference.CLAMP_TO_GROUND,
					color : color,
					outlineColor : Cesium.Color.WHITE,
					outlineWidth : 2
				})
			});			
		}
	}
	
	function initBridgeGroupLayer() {
		var geoserverDataUrl = HONAMBMS.policy.geoserverDataUrl;
		var geoserverDataWorkspace = HONAMBMS.policy.geoserverDataWorkspace;
		var provider = new Cesium.WebMapServiceImageryProvider({
	        url : geoserverDataUrl + "/wms",
	        layers : [geoserverDataWorkspace + ':'+ "bridge_group_layer"],
	        minimumLevel:2,
	        maximumLevel : 20,
	        parameters : {
	            service : 'WMS'
	            ,version : '1.1.1'
	            ,request : 'GetMap'
	            ,transparent : 'true'
	            ,format : 'image/png'
	            ,time : 'P2Y/PRESENT'
	        },
	        enablePickFeatures : false
	    });
		
		viewer.imageryLayers.addImageryProvider(provider);
	}
	
	//데이터 그룹 목록
	function dataGroupList() {
		let dataGroupMap = new Map();
		$.ajax({
			url: "/data-groups/all",
			type: "GET",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg){
				if(msg.statusCode <= 200) {
					var dataGroupList = msg.dataGroupList;
					if(dataGroupList !== null && dataGroupList !== undefined) {
						var noneTilingDataGroupList = dataGroupList.filter(function(dataGroup){
							dataGroupMap.set(dataGroup.dataGroupId, dataGroup.dataGroupName);
							return !dataGroup.tiling;
						});
						
						HONAMBMS.dataGroup = dataGroupMap;
						
						dataList(noneTilingDataGroupList);
					}
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
				}
			},
			error:function(request,status,error){
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}
	
	// 데이터 정보 목록
	function dataList(dataGroupArray) {
		var dataArray = new Array();
		var dataGroupArrayLength = dataGroupArray.length;
		for(var i=0; i<dataGroupArrayLength; i++) {
			var dataGroup = dataGroupArray[i];
			if(!dataGroup.tiling) {
				var f4dController = MAGO3D_INSTANCE.getF4dController();
				$.ajax({
					url: "/datas/" + dataGroup.dataGroupId + "/list",
					type: "GET",
					headers: {"X-Requested-With": "XMLHttpRequest"},
					dataType: "json",
					success: function(msg){
						if(msg.statusCode <= 200) {
							var dataInfoList = msg.dataInfoList;
							if(dataInfoList != null && dataInfoList.length > 0) {
								var dataInfoFirst = dataInfoList[0];
								var dataInfoGroupId = dataInfoFirst.dataGroupId;
								var group;
								for(var j in dataGroupArray) {
									if(dataGroupArray[j].dataGroupId === dataInfoGroupId) {
										group = dataGroupArray[j];
										break;
									}
								}

								group.datas = dataInfoList;
								f4dController.addF4dGroup(group);
							}
						} else {
							alert(JS_MESSAGE[msg.errorCode]);
						}
					},
					error:function(request,status,error){
						alert(JS_MESSAGE["ajax.error.message"]);
					}
				});
			}
		}
	}
</script>
</body>
</html>
