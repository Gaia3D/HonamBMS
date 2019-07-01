//package honambms.api;
//
//import java.util.HashMap;
//import java.util.Map;
//
//import javax.servlet.http.HttpServletRequest;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RestController;
//
//import honambms.domain.APIError;
//import honambms.domain.Policy;
//import honambms.service.APILogService;
//import honambms.service.PolicyService;
//import honambms.util.WebUtil;
//import io.swagger.annotations.ApiOperation;
//import lombok.extern.slf4j.Slf4j;
//
///**
// * TODO 원래는 gis-user 서버로 분리 되어야 하는데, 서버 사양이 좋지 않아서 url로 분리
// * @author Cheon JeongDae
// *
// */
//@Slf4j
//@RequestMapping("/api")
//@RestController
//public class PolicyAPIController implements APIController {
//
//	@Autowired
//	private APILogService aPILogService;
//	@Autowired
//	private PolicyService policyService;
//	
//	@ApiOperation(value = "운영 정책")
//	@GetMapping("/policy")
//	public ResponseEntity<?> getPolicy(HttpServletRequest request) {
//		log.info("@@@@@@@@@@ getPolicy api call");
//		int statusCode = 0;
//		String message = null;
//		try {
//			// header 체크, 인증, 인가 등 모드 무시
//			statusCode = HttpStatus.OK.value();
//			
//			Policy policy = policyService.getPolicy();
//			policy.setGeoserverUser(null);
//			policy.setGeoserverPassword(null);
//			
//			return new ResponseEntity<>(policy, HttpStatus.OK);
//		} catch(Exception e) {
//			e.printStackTrace();
//			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
//			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
//			
//			Map<String, Object> result = new HashMap<>();
//			result.put("statusCode", statusCode);
//			result.put("error", new APIError(message));
//			return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
//		} finally {
//			insertLog(aPILogService, WebUtil.getClientIp(request), null, request.getRequestURL().toString(), null, null, statusCode, message);
//		}
//	}
//}
