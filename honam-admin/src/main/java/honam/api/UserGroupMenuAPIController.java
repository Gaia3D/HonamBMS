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
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RestController;
//
//import hmd.domain.APIError;
//import hmd.domain.UserGroupMenu;
//import hmd.service.APILogService;
//import hmd.service.UserGroupService;
//import hmd.util.WebUtil;
//import io.swagger.annotations.ApiOperation;
//import lombok.extern.slf4j.Slf4j;
//
//@Slf4j
//@RequestMapping("/api")
//@RestController
//public class UserGroupMenuAPIController implements APIController {
//
//    @Autowired
//    private APILogService aPILogService;
//
//    @Autowired
//    private UserGroupService userGroupService;
//
//    @ApiOperation(value = "사용자 그룹 메뉴")
//    @GetMapping(value = "/user/groups/menus", produces = "application/json; charset=UTF-8")
//    public ResponseEntity<?> userGroupMenu(HttpServletRequest request, UserGroupMenu userGroupMenu) {
//        log.info("@@@@@@@@@@ userGroup api call. userGroupMenu = {}", userGroupMenu);
//
//        int statusCode = 0;
//        String message = null;
//        try {
//            // header 체크, 인증, 인가 등 모드 무시
//            statusCode = HttpStatus.OK.value();
//            List<UserGroupMenu> userGroupMenuList = userGroupService.getListUserGroupMenu(userGroupMenu);
//            
//            return new ResponseEntity<>(userGroupMenuList, HttpStatus.OK);
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
//}
