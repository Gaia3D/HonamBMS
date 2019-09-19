package honam.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import honam.domain.Sat;
import honam.service.SatService;
import honam.persistence.SatMapper;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SatServiceImpl implements SatService {
	@Autowired
	private SatMapper satMapper;
	
	/**
	 * 년간 변위율(평균값) 목록
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<Sat> getListSatAvg(String fac_num) {
		return satMapper.getListSatAvg(fac_num);
	}
	
	/**
	 * 선택된 지점의 날짜별 변위값 목록
	 * @param sat
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<Sat> getListSatValueByLonLat(Sat sat) {
		 return satMapper.getListSatValueByLonLat(sat);
	}
	
	/**
	 * 년간 변위율(평균값) 건수
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getSatAvgTotalCount(String fac_num) {
		return satMapper.getSatAvgTotalCount(fac_num);
	}
	
}