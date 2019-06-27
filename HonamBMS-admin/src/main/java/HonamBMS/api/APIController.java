package HonamBMS.api;

import org.slf4j.Logger;
import org.springframework.http.HttpStatus;

import HonamBMS.domain.APIHeader;
import HonamBMS.domain.APILog;
import HonamBMS.domain.APIResult;
import HonamBMS.exception.CustomSecurityException;
import HonamBMS.service.APILogService;

public interface APIController {
	
	default void insertLog(APILogService aPILogService, String requestIp, String userId, String url, Integer serverId, String serverName, Integer statusCode, String message) {
		try {
			APILog aPILog = new APILog();
			aPILog.setServerId(serverId);
			aPILog.setServerName(serverName);
			aPILog.setRequestIp(requestIp);
			aPILog.setUserId(userId);
			aPILog.setUrl(url);
			aPILog.setStatusCode(statusCode);
			aPILog.setMessage(message);
			
			aPILogService.insertAPILog(aPILog);	
		} catch(Exception ex) {
			ex.printStackTrace();
			//log.error("@@@@@@@@ API 이력 저장 중 오류가 발생했지만... 무시");
		}
	}

	/**
	 * 검증
	 * @param aPIHeader
	 * @return
	 */
	default APIResult validate(Logger log, APIHeader aPIHeader) {
		APIResult aPIResult = new APIResult();
		try {
			if(aPIHeader == null) {
				aPIResult.setStatusCode(HttpStatus.UNAUTHORIZED.value());
				aPIResult.setMessage("honam header is null or empty");
				return aPIResult;
			}
		} catch(CustomSecurityException e) {
			aPIResult.setStatusCode(HttpStatus.INTERNAL_SERVER_ERROR.value());
			aPIResult.setException(e.getMessage());
			aPIResult.setMessage("An error occurred during the encryption / decryption processing.");
			return aPIResult;
		}
		
		aPIResult.setStatusCode(HttpStatus.OK.value());
		return aPIResult;
	}
	
	/**
	 * header 복호화
	 * @return
	 */
	default APIHeader getHeader() {
		// TODO 확장 때문에 남겨둠
		return null;
	}
}
