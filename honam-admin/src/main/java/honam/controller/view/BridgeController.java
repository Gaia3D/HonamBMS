package honam.controller.view;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import honam.domain.Bridge;
import honam.domain.BridgeGroup;
import honam.service.BridgeGroupService;
import honam.service.PolicyService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/bridge")
@Controller
public class BridgeController {

	@Autowired
	private BridgeGroupService bridgeGroupService;
	@Autowired
	private PolicyService policyService;
	@Autowired
	private ObjectMapper objectMapper;

	/**
	 * 교량 목록
	 * @param model
	 * @return
	 * @throws JsonProcessingException
	 */
	@RequestMapping(value = "/list-bridge")
	public String listBridge(HttpServletRequest request, Model model) throws JsonProcessingException {
		List<BridgeGroup> bridgeGroupList = bridgeGroupService.getListBridgeGroup();

		model.addAttribute("policy", objectMapper.writeValueAsString(policyService.getPolicy()));
		model.addAttribute("bridge", new Bridge());
		model.addAttribute("bridgeGroupListSize", bridgeGroupList.size());
		model.addAttribute("bridgeGroupList", bridgeGroupList);
		return "/bridge/list-bridge";
	}

	/**
	 * 교량 그룹 목록
	 * @param model
	 * @return
	 * @throws JsonProcessingException
	 */
	@RequestMapping(value = "/bridge-groups")
	public String listBridgeGroup(HttpServletRequest request, Model model) throws JsonProcessingException {
		List<BridgeGroup> bridgeGroupList = bridgeGroupService.getListBridgeGroup();

		model.addAttribute("policy", objectMapper.writeValueAsString(policyService.getPolicy()));
		model.addAttribute("bridge", new Bridge());
		model.addAttribute("bridgeGroupListSize", bridgeGroupList.size());
		model.addAttribute("bridgeGroupList", bridgeGroupList);
		model.addAttribute("group", true);
		return "/bridge/list-bridge";
	}
}
