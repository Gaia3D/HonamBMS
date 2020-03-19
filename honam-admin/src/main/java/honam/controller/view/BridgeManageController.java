package honam.controller.view;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import honam.config.PropertiesConfig;
import honam.domain.Bridge;
import honam.domain.PageType;
import honam.domain.Pagination;
import honam.domain.Sat;
import honam.domain.Sensor;
import honam.domain.SkSdo;
import honam.domain.SkSgg;
import honam.service.BridgeService;
import honam.service.PolicyService;
import honam.service.SatService;
import honam.service.SensorService;
import honam.utils.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/bridge")
@Controller
public class BridgeManageController {

	@Autowired
	private BridgeService bridgeService;

	@Autowired
	private PropertiesConfig propertiesConfig;

	@Autowired
	private PolicyService policyService;

	@Autowired
	private SatService satService;

	@Autowired
	private SensorService sensorService;


	/**
	 * 교량 관리
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/manage-bridge")
	public String manageBridge(HttpServletRequest request, Bridge bridge, @RequestParam(defaultValue="1") String pageNo, Model model) {
		log.info("@@ bridge = {}", bridge);
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

		String cesiumIonToken = propertiesConfig.getCesiumIonToken();

		model.addAttribute("policy", policyService.getPolicy());
		model.addAttribute("bridgeList", bridgeList);
		model.addAttribute("cesiumIonToken", cesiumIonToken);

		return "/bridge/manage-bridge";
	}

	/**
	 * 교량 등록
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/input-bridge")
	public String inputBridge(HttpServletRequest request, Model model) {
		return "/bridge/input-bridge";
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
