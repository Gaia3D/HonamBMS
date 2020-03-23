package honam.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import honam.domain.UserGroup;
import honam.persistence.UserGroupMapper;
import honam.service.UserGroupService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UserGroupServiceImpl implements UserGroupService {

	@Autowired
	private UserGroupMapper userGroupMapper;
	
	/**
     * 사용자 그룹 목록
     * @return
     */
	@Transactional(readOnly = true)
	public List<UserGroup> getListUserGroup() {
		return userGroupMapper.getListUserGroup();
	}
}
