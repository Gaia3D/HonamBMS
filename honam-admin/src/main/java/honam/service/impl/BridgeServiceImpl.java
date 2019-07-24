package honam.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import honam.domain.Bridge;
import honam.domain.BridgeAttribute;
import honam.service.BridgeService;
import honam.domain.SkSdo;
import honam.domain.SkSgg;
import honam.persistence.BridgeMapper;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service
public class BridgeServiceImpl implements BridgeService {
	
	@Autowired
	private BridgeMapper bridgeMapper;
	
	/**
	 * Sdo 목록(geom 은 제외)
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<SkSdo> getListSdoExceptGeom() {
		return bridgeMapper.getListSdoExceptGeom();
	}
	
	/**
	 * Sgg 목록(geom 은 제외)
	 * @param sdo_code
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<SkSgg> getListSggBySdoExceptGeom(String sdo_code) {
		return bridgeMapper.getListSggBySdoExceptGeom(sdo_code);
	}
	
	/**
	 * 선택한 시도의 center point를 구함
	 * @param skSdo
	 * @return
	 */
	@Transactional(readOnly=true)
	public String getCentroidSdo(SkSdo skSdo) {
		return bridgeMapper.getCentroidSdo(skSdo);
	}
	
	/**
	 * 선택한 시군구 center point를 구함
	 * @param skSgg
	 * @return
	 */
	@Transactional(readOnly=true)
	public String getCentroidSgg(SkSgg skSgg) {
		return bridgeMapper.getCentroidSgg(skSgg);
	}
	
	/**
	 * 총건수
	 * @param bridge
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getBridgeTotalCount(Bridge bridge) {
		return bridgeMapper.getBridgeTotalCount(bridge);
	}

	/**
	 * 목록
	 * @param bridge
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<Bridge> getListBridge(Bridge bridge) {
		return bridgeMapper.getListBridge(bridge);
	}

	/**
	 * bridge 정보 조회
	 * @param bridge_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public Bridge getBridge(Integer bridgeId) {
		return bridgeMapper.getBridge(bridgeId);
	}

	/**
	 * bridge 등록
	 * @param bridge
	 * @return
	 */
	@Transactional
	public int insertBridge(Bridge bridge) {
		return bridgeMapper.insertBridge(bridge);
	}
	
	/**
	 * bridge 수정
	 * @param bridge
	 * @return
	 */
	@Transactional
	public int updateBridge(Bridge bridge) {
		return bridgeMapper.updateBridge(bridge);
	}
	
}
