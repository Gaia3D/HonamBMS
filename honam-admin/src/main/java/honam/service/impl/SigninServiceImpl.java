package honam.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import honam.domain.UserInfo;
import honam.domain.UserSession;
import honam.persistence.SigninMapper;
import honam.service.SigninService;

/**
 * Sign in 관련 처리
 * @author jeongdae
 *
 */
@Service
public class SigninServiceImpl implements SigninService {

	@Autowired
	private SigninMapper signinMapper;
	
	/**
	 * 회원 세션 정보를 취득
	 * @param userInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public UserSession getUserSession(UserInfo userInfo) {
		return signinMapper.getUserSession(userInfo);
	}

	/**
	 * Sign in 성공 후 회원 정보를 갱신
	 * @param userSession
	 * @return
	 */
	@Transactional
	public int updateSigninUserSession(UserSession userSession) {
		return signinMapper.updateSigninUserSession(userSession);
	}
}
