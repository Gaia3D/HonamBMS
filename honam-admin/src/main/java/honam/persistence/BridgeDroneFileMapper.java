package honam.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import honam.domain.BridgeDroneFile;

@Repository
public interface BridgeDroneFileMapper {

	public int insertBridgeDroneFile(BridgeDroneFile file);

	public Long getBridgeDroneFileTotalCount();
	public List<BridgeDroneFile> getBridgeDroneFile(BridgeDroneFile file);

	public int updateBridgeDroneFile(BridgeDroneFile file);

	public int deleteBridgeDroneFile(BridgeDroneFile file);

}
