package honam.service;

import java.util.List;

import honam.domain.BridgeGroup;

public interface BridgeGroupService {
	
	/**
	 * Data Group 총건수
	 * @param dataGroup
	 * @return
	 */
	Long getDataGroupTotalCount(BridgeGroup dataGroup);

	/**
     * 데이터 그룹 목록
     * @param dataGroup
     * @return
     */
    List<BridgeGroup> getListDataGroup(BridgeGroup dataGroup);

    /**
     * 데이터 그룹 정보 조회
     * @param dataGroup
     * @return
     */
    BridgeGroup getDataGroup(BridgeGroup dataGroup);
}
