package honam.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import honam.domain.Sensor;
import honam.persistence.SensorMapper;
import honam.service.SensorService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SensorServiceImpl implements SensorService {
	@Autowired
	private SensorMapper sensorMapper;
	
	/**
	 * sensorID 목록
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<Sensor> getListSensorID(String fac_num) {
		return sensorMapper.getListSensorID(fac_num);
	}
	
	/**
	 * SensorID 건수
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getSensorIDTotalCount(String fac_num) {
		return sensorMapper.getSensorIDTotalCount(fac_num);
	}
	
	/**
	 * 선택된 지점의 SensorID 목록
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<Sensor> getListSensorIDByLonLat(Sensor sensor) {
		return sensorMapper.getListSensorIDByLonLat(sensor);
	}
	
	/**
	 * SensorType별 SensorID 목록
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<Sensor> getListSensorIDBySensorType(Sensor sensor) {
		return sensorMapper.getListSensorIDBySensorType(sensor);
	}
	
	/**
	 * sensordata 목록 
	 * @param sensorid
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<Sensor> getListSensorData(Sensor sensor) {
		return sensorMapper.getListSensorData(sensor);
	}
	
	/**
	 * 데이터중 최근 10일 날짜 목록
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<Sensor> getListSensorTime(String sensorid) {
		return sensorMapper.getListSensorTime(sensorid);
	}
	
	/**
	 * LCCdata 목록
	 * @param fac_num
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<Sensor> getListLCCData(String fac_num) {
		return sensorMapper.getListLCCData(fac_num);
	}
}
