package honam.domain;

import java.io.Serializable;
import java.util.Date;

import javax.validation.constraints.Max;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 운영 정책
 * TODO 도메인 답게 나누자.
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString
public class Policy implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 459206031795645584L;

	@NotNull
	private Long policyId;

	// geoserver 사용유무. Y : 사용(기본값), N : 미사용
	private String geoserverEnable;
	// geoserver wms 버전. 기본 1.1.1
	private String geoserverWmsVersion;
	// geoserver 데이터 URL
	private String geoserverDataUrl;
	// geoserver 데이터 작업공간
	private String geoserverDataWorkspace;
	// geoserver 데이터 저장소
	private String geoserverDataStore;
	// geoserver 계정
	private String geoserverUser;
	// geoserver 비밀번호
	private String geoserverPassword;

	// 레이어 원본 좌표계
	private String layerSourceCoordinate;
	// 레이어 좌표계 정의
	private String layerTargetCoordinate;
	// 기본 항공 레이어
	private String layerInitAerial;
	// 기본 드론 레이어
	private String layerInitDrone;
	// map center
	private String layerInitMapCenter;
	// map extent
	private String layerInitMapExtent;
	// 본사/해양
	private String layerInitMapExtentBonsa;
	// 온산
	private String layerInitMapExtentOnsan;
	// 용연
	private String layerInitMapExtentYongyeon;
	// 모화
	private String layerInitMapExtentMohwa;
	
	// tp 사용자 화면 갱신 주기. 기본값 30초
	private Integer vehicleTpInterval;
	// 172 차량 사용자 화면 갱신 주기. 기본값 30초
	private Integer vehicle172Interval;
	// 자제배송 차량  사용자 화면 갱신 주기. 기본값 30초
	private Integer vehicleMaterialDeliveryInterval;

	// 보안 세션 타임아웃. Y : 사용, N 미사용(기본값)
	private String securitySessionTimeoutYn;
	// 보안 세션 타임아웃 시간. 30분
	private String securitySessionTimeout;
	// 로그인 시 사용자 등록 IP 체크 유무. Y : 사용, N : 미사용(기본값)
	private String securityUserIpCheckYn;  
	// 보안 세션 하이재킹 처리. 0 : 미사용, 1 : 사용(기본값), 2 : OTP 추가 인증
	private String securitySessionHijacking;  
	// 로그인 시 모바일 사업장 영역 확인. Y : 사용, N : 미사용(기본값)
	private String mobileWorkplaceCheckYn;

	// css, js 갱신용 cache version.
	private Integer contentCacheVersion;  
	// layer 그룹 최상위 그룹명
	private String contentLayerGroupRoot; 

	// 업로딩 가능 확장자. tif,tfw,png,pgw,jpg,jpeg,jgw 등
	private String userUploadType;
	// 최대 업로딩 사이즈(단위M). 기본값 500M
	@Max(2048)
	private Long userUploadMaxFilesize;  
	// 1회, 최대 업로딩 파일 수. 기본값 50개
	@Max(50)
	private Integer userUploadMaxCount;  

	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date insertDate;
}
