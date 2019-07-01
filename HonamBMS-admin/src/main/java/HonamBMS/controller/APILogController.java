package honambms.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import honambms.domain.APIError;
import honambms.domain.APILog;
import honambms.domain.Pagination;
import honambms.domain.Search;
import honambms.service.APILogService;
import honambms.util.DateUtil;
import honambms.util.FormatUtil;
import honambms.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/")
@Controller
public class APILogController {
	
	@Autowired
	private APILogService aPILogService;
	
	/**
	 * api 로그 목록
	 * @param request
	 * @param pageNo
	 * @param search
	 * @param model
	 * @return
	 */
	@GetMapping(value = "apilog/list")
	public String list(HttpServletRequest request, @RequestParam(defaultValue="1") String pageNo, Search search, Model model) {
		log.info("@@ search = {}", search);
		
		String today = DateUtil.getToday(FormatUtil.YEAR_MONTH_DAY);
		if(StringUtil.isEmpty(search.getStartDate())) {
			search.setStartDate(today.substring(0,4) + DateUtil.START_DAY_TIME);
		} else {
			search.setStartDate(search.getStartDate().substring(0, 8) + DateUtil.START_TIME);
		}
		if(StringUtil.isEmpty(search.getEndDate())) {
			search.setEndDate(today + DateUtil.END_TIME);
		} else {
			search.setEndDate(search.getEndDate().substring(0, 8) + DateUtil.END_TIME);
		}
		
		APILog apiLog = new APILog();
		apiLog.setSearch(search);
		Long totalCount = aPILogService.getAPILogTotalCount(apiLog);
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(search), totalCount, Long.valueOf(pageNo).longValue());
		log.info("@@ pagination = {}", pagination);
		
		search.setOffset(pagination.getOffset());
		search.setLimit(pagination.getPageRows());
		List<APILog> apiLogList = new ArrayList<>();
		if(totalCount > 0l) {
			//apiLogList = logService.getListAccessLog(accessLog);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("searchForm", search);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("apiLogList", apiLogList);
		
		return "/apilog/list";
	}
	
	/**
	 * 모든 서비스 요청에 대한 이력
	 * @param model
	 * @return
	 */
	@GetMapping(value = "apilogs")
	public ResponseEntity<?> listApiLogs(HttpServletRequest request, Search search, @RequestParam(defaultValue="1") String pageNo) {
		
		log.info("@@ search = {}", search);
		
		List<APILog> apiLogList = new ArrayList<>();
		try {
			String today = DateUtil.getToday(FormatUtil.YEAR_MONTH_DAY);
			if(StringUtil.isEmpty(search.getStartDate())) {
				search.setStartDate(today.substring(0,4) + DateUtil.START_DAY_TIME);
			} else {
				search.setStartDate(search.getStartDate().substring(0, 8) + DateUtil.START_TIME);
			}
			if(StringUtil.isEmpty(search.getEndDate())) {
				search.setEndDate(today + DateUtil.END_TIME);
			} else {
				search.setEndDate(search.getEndDate().substring(0, 8) + DateUtil.END_TIME);
			}
			
			APILog apiLog = new APILog();
			apiLog.setSearch(search);
			if(search.getTotalCount() == null) search.setTotalCount(0l);
			Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(search), search.getTotalCount().longValue(), Long.valueOf(pageNo).longValue());
			log.info("@@ pagination = {}", pagination);
			
			search.setOffset(pagination.getOffset());
			search.setLimit(pagination.getPageRows());
			if(search.getTotalCount().longValue() > 0l) {
				apiLogList = aPILogService.getListAPILog(apiLog);
			}
			
			return new ResponseEntity<>(apiLogList, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			
			Map<String, Object> result = new HashMap<>();
			result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
			result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
			return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	/**
	 *  API 로그 상세
	 */
	@GetMapping(value = "apilogs/{apiLogId}")
	public ResponseEntity<?>  detail(@PathVariable Long apiLogId) {
		try {
			APILog apiLog = aPILogService.getAPILog(apiLogId);
			
			return new ResponseEntity<>(apiLog, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			
			Map<String, Object> result = new HashMap<>();
			result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
			result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
			return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	/**
	 * 검색 조건
	 * @param search
	 * @return
	 */
	private String getSearchParameters(Search search) {
		StringBuffer buffer = new StringBuffer();
		buffer.append("&");
		buffer.append("searchWord=" + StringUtil.getDefaultValue(search.getSearchWord()));
		buffer.append("&");
		buffer.append("searchOption=" + StringUtil.getDefaultValue(search.getSearchOption()));
		buffer.append("&");
		try {
			buffer.append("searchValue=" + URLEncoder.encode(StringUtil.getDefaultValue(search.getSearchValue()), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			buffer.append("searchValue=");
		}
		buffer.append("&");
		buffer.append("startDate=" + StringUtil.getDefaultValue(search.getStartDate()));
		buffer.append("&");
		buffer.append("endDate=" + StringUtil.getDefaultValue(search.getEndDate()));
		buffer.append("&");
		buffer.append("orderWord=" + StringUtil.getDefaultValue(search.getOrderWord()));
		buffer.append("&");
		buffer.append("orderValue=" + StringUtil.getDefaultValue(search.getOrderValue()));
		return buffer.toString();
	}
}
