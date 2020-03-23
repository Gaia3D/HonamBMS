package honam.service;

import java.util.List;

import honam.domain.Sensor;

public interface SensorService {
	/**
	 * sensorID 목록
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
}
