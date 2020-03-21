package honam.service;

import honam.domain.Policy;

public interface PolicyService {

    /**
    * 운영 정책 조회
    * @return
    */
    Policy getPolicy();
    
    /**
     * 운영 정책 수정 
     * @param policy
     * @return
     */
    int updatePolicy(Policy policy);
}
