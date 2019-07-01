package honambms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import honambms.domain.APILog;
import honambms.persistence.postgresql.APILogMapper;
import honambms.service.APILogService;

@Service
public class APILogServiceImpl implements APILogService {

	@Autowired
	private APILogMapper aPILogMapper;
	
	/**
	 * API 호출 총 건수
	 * @param apiLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getAPILogTotalCount(APILog apiLog) {
		return aPILogMapper.getAPILogTotalCount(apiLog);
	}
	
	/**
	 * API 호출 목록
	 * @param apiLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<APILog> getListAPILog(APILog apiLog) {
		return aPILogMapper.getListAPILog(apiLog);
	}
	
	/**
	 * API 호출 정보
	 * @param apiLogId
	 * @return
	 */
	@Transactional(readOnly=true)
	public APILog getAPILog(Long apiLogId) {
		return aPILogMapper.getAPILog(apiLogId);
	}
	
	/**
	 * @param apiLog
	 * @return
	 */
	@Transactional
	public int insertAPILog(APILog apiLog) {
		return aPILogMapper.insertAPILog(apiLog);
	}
}
