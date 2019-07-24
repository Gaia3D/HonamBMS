package honam.service;

import java.util.List;

import honam.domain.Bridge;
import honam.domain.BridgeAttribute;
import honam.domain.SkSdo;
import honam.domain.SkSgg;


public interface BridgeService {
	/**
	 * Sdo 목록(geom 은 제외)
	 * @return
	 */
	List<SkSdo> getListSdoExceptGeom();
	
	/**
	 * Sgg 목록(geom 은 제외)
	 * @param sdo_code
	 * @return
	 */
	List<SkSgg> getListSggBySdoExceptGeom(String sdo_code);
	
	/**
	 * 선택한 시도의 center point를 구함
	 * @param skSdo
	 * @return
	 */
	String getCentroidSdo(SkSdo skSdo);
	
	/**
	 * 선택한 시군구 center point를 구함
	 * @param skSgg
	 * @return
	 */
	String getCentroidSgg(SkSgg skSgg);
	
	
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
	 * bridge 정보 조회
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
