package honam.controller.rest;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import honam.config.PropertiesConfig;
import honam.domain.Bridge;
import honam.service.BridgeService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/bridges")
@RestController
public class BridgeManageRestController {

	@Autowired
	private BridgeService bridgeService;

	@Autowired
	private PropertiesConfig propertiesConfig;

	/**
	 * 교량 등록
	 * @param model
	 * @return
	 */
	@PostMapping(value = "/input-bridge")
	public Map<String, Object> inputBridge(HttpServletRequest request, Model model, Bridge bridge, @RequestParam("files") MultipartFile[] files) {

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		log.info("@@@@@@@ bridge = {}", bridge.toString());
		log.info("@@@@@@@ getUploadDir = {}", propertiesConfig.getUploadDir());
		log.info("@@@@@@@ fileName = {}", files[0].getName());

		int statusCode = HttpStatus.OK.value();
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	@DeleteMapping(value = "/{gid:[0-9]+}")
	public Map<String, Object> deleteBridge(HttpServletRequest request, @PathVariable Integer gid) {
		log.info("@@@@@@@ gid = {}", gid);
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		// TODO 관련 레이어 삭제 필요


		int statusCode = HttpStatus.OK.value();
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

}
