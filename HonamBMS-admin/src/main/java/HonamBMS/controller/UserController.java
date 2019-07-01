//package honambms.controller;
//
//import java.net.URLEncoder;
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import javax.servlet.http.HttpServletRequest;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.DeleteMapping;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//
//import honambms.domain.APIError;
//import honambms.domain.PageType;
//import honambms.domain.Pagination;
//import honambms.domain.Search;
//import honambms.domain.UserGroup;
//import honambms.domain.UserInfo;
//import honambms.domain.UserStatus;
//import honambms.domain.YOrN;
//import honambms.service.UserGroupService;
//import honambms.service.UserService;
//import honambms.util.DateUtil;
//import honambms.util.StringUtil;
//import lombok.extern.slf4j.Slf4j;
//
///**
// * 사용자
// * @author jeongdae
// *
// */
//@Slf4j
//@Controller
//@RequestMapping("/")
//public class UserController {
//	
//	@Autowired
//	private UserGroupService userGroupService;
//	@Autowired
//	private UserService userService;
//	
//	/**
//	 * 사용자 목록
//	 * @param request
//	 * @param userInfo
//	 * @param pageNo
//	 * @param list_counter
//	 * @param model
//	 * @return
//	 */
//	@RequestMapping(value = "user/list")
//	public String list(	HttpServletRequest request, Search search, @RequestParam(defaultValue="1") String pageNo, Model model) {
//		
//		log.info("@@ search = {}", search);
//		UserGroup userGroup = new UserGroup();
//		userGroup.setUseYn(YOrN.Y.name());
//		List<UserGroup> userGroupList = userGroupService.getListUserGroup(userGroup);
//		if(StringUtil.isNotEmpty(search.getStartDate())) {
//			search.setStartDate(search.getStartDate().substring(0, 8) + DateUtil.START_TIME);
//		}
//		if(StringUtil.isNotEmpty(search.getEndDate())) {
//			search.setEndDate(search.getEndDate().substring(0, 8) + DateUtil.END_TIME);
//		}
//		
//		// TODO 여긴 좀 고민해야 할거 같네...... userGroupId로 검색을 하게 되면 어떡해야 할까?
//		UserInfo userInfo = new UserInfo();
//		if(userInfo.getUserGroupId() == null) {
//			userInfo.setUserGroupId(0);
//		}
//		userInfo.setSearch(search);
//
//		// 논리적 삭제는 SELECT에서 제외
////		userInfo.setDelete_flag(UserInfo.STATUS_LOGICAL_DELETE);
//		long totalCount = userService.getUserTotalCount(userInfo);
//		
//		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(PageType.LIST, request, userInfo), totalCount, Long.valueOf(pageNo).longValue());
//		log.info("@@ pagination = {}", pagination);
//		
//		search.setOffset(pagination.getOffset());
//		search.setLimit(pagination.getPageRows());
//		List<UserInfo> userList = new ArrayList<>();
//		if(totalCount > 0l) {
//			userList = userService.getListUser(userInfo);
//		}
//		
//		model.addAttribute(pagination);
//		model.addAttribute("searchForm", search);
//		model.addAttribute("userGroupList", userGroupList);
//		model.addAttribute("userList", userList);
//		return "/user/list";
//	}
//	
////	/**
////	 * 사용자 그룹 등록된 사용자 목록
////	 * @param request
////	 * @return
////	 */
////	@RequestMapping(value = "ajax-list-user-group-user.do")
////	@ResponseBody
////	public Map<String, Object> ajaxListUserGroupUser(HttpServletRequest request, @RequestParam("user_group_id") Long user_group_id, @RequestParam(defaultValue="1") String pageNo) {
////		Map<String, Object> map = new HashMap<>();
////		String result = "success";
////		Pagination pagination = null;
////		List<UserInfo> userList = new ArrayList<>();
////		try {		
////			UserInfo userInfo = new UserInfo();
////			userInfo.setUser_group_id(user_group_id);
////			
////			long totalCount = userService.getUserTotalCount(userInfo);
////			pagination = new Pagination(request.getRequestURI(), getSearchParameters(userInfo), totalCount, Long.valueOf(pageNo).longValue());
////			
////			userInfo.setOffset(pagination.getOffset());
////			userInfo.setLimit(pagination.getPageRows());
////			if(totalCount > 0l) {
////				userList = userService.getListUser(userInfo);
////			}
////		} catch(Exception e) {
////			e.printStackTrace();
////			result = "db.exception";
////		}
////		
////		map.put("result", result);
////		map.put("pagination", pagination);
////		map.put("userList", userList);
////		
////		log.info(">>>>>>>>>>>>>>>>>> userlist = {}", map);
////		
////		return map;
////	}
////	
////	/**
////	 * 사용자 그룹 전체 User 에서 선택한 사용자 그룹에 등록된 User 를 제외한 User 목록
////	 * @param request
////	 * @return
////	 */
////	@RequestMapping(value = "ajax-list-except-user-group-user-by-group-id.do")
////	@ResponseBody
////	public Map<String, Object> ajaxListExceptUserGroupUserByGroupId(HttpServletRequest request, UserInfo userInfo, @RequestParam(defaultValue="1") String pageNo) {
////		Map<String, Object> map = new HashMap<>();
////		String result = "success";
////		Pagination pagination = null;
////		List<UserInfo> userList = new ArrayList<>();
////		try {
////			long totalCount = userService.getExceptUserGroupUserByGroupIdTotalCount(userInfo);
////			pagination = new Pagination(request.getRequestURI(), getSearchParameters(userInfo), totalCount, Long.valueOf(pageNo).longValue());
////			
////			userInfo.setOffset(pagination.getOffset());
////			userInfo.setLimit(pagination.getPageRows());
////			if(totalCount > 0l) {
////				userList = userService.getListExceptUserGroupUserByGroupId(userInfo);
////			}
////		} catch(Exception e) {
////			e.printStackTrace();
////			result = "db.exception";
////		}
////		map.put("result", result);
////		map.put("pagination", pagination);
////		map.put("userList", userList);
////		return map;
////	}
////	
////	/**
////	 * 선택한 사용자 그룹에 등록된 User 목록
////	 * @param request
////	 * @return
////	 */
////	@RequestMapping(value = "ajax-list-user-group-user-by-group-id.do")
////	@ResponseBody
////	public Map<String, Object> ajaxListUserGroupUserByGroupId(HttpServletRequest request, UserInfo userInfo, @RequestParam(defaultValue="1") String pageNo) {
////		Map<String, Object> map = new HashMap<>();
////		String result = "success";
////		Pagination pagination = null;
////		List<UserInfo> userList = new ArrayList<>();
////		try {
////			
////			long totalCount = userService.getUserTotalCount(userInfo);
////			pagination = new Pagination(request.getRequestURI(), getSearchParameters(userInfo), totalCount, Long.valueOf(pageNo).longValue());
////			
////			userInfo.setOffset(pagination.getOffset());
////			userInfo.setLimit(pagination.getPageRows());
////			if(totalCount > 0l) {
////				userList = userService.getListUser(userInfo);
////			}
////		} catch(Exception e) {
////			e.printStackTrace();
////			result = "db.exception";
////		}
////		map.put("result", result);
////		map.put("pagination", pagination);
////		map.put("userList", userList);
////		return map;
////	}
////	
//	/**
//	 * 사용자 등록 화면
//	 * @param model
//	 * @return
//	 */
//	@GetMapping(value = "user/input")
//	public String input(Model model) {
//		
//		UserGroup userGroup = new UserGroup();
//		userGroup.setUseYn(YOrN.Y.name());
//		List<UserGroup> userGroupList = userGroupService.getListUserGroup(userGroup);
//		
//		UserInfo userInfo = new UserInfo();
//		
//		model.addAttribute(userInfo);
//		model.addAttribute("userGroupList", userGroupList);
//		return "/user/input";
//	}
//	
//	/**
//	 * 사용자 등록
//	 * @param request
//	 * @param userInfo
//	 * @return
//	 */
//	@PostMapping(value = "users", produces = "application/json;charset=UTF-8")
//	public ResponseEntity<?> insert(HttpServletRequest request, UserInfo userInfo) {
//		log.info("@@ userInfo = {} ", userInfo);
//		
//		try {
////			if(bindingResult.hasErrors()) {
////				String errorMessage = bindingResult.getAllErrors().get(0).getDefaultMessage();
////
////				Map<String, Object> result = new HashMap<>();
////				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
////				result.put("error", new APIError(errorMessage));
////				return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
////            }
//			
//			userService.insertUser(userInfo);
//			
//			return new ResponseEntity<>(HttpStatus.OK.value(), HttpStatus.OK);
//		} catch(Exception e) {
//			e.printStackTrace();
//			Map<String, Object> result = new HashMap<>();
//			result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
//			result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
//			return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
//		} 
//	}
//	
////	/**
////	 * 선택 사용자 그룹내 사용자 등록
////	 * @param request
////	 * @param user_all_id
////	 * @param user_group_id
////	 * @param model
////	 * @return
////	 */
////	@PostMapping(value = "ajax-insert-user-group-user.do")
////	@ResponseBody
////	public Map<String, Object> ajaxInsertUserGroupUser(HttpServletRequest request,
////			@RequestParam("user_group_id") Long user_group_id,
////			@RequestParam("user_all_id") String[] user_all_id) {
////		
////		log.info("@@@ user_group_id = {}, user_all_id = {}", user_group_id, user_all_id);
////		Map<String, Object> map = new HashMap<>();
////		List<UserInfo> exceptUserList = new ArrayList<>();
////		List<UserInfo> userList = new ArrayList<>();
////		String result = "success";
////		try {
////			if(user_group_id == null || user_group_id.longValue() == 0l ||				
////					user_all_id == null || user_all_id.length < 1) {
////				result = "input.invalid";
////				map.put("result", result);
////				return map;
////			}
////			
////			UserInfo userInfo = new UserInfo();
////			userInfo.setUser_group_id(user_group_id);
////			userInfo.setUser_all_id(user_all_id);
////			
////			userService.updateUserGroupUser(userInfo);
////			
////			userList = userService.getListUser(userInfo);
////			exceptUserList = userService.getListExceptUserGroupUserByGroupId(userInfo);
////		} catch(Exception e) {
////			e.printStackTrace();
////			map.put("result", "db.exception");
////		}
////		
////		map.put("result", result	);
////		map.put("exceptUserList", exceptUserList);
////		map.put("userList", userList);
////		return map;
////	}
////	
////	/**
////	 * ajax 용 사용자 validation 체크
////	 * @param userInfo
////	 * @return
////	 */
////	private String userValidate(Policy policy, UserInfo userInfo) {
////		
////		// 비밀번호 변경이 아닐경우
////		if(!"updatePassword".equals(userInfo.getMethod_mode())) {
////			if(userInfo.getUser_id() == null || "".equals(userInfo.getUser_id())) {
////				return "user.input.invalid";
////			}
////			
////			if(userInfo.getUser_group_id() == null || userInfo.getUser_group_id() <= 0
////					|| userInfo.getUser_name() == null || "".equals(userInfo.getUser_name())) {
////				return "user.input.invalid";
////			}
////		}
////		
////		if("insert".equals(userInfo.getMethod_mode())) {
////			if(userInfo.getUser_id().length() < policy.getUser_id_min_length()) {
////				return "user.id.min_length.invalid";
////			}
////			if(!"0".equals(userInfo.getDuplication_value())) {
////				return "user.id.duplication";
////			}
////		}
////		
////		// 사용자 정보 수정화면에서는 Password가 있을 경우만 체크
////		if("update".equals(userInfo.getMethod_mode())) {
////			if(userInfo.getPassword() == null || "".equals(userInfo.getPassword())
////				|| userInfo.getPassword_confirm() == null || "".equals(userInfo.getPassword_confirm())) {
////				return null;
////			}
////		} 
////		
////		return PasswordHelper.validateUserPassword(CacheManager.getPolicy(), userInfo);
////	}
//
//	/**
//	 * 사용자 정보 수정 화면
//	 * @param user_id
//	 * @param model
//	 * @return
//	 */
//	@GetMapping(value = "user/modify")
//	public String modifyUser(HttpServletRequest request, @RequestParam("userId") String userId, @RequestParam(defaultValue="1") String pageNo, Model model) {
//		
//		String searchParameter = getSearchParameters(PageType.MODIFY, request, null);
//		
//		UserGroup userGroup = new UserGroup();
//		userGroup.setUseYn(YOrN.Y.name());
//		List<UserGroup> userGroupList = userGroupService.getListUserGroup(userGroup);
//		
//		UserInfo userInfo = userService.getUser(userId);
//		
//		model.addAttribute("searchParameter", searchParameter);
//		model.addAttribute("userGroupList", userGroupList);
//		model.addAttribute(userInfo);
//		
//		return "/user/modify";
//	}
//
//	/**
//	 * 사용자 정보 수정
//	 * @param role
//	 * @param bindingResult
//	 * @return
//	 */
//	@PostMapping(value = "users/{userId}")
//	public ResponseEntity<?> update(HttpServletRequest request, @PathVariable String userId, UserInfo userInfo) {
//		try {
//			log.info("@@ userInfo = {}", userInfo);
//			userInfo.setUserId(userId);
//			
////			if(bindingResult.hasErrors()) {
////			String errorMessage = bindingResult.getAllErrors().get(0).getDefaultMessage();
////
////			Map<String, Object> result = new HashMap<>();
////			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
////			result.put("error", new APIError(errorMessage));
////			return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
////        }
//			
//			UserInfo dbUserInfo = userService.getUser(userId);
//		
//			if(!UserStatus.USE.getValue().equals(dbUserInfo.getStatus())) {
//				log.info("@@ dbUserInfo.getStatus() = {}", dbUserInfo.getStatus());	
//				if(UserStatus.USE.getValue().equals(userInfo.getStatus())) {
//					// 실패 횟수 잠금 이었던 경우는 실패 횟수를 초기화
//					// 휴면 계정이었던 경우 마지막 로그인 시간을 갱신
//					userInfo.setFailLoginCount(0);
//				} else if(UserStatus.TEMP_PASSWORD.getValue().equals(userInfo.getStatus())) {
//					// TODO 이건 지금 하지 않음
//				}
//				userInfo.setDbStatus(dbUserInfo.getStatus());
//			} else {
//				if(UserStatus.TEMP_PASSWORD.getValue().equals(userInfo.getStatus())) {
//					log.info("@@ userInfo.getStatus() = {}", userInfo.getStatus());	
//					// TODO 이건 지금 하지 않음
//				}
//			}
//			
//			userService.updateUser(userInfo);
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
//	 * 사용자 상태 수정(패스워드 실패 잠금, 해제 등)
//	 * @param request
//	 * @param checkIds
//	 * @param status_value
//	 * @return
//	 */
//	@PostMapping(value = "user/status")
//	public ResponseEntity<?> updateUserStatus(	HttpServletRequest request, 
//										@RequestParam("checkIds") String checkIds, 
//										@RequestParam("statusValue") String statusValue) {
//		
//		log.info("@@@@@@@ checkIds = {}, statusValue = {}", checkIds, statusValue);
//		try {
//			if(checkIds.length() <= 0) {
//				String errorMessage = "선택 항목 값이 없습니다.";
//				Map<String, Object> result = new HashMap<>();
//				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
//				result.put("error", new APIError(errorMessage));
//				return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
//
//			}
//			
//			userService.updateUserStatus(statusValue, checkIds);
//			
//			return new ResponseEntity<>(HttpStatus.OK.value(), HttpStatus.OK);
//		} catch(Exception e) {
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
//	 * 사용자 삭제
//	 * @param userId
//	 * @return
//	 */
//	@DeleteMapping(value = "users/{userId}")
//	public ResponseEntity<?> delete(@PathVariable String userId) {
//		try {
//			userService.deleteUser(userId);
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
////	/**
////	 * 선택 사용자 삭제
////	 * @param request
////	 * @param user_select_id
////	 * @param user_group_id
////	 * @param model
////	 * @return
////	 */
////	@PostMapping(value = "ajax-delete-users.do")
////	@ResponseBody
////	public Map<String, Object> ajaxDeleteUsers(HttpServletRequest request, @RequestParam("check_ids") String check_ids) {
////		
////		log.info("@@@@@@@ check_ids = {}", check_ids);
////		Map<String, Object> map = new HashMap<>();
////		String result = "success";
////		try {
////			if(check_ids.length() <= 0) {
////				map.put("result", "check.value.required");
////				return map;
////			}
////			
////			userService.deleteUserList(check_ids);
////		} catch(Exception e) {
////			e.printStackTrace();
////			map.put("result", "db.exception");
////		}
////		
////		map.put("result", result	);
////		return map;
////	}
////	
////	/**
////	 * 선택 사용자 그룹내 사용자 삭제
////	 * @param request
////	 * @param user_select_id
////	 * @param user_group_id
////	 * @param model
////	 * @return
////	 */
////	@PostMapping(value = "ajax-delete-user-group-user.do")
////	@ResponseBody
////	public Map<String, Object> ajaxDeleteUserGroupUser(HttpServletRequest request,
////			@RequestParam("user_group_id") Long user_group_id,
////			@RequestParam("user_select_id") String[] user_select_id) {
////		
////		log.info("@@@ user_group_id = {}, user_select_id = {}", user_group_id, user_select_id);
////		Map<String, Object> map = new HashMap<>();
////		List<UserInfo> exceptUserList = new ArrayList<>();
////		List<UserInfo> userList = new ArrayList<>();
////		String result = "success";
////		try {
////			if(user_group_id == null || user_group_id.longValue() == 0l ||				
////					user_select_id == null || user_select_id.length < 1) {
////				result = "input.invalid";
////				map.put("result", result);
////				return map;
////			}
////			
////			UserInfo userInfo = new UserInfo();
////			userInfo.setUser_group_id(user_group_id);
////			userInfo.setUser_select_id(user_select_id);
////			
////			userService.updateUserGroupUser(userInfo);
////			
////			// UPDATE 문에서 user_group_id 를 temp 그룹으로 변경
////			userInfo.setUser_group_id(user_group_id);
////			
////			userList = userService.getListUser(userInfo);
////			exceptUserList = userService.getListExceptUserGroupUserByGroupId(userInfo);
////		} catch(Exception e) {
////			e.printStackTrace();
////			map.put("result", "db.exception");
////		}
////		
////		map.put("result", result	);
////		map.put("exceptUserList", exceptUserList);
////		map.put("userList", userList);
////		return map;
////	}
////	
////	/**
////	 * 사용자 그룹 정보
////	 * @param request
////	 * @return
////	 */
////	@RequestMapping(value = "ajax-user-group-info.do")
////	@ResponseBody
////	public Map<String, Object> ajaxUserGroupInfo(HttpServletRequest request, @RequestParam("user_group_id") Long user_group_id) {
////		log.info("@@@@@@@ user_group_id = {}", user_group_id);
////		Map<String, Object> map = new HashMap<>();
////		String result = "success";
////		UserGroup userGroup = null;
////		try {	
////			userGroup = userGroupService.getUserGroup(user_group_id);
////			log.info("@@@@@@@ userGroup = {}", userGroup);
////		} catch(Exception e) {
////			e.printStackTrace();
////			result = "db.exception";
////		}
////		map.put("result", result);
////		map.put("userGroup", userGroup);
////		
////		return map;
////	}
//	
//	/**
//	 * 검색 조건
//	 * @param pageType
//	 * @param request
//	 * @param userInfo
//	 * @return
//	 */
//	private String getSearchParameters(PageType pageType, HttpServletRequest request, UserInfo userInfo) {
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
//		.append("searchOption=" + StringUtil.getDefaultValue(isListPage ? userInfo.getSearch().getSearchOption() : request.getParameter("searchOption")))
//		.append("&");
//		try {
//			buffer.append("searchValue=" + URLEncoder.encode(
//					StringUtil.getDefaultValue(isListPage ? userInfo.getSearch().getSearchValue() : request.getParameter("searchValue")), "UTF-8"));
//		} catch(Exception e) {
//			e.printStackTrace();
//			buffer.append("searchValue=");
//		}
//		buffer.append("&")
//		.append("searchWord=" + StringUtil.getDefaultValue(isListPage ? userInfo.getSearch().getSearchWord() : request.getParameter("searchType")))
//		.append("&")
//		.append("userGroupId=" + (isListPage ? userInfo.getUserGroupId() : request.getParameter("userGroupId")))
//		.append("&")
//		.append("startDate=" + StringUtil.getDefaultValue(isListPage ? userInfo.getSearch().getStartDate() : request.getParameter("startDate")))
//		.append("&")
//		.append("endDate=" + StringUtil.getDefaultValue(isListPage ? userInfo.getSearch().getEndDate() : request.getParameter("endDate")))
//		.append("&")
//		.append("orderWord=" + StringUtil.getDefaultValue(isListPage ? userInfo.getSearch().getOrderWord() : request.getParameter("orderWord")))
//		.append("&")
//		.append("orderValue=" + StringUtil.getDefaultValue(isListPage ? userInfo.getSearch().getOrderValue() : request.getParameter("orderValue")))
//		.append("&")
//		.append("listCount=" + (isListPage ? userInfo.getSearch().getListCounter() : StringUtil.getDefaultValue(request.getParameter("listCount"))));
//		return buffer.toString();
//	}
//}