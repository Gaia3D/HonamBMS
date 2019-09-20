<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>교량 상세 | Honam-BMS</title>
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

<div id="wrap" style="height:94.7%; width: 100%;">
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	
	<!-- S: 1depth / 교량 목록 -->
	<div id="leftMenuArea" class="subWrap">
		<!-- S: 교량 명, 목록가기, 닫기 -->
		<div class="subHeader">
			<h2>${bridge.brg_nam}</h2>
			<div class="ctrlBtn">
				<a href="/bridge/list-bridge?${searchParameters}" style="padding-top:3px; font-size:13px; color: #fff;">목록 보기</a>
			</div>
		</div>
		<!-- E: 교량 명, 목록가기, 닫기 -->	
		<!-- S: 교량 상세 정보 -->
		<ul id="projectInfo" class="projectInfo">
			<li title="주소"><label>주소 : </label>
				${bridge.fac_sido} ${bridge.fac_sgg} ${bridge.fac_emd} ${bridge.fac_ri}
			</li>
			<li title="관리주체"><label>관리주체 : </label>
				${bridge.mng_org}
			</li>
			<li class="half" title="종별"><label>종별 : </label>
				${bridge.fac_gra}
			</li>
			<li class="half" title="준공년도"><label>준공년도 : </label>
				${bridge.end_amd.substring(0,4)}
			</li>
			<li class="half" title="연장"><label>연장(m) : </label>
				${bridge.brg_len}
			</li>
			<li class="half" title="폭"><label>폭(m) : </label>
				${bridge.tot_wid}
			</li>
			<li title="유지관리 목표성능"><label>유지관리 목표성능 : </label>
				${bridge.bridge_cm} 
			</li>
			<li title="내하성능"><label>내하성능 : </label>
				${bridge.bridge_lcc} 
			</li>			
			<li title="교량등급"><label>교량등급 : </label>
				${bridge.bridge_grade}
			</li>
		</ul>
		<div class="alignCenter">
			<button type="button" class="basic" onclick="viewBridgeInfo();" />교량 상세정보</button>
		</div>
		<!-- E: 교량 상세 정보 -->
		<!-- S: 교량  레이어 -->	
		<br>
		<div id = "bridgeLayer">	
			<hr> <h3 style="margin: 8px;">Layers</h3> <hr>	
			<ul class="listLayer yScroll" style="height: 450px;">				
				<li id="3dModel">
					<p>3차원 교량 모델</p>
				</li>
				<li id="satImageAnalysis" >
					<p>위성 영상 결과</p>
					<div class="listContents">
						<div class="legend"></div>
					</div>					
				</li>
				<li id="sensor"  >
					<p>접촉식 센서</p>
					<div class="listContents">
						<h3>Display Variable</h3> <hr>				
						<input type="radio" name="sensor" value="ACC" /> ACC (가속도계) <br>
						<input type="radio" name="sensor" value="STR" /> STR (변형률계) <br>
						<input type="radio" name="sensor" value="TMP" /> TMP (온도계) <br>
					</div> 
				</li>
				<li id="droneImage" >
					<p>드론 영상</p>
					<div class="listContents">
						Time, 드론 영상 리스트
					</div>
				</li>
			</ul>
		</div>		
		<!-- E: 교량  레이어 -->		
	</div>
	<!-- E: 1depth / 프로젝트 목록 -->
	
	<!-- S: 화면하단 분석결과영역 -->
	<div class="analysisGraphic">
		<canvas id="analysisGraphic"></canvas>
	</div>
	<!-- E: 화면하단 분석결과영역 -->		
	<!-- S: MAPWRAP -->
	<div id="MapContainer" class="mapWrap">
	</div>
	<div class="ctrlBtn">
		<button type="button" class="divide" title="화면분할">화면분할</button>
		<button type="button" class="fullscreen" title="전체화면">전체화면</button>
	</div>
		
	<div class="mapInfo">
		<span id="positionDD">127.156797°, 38.012334°</span>
		<span><label>고도: </label><span id="positionAlt"><!--10m--></span></span>
	</div>
	<%@ include file="/WEB-INF/views/bridge/bridgeInfo.jsp" %>
	<!-- E: MAPWRAP -->
</div>
<!-- E: wrap -->
	
