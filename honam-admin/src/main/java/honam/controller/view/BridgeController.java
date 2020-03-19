package honam.controller.view;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import honam.config.PropertiesConfig;
import honam.domain.Bridge;
import honam.domain.BridgeGroup;
import honam.domain.PageType;
import honam.service.BridgeGroupService;
import honam.service.BridgeService;
import honam.service.PolicyService;
import honam.utils.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/bridge")
@Controller
public class BridgeController {

	@Autowired
	private BridgeService bridgeService;
	@Autowired
	private BridgeGroupService bridgeGroupService;
	@Autowired
	private PropertiesConfig propertiesConfig;
	@Autowired
	private PolicyService policyService;
	
	/**
	 * 교량 목록
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/list-bridge")
	public String listBridge(HttpServletRequest request, Model model) {
		String cesiumIonToken = propertiesConfig.getCesiumIonToken();
		
		List<BridgeGroup> bridgeGroupList = bridgeGroupService.getListBridgeGroup();

		model.addAttribute("policy", policyService.getPolicy());
		model.addAttribute("bridge", new Bridge());
		model.addAttribute("cesiumIonToken", cesiumIonToken);
		model.addAttribute("bridgeGroupListSize", bridgeGroupList.size());
		model.addAttribute("bridgeGroupList", bridgeGroupList);
		return "/bridge/list-bridge";
	}

	@RequestMapping(value = "/detail-bridge")
	public String detailBridge(HttpServletRequest request, @RequestParam(value="gid", required = true) Integer gid, Model model) {
		log.info("@@ bridge_id = {}", gid);

		Bridge bridge = bridgeService.getBridge(gid);
		log.info("############### Bridge = {}", bridge);

		String cesiumIonToken = propertiesConfig.getCesiumIonToken();

		model.addAttribute("policy", policyService.getPolicy());
		model.addAttribute("bridge", bridge);
		model.addAttribute("searchParameters", getSearchParameters(PageType.DETAIL, request, bridge));
		model.addAttribute("cesiumIonToken", cesiumIonToken);
		return "/bridge/detail-bridge";
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
