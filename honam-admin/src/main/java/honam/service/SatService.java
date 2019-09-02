package honam.service;

import java.util.List;

import honam.domain.Bridge;
import honam.domain.Sat;

public interface SatService {
	/**
	 * 년간 변위율(평균값) 목록
	 * @return
	 */
	List<Sat> getListSatAvg(String fac_num);
	
	/**
	 * 선택된 지점의 날짜별 변위값 목록
	 * @param sat
	 * @return
	 */
	List<Sat> getListSatValueByLonLat(Sat sat);
}
