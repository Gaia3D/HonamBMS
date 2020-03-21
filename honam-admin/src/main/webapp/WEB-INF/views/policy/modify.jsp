<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>
<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>환경설정 | Honam-BMS</title>
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="/css/${lang}/style.css">
	<link rel="stylesheet" href="/css/${lang}/honam-bms.css">
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css">
	<link rel="stylesheet" href="/externlib/cesium/Widgets/widgets.css?cache_version=${cache_version}" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
	<link rel="stylesheet" href="/externlib/geostats/geostats.css">
	<style>
		.wrapper {
			padding-top: 50px;
			width: 100%;
			height: calc(100% - 50px);
		}
		.contents-wrapper {
			padding-top: 25px;
			height: calc(100% - 135px);
		   	margin-left: 100px;
		   	width: calc(100% - 100px);
		}
		.list-wrapper {
			position: relative;
			display: inline-block;
			height:100%;
			width:calc(100% - 80px);
			padding: 20px;
			background-color: #fff;
			overflow-y: auto;
		}
		label {
		    padding: 0 5px;
		    min-width: 50px;
		    height: 30px;
		    line-height: 30px;
		    display: inline-block;
		    color: #666;
		}
		.page-content > .button-group, form > .button-group {
		    margin: 30px 0;
		}
		.button-group .center-buttons {
		    text-align: center;
		}
		.l {
		    width: 400px;
		}
		.input-table {
		    border: 1px solid #d9d9d9;
		}
		.table {
		    width: 100%;
		    border-collapse: collapse;
		}
		.scope-row .col-label.l, .scope-row .col-sub-label.l {
		    width: 280px;
		}
		.scope-row .col-label, .scope-row .col-sub-label {
		    width: 130px;
		}
		.scope-row .col-label, .scope-row .col-sub-label, .scope-row .col-data, .scope-row .col-input {
		    text-align: left;
		}
		.input-table th {
		    color: #888;
		    border: 1px solid #d9d9d9;
		    background-color: #f5f5f5;
		    height: 37px;
		    line-height: 37px;
		    text-align: left;
		    padding-left: 20px;
		    padding-right: 20px;
		}
		.scope-row .col-label, .scope-row .col-sub-label, .scope-row .col-data, .scope-row .col-input {
		    text-align: left;
		}
		.input-table td {
		    border: 1px solid #d9d9d9;
		    height: 37px;
		    line-height: 37px;
		    padding-left: 5px;
		    padding-right: 5px;
		}
		.input-table td {
		    color: #666;
		}
		th, td {
		    padding: 0;
		    border: 0;
		}
		.input-table input[type=search], .input-table input[type=password], .input-table input[type=text], .input-table textarea {
	    background-color: #fff;
		}
		.input-table input, .input-table a.button, .input-table button, .input-table label, .input-table .delimeter, .input-table .table-desc, .input-table .icon-glyph, .input-table span, .input-table textarea {
		    display: block;
		    float: left;
		}
		input[type=search], input[type=password], input[type=text], input[type=file] {
		    min-width: 70px;
		    height: 30px;
		}
		input[type=search], input[type=password], input[type=text], input[type=file], textarea {
		    margin: 0;
		    padding: 6px 10px;
		    background-color: #f7f7f7;
		    border: 1px solid #d5d5d5;
		    -webkit-border-radius: 0;
		    -moz-border-radius: 0;
		    border-radius: 0;
		    box-shadow: none;
		    box-sizing: border-box;
		}
		input[type=search], input[type=password], input[type=text], input[type=file], textarea {
		    -webkit-appearance: none;
		    -moz-appearance: none;
		    appearance: none;
		}
		input, select, textarea, button, .ui-widget, .ui-widget input, .ui-widget select, .ui-widget textarea, .ui-widget button {
		    font-family: 'Nanum Gothic', sans-serif;
		    color: #7d7d7d;
		}
		.radio-set input[type=radio], .checkbox-set input[type=checkbox] {
	    margin: 9px 0 8px 5px;
		}
		.input-table input, .input-table a.button, .input-table button, .input-table label, .input-table .delimeter, .input-table .table-desc, .input-table .icon-glyph, .input-table span, .input-table textarea {
		    display: block;
		    float: left;
		}
		.button-group .center-buttons a.button, .button-group .center-buttons button, .button-group .center-buttons input[type="submit"], .button-group .center-buttons input[type="reset"], .button-group .center-buttons input[type="button"] {
		    display: inline-block !important;
		    float: none !important;
		}
		.button-group .button, .button-group button, .button-group input[type="submit"], .button-group input[type="reset"], .button-group input[type="button"] {
		    margin-right: 5px !important;
		}
		a.button {
		    line-height: 28px;
		    padding: 0px 10px;
		    color: #fff;
		}
		.ui-widget-content a {
		    color: #333;
		}
		.button, button, input[type="submit"], input[type="reset"], input[type="button"], .ui-dialog .ui-dialog-buttonpane button {
		    display: inline-block;
		    height: 30px;
		    padding: 6px 10px;
		    box-sizing: border-box;
		    margin: 0;
		    text-align: center;
		    color: #fff;
		    background: #727272;
		    text-transform: uppercase;
		    text-decoration: none;
		    white-space: nowrap;
		    -webkit-border-radius: 3px;
		    -moz-border-radius: 3px;
		    border-radius: 3px;
		    border: 1px solid #636363;
		    cursor: pointer;
		}
	</style>
