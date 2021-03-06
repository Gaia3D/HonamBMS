<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script id="templateBridgeDetail" type="text/x-handlebars-template">
<div class="subHeader">
	<h2>교량 검색  > 상세 정보</h2>
	<div class="ctrlBtn">
		<a href="#" onClick="viewBridgeList(); return false;" style="padding-top:3px; font-size:13px; color: #fff;">목록 보기</a>
	</div>
</div>

<div class="subContents" style="height: calc(100% - 65px);">
	<table class="list-table scope-col">
		<col class="col-number" />
		<col class="col-toggle" />
		<col class="col-number" />
		<col class="col-toggle" />
		<thead>
		<tr>
			<th colspan="4" scope="col" style="background:#D3D3D3";>
				<b>{{bridge.brgNam}}</b> [ <a href ="#" onclick="viewBridgeDetailInfo();">자세히</a> ]
			</th>
		</tr>
		</thead>
		<tbody>
			<tr>
				<td class="col-number" style="background:#efefef";>위성영상</td>
				<td class="col-name">{{bridge.satGrade}}</td>
				<td class="col-number" style="background:#efefef";>내하성능</td>
				<td class="col-name"><a href ="#" onclick="viewBridgeLCCGraph();">{{bridge.bridgeLcc}}</a></td>
			</tr>
			<tr>
				<td class="col-number" style="background:#efefef";>목표성능</td>
				<td class="col-name">{{bridge.bridgeCm}}</td>
				<td class="col-number" style="background:#efefef";>교량등급</td>
				<td class="col-name">{{bridge.grade}}</td>
			</tr>
		</tbody>
	</table>

	<ul id="bridgeSubContents" class="listDrop" style="margin-top: 20px;height: calc(100% - 150px);overflow: auto;">
		<li id="dataContent">
			<p onclick="toggleSubContent('data', 'dataInfo');">교량 3차원 모델<span class="collapse-icon">icon</span></p>
			<div id="dataInfo" class="listContents">
				<ul class="bridgeSubInfoGroup">
					<li>
{{#greaterThan bridge.dataId 0}}
						<input type="radio" id="dataVisibleTrue" name="dataVisible" value="true"
							onclick="show3DData('{{bridge.dataGroupId}}', '{{bridge.facNum}}', 'true');" checked="checked" style="width : 50px;" />
						<label for="dataVisibleTrue" style="width : 50px;">표시</label>
						<input type="radio" id="dataVisibleFalse" name="dataVisible" value="false"
							onclick="show3DData('{{bridge.dataGroupId}}', '{{bridge.facNum}}', 'false');"  style="width : 50px;" />
						<label for="dataVisibleFalse" style="width : 50px;">비표시</label>
{{else}}
					없음
{{/greaterThan}}
					</li>
				</ul>
			</div>
		</li>
		<li id="satContent" style="margin-top: 10px;">
			<p onclick="toggleSubContent('sat', 'satInfo');">위성 영상 - 교량 평균 변위 정보<span class="collapse-icon">icon</span></p>
			<div id="satInfo" class="listContents">
				<ul class="bridgeSubInfoGroup">
					<li>
						<input type="radio" id="satVisibleTrue" name="satVisible" value="true"
							onclick="showSat('{{bridge.gid}}', '{{bridge.facNum}}', 'true');" style="width : 50px;" />
						<label for="satVisibleTrue" style="width : 50px;">표시</label>
						<input type="radio" id="satVisibleFalse" name="satVisible" value="false"
							onclick="showSat('{{bridge.gid}}', '{{bridge.facNum}}', 'false');" checked="checked" style="width : 50px;" />
						<label for="satVisibleFalse" style="width : 50px;">비표시</label>
					</li>
					<li>
						<table>
							<tr>
								<td style="width:20px;height:20px;background-color:#FF0000"></td>
								<td style="width: 100px;margin: auto; text-align: center">4mm/yr 이상 </td>
								<td style="width:20px;height:20px;background-color:#FF4500"></td>
								<td style="width: 100px;margin: auto; text-align: center">3 ~ 4mm/yr</td>
							</tr>
							<tr>
								<td style="width:20px;height:20px;background-color:#FF8C00"></td>
								<td style="width: 100px;margin: auto; text-align: center">2 ~ 3mm/yr</td>
								<td style="width:20px;height:20px;background-color:#FFFF00"></td>
								<td style="width: 100px;margin: auto; text-align: center">1 ~ 2mm/yr</td>
							</tr>
							<tr>
								<td style="width:20px;height:20px;background-color:#00FF00"></td>
								<td style="width: 100px;margin: auto; text-align: center">0 ~ 1mm/yr</td>
								<td style="width:20px;height:20px;background-color:#00FF7F"></td>
								<td style="width: 100px;margin: auto; text-align: center">-1 ~ 0mm/yr</td>
							</tr>
							<tr>
								<td style="width:20px;height:20px;background-color:#00FFFF"></td>
								<td style="width: 100px;margin: auto; text-align: center">-2 ~ -1mm/yr</td>
								<td style="width:20px;height:20px;background-color:#00BFFF"></td>
								<td style="width: 100px;margin: auto; text-align: center">-3 ~ -2mm/yr</td>
							</tr>
							<tr>
								<td style="width:20px;height:20px;background-color:#0000FF"></td>
								<td style="width: 100px;margin: auto; text-align: center">-4 ~ -3mm/yr</td>
								<td style="width:20px;height:20px;background-color:#00008B"></td>
								<td style="width: 100px;margin: auto; text-align: center">-4mm/yr 이하</td>
							</tr>
						</table>
					</li>
				</ul>
			</div>
		</li>
		<li id="sensorContent" style="margin-top: 10px;">
			<p onclick="toggleSubContent('sensor', 'sensorInfo');">접촉식 센서<span class="collapse-icon">icon</span></p>
			<div id="sensorInfo" class="listContents">
				<ul class="bridgeSubInfoGroup">
					<li>
						<input type="radio" id="sensorVisibleTrue" name="sensorVisible" value="true"
							onclick="showSensorData('true');" checked="checked" style="width : 50px;" />
						<label for="sensorVisibleTrue" style="width : 50px;">표시</label>
						<input type="radio" id="sensorVisibleFalse" name="sensorVisible" value="false"
							onclick="showSensorData('false');" style="width : 50px;" />
						<label for="sensorVisibleFalse" style="width : 50px;">비표시</label>
					</li>
					<li>
						<div style="width:20px;height:20px;background-color:red">
							<lable style="width: 150px; margin-left:30px;display:inline-block">ACC (가속도계)</lable>
						</div>
					</li>
					<li>
						<div style="width:20px;height:20px;background-color:green">
							<lable style="width: 150px; margin-left:30px;display:inline-block">STR (변형률계)</lable>
						</div>
					</li>
					<li>
						<div style="width:20px;height:20px;background-color:blue">
							<lable style="width: 150px; margin-left:30px;display:inline-block">TMP (온도계)</lable>
						</div>
					</li>
				</ul>
			</div>
		</li>
		<li  id="droneContent" style="margin-top: 10px;">
			<p onclick="toggleSubContent('drone', 'droneInfo');">드론 영상<span class="collapse-icon">icon</span></p>
			<div id="droneInfo" class="listContents">
				<ul class="bridgeSubInfoGroup">
{{#if bdfCreateDateList}}
					<li> 정사 영상 : 
						<select id="orthoList" style="width: 100px;">
							<option value="orthoi_19-04-27">2019-04-27</option>
							<option value="orthoi_19-07-06">2019-07-06</option>
							<option value="orthoi_19-10-04">2019-10-04</option>
						</select>
						<input type="checkbox" name="orthoi"
							onclick="initImageLayer('ortho')" style="width : 30px;" />
						<label for="ortho" style="width : 50px;">표시</label>
					</li>
					<li> 변화 탐지 영상 : 
						<select id="changedetectionList" style="width: 80px;">
							<option value="change_12">1-2 시기</option>
							<option value="change_23">2-3 시기</option>
						</select>	
						<input type="checkbox" name="change" 
							onclick="initImageLayer('changedetection')"  style="width : 30px;" />
						<label for="change" style="width : 50px;">표시</label>	
					</li>
					
					<li style="margin-top: 10px; margin-bottom: 5px;"> 촬영 날짜 :
					<select id="droneCreateDateList" style="margin-right: 5px">
						{{#each bdfCreateDateList}}
							<option value="{{this}}">{{this}}</option>
						{{/each}}
					</select>
					<button class="intd" onclick="getListBridgeDroneFile()">검색</button>

					<li>
						<input type="radio" id="droneVisibleTrue" name="droneVisible" value="true"
							onclick="showDroneData('true');" checked="checked" style="width : 50px;" />
						<label for="droneVisibleTrue" style="width : 50px;">표시</label>
						<input type="radio" id="sensorVisibleFalse" name="droneVisible" value="false"
							onclick="showDroneData('false');" style="width : 50px;" />
						<label for="droneVisibleFalse" style="width : 50px;">비표시</label>
					</li>

			<dl class="legendWrap" style="margin-top: 5px;">
				<dt>교량 구조</dt>
				<dd><span class="legend co">T</span>상판</dd>
				<dd><span class="legend pr">P</span>교각</dd>
			</dl>							
<div class="count">
	전체 <em>{{pagination.totalCount}}</em> 건
	{{pagination.pageNo}} / {{pagination.lastPage}} 페이지
</div>
<div>
	<table class="list-table scope-col">
		<col class="col-number" />
		<col class="col-toggle" />
		<col class="col-name" />
		<thead>
			<tr>
				<th scope="col" class="col-number">번호</th>
				<th scope="col" class="col-toggle">파일명</th>
				<th scope="col" class="col-name">이동</th>
			</tr>
		</thead>
		<tbody id="transferDataList">
		{{#if bdfList}}
			{{#each bdfList}}
				<tr>
					<td class="col-number">{{#replaceRowNumber ../pagination.pageNo @index}}{{/replaceRowNumber}}</td>
					<td class="col-toggle">
				{{#ifMatch bridgeStructure '상판'}}
						<span class="legend co">T</span>
				{{/ifMatch}}
				{{#ifMatch bridgeStructure '교각'}}
						<span class="legend pr">P</span>
				{{/ifMatch}}
						<a href="#" onclick="window.open('/upload/{{filePath}}/{{fileName}}', 'popup', 'width=600,height=300'); return false;">{{fileName}}</a>
					</td>
					<td class="col-name"><a href="#" onclick="gotoFlyBridge({{longitude}}, {{latitude}}, {{altitude}}, {{uploadDroneFileId}}, {{ogcFid}}); return false;">이동</a></td>
				</tr>
			{{/each}}
		{{else}}
			<tr><td colspan="4" style="text-align:center;">검색된 데이터가 없습니다.</td></tr>
		{{/if}}
		</tbody>
	</table>
{{#if pagination.totalCount}}
    <ul class="pagination">
        <li class="ico first" onClick="getListBridgeDroneFile({{pagination.firstPage}})"></li>
    {{#if pagination.existPrePage}}
        <li class="ico forward" onClick="getListBridgeDroneFile({{pagination.prePageNo}})"></li>
    {{/if}}

    {{#forEachStep pagination.startPage pagination.endPage 1}}
        {{#if (indexCompare this ../pagination.pageNo)}}
            <li class="on"><a href='#'>{{this}}</a></li>
        {{else}}
            <li onClick="getListBridgeDroneFile({{this}})"><a href='#'>{{this}}</a></li>
        {{/if}}
    {{/forEachStep}}

    {{#if pagination.existNextPage}}
        <li class="ico back" onClick="getListBridgeDroneFile({{pagination.nextPageNo}})"></li>
    {{/if}}
        <li class="ico end" onClick="getListBridgeDroneFile({{pagination.lastPage}})"></li>
    </ul>
{{/if}}


</div>

{{else}}
						검색된 드론 영상이 없습니다.
{{/if}}
					</li>
				</ul>
			</div>
		</li>
	</ul>

	<div id="bridgeInfoLayer" class="layer" style="top:100px; right:100px; z-index:1; display: none; width: 360px; ">
		<div class="layerHeader">
			<h2>교량 상세정보</h2>
			<div class="ctrlBtn">
				<button type="button" title="닫기" class="layerClose" onClick="closeBridgeDetailInfo()">닫기</button>
			</div>
		</div>
		<ul id="bridgeInfo" class="layerContents">
			<li>
				<label>교량명</label>
				{{bridge.brgNam}}
			</li>
			<li>
				<label>시설물 번호</label>
				{{bridge.facNum}}
			</li>
			<li>
				<label>관리주체</label>
				{{bridge.mngOrg}}
			</li>
			<li>
				<label>주소</label>
				{{bridge.facSido}} {{bridge.facSgg}} {{bridge.facEmd}} {{bridge.facRi}}
			</li>
			<li>
				<label>종별</label>
				{{bridge.facGra}}
			</li>
			<li>
				<label>준공년도</label>
				{{#replaceYear bridge.endAmd}}{{/replaceYear}}
			</li>
			<li>
				<label>설계하중</label>
				{{bridge.dsnWet}}
			</li>
			<li>
				<label>연장 (m)</label>
				{{bridge.brgLen}}
			</li>
			<li>
				<label>교고 (m)</label>
				{{bridge.brgHit}}
			</li>
			<li>
				<label>유효폭 (m)</label>
				{{bridge.effWid}}
			</li>
			<li>
				<label>총폭 (m)</label>
				{{bridge.totWid}}
			</li>
			<li>
				<label>경간수</label>
				{{bridge.spaCnt}}
			</li>
			<li>
				<label>최대경간장 (m)</label>
				{{bridge.maxLen}}
			</li>
			<li>
				<label>교통량</label>
				{{bridge.traCnt}}
			</li>
			<li>
				<label>상부 형식</label>
				{{bridge.uspRep}}
			</li>
			<li>
				<label>하부 형식</label>
				{{bridge.dpiRep}}
			</li>
			<li>
				<label>위성영상기반 상태평가</label>
				{{bridge.satGrade}}
			</li>
			<li>
				<label>내하성능</label>
				{{bridge.bridgeLcc}}
			</li>
			<li>
				<label>유지관리 목표성능</label>
				{{bridge.bridgeCm}}
			</li>
			<li>
				<label>교량등급</label>
				{{bridge.grade}}
			</li>
		</ul>
	</div>
</div>
</script>
