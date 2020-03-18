package honam.controller;

import java.util.HashMap;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import honam.domain.Policy;
import honam.service.PolicyService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/")
public class PolicyController {

    @Autowired
    private PolicyService policyService;

    /**
    * 환경 설정 페이지
    */
    @GetMapping(value = "policy")
    public String modifyPolicy(Model model) {
        Policy policy = policyService.getPolicy();
        model.addAttribute("policy", policy);
        return "/policy/modify";
    }

    /**
    * Geoserver 정책 UPDATE
    */
    @PostMapping(value = "policy/{policyId}/geoserver")
    @ResponseBody
	public Map<String, Object> updateGeoserver(@PathVariable String policyId, @Valid Policy policy, BindingResult bindingResult) {
    	Map<String, Object> map = new HashMap<>();
		String result = "success";
		
    	try {
            if(bindingResult.hasErrors()) {
                String errorMessage = bindingResult.getAllErrors().get(0).getDefaultMessage();

                map.put("result", "input.invalid");
				log.info("errorMessage = {} ", errorMessage);
				return map;
            }

            policyService.updateGeoserver(policy);
    	} catch (Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		log.info("@@@@ sggList = {}", map.toString());
		return map;
    }

    /**
    * Geoserver 정책 UPDATE
    */
    @PostMapping(value = "policy/{policyId}/layer")
    @ResponseBody
	public Map<String, Object> updateLayer(@PathVariable String policyId, @Valid Policy policy, BindingResult bindingResult) {
    	Map<String, Object> map = new HashMap<>();
		String result = "success";
    	
    	try {
            if(bindingResult.hasErrors()) {
                String errorMessage = bindingResult.getAllErrors().get(0).getDefaultMessage();

                map.put("result", "input.invalid");
				log.info("errorMessage = {} ", errorMessage);
				return map;
            }

            policyService.updateLayer(policy);
    	} catch (Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		log.info("@@@@ sggList = {}", map.toString());
		return map;
    }
    
    /**
    * 보안 정책 UPDATE
    */
    @PostMapping(value = "policy/{policyId}/security")
    @ResponseBody
	public Map<String, Object> updateSecurity(@PathVariable String policyId, @Valid Policy policy, BindingResult bindingResult) {
    	Map<String, Object> map = new HashMap<>();
		String result = "success";
    	
    	try {
            if(bindingResult.hasErrors()) {
                String errorMessage = bindingResult.getAllErrors().get(0).getDefaultMessage();

                map.put("result", "input.invalid");
				log.info("errorMessage = {} ", errorMessage);
				return map;
            }

            policyService.updateSecurity(policy);
    	} catch (Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		log.info("@@@@ sggList = {}", map.toString());
		return map;
    }

    /**
    * 컨텐츠 정책 UPDATE
    */
    @PostMapping("policy/{policyId}/contents")
    @ResponseBody
	public Map<String, Object> updateContents(@PathVariable String policyId, @Valid Policy policy, BindingResult bindingResult) {
    	Map<String, Object> map = new HashMap<>();
		String result = "success";
    	
    	try {
            if(bindingResult.hasErrors()) {
                String errorMessage = bindingResult.getAllErrors().get(0).getDefaultMessage();

                map.put("result", "input.invalid");
				log.info("errorMessage = {} ", errorMessage);
				return map;
            }

            policyService.updateContents(policy);
    	} catch (Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		log.info("@@@@ sggList = {}", map.toString());
		return map;
    }

    /**
    * 파일 관리 정책 UPDATE
    */
    @PostMapping(value = "policy/{policyId}/fileUpload")
    @ResponseBody
	public Map<String, Object> updateFileUpload(@PathVariable String policyId, @Valid Policy policy, BindingResult bindingResult) {
    	Map<String, Object> map = new HashMap<>();
		String result = "success";
    	
    	try {
            if(bindingResult.hasErrors()) {
                String errorMessage = bindingResult.getAllErrors().get(0).getDefaultMessage();

                map.put("result", "input.invalid");
				log.info("errorMessage = {} ", errorMessage);
				return map;
            }

            policyService.updateFileUpload(policy);
    	} catch (Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		log.info("@@@@ sggList = {}", map.toString());
		return map;
    }
}
