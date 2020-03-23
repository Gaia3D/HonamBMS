package honam.service;

import java.util.List;

import honam.domain.UserGroup;

public interface UserGroupService {

	/**
     * 사용자 그룹 목록
     * @return
     */
    List<UserGroup> getListUserGroup();
}
