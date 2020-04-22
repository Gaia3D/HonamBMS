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
	
	/**
	 * sensordata 목록 
	 * @param sensorid
	 * @return
	 */
	List<Sensor> getListSensorData(Sensor sensor);
	
	/**
	 * 데이터중 최근 10일 날짜 목록
	 * @return
	 */
	List<Sensor> getListSensorTime(String sensorid);
	
	/**
	 * LCCdata 목록
	 * @param fac_num
	 * @return
	 */
	List<Sensor> getListLCCData(String fac_num);
}
