package honam.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import honam.domain.DataInfo;

/**
 * Data
 * @author jeongdae
 *
 */
@Repository
public interface DataMapper {
	
	/**
	 * 데이터 그룹에 속하는 전체 데이터 목록
	 * @param dataInfo
	 * @return
	 */
	List<DataInfo> getAllListData(DataInfo dataInfo);

	/**
	 * Data 정보 취득
	 * @param dataInfo
	 * @return
	 */
	DataInfo getData(DataInfo dataInfo);
	
	/**
	 * Data 정보 취득
	 * @param dataInfo
	 * @return
	 */
	DataInfo getDataByDataKey(DataInfo dataInfo);
}
