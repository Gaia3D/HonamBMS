package honam.domain;

import java.math.BigDecimal;
import java.sql.Timestamp;

import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * bridge 그룹
 * @author Cheon JeongDae
 *
 */
@ToString(callSuper = true)
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class BridgeGroup extends Search {

	/****** 화면 표시용 *******/
	// 위도
	private BigDecimal latitude;
	// 경도
	private BigDecimal longitude;
	
	/****** validator ********/
	private String methodMode;
	
	// 고유번호
	private Integer bridgeGroupId;
	// 링크 활용 등을 위한 확장 컬럼
	private String bridgeGroupKey;
	// 그룹명
	@Size(max = 100)
	private String bridgeGroupName;
	// 사용자명
	private String userId;
	private String userName;
	
	// 목표 성능
	private BigDecimal goalPerformance;
	
	// 순서
	private Integer viewOrder;
	
	// true : 사용, false : 사용안함
	private Boolean available;
	
	// POINT(위도, 경도). 공간 검색 속도 때문에 altitude는 분리
	private String location;
	// 높이
	private BigDecimal altitude;
	// Map 이동시간
	private Integer duration;
	// 시작 지역
	private String startArea;
	// 종료 지역
	private String endArea;
	
	// 설명
	private String description;
	
	@Getter(AccessLevel.NONE)
	@Setter(AccessLevel.NONE)
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private Timestamp viewUpdateDate;
	
	@Getter(AccessLevel.NONE)
	@Setter(AccessLevel.NONE)
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private Timestamp viewInsertDate;
	
	public Timestamp getViewUpdateDate() {
		return this.updateDate;
	}
	public Timestamp getViewInsertDate() {
		return this.insertDate;
	}
	
	// 수정일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp updateDate;
	// 등록일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp insertDate;
}
