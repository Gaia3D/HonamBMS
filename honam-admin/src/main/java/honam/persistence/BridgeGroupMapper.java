package honam.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import honam.domain.BridgeGroup;

@Repository
public interface BridgeGroupMapper {
	
	/**
	 * 사용자 Data Group 총건수
	 * @param dataGroup
	 * @return
	 */
	Long getDataGroupTotalCount(BridgeGroup dataGroup);

	/**
     * 데이터 그룹 목록
     * @return
     */
    List<BridgeGroup> getListDataGroup();

    /**
     * 데이터 정보 조회
     * @param dataGroup
     * @return
     */
    BridgeGroup getDataGroup(BridgeGroup dataGroup);
}
