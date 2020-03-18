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
    * Geoserver 정책 수정
    * @param policy
    * @return
    */
    @Transactional
    public int updateGeoserver(Policy policy) {
        return policyMapper.updateGeoserver(policy);
    }

    /**
    * LayerMap 정책 수정
    * @param policy
    * @return
    */
    @Transactional
    public int updateLayer(Policy policy) {
        return policyMapper.updateLayer(policy);
    }
    
    /**
    * 보안 정책 수정
    * @param policy
    * @return
    */
    @Transactional
    public int updateSecurity(Policy policy) {
        return policyMapper.updateSecurity(policy);
    }

    /**
    * 컨텐츠 정책 수정
    * @param policy
    * @return
    */
    @Transactional
    public int updateContents(Policy policy) {
        return policyMapper.updateContents(policy);
    }

    /**
    * 파일 업로드 정책 수정
    * @param policy
    * @return
    */
    @Transactional
    public int updateFileUpload(Policy policy) {
        return policyMapper.updateFileUpload(policy);
    }
}
