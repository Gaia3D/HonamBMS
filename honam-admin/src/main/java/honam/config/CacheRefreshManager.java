package honam.config;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import honam.domain.CacheManager;
import honam.domain.CacheName;
import honam.domain.CacheType;
import honam.domain.MenuTarget;
import honam.domain.RoleTarget;
import honam.domain.UserGroup;
import honam.domain.UserGroupMenu;
import honam.domain.UserGroupRole;
import honam.domain.YOrN;
import honam.service.UserGroupService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class CacheRefreshManager {

    @Autowired
    private UserGroupService userGroupService;

    public void refresh(CacheType cacheType, CacheName cacheName) {
    	if(cacheName == CacheName.USER_GROUP) {
    		if(cacheType == CacheType.SELF) {
    			userGroupMenuAndRole();
    		}
    	}
    }
    
    
    /**
     * 사용자 그룹, 메뉴, Role
     */
    private void userGroupMenuAndRole() {
    	log.info("----------------- userGroupMenuAndRole cache refresh start ---------------");
    	UserGroup inputUserGroup = new UserGroup();
    	inputUserGroup.setUseYn(YOrN.Y.name());
    	List<UserGroup> userGroupList = userGroupService.getListUserGroup(inputUserGroup);
    	
    	Map<Integer, List<UserGroupMenu>> userGroupMenuMap = new HashMap<>();
    	Map<Integer, List<String>> userGroupRoleMap = new HashMap<>();
    	
    	UserGroupMenu userGroupMenu = new UserGroupMenu();
    	userGroupMenu.setParent(-1);
    	userGroupMenu.setMenuTarget(MenuTarget.ADMIN.getValue());
    	
    	UserGroupRole userGroupRole = new UserGroupRole();
    	userGroupRole.setRoleTarget(RoleTarget.ADMIN.getValue());
    	for(UserGroup userGroup : userGroupList) {
    		Integer userGroupId = userGroup.getUserGroupId();
    		
    		userGroupMenu.setUserGroupId(userGroupId);
    		List<UserGroupMenu> userGroupMenuList = userGroupService.getListUserGroupMenu(userGroupMenu);
    		userGroupMenuMap.put(userGroupId, userGroupMenuList);
    		
    		userGroupRole.setUserGroupId(userGroupId);
    		List<String> userGroupRoleKeyList = userGroupService.getListUserGroupRoleKey(userGroupRole);
    		userGroupRoleMap.put(userGroupId, userGroupRoleKeyList);
    	}
    	
    	CacheManager.setUserGroupMenuMap(userGroupMenuMap);
    	CacheManager.setUserGroupRoleMap(userGroupRoleMap);
    	log.info("----------------- userGroupMenuAndRole cache refresh end ---------------");
    }
}
