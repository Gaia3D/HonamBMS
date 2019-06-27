package HonamBMS.persistence.postgresql;

import java.util.List;

import org.springframework.stereotype.Repository;

import HonamBMS.domain.APILog;

@Repository
public interface APILogMapper {

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
