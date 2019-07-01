//package honambms.controller;
//
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//import java.util.UUID;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.validation.Valid;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.validation.BindingResult;
//import org.springframework.web.bind.annotation.DeleteMapping;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//
//import honambms.domain.APIError;
//import honambms.domain.Search;
//import honambms.domain.Server;
//import honambms.service.ServerService;
//import honambms.util.DateUtil;
//import honambms.util.FormatUtil;
//import honambms.util.StringUtil;
//import lombok.extern.slf4j.Slf4j;
//
//@Slf4j
//@Controller
//@RequestMapping("/")
//public class ServerController {
//
//	@Autowired
//	private ServerService serverService;
//	
//	/**
//	 * 서버 관리 목록 페이지
//	 */
//	@GetMapping(value = "server/list")
//	public String list(HttpServletRequest request, @RequestParam(defaultValue="1") String pageNo, Search search, Model model) {
//		log.info("@@ search = {}", search);
//		
//		String today = DateUtil.getToday(FormatUtil.YEAR_MONTH_DAY);
//		if(StringUtil.isEmpty(search.getStartDate())) {
//			search.setStartDate(today.substring(0,4) + DateUtil.START_DAY_TIME);
//		} else {
//			search.setStartDate(search.getStartDate().substring(0, 8) + DateUtil.START_TIME);
//		}
//		if(StringUtil.isEmpty(search.getEndDate())) {
//			search.setEndDate(today + DateUtil.END_TIME);
//		} else {
//			search.setEndDate(search.getEndDate().substring(0, 8) + DateUtil.END_TIME);
//		}
//		
//		Server server = new Server();
////		server.setSearch(search);
////		Long totalCount = serverService.getServerTotalCount(server);
////		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(search), totalCount, Long.valueOf(pageNo).longValue());
////		log.info("@@ pagination = {}", pagination);
////		
////		search.setOffset(pagination.getOffset());
////		search.setLimit(pagination.getPageRows());
//		
//		List<Server> serverList = new ArrayList<>();
////		if(totalCount > 0l) {
//			serverList = serverService.getListServer(server);
////		}
//		
////		model.addAttribute(pagination);
//		model.addAttribute("searchForm", search);
////		model.addAttribute("totalCount", totalCount);
//		model.addAttribute("serverList", serverList);
//		
//		return "/server/list";
//	}
//	
//	/**
//	 * 서버 관리 등록 페이지
//	 */
//	@GetMapping(value = "server/input")
//	public String inputServer(Model model) {
//		Server server = new Server();
//		model.addAttribute("server", server);
//		return "/server/input";
//	}
//	
//	/**
//	 * 서버 등록
//	 */
//	@PostMapping(value = "servers")
//	public ResponseEntity<?> insert(@Valid Server server, BindingResult bindingResult) {
//		try {
//			if(bindingResult.hasErrors()) {
//				String errorMessage = bindingResult.getAllErrors().get(0).getDefaultMessage();
//				
//				Map<String, Object> result = new HashMap<>();
//				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
//				result.put("error", new APIError(errorMessage));
//				return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
//			}
//		
//			serverService.insertServer(server);
//			
//			return new ResponseEntity<>(HttpStatus.OK.value(), HttpStatus.OK);
//		} catch (Exception e) {
//			e.printStackTrace();
//			
//			Map<String, Object> result = new HashMap<>();
//			result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
//			result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
//			return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
//		}
//	}
//	
//	/**
//	 * 서버 관리 수정 페이지
//	 */
//	@GetMapping(value = "servers/{serverId}")
//	public String modify(@PathVariable Integer serverId, Model model) {
//		Server server = serverService.getServer(serverId);
//		model.addAttribute("server", server);
//		return "/server/modify";
//	}
//	
//	/**
//	 * 서버 관리 UPDATE
//	 */
//	@PostMapping(value = "servers/{serverId}")
//	public ResponseEntity<?> update(@Valid Server server, @PathVariable Integer serverId, BindingResult bindingResult) {
//		try {
//			if(bindingResult.hasErrors()) {
//				String errorMessage = bindingResult.getAllErrors().get(0).getDefaultMessage();
//				log.info("@ errorMessage = {}", errorMessage);
//				Map<String, Object> result = new HashMap<>();
//				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
//				result.put("error", new APIError(errorMessage));
//				return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
//			}
//			
//			serverService.updateServer(server);
//			
//			return new ResponseEntity<>(HttpStatus.OK.value(), HttpStatus.OK);
//		} catch (Exception e) {
//			e.printStackTrace();
//			
//			Map<String, Object> result = new HashMap<>();
//			result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
//			result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
//			return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
//		}
//	}
//	
//	/**
//	 * 서버 관리 DELETE
//	 */
//	@DeleteMapping(value = "servers/{serverId}")
//	public ResponseEntity<?> delete(@PathVariable Integer serverId) {
//		try {
//			serverService.deleteServer(serverId);
//			return new ResponseEntity<>(HttpStatus.OK.value(), HttpStatus.OK);
//		} catch (Exception e) {
//			e.printStackTrace();
//			
//			Map<String, Object> result = new HashMap<>();
//			result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
//			result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
//			return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
//		}
//	}
//	
//	/**
//	 * API KEY UUID 생성
//	 */
//	@GetMapping("servers/uuid")
//	public ResponseEntity<?> uuid() {
//		try {
//			UUID uuid = UUID.randomUUID();
//			return new ResponseEntity<>(uuid, HttpStatus.OK);
//		} catch (Exception e) {
//			e.printStackTrace();
//			
//			Map<String, Object> result = new HashMap<>();
//			result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
//			result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
//			return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
//		}
//	}
//	
////	/**
////	 * 검색 조건
////	 * @param dataInfo
////	 * @return
////	 */
////	private String getSearchParameters(Search search) {
////		// TODO 아래 메소드랑 통합
////		StringBuilder builder = new StringBuilder(100);
////		builder.append("&");
////		builder.append("search_word=" + StringUtil.getDefaultValue(search.getSearchWord()));
////		builder.append("&");
////		builder.append("search_option=" + StringUtil.getDefaultValue(search.getSearchOption()));
////		builder.append("&");
////		try {
////			builder.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(search.getSearchValue()), "UTF-8"));
////		} catch(Exception e) {
////			e.printStackTrace();
////			builder.append("search_value=");
////		}
////		builder.append("&");
////		builder.append("start_date=" + StringUtil.getDefaultValue(search.getStartDate()));
////		builder.append("&");
////		builder.append("end_date=" + StringUtil.getDefaultValue(search.getEndDate()));
////		builder.append("&");
////		builder.append("order_word=" + StringUtil.getDefaultValue(search.getOrderWord()));
////		builder.append("&");
////		builder.append("order_value=" + StringUtil.getDefaultValue(search.getOrderValue()));
////		return builder.toString();
////	}
//
//}
