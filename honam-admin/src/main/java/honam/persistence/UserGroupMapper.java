package honam.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import honam.domain.UserGroup;

@Repository
public interface UserGroupMapper {

	/**
     * 사용자 그룹 목록
     * @return
     */
    List<UserGroup> getListUserGroup();
}
