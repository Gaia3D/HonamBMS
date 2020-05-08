package honam.controller.view;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import honam.domain.Policy;
import honam.domain.UserGroup;
import honam.service.PolicyService;
import honam.service.UserGroupService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/user-group")
public class UserGroupController {

	@Autowired
	private UserGroupService userGroupService;


	@Autowired
	private PolicyService policyService;

	@Autowired
	private ObjectMapper objectMapper;

	/**
	 * 사용자 그룹 목록
	 * @param request
	 * @param userGroup
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/list")
	public String list(HttpServletRequest request, @ModelAttribute UserGroup userGroup, Model model) {
		List<UserGroup> userGroupList = userGroupService.getListUserGroup();

		model.addAttribute("userGroupList", userGroupList);

		return "/user-group/list";
	}

}
