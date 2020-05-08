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
				<li><a href="/user/list">사용자 목록</a></li>
				<li><a href="/user/input-user">사용자 등록</a></li>
			</ul>
		</nav>
		<!-- S: 교량 목록 -->
		<div class="list-wrapper" style="width: calc(100% - 80px);">
			<div class="boardHeader" style="margin:0;">
				<h2>사용자 목록</h2>
				<div class="button-wrapper-right">
					<button class="basic" onclick="location.href='/bridge/input-bridge'">사용자 잠금</button>
					<button id="deleteSelected" class="basic">사용자 해제</button>
				</div>
			</div>
			<div class="boardList">
				<table>
					<col class="col-number" />
					<col class="col-toggle" />
					<col class="col-name" />
					<thead>
						<tr>
							<th scope="col" class="col-name" style="width:5%; font-weight: bold">
								<input type="checkbox" id="selectAll">
							</th>
							<th scope="col" class="col-number">번호</th>
							<th scope="col" class="col-toggle">교량 명</th>
							<th scope="col" class="col-name">준공년도</th>
							<th scope="col" class="col-name">상태</th>
							<!-- <th scope="col" class="col-name">드론영상</th> -->
							<th scope="col" class="col-name">이동</th>
							<th scope="col" class="col-name">삭제</th>
						</tr>
					</thead>
					<tbody id="transferDataList"></tbody>
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
	$(document).ready(function() {
		initDatePicker();

		$("#searchWord").val("${userInfo.searchWord}");
		$("#searchValue").val("${userInfo.searchValue}");
		$("#orderWord").val("${userInfo.orderWord}");
		$("#orderValue").val("${userInfo.orderValue}");

		initCalendar(new Array("startDate", "endDate"), new Array("${userInfo.startDate}", "${userInfo.endDate}"));
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
