<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>
<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>사용자 목록 | Honam-BMS</title>
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
				<li id = "userList"><a href="/user/list">사용자 목록</a></li>
				<li id = "userInput"><a href="/user/input">사용자 등록</a></li>
			</ul>
		</nav>
		<!-- S: 사용자 목록 -->
		<div class="list-wrapper" style="width: calc(100% - 80px);">
			<h2>사용자 목록</h2>
			<div class="boardHeader">
				<div class="button-wrapper-right">
					<button class="basic" onclick="updateUserStatus('LOCK'); return false;">사용자 잠금</button>
					<button class="basic" onclick="updateUserStatus('UNLOCK'); return false;">사용자 해제</button>
				</div>
				<p>
					<spring:message code='all.d'/> <strong></strong><fmt:formatNumber value="${pagination.totalCount}" type="number"/></strong> <spring:message code='search.what.count'/>
					<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
				</p>
			</div>
			<div class="boardList">
				<table class="list-table scope-col" summary="사용자 목록 조회 ">
					<col class="col-checkbox" />
					<col class="col-number" />
					<col class="col-name" />
					<col class="col-name" />
					<col class="col-name" />
					<col class="col-type" />
					<col class="col-functions" />
					<col class="col-functions" />
					<col class="col-functions" />
					<thead>
						<tr>
							<th scope="col" class="col-checkbox"><label for="chkAll" class="hiddenTag"></label><input type="checkbox" id="chkAll" name="chkAll" /></th>
							<th scope="col" class="col-number"><spring:message code='number'/></th>
							<th scope="col"><spring:message code='user.group.name'/></th>
		                    <th scope="col">아이디</th>
		                    <th scope="col">이름</th>
		                    <th scope="col">상태</th>
		                    <th scope="col">마지막 로그인</th>
		                    <th scope="col">편집</th>
		                    <th scope="col">등록일</th>
						</tr>
					</thead>
					<tbody>
<c:if test="${empty userList}">
						<tr>
							<td colspan="9" class="col-none">사용자 목록이 존재하지 않습니다.</td>
						</tr>
</c:if>
<c:if test="${!empty userList}">
	<c:forEach var="user" items="${userList}" varStatus="status">

						<tr>
							<td class="col-checkbox">
								<label for="userId_${user.userId}" class="hiddenTag"></label>
								<input type="checkbox" id="userId_${user.userId}" name="userId" value="${user.userId}" />
							</td>
							<td class="col-number">${pagination.rowNumber - status.index}</td>
							<td class="col-name ellipsis">${user.userGroupName}</td>
							<td class="col-name">${user.userId}</td>
							<td class="col-name">${user.userName}</td>
							<td class="col-type">
								<c:choose>
									<c:when test="${user.status eq '0'}">
										<span class="icon-glyph glyph-on on" style="margin-right:3px;"></span>
										<span class="icon-text"><spring:message code='user.group.in.use' /></span>
									</c:when>
									<c:when test="${user.status eq '1'}">
										<span class="icon-glyph glyph-off off" style="margin-right:3px;"></span>
										<span class="icon-text"><spring:message code='user.group.stop.use'/></span>
									</c:when>
									<c:when test="${user.status eq '2'}">
										<span class="icon-glyph glyph-off off" style="margin-right:3px;"></span>
										<span class="icon-text"><spring:message code='user.group.lock.password'/></span>
									</c:when>
									<c:when test="${user.status eq '3'}">
										<span class="icon-glyph glyph-off off" style="margin-right:3px;"></span>
										<span class="icon-text"><spring:message code='user.group.dormancy'/></span>
									</c:when>
									<c:when test="${user.status eq '4'}">
										<span class="icon-glyph glyph-off off" style="margin-right:3px;"></span>
										<span class="icon-text"><spring:message code='user.group.expires'/></span>
									</c:when>
									<c:when test="${user.status eq '5'}">
										<span class="icon-glyph glyph-off off" style="margin-right:3px;"></span>
										<span class="icon-text"><spring:message code='user.group.delete'/></span>
									</c:when>
									<c:when test="${user.status eq '6'}">
										<span class="icon-glyph glyph-off off" style="margin-right:3px;"></span>
										<span class="icon-text"><spring:message code='user.group.temporary.password'/></span>
									</c:when>
								</c:choose>
							</td>
							<td class="col-type">
								<fmt:parseDate value="${user.lastSigninDate}" var="viewLastSigninDate" pattern="yyyy-MM-dd HH:mm:ss"/>
								<fmt:formatDate value="${viewLastSigninDate}" pattern="yyyy-MM-dd HH:mm"/>
							</td>
		                    <td class="col-type">
								<a href="/user/modify?userId=${user.userId}" class="image-button button-edit"><spring:message code='modified'/></a>&nbsp;&nbsp;
		                    	<a href="/user/delete?userId=${user.userId}" onclick="return deleteWarning();" class="image-button button-delete"><spring:message code='delete'/></a>
		                    </td>
							<td class="col-type">
								<fmt:parseDate value="${user.insertDate}" var="viewInsertDate" pattern="yyyy-MM-dd HH:mm:ss"/>
								<fmt:formatDate value="${viewInsertDate}" pattern="yyyy-MM-dd HH:mm"/>
							</td>
						</tr>
	</c:forEach>
