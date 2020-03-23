package honam.controller.rest;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import honam.domain.Bridge;
import honam.domain.BridgeDroneFile;
import honam.domain.PageType;
import honam.domain.Pagination;
import honam.domain.Sat;
import honam.domain.Sensor;
import honam.domain.SkSdo;
import honam.domain.SkSgg;
import honam.service.BridgeDroneFileService;
import honam.service.BridgeService;
import honam.service.DataService;
import honam.service.SatService;
import honam.service.SensorService;
import honam.utils.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/bridges")
public class BridgeRestController {

	@Autowired
	private BridgeService bridgeService;
	@Autowired
	private DataService dataService;
	@Autowired
	private SatService satService;
	@Autowired
	private SensorService sensorService;
	@Autowired
	private BridgeDroneFileService bridgeDroneFileService;

	private static final long PAGE_ROWS = 10l;
	private static final long PAGE_LIST = 5l;

	/**
	 * 교량 목록 정보
	 * @param
	 * @return
	 */
	@GetMapping
	public Map<String, Object> list(HttpServletRequest request, Bridge bridge, @RequestParam(defaultValue="1") String pageNo) {
		log.info("@@@@@ bridge = {}", bridge);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		long totalCount = bridgeService.getBridgeTotalCount(bridge);
		log.info("@@@@ totalCount = {}", totalCount);
		Pagination pagination = new Pagination(	request.getRequestURI(),
												getSearchParameters(PageType.LIST, request, bridge),
												totalCount,
												Long.valueOf(pageNo).longValue(),
												PAGE_ROWS,
												PAGE_LIST
												);

		bridge.setOffset(pagination.getOffset());
		bridge.setLimit(pagination.getPageRows());

		List<Bridge> bridgeList = new ArrayList<>();
		if(totalCount > 0l) {
			bridgeList = bridgeService.getListBridge(bridge);
		}

		int statusCode = HttpStatus.OK.value();

		result.put("bridgeList", bridgeList);
		result.put("pagination", pagination);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

//	@GetMapping("/bridges")
//	public Map<String, Object> getListbridge(HttpServletRequest request, Bridge bridge, @RequestParam(defaultValue="1") String pageNo) {
//		log.info("@@ bridge = {}", bridge);
//		Map<String, Object> result = new HashMap<>();
//		String errorCode = null;
//		String message = null;
//
//		bridge.setListCounter(10l);
//
//		long bridgeTotalCount = bridgeService.getBridgeTotalCount(bridge);
//		Pagination pagination = new Pagination(	request.getRequestURI(), getSearchParameters(PageType.LIST, request, bridge),
//				bridgeTotalCount,
//				Long.valueOf(pageNo).longValue(),
//				bridge.getListCounter());
//
//		bridge.setOffset(pagination.getOffset());
//		bridge.setLimit(pagination.getPageRows());
//
//		List<Bridge> bridgeList = new ArrayList<>();
//		if(bridgeTotalCount > 0l) {
//			bridgeList = bridgeService.getListBridge(bridge);
//		}
//		int statusCode = HttpStatus.OK.value();
//
//		result.put("bridgeList", bridgeList);
//		result.put("bridgeTotalCount", bridgeTotalCount);
//		// image total count
//		result.put("pagination", pagination);
//
//		result.put("statusCode", statusCode);
//		result.put("errorCode", errorCode);
//		result.put("message", message);
//		return result;
//	}


	@GetMapping("/dronfile/{gid:[0-9]+}")
	public Map<String, Object> getBridgeDronFileList(HttpServletRequest request, @PathVariable Integer gid, @RequestParam(defaultValue="1") String pageNo, String createDate) {
		log.info("@@@@@@@@@@ createDate = {}", createDate);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = null;
		try {
			date = transFormat.parse(createDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		BridgeDroneFile bridgeDronFile = new BridgeDroneFile();
		bridgeDronFile.setOgcFid(gid);

		List<Date> createDateList = bridgeDroneFileService.getBridgeDroneFileCreateDateList(bridgeDronFile);
		List<String> strCreateDateList = new ArrayList<>();
		for(Date cdate : createDateList) {
			String to = transFormat.format(cdate);
			strCreateDateList.add(to);
		}
		result.put("bdfCreateDateList", strCreateDateList);

		bridgeDronFile.setCreateDate(date);

		Long bridgeDroneFileTotalCount = bridgeDroneFileService.getBridgeDroneFileTotalCount(bridgeDronFile);
		StringBuffer bdfBuffer = new StringBuffer(bridgeDronFile.getParameters());
		String stringParameters =  bdfBuffer.toString();
		Pagination pagination = new Pagination(	request.getRequestURI(),
												stringParameters,
												bridgeDroneFileTotalCount,
												Long.valueOf(pageNo).longValue(),
												PAGE_ROWS,
												PAGE_LIST
												);
		bridgeDronFile.setOffset(pagination.getOffset());
		bridgeDronFile.setLimit(pagination.getPageRows());

		List<BridgeDroneFile> bridgeDroneFileList = bridgeDroneFileService.getBridgeDroneFile(bridgeDronFile);

		int statusCode = HttpStatus.OK.value();
		result.put("pagination", pagination);
		result.put("bdfList", bridgeDroneFileList);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);

		return result;
	}

	/**
	 * 교량 조회 by 교량 id
	 * @param request
	 * @param gid
	 * @return
	 */
	@GetMapping("/{gid}")
	public Map<String, Object> getBridge(HttpServletRequest request, @PathVariable Integer gid) {
		log.info("@@@@@@@@@@ bridge id = {}", gid);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		if(gid == null || gid.intValue() <= 0) {
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", "bridge.id.require");
			result.put("message", message);
            return result;
		}

		Bridge bridge = bridgeService.getBridge(gid);
		List<Sensor> sensorList = sensorService.getListSensorID(bridge.getFacNum());

		BridgeDroneFile bridgeDronFile = new BridgeDroneFile();
		bridgeDronFile.setOgcFid(gid);

		List<BridgeDroneFile> bridgeDroneFileList = new ArrayList<>();
		List<BridgeDroneFile> bridgeDroneFileListAll = new ArrayList<>();
		Long bridgeDroneFileTotalCount = 0l;
		List<Date> createDateList = bridgeDroneFileService.getBridgeDroneFileCreateDateList(bridgeDronFile);
		if(createDateList.size() > 0) {
			Date firstCreateDate = createDateList.get(0);
			bridgeDronFile.setCreateDate(firstCreateDate);
			bridgeDroneFileTotalCount = bridgeDroneFileService.getBridgeDroneFileTotalCount(bridgeDronFile);

			log.info("@@@@ totalCount = {}", bridgeDroneFileTotalCount);
			StringBuffer bdfBuffer = new StringBuffer(bridgeDronFile.getParameters());
			String stringParameters =  bdfBuffer.toString();
			Pagination pagination = new Pagination(	request.getRequestURI(),
													stringParameters,
													bridgeDroneFileTotalCount,
													Long.valueOf(1).longValue(),
													PAGE_ROWS,
													PAGE_LIST
													);

			bridgeDronFile.setOffset(pagination.getOffset());
			bridgeDronFile.setLimit(pagination.getPageRows());

			bridgeDroneFileList = bridgeDroneFileService.getBridgeDroneFile(bridgeDronFile);
			bridgeDroneFileListAll = bridgeDroneFileService.getBridgeDroneFileAll(bridgeDronFile);
			result.put("pagination", pagination);
			result.put("bdfList", bridgeDroneFileList);
			result.put("bdfListAll", bridgeDroneFileListAll);

			List<String> strCreateDateList = new ArrayList<>();
			for(Date createDate : createDateList) {
				SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
				String to = transFormat.format(createDate);
				strCreateDateList.add(to);
			}
			result.put("bdfCreateDateList", strCreateDateList);
		}

		int statusCode = HttpStatus.OK.value();
		result.put("bridge", bridge);
		result.put("sensorList", sensorList);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	@GetMapping("/{gid:[0-9]+}/sat/avg")
	public Map<String, Object> getListSatAvg(Bridge bridge, @PathVariable Integer gid) {
		log.info("@@@@ gid = {}", gid);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		long satAvgCount = satService.getSatAvgTotalCount(bridge.getFacNum());
		List<Sat> satAvgList = satService.getListSatAvg(bridge.getFacNum());
		int statusCode = HttpStatus.OK.value();

		result.put("satAvgList", satAvgList);
		result.put("satAvgCount", satAvgCount);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	@GetMapping("/{gid:[0-9]+}/sat/value")
	public Map<String, Object> getListSatValue(Sat sat, @PathVariable Integer gid) {
		log.info("@@@@ gid = {}", gid);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		List<Sat> satValueList = satService.getListSatValueByLonLat(sat);
		int statusCode = HttpStatus.OK.value();

		result.put("satValueList", satValueList);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	@GetMapping("/{gid:[0-9]+}/sensor")
	public Map<String, Object> getListSensorId(Bridge bridge, @PathVariable Integer gid) {
		log.info("@@@@ gid = {}", gid);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		long sensorIDCount = sensorService.getSensorIDTotalCount(bridge.getFacNum());
		List<Sensor> sensorIDList = sensorService.getListSensorID(bridge.getFacNum());

		int statusCode = HttpStatus.OK.value();

		result.put("sensorIDList", sensorIDList);
		result.put("sensorIDCount", sensorIDCount);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	@GetMapping("/{gid:[0-9]+}/sensor/{sensorType}")
	public Map<String, Object> getListSensorIdBysensorType(HttpServletRequest request, Sensor sensor, @PathVariable Integer gid, @PathVariable String sensorType) {
		log.info("@@@@ gid = {}", gid);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		sensor.setSensorType(sensorType);
		log.info("@@@@ Sensor = {}", sensor);

		List<Sensor> sensorIDList = sensorService.getListSensorIDBySensorType(sensor);
		int statusCode = HttpStatus.OK.value();

		result.put("sensorIDList", sensorIDList);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	@GetMapping("/sensor/{sensorid}")
	public Map<String, Object> getListSensorData(HttpServletRequest request, @PathVariable String sensorid) {

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		// 데이터에서 최근 10일의 날짜를 가져옴
		List<Sensor> sensorTimeList = new ArrayList<>();
		List<Sensor> sensorDataList = new ArrayList<>();
		sensorTimeList = sensorService.getListSensorTime(sensorid);
		if(sensorTimeList.size() > 0) {
			sensorDataList = sensorService.getListSensorData(sensorTimeList.get(0));
		}
		int statusCode = HttpStatus.OK.value();

		result.put("sensorDataList", sensorDataList);
		result.put("sensorTimeList", sensorTimeList);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 시도 목록
	 * @return
	 */
	@GetMapping("/sdos")
	public Map<String, Object> getListSdo() {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		List<SkSdo> sdoList = bridgeService.getListSdoExceptGeom();
		int statusCode = HttpStatus.OK.value();

		result.put("sdoList", sdoList);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 시군구 목록
	 * @param sdoCode
	 * @return
	 */
	@GetMapping("/sdos/{sdoCode:[0-9]+}/sggs")
	public Map<String, Object> getListSggBySdo(@PathVariable String sdoCode) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		// TODO 여기 들어 오지 않음. PathVariable 은 불칠전해서 이렇게 하고 싶음
		if(sdoCode == null || "".equals(sdoCode)) {
			log.info("@@@@@ message = {}", "sdo.code.invalid");
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", "sdo.code.invalid");
			result.put("message", message);
            return result;
		}

		List<SkSgg> sggList = bridgeService.getListSggBySdoExceptGeom(sdoCode);
		int statusCode = HttpStatus.OK.value();

		result.put("sggList", sggList);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 선택 한 주소별(시도, 시군구)의 center point를 구함
	 * @param skSgg
	 * @return
	 */
//	@GetMapping("/centroids")
//	public Map<String, Object> getCentroid(SkSgg skSgg) {
//		log.info("@@@@ SkSgg = {}", skSgg);
//
//		Map<String, Object> result = new HashMap<>();
//		String errorCode = null;
//		String message = null;
//
//		// TODO 여기 들어 오지 않음. PathVariable 은 불칠전해서 이렇게 하고 싶음
//		String centerPoint = null;
//		if(skSgg.getLayer_type() == 1) {
//			// 시도
//			SkSdo skSdo = new SkSdo();
//			skSdo.setName(skSgg.getName());
//			skSdo.setBjcd(skSgg.getBjcd());
//			centerPoint = bridgeService.getCentroidSdo(skSdo);
//			log.info("@@@@ sdo center point {}", centerPoint);
//		} else if(skSgg.getLayer_type() == 2) {
//			// 시군구
//			centerPoint = bridgeService.getCentroidSgg(skSgg);
//			log.info("@@@@ sgg center point {}", centerPoint);
//		}
//
//		String[] location = centerPoint.substring(centerPoint.indexOf("(") + 1, centerPoint.indexOf(")")).split(" ");
//		int statusCode = HttpStatus.OK.value();
//
//		result.put("longitude", location[0]);
//		result.put("latitude", location[1]);
//		result.put("statusCode", statusCode);
//		result.put("errorCode", errorCode);
//		result.put("message", message);
//		return result;
//	}

	/**
	 * 선택된 교량의 center point를 구함
	 * @param gid
	 * @return
	 */
	@GetMapping("/centroids")
	public Map<String, Object> getCentroidBridge() {

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		List<Bridge> bridgeList =  bridgeService.getListCentroidBridge();
		int statusCode = HttpStatus.OK.value();

		result.put("bridgeList", bridgeList);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 관리 주체 목록
	 * @return
	 */
	@GetMapping("/manage")
	public Map<String, Object> getListMngOrg() {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		List<Bridge> bridgeList = bridgeService.getListMngOrg();
		int statusCode = HttpStatus.OK.value();

		result.put("bridgeList", bridgeList);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 검색 조건
	 * @param bridge
	 * @return
	 */
	private String getSearchParameters(PageType pageType, HttpServletRequest request, Bridge bridge) {
		StringBuffer buffer = new StringBuffer(bridge.getParameters());
		boolean isListPage = true;
		if(pageType.equals(PageType.MODIFY) || pageType.equals(PageType.DETAIL)) {
			isListPage = false;
		}

		buffer.append("&");
		buffer.append("sdoCode=" + StringUtil.getDefaultValue(isListPage ? bridge.getSdoCode() : request.getParameter("sdoCode")));
		buffer.append("&");
		buffer.append("sggCode=" + StringUtil.getDefaultValue(isListPage ? bridge.getSggCode() : request.getParameter("sggCode")));
		buffer.append("&");
		buffer.append("mngOrg=" + StringUtil.getDefaultValue(isListPage ? bridge.getMngOrg() : request.getParameter("mngOrg")));
		return buffer.toString();
	}
}
