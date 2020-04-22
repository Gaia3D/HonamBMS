package honam.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Sensor {
	
	// 고유 번호
	private Integer gid;	
	// 시설물 번호
	private String facNum;
	// sensor Type
	private String sensorType;
	// sensor id
	private String sensorid;
	// x (TM좌표)
	private Double lat;
	// y (TM좌표)
	private Double lon;
	// x (WGS84 좌표)
	private Double latWgs;
	// y (WGS84좌표)
	private Double lonWgs;
	// z (altitude)
	private Double alt;
	// Point
	@Setter(AccessLevel.NONE)
	private String location;
	
	// time
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm", timezone="Asia/Seoul")
	private Date time; 
	// condition (0 or 1)
	private Integer condition;
	// mean value
	private Double meanValue;
	// max value
	private Double maxValue;
	// 총 건수
	private Double sensorIDCount;
	
	// lcc
	private Double lcc;
}
