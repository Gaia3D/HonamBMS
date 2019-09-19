package honam.domain;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Sat {
	
	// 고유 번호
	private Integer id;
	// 시설물 번호
	private String fac_num;
	// 경도(longitude)
	private Double lon;
	// 위도(latitude)
	private Double lat;
	// 위성영상 촬영 일자
	private Integer acquire_date;
	// 변위값
	private Double value;
	// Multi Polygon
	@Setter(AccessLevel.NONE)
	private String geom;
	
	// 년간 변위율(displacement)
	private Double displacement;
	// 총 건수
	private Double satAvgCount;
}
