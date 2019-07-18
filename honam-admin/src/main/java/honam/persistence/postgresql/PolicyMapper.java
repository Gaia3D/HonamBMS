package honam.persistence.postgresql;

import org.springframework.stereotype.Repository;

import honam.domain.Policy;

@Repository
public interface PolicyMapper {

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
    * LayerMap 정책 수정
    * @param policy
    * @return
    */
    int updateLayer(Policy policy);
    
    /**
     * 이동체 정책 수정
     * @param policy
     * @return
     */
     int updateVehicle(Policy policy);

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

    /**
    * 블록 관리 정책 수정
    * @param policy
    * @return
    */
    int updateBlockManage(Policy policy);

}
