package honam.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import honam.domain.BridgeGroup;
import honam.persistence.BridgeGroupMapper;
import honam.service.BridgeGroupService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BridgeGroupServiceImpl implements BridgeGroupService {

	@Autowired
	private BridgeGroupMapper bridgeGroupMapper;
	
	/**
	 * 교량 Group 총건수
	 * @param bridgeGroup
	 * @return
	 */
	public Long getBridgeGroupTotalCount() {
		return bridgeGroupMapper.getBridgeGroupTotalCount();
	}
	
	/**
     * 교량 그룹 목록
     * @return
     */
	@Transactional(readOnly = true)
	public List<BridgeGroup> getListBridgeGroup() {
		return bridgeGroupMapper.getListBridgeGroup();
	}

	/**
     * 교량 그룹 정보 조회
     * @param dataGroup
	 * @return
	 */
	@Transactional(readOnly = true)
	public BridgeGroup getBridgeGroup(BridgeGroup bridgeGroup) {
		return bridgeGroupMapper.getBridgeGroup(bridgeGroup);
	}
}
