package honam.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import honam.domain.Bridge;
import honam.domain.BridgeDroneFile;
import honam.domain.SkSdo;
import honam.domain.SkSgg;
import honam.service.BridgeDroneFileService;
import honam.service.BridgeService;
import honam.persistence.BridgeMapper;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service
public class BridgeServiceImpl implements BridgeService {

	@Autowired
	private BridgeMapper bridgeMapper;

	@Autowired
	private BridgeDroneFileService bridgeDroneFileService;

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
	 * 선택한 교량의 center point를 구함
	 * @param gid
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<Bridge> getListCentroidBridge() {
		return bridgeMapper.getListCentroidBridge();
	}

	/**
	 * 관리주체 목록
	 * @param bridge
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<Bridge> getListMngOrg() {
		return bridgeMapper.getListMngOrg();
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
	 * 교량 그룹 교량 목록
	 * @param bridgeGroupId
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<Bridge> getListBridgeByBridgeGroupId(Integer bridgeGroupId) {
		return bridgeMapper.getListBridgeByBridgeGroupId(bridgeGroupId);
	}

	/**
	 * bridge 정보 조회
	 * @param gid
	 * @return
	 */
	@Transactional(readOnly=true)
	public Bridge getBridge(Integer gid) {
		return bridgeMapper.getBridge(gid);
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
	 * bridge, dronefile 등록
	 * @param bridge
	 * @return
	 */
	@Transactional
	public int insertBridge(Bridge bridge, List<BridgeDroneFile> files) {
		int result = bridgeMapper.insertBridge(bridge);
		int gid = bridge.getGid();
		if (result > 0) {
			for (BridgeDroneFile file : files) {
				file.setOgcFid(gid);
			}
			result = bridgeDroneFileService.insertBridgeDroneFile(files);
		}
		return result;
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

	@Override
	public List<Bridge> getListBridgeAll() {
		return bridgeMapper.getListBridgeAll();
	}

	/**
	 * bridge 삭제
	 */
	@Transactional
	public int deleteBridge(Integer gid) {
		return bridgeMapper.deleteBridge(gid);
	}

	/**
	 * bridge 선택 삭제
	 */
	@Transactional
	public int deleteBridge(Integer[] gids) {
		int result = 0;
		for (Integer gid : gids) {
			result += bridgeMapper.deleteBridge(gid);
		}
		return result;
	}

}
