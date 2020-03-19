package honam.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import honam.domain.BridgeGroup;

@Repository
public interface BridgeGroupMapper {
	
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
