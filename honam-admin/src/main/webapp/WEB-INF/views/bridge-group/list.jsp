<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="subHeader">
	<h2>교량 그룹별 유지관리 목표 성능</h2>
	<div id="menuCloseButton" class="ctrlBtn">
		<button type="button" title="닫기" class="close">닫기</button>
	</div>
</div>
<!-- E: 프로젝트 제목, 목록가기, 닫기 -->

<div class="subContents">
	<ul class="projectSearch input-group row">
		<li class="input-set">
			시작 지역 : 광주시
		</li>
		<li class="input-set">
			중간 지역 : 순천
		</li>
		<li class="input-set">
			종료 지역 : 여수시
		</li>
		<li class="input-set btn">
			<button type="submit" value="search" class="point" id="search">검색</button>
		</li>
	</ul>
	
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
</div>
