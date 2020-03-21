package honam.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import honam.domain.Policy;
import honam.persistence.PolicyMapper;
import honam.service.PolicyService;

@Service
public class PolicyServiceImpl implements PolicyService {

    @Autowired
    private PolicyMapper policyMapper;

    /**
    * 운영 정책 조회
    * @return
    */
    @Transactional(readOnly=true)
    public Policy getPolicy() {
        return policyMapper.getPolicy();
    }
    
    /**
     * 운영정책 수정
     */
    @Transactional(readOnly=true)
    public int updatePolicy(Policy policy) {
    	return policyMapper.updatePolicy(policy);
    }
}
