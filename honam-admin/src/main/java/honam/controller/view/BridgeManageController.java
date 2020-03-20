package honam.controller.view;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import honam.config.PropertiesConfig;
import honam.domain.Bridge;
import honam.service.BridgeDroneFileService;
import honam.service.BridgeService;
import honam.service.PolicyService;
import honam.service.SatService;
import honam.service.SensorService;
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

	@Autowired
	private BridgeDroneFileService bridgeDroneFileService;

	/**
	 * 교량 관리
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/manage-bridge")
	public String manageBridge(HttpServletRequest request, Bridge bridge, @RequestParam(defaultValue="1") String pageNo, Model model) {
		model.addAttribute("policy", policyService.getPolicy());
		//model.addAttribute("bridgeList", bridgeService.getListBridgeAll());
		model.addAttribute("cesiumIonToken", propertiesConfig.getCesiumIonToken());
		return "/bridge/manage-bridge";
	}

	/**
	 * 교량 등록
	 * @param request
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/input-bridge")
	public String inputBridge(HttpServletRequest request, Model model) {
		return "/bridge/input-bridge";
	}

	/**
	 * 교량 수정
	 * @param request
	 * @param gid
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/modify-bridge/{gid:[0-9]+}")
	public String modifyBridge(HttpServletRequest request, @PathVariable Integer gid, Model model) {
		Bridge bridge = bridgeService.getBridge(gid);
		model.addAttribute("bridge", bridge);
		return "/bridge/modify-bridge";
	}

}
