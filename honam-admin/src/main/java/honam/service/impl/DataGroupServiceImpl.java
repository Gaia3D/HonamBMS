package honam.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import honam.domain.DataGroup;
import honam.persistence.DataGroupMapper;
import honam.service.DataGroupService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class DataGroupServiceImpl implements DataGroupService {
	
	@Autowired
	private DataGroupMapper dataGroupMapper;
	
	/**
     * 전체 데이터 그룹 목록
     * @param dataGroup
     */
	@Transactional(readOnly = true)
	public List<DataGroup> getAllListDataGroup(DataGroup dataGroup) {
		return dataGroupMapper.getAllListDataGroup(dataGroup);
	}
}
