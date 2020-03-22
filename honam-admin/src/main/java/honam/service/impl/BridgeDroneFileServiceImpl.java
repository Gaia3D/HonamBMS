package honam.service.impl;

import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import honam.config.PropertiesConfig;
import honam.domain.BridgeDroneFile;
import honam.persistence.BridgeDroneFileMapper;
import honam.service.BridgeDroneFileService;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service
public class BridgeDroneFileServiceImpl implements BridgeDroneFileService {

	@Autowired
	private BridgeDroneFileMapper bridgeDroneFileMapper;

	@Autowired
	private PropertiesConfig propertiesConfig;

	@Override
	public int insertBridgeDroneFile(List<BridgeDroneFile> files) {
		int result = 0;
		for (BridgeDroneFile file : files) {
			result += bridgeDroneFileMapper.insertBridgeDroneFile(file);
		}
		return result;
	}

	@Override
	public Long getBridgeDroneFileTotalCount(BridgeDroneFile file) {
		return bridgeDroneFileMapper.getBridgeDroneFileTotalCount(file);
	}

	private List<BridgeDroneFile> replacePath(List<BridgeDroneFile> fileList) {
		for (BridgeDroneFile droneFile : fileList) {
			String filePath = droneFile.getFilePath().replace(propertiesConfig.getUploadDir(), "");
			filePath = filePath.replaceAll(Matcher.quoteReplacement(File.separator), "/");
			droneFile.setFilePath(filePath);
		}
		return fileList;
	}

	@Override
	public List<BridgeDroneFile> getBridgeDroneFile(BridgeDroneFile file) {
		List<BridgeDroneFile> fileList = bridgeDroneFileMapper.getBridgeDroneFile(file);
		return replacePath(fileList);
	}

	@Override
	public List<BridgeDroneFile> getBridgeDroneFileAll(BridgeDroneFile file) {
		List<BridgeDroneFile> fileList = bridgeDroneFileMapper.getBridgeDroneFileAll(file);
		return replacePath(fileList);
	}

	@Override
	public List<Date> getBridgeDroneFileCreateDateList(BridgeDroneFile file) {
		return bridgeDroneFileMapper.getBridgeDroneFileCreateDateList(file);
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
