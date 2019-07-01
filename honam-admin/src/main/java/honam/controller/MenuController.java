//package honam.controller;
//
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
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//
//import honam.config.CacheRefreshManager;
//import honam.domain.APIError;
//import honam.domain.CacheName;
//import honam.domain.CacheType;
//import honam.domain.Menu;
//import honam.domain.MenuTarget;
//import honam.domain.MenuType;
//import honam.domain.Policy;
//import honam.service.MenuService;
//import honam.service.PolicyService;
//import honam.util.StringUtil;
//import lombok.extern.slf4j.Slf4j;
//
//@Slf4j
//@Controller
//@RequestMapping("/")
//public class MenuController {
//	
//	@Autowired
//	private CacheRefreshManager cacheRefreshManager;
//	
//	@Autowired
//	private PolicyService policyService;
//	
//	@Autowired
//	private MenuService menuService;
//
//	@GetMapping(value = "menus")
//	public String list(HttpServletRequest request, Model model) {
//		Policy policy = policyService.getPolicy();
//		
//		model.addAttribute("policy", policy);
//		
//		return "/menu/list";
//	}
//	
//	/**
//	 * 메뉴 트리
//	 * @param request
//	 * @return
//	 */
//	@GetMapping(value = "menus/tree", produces = "application/json;charset=UTF-8")
//	public ResponseEntity<?> tree(HttpServletRequest request) {
//		String menuTree = null;
//		try {
//			menuTree = getMenuTree(getAllListMenu());
//			log.info("@@ menuTree = {} ", menuTree);
//			
//			return new ResponseEntity<>(menuTree, HttpStatus.OK);
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
//	 * 메뉴 추가
//	 * @param request
//	 * @param menu
//	 * @return
//	 */
//	@PostMapping(value = "menus", produces = "application/json;charset=UTF-8")
//	public ResponseEntity<?> insert(HttpServletRequest request, Menu menu) {
//		
//		log.info("@@ menu = {} ", menu);
//		
//		String menuTree = null;
//		try {
//			if(menu.getName() == null || "".equals(menu.getName())
//					|| menu.getNameEn() == null || "".equals(menu.getNameEn())	
//					|| menu.getParent() == null
//					|| menu.getUseYn() == null || "".equals(menu.getUseYn())) {
//				
//				menuTree = getMenuTree(getAllListMenu());
//				
//				Map<String, Object> result = new HashMap<>();
//				result.put("menuTree", menuTree);
//				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
//				result.put("error", new APIError("입력값이 유효하지 않습니다.", "input.invalid"));
//				return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
//			}
//			
//			Menu childMenu = menuService.getMaxViewOrderChildMenu(menu.getParent());
//			if(childMenu == null) {
//				menu.setViewOrder(1);
//			} else {
//				menu.setViewOrder(childMenu.getViewOrder() + 1);
//			}
//			
//			if("\"null\"".equals(menu.getNameEn()) || "null".equals(menu.getNameEn())) menu.setNameEn("");
//			if("\"null\"".equals(menu.getUrl()) || "null".equals(menu.getUrl())) menu.setUrl("");
//			if("\"null\"".equals(menu.getUrlAlias()) || "null".equals(menu.getUrlAlias())) menu.setUrlAlias("");
//			if("\"null\"".equals(menu.getHtmlId()) || "null".equals(menu.getHtmlId())) menu.setHtmlId("");
//			if("\"null\"".equals(menu.getHtmlContentId()) || "null".equals(menu.getHtmlContentId())) menu.setHtmlContentId("");
//			if("\"null\"".equals(menu.getImage()) || "null".equals(menu.getImage())) menu.setImage("");
//			if("\"null\"".equals(menu.getImageAlt()) || "null".equals(menu.getImageAlt())) menu.setImageAlt("");
//			if("\"null\"".equals(menu.getCssClass()) || "null".equals(menu.getCssClass())) menu.setCssClass("");
//			if("\"null\"".equals(menu.getDisplayYn()) || "null".equals(menu.getDisplayYn())) menu.setDisplayYn("");
//			if("\"null\"".equals(menu.getDescription()) || "null".equals(menu.getDescription())) menu.setDescription("");
//			
//			menuService.insertMenu(menu);
//			menuTree = getMenuTree(getAllListMenu());
//			log.info("@@ menuTree = {} ", menuTree);
//			
//			cacheRefreshManager.refresh(CacheType.SELF, CacheName.USER_GROUP);
//			
//			return new ResponseEntity<>(menuTree, HttpStatus.OK);
//		} catch(Exception e) {
//			e.printStackTrace();
//			Map<String, Object> result = new HashMap<>();
//			result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
//			result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
//			return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
//		} 
//	}
//	
//	/**
//	 * 사용자 그룹 트리 수정
//	 * @param request
//	 * @param menuId
//	 * @param menu
//	 * @return
//	 */
//	@PostMapping(value = "menus/{menuId}", produces = "application/json;charset=UTF-8")
//	public ResponseEntity<?> update(HttpServletRequest request, @PathVariable Integer menuId, @ModelAttribute Menu menu) {
//		
//		log.info("@@ menu = {}", menu);
//		
//		String menuTree = null;
//		try {
//			if(menu.getName() == null || "".equals(menu.getName())
//					|| menu.getNameEn() == null || "".equals(menu.getNameEn())	
//					|| menu.getParent() == null
//					|| menu.getUseYn() == null || "".equals(menu.getUseYn())) {
//				
//				menuTree = getMenuTree(getAllListMenu());
//				
//				Map<String, Object> result = new HashMap<>();
//				result.put("menuTree", menuTree);
//				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
//				result.put("error", new APIError("입력값이 유효하지 않습니다.", "input.invalid"));
//				return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
//			}
//			
//			if("\"null\"".equals(menu.getNameEn()) || "null".equals(menu.getNameEn())) menu.setNameEn("");
//			if("\"null\"".equals(menu.getUrl()) || "null".equals(menu.getUrl())) menu.setUrl("");
//			if("\"null\"".equals(menu.getUrlAlias()) || "null".equals(menu.getUrlAlias())) menu.setUrlAlias("");
//			if("\"null\"".equals(menu.getHtmlId()) || "null".equals(menu.getHtmlId())) menu.setHtmlId("");
//			if("\"null\"".equals(menu.getHtmlContentId()) || "null".equals(menu.getHtmlContentId())) menu.setHtmlContentId("");
//			if("\"null\"".equals(menu.getImage()) || "null".equals(menu.getImage())) menu.setImage("");
//			if("\"null\"".equals(menu.getImageAlt()) || "null".equals(menu.getImageAlt())) menu.setImageAlt("");
//			if("\"null\"".equals(menu.getCssClass()) || "null".equals(menu.getCssClass())) menu.setCssClass("");
//			if("\"null\"".equals(menu.getDisplayYn()) || "null".equals(menu.getDisplayYn())) menu.setDisplayYn("");
//			if("\"null\"".equals(menu.getDescription()) || "null".equals(menu.getDescription())) menu.setDescription("");
//			
//			menu.setMenuId(menuId);
//			menuService.updateMenu(menu);
//			menuTree = getMenuTree(getAllListMenu());
//			log.info("@@ menuTree = {} ", menuTree);
//			
//			cacheRefreshManager.refresh(CacheType.SELF, CacheName.USER_GROUP);
//			
//			return new ResponseEntity<>(menuTree, HttpStatus.OK);
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
//	 * 사용자 그룹 트리 순서 수정, up, down
//	 * @param request
//	 * @param menuId
//	 * @param menu
//	 * @return
//	 */
//	@PostMapping(value = "menus/{menuId}/move", produces = "application/json;charset=UTF-8")
//	public ResponseEntity<?> move(HttpServletRequest request, @PathVariable Integer menuId, @ModelAttribute Menu menu) {
//		log.info("@@ menu = {}", menu);
//		
//		String menuTree = null;
//		try {
//			if(	menu.getViewOrder() == null || menu.getViewOrder().intValue() == 0
//				|| menu.getUpdateType() == null || "".equals(menu.getUpdateType())) {
//				
//				menuTree = getMenuTree(getAllListMenu());
//				
//				Map<String, Object> result = new HashMap<>();
//				result.put("menuTree", menuTree);
//				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
//				result.put("error", new APIError("입력값이 유효하지 않습니다.", "input.invalid"));
//				return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
//			}
//			
//			menuService.updateMoveMenu(menu);
//			menuTree = getMenuTree(getAllListMenu());
//			log.info("@@ menuTree = {} ", menuTree);
//			
//			cacheRefreshManager.refresh(CacheType.SELF, CacheName.USER_GROUP);
//			
//			return new ResponseEntity<>(menuTree, HttpStatus.OK);
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
//	 * 메뉴 삭제
//	 * @param request
//	 * @param menuId
//	 * @return
//	 */
//	@DeleteMapping(value = "menus/{menuId}", produces = "application/json;charset=UTF-8")
//	public ResponseEntity<?> delete(HttpServletRequest request, @PathVariable Integer menuId) {
//		
//		log.info("@@ menuId = {} ", menuId);
//		
//		String menuTree = null;
//		try {
//			menuService.deleteMenu(menuId);
//			menuTree = getMenuTree(getAllListMenu());
//			log.info("@@ menuTree = {} ", menuTree);
//			
//			cacheRefreshManager.refresh(CacheType.SELF, CacheName.USER_GROUP);
//			
//			return new ResponseEntity<>(menuTree, HttpStatus.OK);
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
////	/**
////	 * TODO menu 에도 enum을 사용해야 하는데.... ㅠ.ㅠ
////	 * 기본 메뉴 트리
////	 * @param menuTarget
////	 * @return
////	 */
////	private Menu getRootMenu(MenuType menuType, MenuTarget menuTarget) {
////		Menu menu = new Menu();
////		menu.setMenuType(menuType.getValue());
////		menu.setMenuTarget(menuTarget.getValue());
////		if(MenuTarget.ADMIN == menuTarget) {
////			menu.setMenuId(0);
////			menu.setAncestor(0);
////			menu.setParent(-1);
////			menu.setName("[관리자 사이트]");
////			menu.setNameEn("[ADMIN]");
////		} else {
////			menu.setMenuId(1000);
////			menu.setAncestor(1000);
////			menu.setParent(-1);
////			menu.setName("[사용자 사이트]");
////			menu.setNameEn("[USER]");
////		}
////		
////		menu.setOpen("true");
////		menu.setNodeType("company");
////		menu.setParentName("");
////		menu.setDepth(0);
////		menu.setViewOrder(0);
////		menu.setUrl("");
////		menu.setUrlAlias("");
////		menu.setHtmlId("");
////		menu.setHtmlContentId("");
////		menu.setImage("");
////		menu.setImageAlt("");
////		menu.setCssClass("");
////		menu.setDefaultYn("Y");
////		menu.setUseYn("Y");
////		menu.setDisplayYn("");
////		menu.setDescription("");
////		
////		return menu;
////	}
//	
//	private String getMenuTree(List<Menu> menuList) {
//		if(menuList.isEmpty()) return "{}";
//		
//		StringBuffer buffer = new StringBuffer();
//		
//		int count = menuList.size();
//		Menu menu = menuList.get(0);
//		
//		buffer.append("[")
//		.append("{")
//		.append("\"menuId\"").append(":").append("\"" + menu.getMenuId() + "\"").append(",")
//		.append("\"menuType\"").append(":").append("\"" + menu.getMenuType() + "\"").append(",")
//		.append("\"menuTarget\"").append(":").append("\"" + menu.getMenuTarget() + "\"").append(",")
//		.append("\"name\"").append(":").append("\"" + menu.getName() + "\"").append(",")
//		.append("\"nameEn\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getNameEn()) + "\"").append(",")
//		.append("\"open\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getOpen()) + "\"").append(",")
//		.append("\"nodeType\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getNodeType()) + "\"").append(",")
//		.append("\"ancestor\"").append(":").append("\"" + menu.getAncestor() + "\"").append(",")
//		.append("\"parent\"").append(":").append("\"" + menu.getParent() + "\"").append(",")
//		.append("\"parentName\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getParentName()) + "\"").append(",")
//		.append("\"depth\"").append(":").append("\"" + menu.getDepth() + "\"").append(",")
//		.append("\"viewOrder\"").append(":").append("\"" + menu.getViewOrder() + "\"").append(",")
//		.append("\"url\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getUrl()) + "\"").append(",")
//		.append("\"urlAlias\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getUrlAlias()) + "\"").append(",")
//		.append("\"htmlId\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getHtmlId()) + "\"").append(",")
//		.append("\"htmlContentId\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getHtmlContentId()) + "\"").append(",")
//		.append("\"image\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getImage()) + "\"").append(",")
//		.append("\"imageAlt\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getImageAlt()) + "\"").append(",")
//		.append("\"cssClass\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getCssClass()) + "\"").append(",")
//		.append("\"defaultYn\"").append(":").append("\"" + menu.getDefaultYn() + "\"").append(",")
//		.append("\"useYn\"").append(":").append("\"" + menu.getUseYn() + "\"").append(",")
//		.append("\"displayYn\"").append(":").append("\"" + menu.getDisplayYn() + "\"").append(",")
//		.append("\"description\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getDescription()) + "\"");
//		
//		if(count > 1) {
//			long preParent = menu.getParent();
//			int preDepth = menu.getDepth();
//			int bigParentheses = 0;
//			for(int i=1; i<count; i++) {
//				menu = menuList.get(i);
//				
//				if(preParent == menu.getParent()) {
//					// 부모가 같은 경우
//					buffer.append("}");
//					buffer.append(",");
//				} else {
//					if(preDepth > menu.getDepth()) {
//						// 닫힐때
//						int closeCount = preDepth - menu.getDepth();
//						for(int j=0; j<closeCount; j++) {
//							buffer.append("}");
//							buffer.append("]");
//							bigParentheses--;
//						}
//						buffer.append("}");
//						buffer.append(",");
//					} else {
//						// 열릴때
//						buffer.append(",");
//						buffer.append("\"subTree\"").append(":").append("[");
//						bigParentheses++;
//					}
//				} 
//				
//				buffer.append("{")
//				.append("\"menuId\"").append(":").append("\"" + menu.getMenuId() + "\"").append(",")
//				.append("\"menuType\"").append(":").append("\"" + menu.getMenuType() + "\"").append(",")
//				.append("\"menuTarget\"").append(":").append("\"" + menu.getMenuTarget() + "\"").append(",")
//				.append("\"name\"").append(":").append("\"" + menu.getName() + "\"").append(",")
//				.append("\"nameEn\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getNameEn()) + "\"").append(",")
//				.append("\"open\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getOpen()) + "\"").append(",")
//				.append("\"nodeType\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getNodeType()) + "\"").append(",")
//				.append("\"ancestor\"").append(":").append("\"" + menu.getAncestor() + "\"").append(",")
//				.append("\"parent\"").append(":").append("\"" + menu.getParent() + "\"").append(",")
//				.append("\"parentName\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getParentName()) + "\"").append(",")
//				.append("\"depth\"").append(":").append("\"" + menu.getDepth() + "\"").append(",")
//				.append("\"viewOrder\"").append(":").append("\"" + menu.getViewOrder() + "\"").append(",")
//				.append("\"url\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getUrl()) + "\"").append(",")
//				.append("\"urlAlias\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getUrlAlias()) + "\"").append(",")
//				.append("\"htmlId\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getHtmlId()) + "\"").append(",")
//				.append("\"htmlContentId\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getHtmlContentId()) + "\"").append(",")
//				.append("\"image\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getImage()) + "\"").append(",")
//				.append("\"imageAlt\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getImageAlt()) + "\"").append(",")
//				.append("\"cssClass\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getCssClass()) + "\"").append(",")
//				.append("\"defaultYn\"").append(":").append("\"" + menu.getDefaultYn() + "\"").append(",")
//				.append("\"useYn\"").append(":").append("\"" + menu.getUseYn() + "\"").append(",")
//				.append("\"displayYn\"").append(":").append("\"" + menu.getDisplayYn() + "\"").append(",")
//				.append("\"description\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getDescription()) + "\"");
//				
//				if(i == (count-1)) {
//					// 맨 마지막의 경우 괄호를 닫음
//					if(bigParentheses == 0) {
//						buffer.append("}");
//					} else {
//						for(int k=0; k<bigParentheses; k++) {
//							buffer.append("}");
//							buffer.append("]");
//						}
//					}
//				}
//				
//				preParent = menu.getParent();
//				preDepth = menu.getDepth();
//			}
//		}
//		
//		buffer.append("}");
//		buffer.append("]");
//		
//		return buffer.toString();
//	}
//	
//	private List<Menu> getAllListMenu() {
//		List<Menu> menuList = new ArrayList<>();
//		Menu menu = new Menu();
//		menu.setMenuType(MenuType.URL.getValue());
//		menu.setMenuTarget(MenuTarget.ADMIN.getValue());
//		menu.setDefaultYn(null);
//		//menuList.add(getRootMenu(MenuType.URL, MenuTarget.ADMIN));
//		menuList.addAll(menuService.getListMenu(menu));
//		
//		menu.setMenuType(MenuType.HTMLID.getValue());
//		menu.setMenuTarget(MenuTarget.USER.getValue());
////		menuList.add(getRootMenu(MenuType.HTMLID, MenuTarget.USER));
//		menuList.addAll(menuService.getListMenu(menu));
//		return menuList;
//	}
//}
