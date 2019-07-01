package honam.service;

import java.util.List;

import honam.domain.APILog;

/**
 * API 이력
 * @author jeongdae
 *
 */
public interface APILogService {
	
	/**
	 * API 호출 총 건수
	 * @param apiLog
	 * @return
	 */
	Long getAPILogTotalCount(APILog apiLog);
	
	/**
	 * API 호출 목록
	 * @param apiLog
	 * @return
	 */
	List<APILog> getListAPILog(APILog apiLog);
	
	/**
	 * API 호출 정보
	 * @param apiLogId
	 * @return
	 */
	APILog getAPILog(Long apiLogId);
	
	/**
	 * @param apiLog
	 * @return
	 */
	int insertAPILog(APILog apiLog);
}
