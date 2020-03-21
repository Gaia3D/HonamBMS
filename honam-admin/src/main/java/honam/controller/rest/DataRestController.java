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

import honam.config.PropertiesConfig;
import honam.domain.DataInfo;
import honam.service.DataService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/datas")
public class DataRestController {
	
	@Autowired
	private DataService dataService;
	@Autowired
	private PropertiesConfig propertiesConfig;
	
	/**
	 * 데이터 그룹에 속하는 전체 데이터 목록
	 * @param projectId
	 * @return
	 */
	@GetMapping(value = "/{dataGroupId:[0-9]+}/list")
	public Map<String, Object> allList(HttpServletRequest request, @PathVariable Integer dataGroupId) {
		log.info("@@@@@ list dataGroupId = {}", dataGroupId);
		
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		DataInfo dataInfo = new DataInfo();
		//dataInfo.setUserId(userSession.getUserId());
		dataInfo.setDataGroupId(dataGroupId);
		List<DataInfo> dataInfoList = dataService.getAllListData(dataInfo);
		result.put("dataInfoList", dataInfoList);
		int statusCode = HttpStatus.OK.value();
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	/**
	 * 데이터 정보
	 * @param dataId
	 * @return
	 */
	@GetMapping("/{dataId:[0-9]+}")
	public Map<String, Object> detail(HttpServletRequest request, @PathVariable Long dataId) {
		log.info("@@@@@ dataId = {}", dataId);
		
		//UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		DataInfo dataInfo = new DataInfo();
		//dataInfo.setUserId(userSession.getUserId());
		dataInfo.setDataId(dataId);
		dataInfo = dataService.getData(dataInfo);
		int statusCode = HttpStatus.OK.value();
		
		result.put("dataInfo", dataInfo);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
}
