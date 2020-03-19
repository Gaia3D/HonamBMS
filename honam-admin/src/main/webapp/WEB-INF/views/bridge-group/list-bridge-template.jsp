<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script id="templateBridgeGroupBridgeList" type="text/x-handlebars-template">
<td colspan="4">
{{#greaterThan bridgeList.length 0}}
	<ul style="list-style-type : disc;">
	{{#each bridgeList}}
		<li style="margin-left: 20px; padding-top: 10px; height: 20px; vertical-align: middle; ">
			{{brgNam}} : {{facSgg}} {{facEmd}} {{facRi}}
			<button type="button" title="바로가기" class="goto" style="margin: 0px; padding: 0px;"
			onclick="gotoFlyBridge('{{longitude}}', '{{latitude}}');">바로가기</button>
		</li>
	{{/each}}
	</ul>
{{else}}
	&nbsp;&nbsp;&nbsp;교량이 존재하지 않습니다.
{{/greaterThan}}
</td>
</script>
