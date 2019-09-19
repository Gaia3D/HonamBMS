package honam.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import honam.domain.Sat;

@Repository
public interface SatMapper {
	
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
	
	/**
	 * 년간 변위율(평균값) 건수
	 * @return
	 */
	Long getSatAvgTotalCount(String fac_num);
}
