package honam.domain;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BridgeAttribute implements Serializable{
	private static final long serialVersionUID = -858142988322925960L;
	
	/****** DB 데이터 화면 표시용 ********/
	// 고유번호
	private Integer gid;
	// UFID (고유식별번호)
	private String ufid;
	// 시설물 번호
	private String facNum;
	// 교량 명
	private String bridgeName;
	// 관리주체
	private String manageOrg;
	// 시도
	private String facSido;
	// 시군구
	private String facSgg;
	// 읍명돈
	private String facEmd;
	// 리
	private String facRi;
	// 종별
	private String facGrade;
	// 준공일
	private String endAmd;
	// 설계 하중
	private String designWet;
	// 연장
	private Double bridgeLength; 
	// 교고
	private Double bridgeHight;
	// 유효폭
	private Double effWidth;
	// 총폭
	private Double totalWidth; 
	// 경간수
	private Double spaCnt;
	// 최대경간장
	private Double maxLength;
	// 교통량
	private String transitCnt;
	// 상부 경간 대표
	private String uspRep;
	// 하부 고각 대표
	private String dpiRep;
	
	// Multi Polygon
	@Setter(AccessLevel.NONE)
	private String geom;
	
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date updateDate;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date insertDate;		
}
