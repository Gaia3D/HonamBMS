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
				<li id = "userList"><a href="/user/list">사용자 목록</a></li>
				<li id = "userInput"><a href="/user/input">사용자 등록</a></li>
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
						<button type="button" class="point" onclick="listUser()">목록</button>						
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
		$('#userList').css('background-color','#999');
	});
	
	var userDialog = $("#userGroupListDialog").dialog({
		autoOpen: false,
		height: 600,
		width: 1200,
		modal: true,
		overflow : "auto",
		resizable: false
	});

	// 부모 찾기
	$("#userGroupButton").on("click", function() {
		userDialog.dialog("open");
		userDialog.dialog("option", "title", "사용자 그룹 선택");
		$('#rootParentSelect').hide();
	});

	// 상위 Node
	function confirmParent(parent, parentName) {
		$("#userGroupId").val(parent);
		$("#userGroupName").val(parentName);
		userDialog.dialog("close");
	}

	// 입력값이 변경되면 중복체크, 영문+숫자
	$("#userId").on("keyup", function(event) {
		$("#duplicationValue").val(null);
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputValue = $(this).val();
			$(this).val(inputValue.replace(/[^a-z0-9]/gi,''));
		}
	});

	// 아이디 중복 확인
 	$("#userDuplicationButton").on("click", function() {
		var userId = $("#userId").val();
		if (userId == "") {
			alert(JS_MESSAGE["user.id.empty"]);
			$("#userId").focus();
			return false;
		} else if (userId.length < "${policy.userIdMinLength}"*1) {
			alert(JS_MESSAGE["user.id.min_length.invalid"]);
			$("#userId").focus();
			return false;
		}
		$.ajax({
			url: "/users/duplication",
			type: "GET",
			data: {"userId": userId},
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg){
				if(msg.statusCode <= 200) {
					if(msg.duplication == true) {
						alert(JS_MESSAGE["user.id.duplication"]);
						$("#userId").focus();
						return false;
					} else {
						alert(JS_MESSAGE["user.id.enable"]);
						$("#duplicationValue").val(msg.duplication);
					}
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
					console.log("---- " + msg.message);
				}
			},
			error:function(request, status, error) {
				//alert(JS_MESSAGE["ajax.error.message"]);
				alert(" code : " + request.status + "\n" + ", message : " + request.responseText + "\n" + ", error : " + error);
    		}
		});
	});

	// 사용자 등록
	var insertUserFlag = true;
	function insertUser() {
		if (checkData() == false) {
			return false;
		}
		if(insertUserFlag) {
			insertUserFlag = false;
			var info = $("#userInfo").serialize();
			$.ajax({
				url: "/users/insert",
				type: "POST",
				data: info,
				headers: {"X-Requested-With": "XMLHttpRequest"},
				dataType: "json",
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert(JS_MESSAGE["user.insert"]);
						window.location.reload();
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
					insertUserFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        alert(" code : " + request.status + "\n" + ", message : " + request.responseText + "\n" + ", error : " + error);
			        insertUserFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}

	function checkData() {
		var passwordValidation = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!#^%*?&])[A-Za-z\d$@$!#^%*?&]{${policy.passwordMinLength},${policy.passwordMaxLength}}$/;

		if($("#duplicationValue").val() == null || $("#duplicationValue").val() == "") {
			alert(JS_MESSAGE["check.id.duplication"]);
			return false;
		} else if($("#duplicationValue").val() == "1") {
			alert(JS_MESSAGE["user.id.duplication"]);
			return false;
		}
		if (!$("#userGroupId").val()) {
			alert(JS_MESSAGE["user.group.select"]);
			$("#userGroupId").focus();
			return false;
		}
		if (!$("#userName").val()) {
			alert(JS_MESSAGE["user.name.empty"]);
			$("#userName").focus();
			return false;
		}
		if (!$("#password").val()) {
			alert(JS_MESSAGE["password.empty"]);
			$("#password").focus();
			return false;
		} else if(!passwordValidation.test($("#password").val())) {
			alert(JS_MESSAGE["user.password.invalid"]);
			$("#password").focus();
			return false;
		} else if($("#passwordConfirm").val() == "") {
			alert(JS_MESSAGE["password.correct.empty"]);
			$("#passwordConfirm").focus();
			return false;
		} else if($("#password").val() !== $("#passwordConfirm").val()) {
			alert("입력한 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
			$("#passwordConfirm").focus();
			return false;
		}
	}

	// 초기화
	function formClear() {
		$("#userId").val("");
		$("#userGroupId").val("");
		$("#userGroupName").val("");
		$("#userName").val("");
		$("#password").val("");
		$("#passwordConfirm").val("");
		$("#duplicationValue").val("");
	}
	
	// 사용자 목록으로 이동
	function listUser() {
		location.href = '/user/list';
	}

</script>

</body>
</html>