</c:if>
					</tbody>
				</table>
			</div>
			<ul class="pagination"></ul>
			<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
		</div>
		<!-- E: 사용자 목록 -->
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
		$('#userInput').css('background-color','#999');
	});

	//전체 선택
	$("#chkAll").click(function() {
		$(":checkbox[name=userId]").prop("checked", this.checked);
	});

	// 사용자 그룹 정보
	var userGroupDialog = $("#userGroupInfoDialog").dialog({
		autoOpen: false,
		width: 700,
		height: 400,
		modal: true,
		resizable: false
	});

	// 사용자 그룹 정보
	function detailUserGroup(userGroupId) {
		userGroupDialog.dialog("open");

		$.ajax({
			url: "/user-groups/detail",
			data: {"userGroupId": userGroupId},
			type: "GET",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg){
				if(msg.statusCode <= 200) {
					$("#userGroupNameInfo").html(msg.userGroup.userGroupName);
					$("#userGroupKeyInfo").html(msg.userGroup.userGroupKey);
					$("#basicInfo").html(msg.userGroup.basic?'기본':'선택');
					$("#availableInfo").html(msg.userGroup.available?'사용':'미사용');
					$("#descriptionInfo").html(msg.userGroup.description);
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
				}
			},
			error: function(request, status, error){
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	// 사용자 잠금, 사용자 잠금 해제
	var updateUserStatusFlag = true;
	function updateUserStatus(statusValue) {
		if($("input:checkbox[name=userId]:checked").length == 0) {
			alert(JS_MESSAGE["check.value.required"]);
			return false;
		} else {
			var checkedValue = "";
			$("input:checkbox[name=userId]:checked").each(function(index){
				checkedValue += $(this).val() + ",";
			});
			$("#checkIds").val(checkedValue);
		}

		if(updateUserStatusFlag) {
			updateUserStatusFlag = false;
			$.ajax({
				url: "/users/status",
				type: "POST",
				data: {checkIds: checkedValue, statusValue: statusValue},
				dataType: "json",
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert(JS_MESSAGE["update"]);
						location.reload();
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
					}
					updateUserStatusFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateUserStatusFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}

	function searchCheck() {
		if($("#searchOption").val() == "1") {
			if(confirm(JS_MESSAGE["search.option.warning"])) {
				// go
			} else {
				return false;
			}
		}

		var startDate = $("#startDate").val();
		var endDate = $("#endDate").val();
		if(startDate != null && startDate != "" && endDate != null && endDate != "") {
			if(parseInt(startDate) > parseInt(endDate)) {
				alert(JS_MESSAGE["search.date.warning"]);
				$("#startDate").focus();
				return false;
			}
		}
		return true;
	}
</script>

</body>
</html>
