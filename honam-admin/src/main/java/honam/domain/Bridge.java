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
public class Bridge extends Search {

	/****** DB 데이터 화면 표시용 ********/
	// 고유번호
	private Integer gid;
	// UFID (고유식별번호)
	private String ufid;
	// 시설물 번호
	private String fac_num;
	// 교량 명
	private String brg_nam;
	// 관리주체
	private String mng_org;
	// 시도
	private String fac_sido;
	// 시군구
	private String fac_sgg;
	// 읍명동
	private String fac_emd;
	// 리
	private String fac_ri;
	// 종별
	private String fac_gra;
	// 준공일
	private String end_amd;
	// 설계 하중
	private String dsn_wet;
	// 연장
	private Double brg_len; 
	// 교고
	private Double brg_hit;
	// 유효폭
	private Double eff_wid;
	// 총폭
	private Double tot_wid; 
	// 경간수
	private Double spa_cnt;
	// 최대경간장
	private Double max_len;
	// 교통량
	private String tra_cnt;
	// 상부 경간 대표
	private String usp_rep;
	// 하부 고각 대표
	private String dpi_rep;
	// 교량그룹 고유변호
	private String gru_num;
	
	// Multi Polygon
	@Setter(AccessLevel.NONE)
	private String geom;
	
	// 교량의 유지 관리 목표 성능
	private Double bridge_cm;
	// 교량의 내하 성능 수치
	private Double bridge_lcc;
	// 교량 등급
	private String bridge_grade;
	
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date update_date;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date insert_date;
	
	// 시도 코드
	private String sdoCode;
	// 시군구 코드
	private String sggCode;
	
}
