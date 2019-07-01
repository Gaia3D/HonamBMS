//package honam.controller;
//
//import java.util.HashMap;
//import java.util.Map;
//
//import javax.validation.Valid;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.validation.BindingResult;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//
//import honam.domain.APIError;
//import honam.domain.Policy;
//import honam.service.PolicyService;
//
//@Controller
//@RequestMapping("/")
//public class PolicyController {
//
//    @Autowired
//    private PolicyService policyService;
//
//    /**
//    * 환경 설정 페이지
//    */
//    @GetMapping(value = "policy")
//    public String modifyPolicy(Model model) {
//        Policy policy = policyService.getPolicy();
//        model.addAttribute("policy", policy);
//        return "/policy/modify";
//    }
//
//    /**
//    * Geoserver 정책 UPDATE
//    */
//    @PostMapping(value = "policy/{policyId}/geoserver")
//    public ResponseEntity<?> updateGeoserver(@PathVariable String policyId, @Valid Policy policy, BindingResult bindingResult) {
//        try {
//            if(bindingResult.hasErrors()) {
//                String errorMessage = bindingResult.getAllErrors().get(0).getDefaultMessage();
//
//                Map<String, Object> result = new HashMap<>();
//                result.put("statusCode", HttpStatus.BAD_REQUEST.value());
//                result.put("error", new APIError(errorMessage));
//                return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
//            }
//
//            policyService.updateGeoserver(policy);
//            return new ResponseEntity<>(HttpStatus.OK.value(), HttpStatus.OK);
//        } catch (Exception e) {
//            e.printStackTrace();
//
//            Map<String, Object> result = new HashMap<>();
//            result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
//            result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
//            return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//    }
//
//    /**
//    * Geoserver 정책 UPDATE
//    */
//    @PostMapping(value = "policy/{policyId}/layer")
//    public ResponseEntity<?> updateLayer(@PathVariable String policyId, @Valid Policy policy, BindingResult bindingResult) {
//        try {
//            if(bindingResult.hasErrors()) {
//                String errorMessage = bindingResult.getAllErrors().get(0).getDefaultMessage();
//
//                Map<String, Object> result = new HashMap<>();
//                result.put("statusCode", HttpStatus.BAD_REQUEST.value());
//                result.put("error", new APIError(errorMessage));
//                return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
//            }
//
//            policyService.updateLayer(policy);
//
//            return new ResponseEntity<>(HttpStatus.OK.value(), HttpStatus.OK);
//        } catch (Exception e) {
//            e.printStackTrace();
//
//            Map<String, Object> result = new HashMap<>();
//            result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
//            result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
//            return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//    }
//    
//    /**
//     * 이동체 정책 UPDATE
//     */
//    @PostMapping("policy/{policyId}/vehicle")
//    public ResponseEntity<?> updateVehicle(@PathVariable String policyId, @Valid Policy policy, BindingResult bindingResult) {
//    	try {
//    		if(bindingResult.hasErrors()) {
//    			String errorMessage = bindingResult.getAllErrors().get(0).getDefaultMessage();
//
//                Map<String, Object> result = new HashMap<>();
//                result.put("statusCode", HttpStatus.BAD_REQUEST.value());
//                result.put("error", new APIError(errorMessage));
//                return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
//    		}
//
//    		policyService.updateVehicle(policy);
//    		return new ResponseEntity<>(HttpStatus.OK.value(), HttpStatus.OK);
//    	} catch (Exception e) {
//    		e.printStackTrace();
//
//    		Map<String, Object> result = new HashMap<>();
//    		result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
//    		result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
//    		return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
//    	}
//    }
//    
//    /**
//    * 보안 정책 UPDATE
//    */
//    @PostMapping(value = "policy/{policyId}/security")
//    public ResponseEntity<?> updateSecurity(@PathVariable String policyId, @Valid Policy policy, BindingResult bindingResult) {
//    	try {
//            if(bindingResult.hasErrors()) {
//                String errorMessage = bindingResult.getAllErrors().get(0).getDefaultMessage();
//
//                Map<String, Object> result = new HashMap<>();
//                result.put("statusCode", HttpStatus.BAD_REQUEST.value());
//                result.put("error", new APIError(errorMessage));
//                return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
//            }
//
//            policyService.updateSecurity(policy);
//
//            return new ResponseEntity<>(HttpStatus.OK.value(), HttpStatus.OK);
//        } catch (Exception e) {
//            e.printStackTrace();
//
//            Map<String, Object> result = new HashMap<>();
//            result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
//            result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
//            return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//    }
//
//    /**
//    * 컨텐츠 정책 UPDATE
//    */
//    @PostMapping("policy/{policyId}/contents")
//    public ResponseEntity<?> updateContents(@PathVariable String policyId, @Valid Policy policy, BindingResult bindingResult) {
//        try {
//            if(bindingResult.hasErrors()) {
//                String errorMessage = bindingResult.getAllErrors().get(0).getDefaultMessage();
//
//                Map<String, Object> result = new HashMap<>();
//                result.put("statusCode", HttpStatus.BAD_REQUEST.value());
//                result.put("error", new APIError(errorMessage));
//                return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
//            }
//
//            policyService.updateContents(policy);
//
//            return new ResponseEntity<>(HttpStatus.OK.value(), HttpStatus.OK);
//        } catch (Exception e) {
//            e.printStackTrace();
//
//            Map<String, Object> result = new HashMap<>();
//            result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
//            result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
//            return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//    }
//
//    /**
//    * 파일 관리 정책 UPDATE
//    */
//    @PostMapping(value = "policy/{policyId}/fileUpload")
//    public ResponseEntity<?> updateFileUpload(@PathVariable String policyId, @Valid Policy policy, BindingResult bindingResult) {
//        try {
//            if(bindingResult.hasErrors()) {
//                String errorMessage = bindingResult.getAllErrors().get(0).getDefaultMessage();
//
//                Map<String, Object> result = new HashMap<>();
//                result.put("statusCode", HttpStatus.BAD_REQUEST.value());
//                result.put("error", new APIError(errorMessage));
//                return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
//            }
//
//            policyService.updateFileUpload(policy);
//
//            return new ResponseEntity<>(HttpStatus.OK.value(), HttpStatus.OK);
//        } catch (Exception e) {
//            e.printStackTrace();
//
//            Map<String, Object> result = new HashMap<>();
//            result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
//            result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
//            return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//    }
//
//    /**
//    * 블록 관리 정책 UPDATE
//    */
//    @PostMapping(value = "policy/{policyId}/blockManage")
//    public ResponseEntity<?> updateBlockManage(@PathVariable String policyId, @Valid Policy policy, BindingResult bindingResult) {
//        try {
//            if(bindingResult.hasErrors()) {
//                String errorMessage = bindingResult.getAllErrors().get(0).getDefaultMessage();
//
//                Map<String, Object> result = new HashMap<>();
//                result.put("statusCode", HttpStatus.BAD_REQUEST.value());
//                result.put("error", new APIError(errorMessage));
//                return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
//            }
//
//            policyService.updateBlockManage(policy);
//
//            return new ResponseEntity<>(HttpStatus.OK.value(), HttpStatus.OK);
//        } catch (Exception e) {
//            e.printStackTrace();
//
//            Map<String, Object> result = new HashMap<>();
//            result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
//            result.put("error", new APIError(e.getCause() != null ? e.getCause().getMessage() : e.getMessage()));
//            return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//    }
//}
