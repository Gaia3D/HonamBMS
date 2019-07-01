//package honambms.controller;
//
//import java.util.List;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpSession;
//import javax.validation.Valid;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.validation.BindingResult;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//
//import honambms.domain.CacheManager;
//import honambms.domain.Policy;
//import honambms.domain.RoleKey;
//import honambms.domain.UserGroup;
//import honambms.domain.UserInfo;
//import honambms.domain.UserSession;
//import honambms.domain.UserStatus;
//import honambms.domain.YOrN;
//import honambms.listener.Gaia3dHttpSessionBindingListener;
//import honambms.service.LoginService;
//import honambms.service.PolicyService;
//import honambms.service.UserGroupService;
//import honambms.support.RoleSupport;
//import honambms.util.WebUtil;
//import lombok.extern.slf4j.Slf4j;
//
//@Slf4j
//@Controller
//@RequestMapping("/login/")
//public class LoginController {
//
//	@Autowired
//	private LoginService loginService;
//	
//	@Autowired
//	private PolicyService policyService;
//	
//	@Autowired
//	private UserGroupService userGroupService;
//	
//	/**
//	 * 로그인
//	 * @param model
//	 * @return
//	 */
//	@RequestMapping(value = "login")
//	public String index(HttpServletRequest request, Model model) {
//		UserInfo loginForm = new UserInfo();
//		model.addAttribute("loginForm", loginForm);
//		
//		return "/login/login";
//	}
//	
//	/**
//	 * 로그인 처리
//	 * @param locale
//	 * @param model
//	 * @return
//	 */
//	@PostMapping(value = "process-login")
//	public String processLogin(HttpServletRequest request, @Valid @ModelAttribute("loginForm") UserInfo loginForm, BindingResult bindingResult, Model model) {
//		
//		Policy policy = policyService.getPolicy();
//		
//		if(bindingResult.hasErrors()) {
//			String errorMessage = bindingResult.getAllErrors().get(0).getDefaultMessage();
//			log.info("@@ errorMessage = {}", errorMessage);
//			loginForm.setPassword(null);
//			model.addAttribute("errorMessage", errorMessage);
//			model.addAttribute("loginForm", loginForm);
//			return "/login/login";
//		}
//		
//		UserSession userSession = loginService.getUserSession(loginForm);
//		userSession.setUserName(userSession.getKorNm());
//		if(userSession.getEmpNo() == null && userSession.getKorNm() == null && userSession.getRespNm() == null ) {
//			String errorMessage = "사용자 정보가 존재하지 않습니다.";
//			log.info("@@ errorMessage = {}", errorMessage);
//			loginForm.setPassword(null);
//			model.addAttribute("errorMessage", errorMessage);
//			model.addAttribute("loginForm", loginForm);
//			return "/login/login";
//		}
//		
//		// Role, 메뉴 관리를 위한 추가 사용자 그룹 정보 취득
//		UserGroup userGroup = userGroupService.getUserGroupByUserId(loginForm.getUserId());
//		if(userGroup == null || userGroup.getUserGroupId() == null) {
//			String errorMessage = "사용자 그룹이 존재하지 않습니다. 관리자에게 문의하여 주십시오.";
//			log.info("@@ errorMessage = {}", errorMessage);
//			loginForm.setPassword(null);
//			model.addAttribute("errorMessage", errorMessage);
//			model.addAttribute("loginForm", loginForm);
//			return "/login/login";
//		}
//		
//		// 회원 상태 체크
//		if(!UserStatus.USE.getValue().equals(userGroup.getStatus()) && !UserStatus.TEMP_PASSWORD.getValue().equals(userGroup.getStatus())) {
//			// 사용자 상태. 0:사용중, 1:사용중지(관리자), 2:잠금(비밀번호 실패횟수 초과), 3:휴면(로그인 기간), 4:만료(사용기간 종료), 5:삭제(화면 비표시, policy.user_delete_type=0), 6:임시비밀번호
//			String errorMessage = "[사용 중지] - 관리자에게 사용자 상태를 문의하여 주십시오.";
//			log.info("@@ errorMessage = {}", errorMessage);
//			loginForm.setPassword(null);
//			model.addAttribute("errorMessage", errorMessage);
//			model.addAttribute("loginForm", loginForm);
//			return "/login/login";
//		}
//		
//		userSession.setUserGroupId(userGroup.getUserGroupId());
//		
//		// Role 체크
//        List<String> userGroupRoleKeyList = CacheManager.getUserGroupRoleKeyList(userGroup.getUserGroupId());
//        if(!RoleSupport.isUserGroupRoleValid(userGroupRoleKeyList, RoleKey.ADMIN_LOGIN.name())) {
//			String errorMessage = "권한이 존재하지 않습니다. 관리자에게 문의하여 주십시오.";
//			log.info("@@ errorMessage = {}", errorMessage);
//			loginForm.setPassword(null);
//			model.addAttribute("errorMessage", errorMessage);
//			model.addAttribute("loginForm", loginForm);
//			return "/login/login";
//		}
//		
//		userSession.setLoginIp(WebUtil.getClientIp(request));
//		Gaia3dHttpSessionBindingListener sessionListener = new Gaia3dHttpSessionBindingListener();
//		request.getSession().setAttribute(UserSession.KEY, userSession);
//		request.getSession().setAttribute(userSession.getUserId(), sessionListener);
//		if(YOrN.Y.name().equals(policy.getSecuritySessionTimeoutYn())) {
//			// 세션 타임 아웃 시간을 초 단위로 변경해서 설정
//			request.getSession().setMaxInactiveInterval(Integer.valueOf(policy.getSecuritySessionTimeout()).intValue() * 60);
//		}
//
//		return "redirect:/layer/list";
//	}
//	
////	/**
////	 * 사용자 정보 유효성을 체크하여 에러 코드를 리턴
////	 * @param request
////	 * @param policy
////	 * @param loginForm
////	 * @param userSession
////	 * @return
////	 */
////	private String validateUserInfo(HttpServletRequest request, boolean isSSO, Policy policy, UserInfo loginForm, UserSession userSession) {
////		// TODO 사용자 상태를 체크 해야 함
////		return null;
////	}
//	
//	/**
//	 * 로그아웃 페이지
//	 * @param model
//	 * @return
//	 */
//	@GetMapping(value = "logout")
//	public String logout(HttpServletRequest request, Model model) {
//		HttpSession session = request.getSession();
//		UserSession userSession = (UserSession)session.getAttribute(UserSession.KEY);
//		if(userSession == null) {
//			log.info("------------- userSession is null ");
//			return "redirect:/login/login";
//		}
//		
//		session.removeAttribute(userSession.getUserId());
//		session.removeAttribute(UserSession.KEY);
//		session.invalidate();
//		log.info("------------- userSession invaliate ");
//		
//		return "redirect:/login/login";
//	}
//}
