<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script id="templateBridgeList" type="text/x-handlebars-template">
<div id="projectListHeader" class="count" style="margin-top: 20px; margin-bottom: 5px;">
	전체 <em>{{pagination.totalCount}}</em> 건
	{{pagination.pageNo}} / {{pagination.lastPage}} 페이지
</div>
<div class="transferDataList">
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
		{{#if bridgeList}}
			{{#each bridgeList}}
				<tr>
					<td class="col-number">{{#replaceRowNumber ../pagination.pageNo @index}}{{/replaceRowNumber}}</td>
					<td class="col-toggle">
						<a href="#" onClick="getBridgeInfo({{gid}}, {{longitude}}, {{latitude}})">{{brgNam}}</a>
					</td>
					<td class="col-name">{{#replaceYear endAmd}}{{/replaceYear}}</td>
					<td class="col-name">{{grade}}</td>
				</tr>
			{{/each}}
		{{else}}
			<tr><td colspan="4" style="text-align:center;">검색된 데이터가 없습니다.</td></tr>
		{{/if}}
		</tbody>
	</table>
	
{{#if pagination.totalCount}}
    <ul class="pagination">
        <li class="ico first" onClick="getListBridge({{pagination.firstPage}})"></li>
    {{#if pagination.existPrePage}}
        <li class="ico forward" onClick="getListBridge({{pagination.prePageNo}})"></li>
    {{/if}}

    {{#each pagination.pageList}}
        {{#if (indexCompare this ../pagination.pageNo)}}
            <li class="on"><a href='#'>{{this}}</a></li>
        {{else}}
            <li onClick="getListBridge({{this}})"><a href='#'>{{this}}</a></li>
        {{/if}}
    {{/each}}

    {{#if pagination.existNextPage}}
        <li class="ico back" onClick="getListBridge({{pagination.nextPageNo}})"></li>
    {{/if}}
        <li class="ico end" onClick="getListBridge({{pagination.lastPage}})"></li>
    </ul>
{{/if}}

</div>
</script>