<script type="text/javascript" src="/externlib/moment-2.22.2/moment-with-locales.min.js"></script>
<script type="text/javascript" src="/externlib/moment-2.22.2/moment.min.js"></script>
<script type="text/javascript" src="/externlib/chartjs/Chart.min.js"></script>
<script type="text/javascript" src="/externlib/geostats/geostats.js"></script>
<script type="text/javascript" src="/externlib/jquery-3.4.1/jquery.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-3.4.1/fixedheadertable.js"></script>
<script type="text/javascript" src="/externlib/cesium/Cesium.js"></script>
<script type="text/javascript" src="/externlib/cesium-navigation/viewerCesiumNavigationMixin.js"></script>
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
	// 초기 위치 설정
	var INIT_WEST = 124.67;
	var INIT_SOUTH = 35.72;
	var INIT_EAST = 128.46;
	var INIT_NORTH = 33.77;
	var rectangle = Cesium.Rectangle.fromDegrees(INIT_WEST, INIT_SOUTH, INIT_EAST, INIT_NORTH);
	Cesium.Camera.DEFAULT_VIEW_FACTOR = 0;
	Cesium.Camera.DEFAULT_VIEW_RECTANGLE = rectangle;
	
	var options = {imageryProvider : imageryProvider, baseLayerPicker : true, 
			animation:false, timeline:false, geocoder:false, navigationHelpButton: false, fullscreenButton:false, homeButton: false, sceneModePicker: false};
	options.policyUrl = "/persistence/json/policy-cesium.json";
	options.dataBaseUrl = "/persistence/json/";
	options.imageBaseUrl = "/images/ko";
	
	var managerFactory;
	var viewer; 
	var satValue, sensorID;
   	var satValueCount = null, sensorIDCount = null;
   	var isVisibleModel;
   	var gid = "${bridge.gid}";
   	var facNum = "${bridge.fac_num}";
   	
	var mago = new Mago3D.Mago3D('MapContainer', options);
	mago.on("finished", function () { 
		managerFactory = this.getManagerFactory();
		var _viewer = managerFactory.getViewer();
		viewer = _viewer;
	   	viewer.extend(Cesium.viewerCesiumNavigationMixin, {});
		viewer.scene.globe.depthTestAgainstTerrain = false;
		viewer.terrainProvider = Cesium.createWorldTerrain({
	            requestWaterMask : false
	        });	
		satValue = viewer.entities.add(new Cesium.Entity());
		sensorID = viewer.entities.add(new Cesium.Entity());	
		getCentroidBridge(viewer, "${bridge.gid}", "${bridge.brg_nam}", "${bridge.bridge_grade}", "${bridge.fac_num}");		
		MouseControll(viewer, "${bridge.gid}", "${bridge.fac_num}");
		MapControll(viewer);
	});
	mago.start();
	
	$(document).ready(function() {
		$("#projectMenu").addClass("on");
		$("#bridgeInfoLayer").hide();
		if(parseFloat("${bridge.bridge_model}") > 0) {
			$('#bridgeLayer ul.listLayer > li:eq(0)').toggleClass('on');
			isVisibleModel = true;
		}
	});

	
	// 교량 상세정보 보기
	function viewBridgeInfo() {
		var bridgeInfoHtml = "<li><label>교량명</label>" + "${bridge.brg_nam}" + "</li>" +
								"<li><label>시설물 번호</label>" + "${bridge.fac_num}" + "</li>" +
								"<li><label>관리주체</label>" + "${bridge.mng_org}" + "</li>" +
								"<li><label>주소</label>" + "${bridge.fac_sido} ${bridge.fac_sgg} ${bridge.fac_emd} ${bridge.fac_ri}" + "</li>" +
								"<li><label>종별</label>" + "${bridge.fac_gra}" + "</li>" +
								"<li><label>준공년도</label>" + "${bridge.end_amd.substring(0,4)}" + "</li>" +
								"<li><label>설계하중</label>" + "${bridge.dsn_wet}" + "</li>" +
								"<li><label>연장 (m)</label>" + "${bridge.brg_len}" + "</li>" +
								"<li><label>교고 (m)</label>" + "${bridge.brg_hit}" + "</li>" +
								"<li><label>유효폭 (m)</label>" + "${bridge.eff_wid}" + "</li>" +
								"<li><label>총폭 (m)</label>" + "${bridge.tot_wid}" + "</li>" +
								"<li><label>경간수</label>" + "${bridge.spa_cnt}" + "</li>" +
								"<li><label>최대경간장 (m)</label>" + "${bridge.max_len}" + "</li>" +
								"<li><label>교통량</label>" + "${bridge.tra_cnt}" + "</li>" +
								"<li><label>상부 형식</label>" + "${bridge.usp_rep}" + "</li>" +
								"<li><label>하부 형식</label>" + "${bridge.dpi_rep}" + "</li>" +
								"<li><label>내하성능</label>" + "${bridge.bridge_lcc}" + "</li>" +
								"<li><label>유지관리 목표성능</label>" + "${bridge.bridge_cm}" + "</li>" +
								"<li><label>교량등급</label>" + "${bridge.bridge_grade}" + "</li>"
		$("#bridgeInfo").html(bridgeInfoHtml);
		$("#bridgeInfoLayer").show();
	} 	
	function closeBridgeInfo() {
		$("#bridgeInfoLayer").hide();
	}	

	$('#bridgeLayer ul.listLayer li > p').click(function () {
		var parentObj = $(this).parent();		
		var index = parentObj.index();
		$('#bridgeLayer ul.listLayer > li:eq('+ index +')').toggleClass('on');
		if(index === 0) {
			isVisibleModel = !isVisibleModel;
			changeMagoStateAPI(managerFactory, isVisibleModel);
		}
  		if(index === 1) {
			satValue.show = !satValue.show;		
		}
		if(!satValue.show) {
			$('.analysisGraphic').css('display','none');
		}
		if(index === 2) {
			sensorID.show = !sensorID.show;		
		}
		if(!sensorID.show) {
			$('.analysisGraphic').css('display','none');
		} 
 	});    
    
</script>
</body>
</html>
