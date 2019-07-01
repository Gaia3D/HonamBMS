package honam.api;
//
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import javax.servlet.http.HttpServletRequest;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RestController;
//
//import hmd.domain.APIError;
//import hmd.domain.UserGroup;
//import hmd.service.APILogService;
//import hmd.service.UserGroupService;
//import hmd.util.WebUtil;
//import io.swagger.annotations.ApiOperation;
//import lombok.extern.slf4j.Slf4j;
//
//@Slf4j
//@RequestMapping("/api")
//@RestController
//public class UserGroupAPIController implements APIController {
//
//    @Autowired
//    private APILogService aPILogService;
//
//    @Autowired
//    private UserGroupService userGroupService;
//
//    @ApiOperation(value = "사용자 그룹")
//    @GetMapping(value = "/user/groups", produces = "application/json; charset=UTF-8")
//    public ResponseEntity<?> userGroup(HttpServletRequest request, UserGroup userGroup) {
//        log.info("@@@@@@@@@@ userGroup api call. userGroup = {}", userGroup);
//
//        int statusCode = 0;
//        String message = null;
//        try {
//            // header 체크, 인증, 인가 등 모드 무시
//            statusCode = HttpStatus.OK.value();
//            List<UserGroup> userGroupList = userGroupService.getListUserGroup(userGroup);
//            
//            return new ResponseEntity<>(userGroupList, HttpStatus.OK);
//        } catch(Exception e) {
//            e.printStackTrace();
//            statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
//            message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
//
//            Map<String, Object> result = new HashMap<>();
//            result.put("statusCode", statusCode);
//            result.put("error", new APIError(message));
//            return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
//        } finally {
//            insertLog(aPILogService, WebUtil.getClientIp(request), null, request.getRequestURL().toString(), null, null, statusCode, message);
//        }
//    }
//
//    @ApiOperation(value = "사용자 그룹")
//    @PostMapping(value = "/user/groups/{userId}")
//    public ResponseEntity<?> getUserGroup(HttpServletRequest request, @PathVariable String userId) {
//        log.info("@@@@@@@@@@ getUserGroup api call!!! userId={}", userId);
//
//        int statusCode = 0;
//        String message = null;
//
//        try {
//            UserGroup userGroup = userGroupService.getUserGroupByUserId(userId);
//            return new ResponseEntity<>(userGroup, HttpStatus.OK);
//        } catch (Exception e) {
//            e.printStackTrace();
//            statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
//            message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
//
//            Map<String, Object> result = new HashMap<>();
//            result.put("statusCode", statusCode);
//            result.put("error", new APIError(message));
//            return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
//        } finally {
//            insertLog(aPILogService, WebUtil.getClientIp(request), null, request.getRequestURL().toString(), null, null, statusCode, message);
//        }
//
//    }
//}
