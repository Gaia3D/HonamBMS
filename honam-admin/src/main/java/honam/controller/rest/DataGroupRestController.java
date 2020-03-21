package honam.controller.rest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import honam.domain.DataGroup;
import honam.service.DataGroupService;
import lombok.extern.slf4j.Slf4j;

/**
 * 사용자 데이터 그룹 관리
 * @author Jeongdae
 *
 */
@Slf4j
@RestController
@RequestMapping("/data-groups")
public class DataGroupRestController {
	
	private static final long PAGE_ROWS = 5l;
	private static final long PAGE_LIST_COUNT = 5l;
	
	@Autowired
	private DataGroupService dataGroupService;
//	@Autowired
//	private GeoPolicyService geoPolicyService;
//	@Autowired
//	private ObjectMapper objectMapper;
//	@Autowired
//	private PolicyService policyService;
	
	/**
	 * 데이터 그룹 전체 목록
	 * @param projectId
	 * @return
	 */
	@GetMapping(value = "/all")
	public Map<String, Object> allList(HttpServletRequest request, DataGroup dataGroup) {
//		dataGroup.setSearchWord(SQLInjectSupport.replaceSqlInection(dataGroup.getSearchWord()));
//		dataGroup.setOrderWord(SQLInjectSupport.replaceSqlInection(dataGroup.getOrderWord()));
		
		log.info("@@@@@ list dataGroup = {}", dataGroup);
//		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
//		dataGroup.setUserId(userSession.getUserId());
//		dataGroup.setUserGroupId(userSession.getUserGroupId());
		List<DataGroup> dataGroupList = dataGroupService.getAllListDataGroup(dataGroup);
		int statusCode = HttpStatus.OK.value();
		
		result.put("dataGroupList", dataGroupList);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
}
