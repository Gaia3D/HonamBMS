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

import honam.domain.Sat;
import honam.service.SatService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/sats")
public class SatRestController {
	
	@Autowired
	private SatService satService;
	
	/**
	 * 데이터 그룹에 속하는 전체 데이터 목록
	 * @param projectId
	 * @return
	 */
	@GetMapping(value = "/{facNum}/average")
	public Map<String, Object> listSatAverage(HttpServletRequest request, @PathVariable String facNum) {
		log.info("@@@@@ listSatAverage facNum = {}", facNum);
		
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		long satAvgCount = satService.getSatAvgTotalCount(facNum);
		List<Sat> satAvgList = satService.getListSatAvg(facNum);
		int statusCode = HttpStatus.OK.value();

		result.put("satAvgList", satAvgList);
		result.put("satAvgCount", satAvgCount);
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	@GetMapping("/{facNum}/average/values")
	public Map<String, Object> listAverageItemValues(Sat sat, @PathVariable String facNum) {
		log.info("@@@@@ facNum = {}", facNum);
		
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		List<Sat> satValueList = satService.getListSatValueByLonLat(sat);
		
		log.info("--------------- satValueList = {}", satValueList);
		
		int statusCode = HttpStatus.OK.value();

		result.put("satValueList", satValueList);
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
}
