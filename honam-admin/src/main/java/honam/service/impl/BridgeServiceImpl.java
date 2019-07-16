package honam.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import honam.domain.Bridge;
import honam.domain.BridgeAttribute;
import honam.persistence.postgresql.BridgeMapper;
import honam.service.BridgeService;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service
public class BridgeServiceImpl implements BridgeService {
	
	@Autowired
	private BridgeMapper bridgeMapper;
	
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
