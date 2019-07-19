<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
    <meta charset="utf-8">
    <meta name="referrer" content="origin">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="robots" content="index,nofollow"/>
	<title>오류 | HonamBMS</title>
    <link rel="shortcut icon" href="/images/favicon.ico">
	<link rel="stylesheet" href="/css/ko/style.css">
</head>

<body>
	
<div id="errorPage">
	<img src="../images/no_page.png">
	<div>
		<p>오류 메시지 ${httpStatusCode }</p>
		<p>요청 하신 페이지에서 오류가 발생 하였습니다.<br>장시간 발생시 관리자에게 문의하여 주십시오.	</p>
		<a href="/login/login">이 페이지 나가기</a>
	</div>
</div>

<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
</body>
</html>