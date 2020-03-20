package honam.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import honam.domain.BridgeDroneFile;
import honam.persistence.BridgeDroneFileMapper;
import honam.service.BridgeDroneFileService;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service
public class BridgeDroneFileServiceImpl implements BridgeDroneFileService {

	@Autowired
	private BridgeDroneFileMapper bridgeDroneFileMapper;

	@Override
	public int insertBridgeDroneFile(List<BridgeDroneFile> files) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<BridgeDroneFile> getBridgeDroneFile(BridgeDroneFile file) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateBridgeDroneFiles(List<BridgeDroneFile> files) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateBridgeDroneFile(BridgeDroneFile file) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteBridgeDroneFiles(List<BridgeDroneFile> files) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteBridgeDroneFile(BridgeDroneFile file) {
		// TODO Auto-generated method stub
		return 0;
	}

}
