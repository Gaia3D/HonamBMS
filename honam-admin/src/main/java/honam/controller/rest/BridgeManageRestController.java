package honam.controller.rest;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import honam.service.BridgeService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/bridges")
@Controller
public class BridgeManageRestController {

	@Autowired
	private BridgeService bridgeService;

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
		return null;
	}

}
