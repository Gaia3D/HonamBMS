<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script id="templateBridgeDetail" type="text/x-handlebars-template">
<div class="subHeader">
	<h2>{{brgNam}}</h2>
	<div class="ctrlBtn">
		<a href="#" onClick="viewBridgeList();" style="padding-top:3px; font-size:13px; color: #fff;">목록 보기</a>
	</div>
</div>
<ul id="projectInfo" class="projectInfo">
	<li title="주소"><label>주소 : </label>
		{{facSido}} {{facSgg}} {{facEmd}} {{facRi}}
	</li>
	<li title="관리주체"><label>관리주체 : </label>
		{{mngOrg}}
	</li>
	<li class="half" title="종별"><label>종별 : </label>
		{{facGra}}
	</li>
	<li class="half" title="준공년도"><label>준공년도 : </label>
		{{#replaceYear endAmd}}{{/replaceYear}}
	</li>
	<li class="half" title="연장"><label>연장(m) : </label>
		{{brgLen}}
	</li>
	<li class="half" title="폭"><label>폭(m) : </label>
		{{totWid}}
	</li>
	<li title="유지관리 목표성능"><label>유지관리 목표성능 : </label>
		{{bridgeCm}}
	</li>
	<li title="내하성능"><label>내하성능 : </label>
		{{bridgeLcc}}
	</li>
	<li title="교량등급"><label>교량등급 : </label>
		{{grade}}
	</li>
	</ul>
<div class="alignCenter">
	<button type="button" class="basic" onclick="viewBridgeDetailInfo();">교량 상세정보</button>
</div>

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
			{{brgNam}}
		</li>
		<li>
			<label>시설물 번호</label>
			{{facNum}}
		</li>
		<li>
			<label>관리주체</label>
			{{mngOrg}}
		</li>
		<li>
			<label>주소</label>
			{{facSido}} {{facSgg}} {{facEmd}} {{facRi}}
		</li>
		<li>
			<label>종별</label>
			{{facGra}}
		</li>
		<li>
			<label>준공년도</label>
			{{#replaceYear endAmd}}{{/replaceYear}}
		</li>
		<li>
			<label>설계하중</label>
			{{dsnWet}}
		</li>
		<li>
			<label>연장 (m)</label>
			{{brgLen}}
		</li>
		<li>
			<label>교고 (m)</label>
			{{brgHit}}
		</li>
		<li>
			<label>유효폭 (m)</label>
			{{effWid}}
		</li>
		<li>
			<label>총폭 (m)</label>
			{{totWid}}
		</li>
		<li>
			<label>경간수</label>
			{{spaCnt}}
		</li>
		<li>
			<label>최대경간장 (m)</label>
			{{maxLen}}
		</li>
		<li>
			<label>교통량</label>
			{{traCnt}}
		</li>
		<li>
			<label>상부 형식</label>
			{{uspRep}}
		</li>
		<li>
			<label>하부 형식</label>
			{{dpiRep}}
		</li>
		<li>
			<label>내하성능</label>
			{{bridgeLcc}}
		</li>
		<li>
			<label>유지관리 목표성능</label>
			{{bridgeCm}}
		</li>
		<li>
			<label>교량등급</label>
			{{grade}}
		</li>
	</ul>
</div>

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
				<h3>Sensor Type</h3> <hr>
				<input type="radio" name="sensor" value="ACC" /> ACC (가속도계) <br>
				<input type="radio" name="sensor" value="STR" /> STR (변형률계) <br>
				<input type="radio" name="sensor" value="TMP" /> TMP (온도계) <br><br>
				<div class="legend"></div>
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
</script>
