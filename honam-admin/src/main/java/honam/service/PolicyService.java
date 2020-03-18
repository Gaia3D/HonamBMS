package honam.service;

import honam.domain.Policy;

public interface PolicyService {

    /**
    * 운영 정책 조회
    * @return
    */
    Policy getPolicy();

    /**
    * Geoserver 정책 수정
    * @param policy
    * @return
    */
    int updateGeoserver(Policy policy);

    /**
    * Map 정책 수정
    * @param policy
    * @return
    */
    int updateLayer(Policy policy);
    
    /**
    * 보안 정책 수정
    * @param policy
    * @return
    */
    int updateSecurity(Policy policy);

    /**
    * 컨텐츠 정책 수정
    * @param policy
    * @return
    */
    int updateContents(Policy policy);

    /**
    * 파일 업로드 정책 수정
    * @param policy
    * @return
    */
    int updateFileUpload(Policy policy);
}
