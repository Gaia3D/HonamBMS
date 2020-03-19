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
	private BridgeGroupMapper dataGroupMapper;
	
	/**
	 * Data Group 총건수
	 * @param dataGroup
	 * @return
	 */
	public Long getDataGroupTotalCount(BridgeGroup dataGroup) {
		return dataGroupMapper.getDataGroupTotalCount(dataGroup);
	}
	
	/**
     * 데이터 그룹 목록
     * @return
     */
	@Transactional(readOnly = true)
	public List<BridgeGroup> getListDataGroup(BridgeGroup dataGroup) {
		return dataGroupMapper.getListDataGroup();
	}

	/**
     * 데이터 그룹 정보 조회
     * @param dataGroup
	 * @return
	 */
	@Transactional(readOnly = true)
	public BridgeGroup getDataGroup(BridgeGroup dataGroup) {
		return dataGroupMapper.getDataGroup(dataGroup);
	}
}
