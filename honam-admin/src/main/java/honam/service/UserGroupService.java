package honam.service;

import java.util.List;

import honam.domain.UserGroup;
import honam.domain.UserGroupMenu;
import honam.domain.UserGroupRole;

/**
 * 사용자 그룹 관리
 * 
 * @author jeongdae
 *
 */
public interface UserGroupService {

	/**
	 * 사용자 그룹 목록
	 * 
	 * @param userGroup
	 * @return
	 */
	List<UserGroup> getListUserGroup(UserGroup userGroup);

	/**
	 * 자식 사용자 그룹 개수
	 * 
	 * @param userGroupId
	 * @return
	 */
	int getChildUserGroupCount(Integer userGroupId);
	
	/**
	 * 사용자 그룹 정보 취득
	 * @param userGroupId
	 * @return
	 */
	UserGroup getUserGroup(Integer userGroupId);
	
	/**
	 * 사용자 그룹 정보 취득
	 * @param userId
	 * @return
	 */
	UserGroup getUserGroupByUserId(String userId);
	
	/**
	 * 자식 사용자 그룹 중 순서가 최대인 사용자 그룹 검색
	 * @param userGroupId
	 * @return
	 */
	UserGroup getMaxViewOrderChildUserGroup(Integer userGroupId);
	
	/**
	 * 사용자 그룹 메뉴 권한 목록
	 * 
	 * @param userGroupMenu
	 * @return
	 */
	List<UserGroupMenu> getListUserGroupMenu(UserGroupMenu userGroupMenu);
	
	/**
	 * 사용자 그룹 Role 목록
	 * @param userGroupRole
	 * @return
	 */
	List<UserGroupRole> getListUserGroupRole(UserGroupRole userGroupRole);
	
	/**
	 * 사용자 그룹 Role Key 목록
	 * @param userGroupRole
	 * @return
	 */
	List<String> getListUserGroupRoleKey(UserGroupRole userGroupRole);
	
	/**
	 * 사용자 그룹 등록
	 * @param userGroup
	 * @return
	 */
	int insertUserGroup(UserGroup userGroup);
	
	/**
	 * 사용자 그룹 트리 정보 수정
	 * @param userGroup
	 * @return
	 */
	int updateUserGroup(UserGroup userGroup);
	
	/**
	 * 사용자 그룹 트리 순서 수정, up, down
	 * @param userGroup
	 * @return
	 */
	int updateMoveTreeUserGroup(UserGroup userGroup);
	
	/**
	 * 사용자 그룹 메뉴 수정
	 * @param userGroupMenu
	 * @return
	 */
	int updateUserGroupMenu(UserGroupMenu userGroupMenu);
	
	/**
	 * 사용자 그룹 Role 수정
	 * @param userGroupRole
	 * @return
	 */
	int updateUserGroupRole(UserGroupRole userGroupRole);
	
	/**
	 * 사용자 그룹 삭제
	 * @param userGroupId
	 * @return
	 */
	int deleteUserGroup(Integer userGroupId);
}