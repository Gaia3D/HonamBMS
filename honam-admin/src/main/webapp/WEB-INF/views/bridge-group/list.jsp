<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="subHeader">
	<h2>교량 그룹별 유지관리 목표 성능</h2>
	<div id="menuCloseButton" class="ctrlBtn">
		<button type="button" title="닫기" class="close">닫기</button>
	</div>
</div>
<!-- E: 프로젝트 제목, 목록가기, 닫기 -->

<div class="subContents">
	<table class="list-table scope-col">
			<col class="col-number" />
			<col class="col-toggle" />
			<col class="col-name" />
			<thead>
				<tr>
					<th scope="col" class="col-toggle">구분</th>
					<th scope="col" class="col-name">지역명</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="col-number">
						<span class="legend co">G</span>
					</td>
					<td class="col-name">광주 광역시</td>
				</tr>
				<tr>
					<td class="col-number">
						<span class="legend pr">S</span>
					</td>
					<td class="col-name">전라남도 순천시</td>
				</tr>
				<tr>
					<td class="col-number">
						<span class="legend gr">Y</span>
					</td>
					<td class="col-name">전라남도 여수시</td>
				</tr>
			</tbody>
		</table>

	<div id="projectListHeader" class="count" style="margin-top: 20px; margin-bottom: 5px;">
		전체 교량 그룹 <em><fmt:formatNumber value="${bridgeGroupListSize}" type="number"/></em> 건
	</div>
	<div class="transferDataList">
		<table class="list-table scope-col">
			<col class="col-name" />
			<col class="col-number" />
			<col class="col-name" />
			<col class="col-number" />
			<thead>
				<tr>
					<th scope="col" class="col-name">그룹명</th>
					<th scope="col" class="col-name">경로</th>
					<th scope="col" class="col-name">목표<br/>성능</th>
					<th scope="col" class="col-name">보기</th>
				</tr>
			</thead>
			<tbody>
<c:forEach var="bridgeGroup" items="${bridgeGroupList}" varStatus="status">
				<tr>
					<td class="col-name">${bridgeGroup.bridgeGroupName}</td>
					<td class="col-number">
	<c:if test="${bridgeGroup.startArea eq 'gwangju'}">
						<span class="legend co">G</span>
	</c:if>
	<c:if test="${bridgeGroup.startArea eq 'suncheon'}">
						<span class="legend pr">S</span>
	</c:if>
						->
	<c:if test="${bridgeGroup.endArea eq 'suncheon'}">
						<span class="legend pr">S</span>
	</c:if>
	<c:if test="${bridgeGroup.endArea eq 'yeosu'}">
						<span class="legend gr">Y</span>
	</c:if>
					</td>
					<td class="col-number">${bridgeGroup.goalPerformance}</td>
					<td class="col-number">
						<span id="bridgeGroupId-${bridgeGroup.bridgeGroupId}" class="layerGroup" onclick="toggleBridgeList('${bridgeGroup.bridgeGroupId}')">ON</span></td>
				</tr>
				<tr id="${bridgeGroup.bridgeGroupId}-bridgeList" style="display: none;">
				</tr>
</c:forEach>
			</tbody>
		</table>
	</div>
</div>

<%@ include file="/WEB-INF/views/bridge-group/list-bridge-template.jsp" %>
<script type="text/javascript">

	// 우선은 개발 하기 편해서... 여기 두고.. .나중에 옮겨야 함
	function toggleBridgeList(bridgeGroupId) {
		var imageryLayers = viewer.imageryLayers;
		if(imageryLayers.length > 0) {
			// 기본 provider, bridge를 제외하고 모두 삭제
			while(imageryLayers.length > 3) {
				imageryLayers.remove(imageryLayers.get(3));
			}
		}
		if($("#" + bridgeGroupId + "-bridgeList").css("display") == "none"){
			$("#bridgeGroupId-" + bridgeGroupId).html("OFF");
			$("#" + bridgeGroupId + "-bridgeList").show();
			bridgeListByBridgeGroupId(bridgeGroupId);
			bridgeGroupFocus(bridgeGroupId);
		} else {
			$("#bridgeGroupId-" + bridgeGroupId).html("ON");
			$("#" + bridgeGroupId + "-bridgeList").hide();
		}


	}

	function bridgeListByBridgeGroupId(bridgeGroupId) {
		$.ajax({
			url: "/bridge-groups/" + bridgeGroupId + "/bridges",
			type: "GET",
			headers: {'X-Requested-With': 'XMLHttpRequest'},
			dataType: 'json',
			success: function(msg){
				if(msg.statusCode <= 200) {
					var template = Handlebars.compile($("#templateBridgeGroupBridgeList").html());
				    var htmlList = template(msg);
				    $("#" + bridgeGroupId + "-bridgeList").html("");
	                $("#" + bridgeGroupId + "-bridgeList").append(htmlList);
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
		//gotoFlyAPI(MAGO3D_INSTANCE, longitude, latitude, 100, 3);
		//hereIamMarker(longitude, latitude, altitude);
	}

	// 선택한 그룹 하이라이트
	function bridgeGroupFocus(groupId) {
		var geoserverDataUrl = HONAMBMS.policy.geoserverDataUrl;
		var geoserverDataWorkspace = HONAMBMS.policy.geoserverDataWorkspace;
		var provider = new Cesium.WebMapServiceImageryProvider({
	        url : geoserverDataUrl + "/wms",
	        layers : [geoserverDataWorkspace + ':'+ "bridge_group_focus"],
	        minimumLevel:2,
	        maximumLevel : 20,
	        parameters : {
	            service : 'WMS'
	            ,version : '1.1.1'
	            ,request : 'GetMap'
	            ,transparent : 'true'
	            ,format : 'image/png'
	            ,time : 'P2Y/PRESENT'
	            ,viewparams : "groupId:"+groupId
	        },
	        enablePickFeatures : false
	    });

		viewer.imageryLayers.addImageryProvider(provider);
	}
</script>
