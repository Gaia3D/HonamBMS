package honam.controller.rest;

import java.util.HashMap;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import honam.domain.Policy;
import honam.service.PolicyService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/policies")
@RestController
public class PolicyRestController {

	@Autowired
	private PolicyService policyService;

	@PostMapping(value = "/{policyId:[0-9]+}")
    public Map<String, Object> updatePassword(@Valid Policy policy, @PathVariable Long policyId, BindingResult bindingResult) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		if(bindingResult.hasErrors()) {
			message = bindingResult.getAllErrors().get(0).getDefaultMessage();
			log.info("@@@@@ message = {}", message);
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", errorCode);
			result.put("message", message);
            return result;
		}
		
		policy.setPolicyId(policyId);
		policyService.updatePolicy(policy);
		int statusCode = HttpStatus.OK.value();
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
    }
}
