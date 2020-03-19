<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="subHeader">
	<h2>교량 그룹별 유지관리 목표 성능</h2>
	<div id="menuCloseButton" class="ctrlBtn">
		<button type="button" title="닫기" class="close">닫기</button>
	</div>
</div>
<!-- E: 프로젝트 제목, 목록가기, 닫기 -->

<div class="subContents">
	<!-- S: 교량 검색 입력 폼 -->
	<form:form id="searchForm" modelAttribute="bridge" method="post" action="/bridge/list-bridge" onsubmit="return searchCheck();">
		<ul class="projectSearch input-group row">
			<li class="input-set">
				<label for="searchWord">교량명</label>
				<form:input path="searchValue" type="search" size="25" cssClass="m" />
				<form:hidden path="searchWord" value="brgNam" />
				<form:hidden path="searchOption" value="1" />
			</li>
			<li class="input-set">
				<label>주소</label>
				<form:select path="sdoCode" name="sdoCode" class="select" style="width: 97px;">
					<option value=""> 시도 </option>
				</form:select>
				<form:select path="sggCode" name="sggCode" class="select" style="width: 85px;">
					<option value=""> 시군구 </option>
				</form:select>
			</li>
			<li class="input-set">
				<label>관리주체</label>
				<form:select path="mngOrg" name="mngOrg" class="select" style="width: 187px;">
				</form:select>
			</li>
			<li class="input-set btn">
				<button type="submit" value="search" class="point" id="search">검색</button>
			</li>
		</ul>
	</form:form>
	<!-- E: 교량 검색 입력 폼 -->
	<!-- S: 교량 목록 -->
	<div id="projectListHeader" class="count" style="margin-top: 20px; margin-bottom: 5px;">
		전체 <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em> 건
		<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> 페이지
	</div>
	<div class="transferDataList" style="max-height: 650px; overflow-y: auto; height:590px;">
		<table class="list-table scope-col">
			<col class="col-number" />
			<col class="col-toggle" />
			<col class="col-name" />
			<thead>
				<tr>
					<th scope="col" class="col-number" style="width:5%; font-weight: bold"></th>
					<th scope="col" class="col-toggle">교량 명</th>
					<th scope="col" class="col-name">준공년도</th>
					<th scope="col" class="col-name">상태</th>
				</tr>
			</thead>
			<tbody id="transferDataList">
			<c:forEach var="bridge" items="${bridgeList}" varStatus="status">
				<tr>
					<td class="col-number">${status.index+1}</td>
					<td class="col-toggle">
						<a href="/bridge/detail-bridge?gid=${bridge.gid}&pageNo=${pagination.pageNo}${pagination.searchParameters}">
							${bridge.brgNam}
						</a>
					</td>
					<td class="col-name">${bridge.endAmd.substring(0,4)} </td>
					<td class="col-name">${bridge.grade}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
	</div>
	<!-- E: 교량 목록 -->
</div>