</head>
<body>
<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
<div class="wrapper">
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	<div class="contents-wrapper">
		<div class="list-wrapper">
			<form:form id="policyContent" modelAttribute="policy" method="post" onsubmit="return false;">
				<table class="input-table scope-row" summary="환경설정 컨텐츠  테이블">
					<col class="col-label l" />
					<col class="col-input" />
					<tr>
						<th class="col-label l" scope="row">
							<form:label path="contentCacheVersion">css, js 갱신용 cache version</form:label>
							<span class="icon-glyph glyph-emark-dot color-warning"></span>
						</th>
						<td class="col-input">
							<form:input path="contentCacheVersion" maxlength="3" cssClass="l"/>
							<form:errors path="contentCacheVersion" cssClass="error" />
						</td>
					</tr>
					<tr>
						<th class="col-label l" scope="row">
							<form:label path="geoserverEnable">Geoserver 사용유무</form:label>
							<span class="icon-glyph glyph-emark-dot color-warning"></span>
						</th>
						<td class="col-input radio-set">
							<form:radiobutton label="사용" path="geoserverEnable" value="true" />
							<form:radiobutton label="미사용" path="geoserverEnable" value="false" />
							<form:errors path="geoserverEnable" cssClass="error" />
						</td>
					</tr>
					<tr>
						<th class="col-label l" scope="row">
							<form:label path="geoserverWmsVersion">WMS 버전</form:label>
							<span class="icon-glyph glyph-emark-dot color-warning"></span>
						</th>
						<td class="col-input">
							<form:input path="geoserverWmsVersion" maxlength="5" cssClass="l" />
							<form:errors path="geoserverWmsVersion" cssClass="error" />
						</td>
					</tr>
					<tr>
						<th class="col-label l" scope="row">
							<form:label path="geoserverDataUrl">데이터 URL</form:label>
							<span class="icon-glyph glyph-emark-dot color-warning"></span>
						</th>
						<td class="col-input">
							<form:input path="geoserverDataUrl" maxlength="256" cssClass="l" />
							<form:errors path="geoserverDataUrl" cssClass="error" />
						</td>
					</tr>
					<tr>
						<th class="col-label l" scope="row">
							<form:label path="geoserverDataWorkspace">작업공간명</form:label>
							<span class="icon-glyph glyph-emark-dot color-warning"></span>
						</th>
						<td class="col-input">
							<form:input path="geoserverDataWorkspace" maxlength="60" cssClass="l" />
							<form:errors path="geoserverDataWorkspace" cssClass="error" />
						</td>
					</tr>
					<tr>
						<th class="col-label l" scope="row">
							<form:label path="geoserverDataStore">저장소명</form:label>
							<span class="icon-glyph glyph-emark-dot color-warning"></span>
						</th>
						<td class="col-input">
							<form:input path="geoserverDataStore" maxlength="60" cssClass="l" />
							<form:errors path="geoserverDataStore" cssClass="error" />
						</td>
					</tr>
					<tr>
						<th class="col-label l" scope="row">
							<form:label path="geoserverUser">사용자 계정</form:label>
							<span class="icon-glyph glyph-emark-dot color-warning"></span>
						</th>
						<td class="col-input">
							<form:input path="geoserverUser" maxlength="256" cssClass="l" />
							<form:errors path="geoserverUser" cssClass="error" />
						</td>
					</tr>
					<tr>
						<th class="col-label l" scope="row">
							<form:label path="geoserverPassword">비밀번호</form:label>
							<span class="icon-glyph glyph-emark-dot color-warning"></span>
						</th>
						<td class="col-input">
							<form:input path="geoserverPassword" maxlength="256" cssClass="l" />
							<form:errors path="geoserverPassword" cssClass="error" />
						</td>
					</tr>
					<tr>
						<th class="col-label l" scope="row">
							<form:label path="geoserverImageproviderEnable">ImageryProvider 사용유무</form:label>
							<span class="icon-glyph glyph-emark-dot color-warning"></span>
						</th>
						<td class="col-input radio-set">
							<form:radiobutton label="사용" path="geoserverImageproviderEnable" value="true" />
							<form:radiobutton label="미사용(기본값)" path="geoserverImageproviderEnable" value="false" />
							<form:errors path="geoserverImageproviderEnable" cssClass="error" />
						</td>
					</tr>
					<tr>
						<th class="col-label l" scope="row">
							<form:label path="geoserverImageproviderUrl">ImageryProvider 요청 URL</form:label>
						</th>
						<td class="col-input">
							<form:input path="geoserverImageproviderUrl" maxlength="256" cssClass="l" />
							<form:errors path="geoserverImageproviderUrl" cssClass="error" />
						</td>
					</tr>
					<tr>
						<th class="col-label l" scope="row">
							<form:label path="geoserverImageproviderLayerName">ImageryProvider 레이어 명</form:label>
						</th>
						<td class="col-input">
							<form:input path="geoserverImageproviderLayerName" maxlength="60" cssClass="l" />
							<form:errors path="geoserverImageproviderLayerName" cssClass="error" />
						</td>
					</tr>
					<tr>
						<th class="col-label l" scope="row">
							<form:label path="geoserverImageproviderStyleName">ImageryProvider 스타일 명</form:label>
						</th>
						<td class="col-input">
							<form:input path="geoserverImageproviderStyleName" maxlength="60" cssClass="l" />
							<form:errors path="geoserverImageproviderStyleName" cssClass="error" />
						</td>
					</tr>
					<tr>
						<th class="col-label l" scope="row">
							<form:label path="geoserverImageproviderParametersWidth">ImageryProvider 레이어 이미지 가로 크기</form:label>
						</th>
						<td class="col-input">
							<form:input path="geoserverImageproviderParametersWidth" cssClass="l" onKeyPress="return numkeyCheck(event);" />
							<form:errors path="geoserverImageproviderParametersWidth" cssClass="error" />
						</td>
					</tr>
					<tr>
						<th class="col-label l" scope="row">
							<form:label path="geoserverImageproviderParametersHeight">ImageryProvider 레이어 이미지 세로 크기</form:label>
						</th>
						<td class="col-input">
							<form:input path="geoserverImageproviderParametersHeight" cssClass="l" onKeyPress="return numkeyCheck(event);" />
							<form:errors path="geoserverImageproviderParametersHeight" cssClass="error" />
						</td>
					</tr>
					<tr>
						<th class="col-label l" scope="row">
							<form:label path="geoserverImageproviderParametersFormat">ImageryProvider 레이어 포맷형식</form:label>
						</th>
						<td class="col-input">
							<form:input path="geoserverImageproviderParametersFormat" maxlength="30" cssClass="l" />
							<form:errors path="geoserverImageproviderParametersFormat" cssClass="error" />
						</td>
					</tr>
					<tr>
						<th class="col-label l" scope="row">
							<form:label path="geoserverTerrainproviderEnable">TerrainProvider 사용유무</form:label>
							<span class="icon-glyph glyph-emark-dot color-warning"></span>
						</th>
						<td class="col-input radio-set">
							<form:radiobutton label="사용" path="geoserverTerrainproviderEnable" value="true" />
							<form:radiobutton label="미사용(기본값)" path="geoserverTerrainproviderEnable" value="false" />
							<form:errors path="geoserverTerrainproviderEnable" cssClass="error" />
						</td>
					</tr>
					<tr>
						<th class="col-label l" scope="row">
							<form:label path="geoserverTerrainproviderUrl">TerrainProvider 요청 URL</form:label>
						</th>
						<td class="col-input">
							<form:input path="geoserverTerrainproviderUrl" maxlength="256" cssClass="l" />
							<form:errors path="geoserverTerrainproviderUrl" cssClass="error" />
						</td>
					</tr>
					<tr>
						<th class="col-label l" scope="row">
							<form:label path="geoserverTerrainproviderLayerName">TerrainProvider 레이어 명</form:label>
						</th>
						<td class="col-input">
							<form:input path="geoserverTerrainproviderLayerName" maxlength="60" cssClass="l" />
							<form:errors path="geoserverTerrainproviderLayerName" cssClass="error" />
						</td>
					</tr>
					<tr>
						<th class="col-label l" scope="row">
							<form:label path="geoserverTerrainproviderStyleName">TerrainProvider 스타일 명</form:label>
						</th>
						<td class="col-input">
							<form:input path="geoserverTerrainproviderStyleName" maxlength="60" cssClass="l" />
							<form:errors path="geoserverTerrainproviderStyleName" cssClass="error" />
						</td>
					</tr>
					<tr>
						<th class="col-label l" scope="row">
							<form:label path="geoserverTerrainproviderParametersWidth">TerrainProvider 레이어 이미지 가로 크기</form:label>
						</th>
						<td class="col-input">
							<form:input path="geoserverTerrainproviderParametersWidth" cssClass="l" onKeyPress="return numkeyCheck(event);" />
							<form:errors path="geoserverTerrainproviderParametersWidth" cssClass="error" />
						</td>
					</tr>
					<tr>
						<th class="col-label l" scope="row">
							<form:label path="geoserverTerrainproviderParametersHeight">TerrainProvider 레이어 이미지 세로 크기</form:label>
						</th>
						<td class="col-input">
							<form:input path="geoserverTerrainproviderParametersHeight" cssClass="l" onKeyPress="return numkeyCheck(event);" />
							<form:errors path="geoserverTerrainproviderParametersHeight" cssClass="error" />
						</td>
					</tr>
					<tr>
						<th class="col-label l" scope="row">
							<form:label path="geoserverTerrainproviderParametersFormat">TerrainProvider 레이어 포맷 형식</form:label>
						</th>
						<td class="col-input">
							<form:input path="geoserverTerrainproviderParametersFormat" maxlength="30" cssClass="l" />
							<form:errors path="geoserverTerrainproviderParametersFormat" cssClass="error" />
						</td>
					</tr>
				</table>
				<div class="button-group">
					<div class="center-buttons">
						<a href="#" onclick="updatePolicy();" class="button">저장</a>
					</div>
				</div>
			</form:form>
		</div>
	</div>
</div>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/externlib/ajax-cross-origin/jquery.ajax-cross-origin.min.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/Honam-bms.js"></script>
<script type="text/javascript">
//초기 로딩 설정
$(document).ready(function() {
	initMenu("#configMenu");
});
var updatePolicyFlag = true;
function updatePolicy() {
    if(updatePolicyFlag) {
    	updatePolicyFlag = false;
        var formData = $('#policyContent').serialize();
        $.ajax({
			url: "/policies/" + "${policy.policyId}",
			type: "POST",
			headers: {"X-Requested-With": "XMLHttpRequest"},
	        data: formData,
			success: function(msg){
				if(msg.statusCode <= 200) {
					alert("환경설정이 수정 되었습니다");
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
					console.log("---- " + msg.message);
				}
				updatePolicyFlag = true;
			},
			error:function(request, status, error){
		        alert(JS_MESSAGE["ajax.error.message"]);
		        updatePolicyFlag = true;
			}
		});
    } else {
        alert("진행 중입니다.");
        return;
	}
}
</script>

</body>
</html>