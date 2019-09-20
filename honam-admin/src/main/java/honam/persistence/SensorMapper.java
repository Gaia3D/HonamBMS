package honam.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;
import honam.domain.Sensor;

@Repository
public interface SensorMapper {
	/**
	 * SensorID 목록
	 * @return
	 */
	List<Sensor> getListSensorID(String fac_num);
	
	/**
	 * SensorID 건수
	 * @return
	 */
	Long getSensorIDTotalCount(String fac_num);
	
	/**
	 * 선택된 지점의 SensorID 목록
	 * @return
	 */
	List<Sensor> getListSensorIDByLonLat(Sensor sensor);
	
	/**
	 * SensorType별 SensorID 목록
	 * @return
	 */
	List<Sensor> getListSensorIDBySensorType(Sensor sensor);	
}
