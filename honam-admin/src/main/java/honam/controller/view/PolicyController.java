package honam.controller.view;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import honam.domain.Policy;
import honam.service.PolicyService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/policy")
@Controller
public class PolicyController {

	@Autowired
	private PolicyService policyService;
	
	/**
    * 환경 설정 페이지
    */
	@GetMapping
    public String modifyPolicy(Model model) {
    	log.info("policy view");
        Policy policy = policyService.getPolicy();
        
        model.addAttribute("policy", policy);
        
        return "/policy/modify";
    }
}
