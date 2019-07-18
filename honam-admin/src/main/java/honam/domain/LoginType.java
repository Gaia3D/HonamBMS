package honam.domain;

/**
 * MOCK(로컬), REST(블럭 물류 모니터링 시스템을 REST API 로 호출), DB(인사 DB를 이용)
 * rest는 종속이라서 하고 싶지 않지만 SSO 같은게 문제가 생기면 해야 할지도
 * @author Cheon JeongDae
 *
 */
public enum LoginType {
	// mock
	MOCK, 
	// rest api를 이용해서 블록 물류 모니터링 시스템을 호출, 의존성이 싫음
	REST, 
	// 오라클 db 직접 접속
	DB
}
