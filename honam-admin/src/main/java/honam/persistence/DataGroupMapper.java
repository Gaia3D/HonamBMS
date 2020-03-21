package honam.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import honam.domain.DataGroup;

@Repository
public interface DataGroupMapper {
	
	/**
     * 사용자 데이터 그룹 전체 목록
     * @param dataGroup
     * @return
     */
    List<DataGroup> getAllListDataGroup(DataGroup dataGroup);
}
