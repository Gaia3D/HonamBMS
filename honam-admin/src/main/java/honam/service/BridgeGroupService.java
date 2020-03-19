package honam.service;

import java.util.List;

import honam.domain.BridgeGroup;

public interface BridgeGroupService {
	
	/**
	 * 교량 Group 총건수
	 * @param bridgeGroup
	 * @return
	 */
	Long getBridgeGroupTotalCount();

	/**
     * 교량 그룹 목록
     * @return
     */
    List<BridgeGroup> getListBridgeGroup();

    /**
     * 교량 정보 조회
     * @param bridgeGroup
     * @return
     */
    BridgeGroup getBridgeGroup(BridgeGroup bridgeGroup);
}
