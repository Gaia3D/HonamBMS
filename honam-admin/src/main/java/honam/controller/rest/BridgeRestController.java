package honam.controller.rest;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import honam.domain.Bridge;
import honam.domain.PageType;
import honam.domain.Pagination;
import honam.service.BridgeService;
import honam.utils.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/bridges")
public class BridgeRestController {

	@Autowired
	private BridgeService bridgeService;

	/**
	 * 교량 목록 정보
	 * @param 
	 * @return
	 */
	@GetMapping
	public Map<String, Object> list(HttpServletRequest request, Bridge bridge, @RequestParam(defaultValue="1") String pageNo) {
		log.info("@@@@@ bridge = {}", bridge);
		
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		bridge.setListCounter(10l);
		long totalCount = bridgeService.getBridgeTotalCount(bridge);
		log.info("@@@@ totalCount = {}", totalCount);
		Pagination pagination = new Pagination(	request.getRequestURI(),
												getSearchParameters(PageType.LIST, request, bridge),
												totalCount,
												Long.valueOf(pageNo).longValue(),
												bridge.getListCounter());

		bridge.setOffset(pagination.getOffset());
		bridge.setLimit(pagination.getPageRows());

		List<Bridge> bridgeList = new ArrayList<>();
		if(totalCount > 0l) {
			bridgeList = bridgeService.getListBridge(bridge);
		}
		
		int statusCode = HttpStatus.OK.value();
		
		result.put("bridgeList", bridgeList);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	/**
	 * 검색 조건
	 * @param bridge
	 * @return
	 */
	private String getSearchParameters(PageType pageType, HttpServletRequest request, Bridge bridge) {
		StringBuffer buffer = new StringBuffer(bridge.getParameters());
		boolean isListPage = true;
		if(pageType.equals(PageType.MODIFY) || pageType.equals(PageType.DETAIL)) {
			isListPage = false;
		}

		buffer.append("&");
		buffer.append("sdoCode=" + StringUtil.getDefaultValue(isListPage ? bridge.getSdoCode() : request.getParameter("sdoCode")));
		buffer.append("&");
		buffer.append("sggCode=" + StringUtil.getDefaultValue(isListPage ? bridge.getSggCode() : request.getParameter("sggCode")));
		buffer.append("&");
		buffer.append("mngOrg=" + StringUtil.getDefaultValue(isListPage ? bridge.getMngOrg() : request.getParameter("mngOrg")));
		return buffer.toString();
	}
}
