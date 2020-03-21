package honam.persistence;

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
     * 운영 정책 수정 
     * @param policy
     * @return
     */
    int updatePolicy(Policy policy);
}
