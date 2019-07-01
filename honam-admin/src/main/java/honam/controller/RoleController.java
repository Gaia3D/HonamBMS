//package honam.controller;
//
//import java.net.URLEncoder;
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
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
//import honam.config.CacheRefreshManager;
//import honam.domain.APIError;
//import honam.domain.CacheName;
//import honam.domain.CacheType;
//import honam.domain.PageType;
//import honam.domain.Pagination;
//import honam.domain.Role;
//import honam.domain.Search;
//import honam.service.RoleService;
//import honam.util.StringUtil;
//import lombok.extern.slf4j.Slf4j;
//
///**
// * Role 정책
// * @author jeongdae
// *
// */
//@Slf4j
//@Controller
//@RequestMapping("/")
//public class RoleController {
//	
//	@Autowired
//	private CacheRefreshManager cacheRefreshManager;
//	
//	@Autowired
//	private RoleService roleService;
//	
//	/**
//	 * Role 목록
//	 * @param request
//	 * @param pageNo
//	 * @param search
//	 * @param model
//	 * @return
//	 */
//	@RequestMapping(value = "role/list")
//	public String list(HttpServletRequest request, @RequestParam(defaultValue="1") String pageNo, Search search, Model model) {
//		
//		log.info("@@ search = {}", search);
//		
//		Role role = new Role();
//		role.setSearch(search);
//		long totalCount = roleService.getRoleTotalCount(role);
//		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(PageType.LIST, request, role), totalCount, Long.valueOf(pageNo).longValue());
//		log.info("@@ pagination = {}", pagination);
//		
//		search.setOffset(pagination.getOffset());
//		search.setLimit(pagination.getPageRows());
//		List<Role> roleList = new ArrayList<>();
//		if(totalCount > 0l) {
//			roleList = roleService.getListRole(role);
//		}
//
//		model.addAttribute(pagination);
//		model.addAttribute("searchForm", search);
//		model.addAttribute("roleList", roleList);
//		model.addAttribute("roleListSize", roleList.size());
//		return "/role/list";
//	}
//	
//	/**
//	 * Role 등록 화면
//	 * @param model
//	 * @return
//	 */
//	@GetMapping(value = "role/input")
//	public String input(Model model) {
//		Role role = new Role();
//		role.setMethod_mode("insert");
//		
//		model.addAttribute("role", role);
//		return "/role/input";
//	}
//	
//	/**
//	 * Role 등록
//	 * @param role
//	 * @param bindingResult
//	 * @return
//	 */
//	@PostMapping(value = "roles")
//	public ResponseEntity<?> insert(@Valid Role role, BindingResult bindingResult) {
//		try {
//			log.info("@@ role = {}", role);
//			
//			if(bindingResult.hasErrors()) {
//				String errorMessage = bindingResult.getAllErrors().get(0).getDefaultMessage();
//				
//				Map<String, Object> result = new HashMap<>();
//				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
//				result.put("error", new APIError(errorMessage));
//				return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
//			}
//		
//			roleService.insertRole(role);
//			cacheRefreshManager.refresh(CacheType.SELF, CacheName.USER_GROUP);
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
//	 * 수정 페이지로 이동
//	 * @param request
//	 * @param roleId
//	 * @param model
//	 * @return
//	 */
//	@RequestMapping(value = "roles/{roleId}")
//	public String modify(HttpServletRequest request, @PathVariable Integer roleId, Model model) {		
//		
//		Role role = roleService.getRole(roleId);
//		String searchParameter = getSearchParameters(PageType.MODIFY, request, null);
//
//		model.addAttribute(role);
//		model.addAttribute("searchParameter", searchParameter);
//		return "/role/modify";
//	}
//	
//	/**
//	 * Role 정보 수정
//	 * @param role
//	 * @param bindingResult
//	 * @return
//	 */
//	@PostMapping(value = "roles/{roleId}")
//	public ResponseEntity<?> update(HttpServletRequest request, @Valid Role role, @PathVariable Integer roleId, BindingResult bindingResult) {
//		try {
//			log.info("@@ role = {}", role);
//			role.setRoleId(roleId);
//			
//			if(bindingResult.hasErrors()) {
//				String errorMessage = bindingResult.getAllErrors().get(0).getDefaultMessage();
//				
//				Map<String, Object> result = new HashMap<>();
//				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
//				result.put("error", new APIError(errorMessage));
//				return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
//			}
//		
//			roleService.updateRole(role);
//			cacheRefreshManager.refresh(CacheType.SELF, CacheName.USER_GROUP);
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
//	 * Role 삭제
//	 * @param roleId
//	 * @return
//	 */
//	@DeleteMapping(value = "roles/{roleId}")
//	public ResponseEntity<?> delete(@PathVariable Integer roleId) {
//		try {
//			roleService.deleteRole(roleId);
//			cacheRefreshManager.refresh(CacheType.SELF, CacheName.USER_GROUP);
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
//	 * 검색 조건
//	 * @param pageType
//	 * @param request
//	 * @param role
//	 * @return
//	 */
//	private String getSearchParameters(PageType pageType, HttpServletRequest request, Role role) {
//		StringBuffer buffer = new StringBuffer();
//		boolean isListPage = true;
//		if(pageType.equals(PageType.MODIFY) || pageType.equals(PageType.DETAIL)) {
//			isListPage = false;
//		}
//		
//		if(!isListPage) {
//			buffer.append("pageNo=" + request.getParameter("pageNo"));
//		}
//		buffer.append("&")
//		.append("searchOption=" + StringUtil.getDefaultValue(isListPage ? role.getSearch().getSearchOption() : request.getParameter("searchOption")))
//		.append("&");
//		try {
//			buffer.append("searchValue=" + URLEncoder.encode(
//					StringUtil.getDefaultValue(isListPage ? role.getSearch().getSearchValue() : request.getParameter("searchValue")), "UTF-8"));
//		} catch(Exception e) {
//			e.printStackTrace();
//			buffer.append("searchValue=");
//		}
//		buffer.append("&")
//		.append("searchWord=" + StringUtil.getDefaultValue(isListPage ? role.getSearch().getSearchWord() : request.getParameter("searchType")))
//		.append("&")
//		.append("startDate=" + StringUtil.getDefaultValue(isListPage ? role.getSearch().getStartDate() : request.getParameter("startDate")))
//		.append("&")
//		.append("endDate=" + StringUtil.getDefaultValue(isListPage ? role.getSearch().getEndDate() : request.getParameter("endDate")))
//		.append("&")
//		.append("orderWord=" + StringUtil.getDefaultValue(isListPage ? role.getSearch().getOrderWord() : request.getParameter("orderWord")))
//		.append("&")
//		.append("orderValue=" + StringUtil.getDefaultValue(isListPage ? role.getSearch().getOrderValue() : request.getParameter("orderValue")))
//		.append("&")
//		.append("listCount=" + (isListPage ? role.getSearch().getListCounter() : StringUtil.getDefaultValue(request.getParameter("listCount"))));
//		return buffer.toString();
//	}
//}
