package honam.controller.rest;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import honam.config.PropertiesConfig;
import honam.domain.Bridge;
import honam.domain.BridgeDroneFile;
import honam.domain.UserSession;
import honam.service.BridgeService;
import honam.utils.DateUtils;
import honam.utils.FileUtils;
import honam.utils.FormatUtils;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/bridges")
@RestController
public class BridgeManageRestController {

	// 파일 copy 시 버퍼 사이즈
	public static final int BUFFER_SIZE = 8192;

	@Autowired
	private BridgeService bridgeService;

	@Autowired
	private PropertiesConfig propertiesConfig;

	/**
	 * 교량 등록
	 * @param model
	 * @return
	 */
	@PostMapping(value = "/input-bridge")
	public Map<String, Object> inputBridge(HttpServletRequest request, Model model, Bridge bridge, @RequestParam("files") MultipartFile[] files) {
		log.info("@@@@@@@ bridge = {}", bridge.toString());
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		UserSession userSession = (UserSession)request.getSession().getAttribute("USER_SESSION");
		String userId = userSession.getUserId();
		log.info("@@@@@@@ userId = {}", userId);

		// 파일 업로드
		String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY_TIME14);
		String makedDirectory = FileUtils.makeDirectory(userId, propertiesConfig.getUploadDir());
		log.info("@@@@@@@ makedDirectory = {}", makedDirectory);

		String tempDirectory = userId + "_" + System.nanoTime();
		FileUtils.makeDirectory(makedDirectory + tempDirectory);

		List<BridgeDroneFile> bridgeDroneFileList = new ArrayList<>();

		for (MultipartFile multipartFile : files) {
			log.info("@@@@@@@@@@@@@@@ name = {}, originalName = {}", multipartFile.getName(), multipartFile.getOriginalFilename());

			BridgeDroneFile bridgeDroneFile = new BridgeDroneFile();
			bridgeDroneFile.setUserId(userId);

			// TODO 파일 기본 validation 체크
			errorCode = null;
			if(!StringUtils.isEmpty(errorCode)) {
				log.info("@@@@@@@@@@@@ errorCode = {}", errorCode);
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", errorCode);
				result.put("message", message);
	            return result;
			}

			String originalName = multipartFile.getOriginalFilename();
			String[] divideFileName = originalName.split("\\.");
			String saveFileName = originalName;

			// TODO 확장자 이미지 파일만
			String extension = divideFileName[divideFileName.length - 1];
			saveFileName = userId + "_" + today + "_" + System.nanoTime() + "." + extension;

			long size = 0L;
			try (	InputStream inputStream = multipartFile.getInputStream();
					OutputStream outputStream = new FileOutputStream(makedDirectory + tempDirectory + File.separator + saveFileName)) {

				int bytesRead = 0;
				byte[] buffer = new byte[BUFFER_SIZE];
				while ((bytesRead = inputStream.read(buffer, 0, BUFFER_SIZE)) != -1) {
					size += bytesRead;
					outputStream.write(buffer, 0, bytesRead);
				}

				bridgeDroneFile.setFileExt(extension);
				bridgeDroneFile.setFileName(multipartFile.getOriginalFilename());
				bridgeDroneFile.setFileRealName(saveFileName);
				bridgeDroneFile.setFilePath(makedDirectory + tempDirectory + File.separator);
				bridgeDroneFile.setFileSubPath(tempDirectory);
				bridgeDroneFile.setFileSize(String.valueOf(size));

			} catch(IOException e) {
				log.info("@@@@@@@@@@@@ io exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
				result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
				result.put("errorCode", "io.exception");
				result.put("message", message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
	            return result;
			} catch(Exception e) {
				log.info("@@@@@@@@@@@@ file copy exception.");
				result.put("statusCode", HttpStatus.INTERNAL_SERVER_ERROR.value());
				result.put("errorCode", "file.copy.exception");
				result.put("message", message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
	            return result;
			}

			bridgeDroneFileList.add(bridgeDroneFile);

		}

		// DB insert
		bridgeService.insertBridge(bridge, bridgeDroneFileList);

		int statusCode = HttpStatus.OK.value();
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	@DeleteMapping(value = "/{gid:[0-9]+}")
	public Map<String, Object> deleteBridge(HttpServletRequest request, @PathVariable Integer gid) {
		log.info("@@@@@@@ gid = {}", gid);
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		// TODO 관련 레이어 삭제 필요


		int statusCode = HttpStatus.OK.value();
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

}
