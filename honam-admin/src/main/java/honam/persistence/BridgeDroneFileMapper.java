package honam.persistence;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Repository;

import honam.domain.BridgeDroneFile;

@Repository
public interface BridgeDroneFileMapper {

	public int insertBridgeDroneFile(BridgeDroneFile file);

	public Long getBridgeDroneFileTotalCount(BridgeDroneFile file);
	public List<BridgeDroneFile> getBridgeDroneFile(BridgeDroneFile file);
	public List<BridgeDroneFile> getBridgeDroneFileAll(BridgeDroneFile file);
	public List<Date> getBridgeDroneFileCreateDateList(BridgeDroneFile file);

	public int updateBridgeDroneFile(BridgeDroneFile file);

	public int deleteBridgeDroneFile(BridgeDroneFile file);

}
