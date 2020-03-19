package honam.controller.rest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import honam.domain.Bridge;
import honam.domain.BridgeGroup;
import honam.service.BridgeGroupService;
import honam.service.BridgeService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/bridge-groups")
public class BridgeGroupRestController {

	@Autowired
	private BridgeService bridgeService;
	
	@Autowired
	private BridgeGroupService bridgeGroupService;
	
	/**
	 * 교량 그룹 정보
	 * @param dataGroup
	 * @return
	 */
	@GetMapping
	public Map<String, Object> list(HttpServletRequest request, BridgeGroup bridgeGroup) {
		log.info("@@@@@ bridgeGroup = {}", bridgeGroup);
		
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		List<BridgeGroup> bridgeGroupList = bridgeGroupService.getListBridgeGroup();
		int statusCode = HttpStatus.OK.value();
		
		result.put("bridgeGroupList", bridgeGroupList);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	/**
	 * 교량 그룹 교량 목록
	 * @param dataGroupId
	 * @return
	 */
	@GetMapping("/{bridgeGroupId}/bridges")
	public Map<String, Object> listBridges(HttpServletRequest request, @PathVariable Integer bridgeGroupId) {
		log.info("@@@@@ bridgeGroupId = {}", bridgeGroupId);
		
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		List<Bridge> bridgeList = bridgeService.getListBridgeByBridgeGroupId(bridgeGroupId);
		int statusCode = HttpStatus.OK.value();
		
		result.put("bridgeList", bridgeList);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
}
