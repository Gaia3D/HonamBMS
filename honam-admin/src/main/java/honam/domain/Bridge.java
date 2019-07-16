package honam.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Bridge extends Search {

	/****** DB 데이터 화면 표시용 ********/
	// 고유번호
	private Integer bridgeId;
	// 시설물 번호
	private String facNum;
	// 교량 명
	private String bridgeName;
	// 교량 그룹의 고유 번호
	private String bridgeGroupId;
	// 교량의 유지 관리 목표 성능
	private Double bridgeCm;
	// 교량의 내하 성능 수치
	private Double bridgeLcc;
	// 교량 등급
	private String bridgeGrade;
	
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date updateDate;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date insertDate;	
}
