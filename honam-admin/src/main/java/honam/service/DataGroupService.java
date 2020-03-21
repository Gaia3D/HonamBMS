package honam.service;

import java.util.List;

import honam.domain.DataGroup;

public interface DataGroupService {
	
	/**
     * 사용자 데이터 그룹 전체 목록
     * @return
     */
    List<DataGroup> getAllListDataGroup(DataGroup dataGroup);
}
