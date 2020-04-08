package honam.domain;

import java.math.BigDecimal;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Bridge extends Search {

	// 위도
	private BigDecimal latitude;
	// 경도
	private BigDecimal longitude;


	/****** 조회용 ********/
	// 교량 검색 타입
	private String bridgeType;
	/****** DB 데이터 화면 표시용 ********/
	
	// 고유번호
	private Long dataId;
	private Integer dataGroupId;
	
	// TODO gid는 삭제해야 함
	// 고유번호
	private Integer ogcFid;
	// 고유번호
	private Integer gid;
	// UFID (고유식별번호)
	private String ufid;
	// 시설물 번호
	private String facNum;
	// 교량 명
	private String brgNam;
	// 관리주체
	private String mngOrg;
	// 시도
	private String facSido;
	// 시군구
	private String facSgg;
	// 읍명동
	private String facEmd;
	// 리
	private String facRi;
	// 종별
	private String facGra;
	// 준공일
	private String endAmd;
	// 설계 하중
	private String dsnWet;
	// 연장
	private Double brgLen;
	// 교고
	private Double brgHit;
	// 유효폭
	private Double effWid;
	// 총폭
	private Double totWid;
	// 경간수
	private Double spaCnt;
	// 최대경간장
	private Double maxLen;
	// 교통량
	private String traCnt;
	// 상부 경간 대표
	private String uspRep;
	// 하부 고각 대표
	private String dpiRep;
	// 교량그룹 고유변호
	private String gruNum;
	// 3D 교량 모델 유무 및 개수
	private Integer model;

	// Multi Polygon
	private String geom;

	// 교량의 위성영상 기반 상태 평가
	private String satGrade;
	// 교량의 유지 관리 목표 성능
	private Double bridgeCm;
	// 교량의 내하 성능 수치
	private Double bridgeLcc;
	// 교량 등급
	private String grade;

	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date updateDate;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date insertDate;

	// 시도 코드
	private String sdoCode;
	// 시군구 코드
	private String sggCode;

}
