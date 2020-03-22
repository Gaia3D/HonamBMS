package honam.service;

import java.util.Date;
import java.util.List;

import honam.domain.BridgeDroneFile;

public interface BridgeDroneFileService {

	public int insertBridgeDroneFile(List<BridgeDroneFile> files);

	public Long getBridgeDroneFileTotalCount(BridgeDroneFile file);
	public List<BridgeDroneFile> getBridgeDroneFile(BridgeDroneFile file);
	public List<BridgeDroneFile> getBridgeDroneFileAll(BridgeDroneFile file);
	public List<Date> getBridgeDroneFileCreateDateList(BridgeDroneFile file);

	public int updateBridgeDroneFiles(List<BridgeDroneFile> files);
	public int updateBridgeDroneFile(BridgeDroneFile file);

	public int deleteBridgeDroneFiles(List<BridgeDroneFile> files);
	public int deleteBridgeDroneFile(BridgeDroneFile file);

}
