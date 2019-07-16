package honam.persistence.postgresql;

import java.util.List;

import org.springframework.stereotype.Repository;

import honam.domain.Bridge;
import honam.domain.BridgeAttribute;

@Repository
public interface BridgeMapper {
	/**
	 * 총건수
	 * @param bridge
	 * @return
	 */
	Long getBridgeTotalCount(Bridge bridge);
	
	/**
	 * 목록
	 * @param bridge
	 * @return
	 */
	List<Bridge> getListBridge(Bridge bridge);
	
	/**
	 * 프로젝트 정보 조회
	 * @param bridge_id
	 * @return
	 */
	Bridge getBridge(Integer bridgeId);

	/**
	 * bridge 등록
	 * @param bridge
	 * @return
	 */
	int insertBridge(Bridge bridge);
	
	/**
	 * bridge 수정
	 * @param bridge
	 * @return
	 */
	int updateBridge(Bridge bridge);

}
