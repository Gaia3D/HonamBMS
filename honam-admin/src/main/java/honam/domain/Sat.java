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
	private String facNum;
	// 경도(longitude)
	private Double lon;
	// 위도(latitude)
	private Double lat;
	// 위성영상 촬영 일자
	private Integer acquireDate;
	// 변위값
	private Double value;
	// slope (mm/yr)
	private Double slope;
	// Multi Polygon
	@Setter(AccessLevel.NONE)
	private String geom;
	
	// 년간 변위율(displacement)
	private Double displacement;
	// 총 건수
	private Double satAvgCount;
}
