<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>
<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>사용자 등록 | Honam-BMS</title>
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
		<nav class="manage-tab">
			<ul>
				<li><a href="/user/list">사용자 목록</a></li>
				<li><a href="/user/input">사용자 등록</a></li>
			</ul>
		</nav>
		<!-- S: 사용자 등록 -->
		<div class="list-wrapper" style="width: calc(100% - 80px);">
			<h2>사용자 등록</h2>
			<form:form id="userInfo" modelAttribute="userInfo" method="post" onsubmit="return false;">
				<div class="boardNew">
					<table class="input-table scope-row" summary="사용자 등록  테이블">
						<col class="col-label" />
						<col class="col-input" />
						<tr>
							<th class="col-label" scope="row">
								<form:label path="userGroupName"><spring:message code='user.group.name'/></form:label>
								<span class="icon-glyph glyph-emark-dot color-warning"></span>
							</th>
							<td class="col-input">
								<form:hidden path="userGroupId" />
	 							<form:input path="userGroupName" cssClass="l" readonly="true" />
								<input type="button" id="userGroupButton" value="<spring:message code='user.group.usergroup'/> 선택" />
							</td>
						</tr>
						<tr>
							<th class="col-label" scope="row">
								<form:label path="userId"><spring:message code='id'/></form:label>
								<span class="icon-glyph glyph-emark-dot color-warning"></span>
							</th>
							<td class="col-input">
								<form:hidden path="duplicationValue"/>
								<form:input path="userId" cssClass="m" />
		  						<input type="button" id="userDuplicationButton" value="<spring:message code='overlap.check'/>" />
		  						<span class="table-desc" style="padding-left: 5px;"><spring:message code='minimum.length'/> ${policy.userIdMinLength}</span>
								<form:errors path="userId" cssClass="error" />
							</td>
						</tr>
						<tr>
							<th class="col-label" scope="row">
								<form:label path="userName"><spring:message code='name'/></form:label>
								<span class="icon-glyph glyph-emark-dot color-warning"></span>
							</th>
							<td class="col-input">
								<form:input path="userName" class="m" maxlength="64" />
		  						<form:errors path="userName" cssClass="error" />
							</td>
						</tr>
						<tr>
							<th class="col-label" scope="row">
								<form:label path="password"><spring:message code='password'/></form:label>
								<span class="icon-glyph glyph-emark-dot color-warning"></span>
							</th>
							<td class="col-input">
								<form:password path="password" class="m" />
								<span class="table-desc"><spring:message code='user.input.upper.case'/> ${policy.passwordEngUpperCount}, <spring:message code='user.input.lower.case'/> ${policy.passwordEngLowerCount},
									 <spring:message code='user.input.number'/> ${policy.passwordNumberCount}, <spring:message code='user.input.special.characters'/> ${policy.passwordSpecialCharCount} <spring:message code='user.input.special.characters.need'/>
									 ${policy.passwordMinLength} ~ ${policy.passwordMaxLength}<spring:message code='user.input.do'/></span>
								<form:errors path="password" cssClass="error" />
							</td>
						</tr>
						<tr>
							<th class="col-label" scope="row">
								<form:label path="passwordConfirm"><spring:message code='password.check'/></form:label>
								<span class="icon-glyph glyph-emark-dot color-warning"></span>
							</th>
							<td class="col-input">
								<form:password path="passwordConfirm" class="m" />
								<form:errors path="passwordConfirm" cssClass="error" />
							</td>
						</tr>
					</table>
					<div class="alignCenter">
						<button type="button" class="point" onclick="insertUser();"><spring:message code='save'/></button>
						<button type="button" class="point" onclick="formClear(); return false;">초기화</button>
						<button type="button" class="point" onclick="insertDrone();">목록</button>						
					</div>
				</div>
			</form:form>
		</div>
		<!-- E: 사용자 등록 -->
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
		initMenu("#userMenu");
	});

	
	
</script>

</body>
</html>
