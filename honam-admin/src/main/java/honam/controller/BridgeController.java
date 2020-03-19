package honam.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import honam.config.PropertiesConfig;
import honam.domain.Bridge;
import honam.domain.PageType;
import honam.domain.Pagination;
import honam.domain.Sat;
import honam.domain.Sensor;
import honam.domain.SkSdo;
import honam.domain.SkSgg;
import honam.service.BridgeService;
import honam.service.PolicyService;
import honam.service.SatService;
import honam.service.SensorService;
import honam.utils.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/bridge")
@Controller
public class BridgeController {

	@Autowired
	private BridgeService bridgeService;
	@Autowired
	private PropertiesConfig propertiesConfig;
	@Autowired
	private PolicyService policyService;
	@Autowired
	private SatService satService;
	@Autowired
	private SensorService sensorService;

	/**
	 * 시도 목록
	 * @return
	 */
	@GetMapping("/sdos")
	@ResponseBody
	public Map<String, Object> getListSdo() {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			List<SkSdo> sdoList = bridgeService.getListSdoExceptGeom();
			map.put("sdoList", sdoList);
		} catch (Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}

		map.put("result", result);
		log.info("@@@@ sdoList = {}", map.toString());
		return map;
	}

	/**
	 * 시군구 목록
	 * @param sdoCode
	 * @return
	 */
	@GetMapping("/sdos/{sdoCode:[0-9]+}/sggs")
	@ResponseBody
	public Map<String, Object> getListSggBySdo(@PathVariable String sdoCode) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			// TODO 여기 들어 오지 않음. PathVariable 은 불칠전해서 이렇게 하고 싶음
			if(sdoCode == null || "".equals(sdoCode)) {
				map.put("result", "sdo.code.invalid");
				log.info("validate error 발생: {} ", map.toString());
				return map;
			}

			List<SkSgg> sggList = bridgeService.getListSggBySdoExceptGeom(sdoCode);
			map.put("sggList", sggList);
		} catch (Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}

		map.put("result", result);
		log.info("@@@@ sggList = {}", map.toString());
		return map;
	}

	/**
	 * 선택 한 주소별(시도, 시군구)의 center point를 구함
	 * @param skSgg
	 * @return
	 */
	@GetMapping("/centroids")
	@ResponseBody
	public Map<String, Object> getCentroid(SkSgg skSgg) {
		log.info("@@@@ SkSgg = {}", skSgg);

		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			// TODO 여기 들어 오지 않음. PathVariable 은 불칠전해서 이렇게 하고 싶음
			String centerPoint = null;
			if(skSgg.getLayer_type() == 1) {
				// 시도
				SkSdo skSdo = new SkSdo();
				skSdo.setName(skSgg.getName());
				skSdo.setBjcd(skSgg.getBjcd());
				centerPoint = bridgeService.getCentroidSdo(skSdo);
				log.info("@@@@ sdo center point {}", centerPoint);
			} else if(skSgg.getLayer_type() == 2) {
				// 시군구
				centerPoint = bridgeService.getCentroidSgg(skSgg);
				log.info("@@@@ sgg center point {}", centerPoint);
			}

			String[] location = centerPoint.substring(centerPoint.indexOf("(") + 1, centerPoint.indexOf(")")).split(" ");
			map.put("longitude", location[0]);
			map.put("latitude", location[1]);
		} catch (Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}

		map.put("result", result);
		return map;
	}

	/**
	 * 선택된 교량의 center point를 구함
	 * @param gid
	 * @return
	 */
	@GetMapping("/{gid:[0-9]+}/centroid")
	@ResponseBody
	public Map<String, Object> getCentroidBridge(@PathVariable Integer gid) {
		log.info("@@@@ gid = {}", gid);

		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			String centerPoint =  bridgeService.getCentroidBridge(gid);

			String[] location = centerPoint.substring(centerPoint.indexOf("(") + 1, centerPoint.indexOf(")")).split(" ");
			map.put("longitude", location[0]);
			map.put("latitude", location[1]);
		} catch (Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}

		map.put("result", result);
		return map;
	}

	/**
	 * 관리 주체 목록
	 * @return
	 */
	@GetMapping("/manage")
	@ResponseBody
	public Map<String, Object> getListMngOrg() {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {

			List<Bridge> bridgeList = bridgeService.getListMngOrg();
			map.put("bridgeList", bridgeList);
		} catch (Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}

		map.put("result", result);
		log.info("@@@@ bridgeList = {}", map.toString());
		return map;
	}

	/**
	 * 교량 목록
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/list-bridge")
	public String listBridge(HttpServletRequest request, Model model) {
		String cesiumIonToken = propertiesConfig.getCesiumIonToken();

		model.addAttribute("policy", policyService.getPolicy());
		model.addAttribute("bridge", new Bridge());
		model.addAttribute("cesiumIonToken", cesiumIonToken);

		return "/bridge/list-bridge";
	}

	@GetMapping("/bridges")
	@ResponseBody
	public Map<String, Object> getListbridge(HttpServletRequest request, Bridge bridge, @RequestParam(defaultValue="1") String pageNo) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";

		log.info("@@ bridge = {}", bridge);
		bridge.setListCounter(10l);

		long bridgeTotalCount = bridgeService.getBridgeTotalCount(bridge);
		Pagination pagination = new Pagination(	request.getRequestURI(), getSearchParameters(PageType.LIST, request, bridge),
				bridgeTotalCount,
				Long.valueOf(pageNo).longValue(),
				bridge.getListCounter());
		map.put("pagination", pagination);

		bridge.setOffset(pagination.getOffset());
		bridge.setLimit(pagination.getPageRows());

		try {
			List<Bridge> bridgeList = new ArrayList<>();
			if(bridgeTotalCount > 0l) {
				bridgeList = bridgeService.getListBridge(bridge);
			}
			map.put("bridgeList", bridgeList);
			map.put("bridgeTotalCount", bridgeTotalCount);
			// image total count
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}

		map.put("result", result);
		return map;
	}

	@RequestMapping(value = "/detail-bridge")
	public String detailBridge(HttpServletRequest request, @RequestParam(value="gid", required = true) Integer gid, Model model) {
		log.info("@@ bridge_id = {}", gid);

		Bridge bridge = bridgeService.getBridge(gid);
		log.info("############### Bridge = {}", bridge);

		String cesiumIonToken = propertiesConfig.getCesiumIonToken();

		model.addAttribute("policy", policyService.getPolicy());
		model.addAttribute("bridge", bridge);
		model.addAttribute("searchParameters", getSearchParameters(PageType.DETAIL, request, bridge));
		model.addAttribute("cesiumIonToken", cesiumIonToken);
		return "/bridge/detail-bridge";
	}

	/**
	 * 교량 조회 by 교량 id
	 * @param request
	 * @param gid
	 * @return
	 */
	@GetMapping("/{gid}")
	@ResponseBody
	public Map<String, Object> getBridge(HttpServletRequest request, @PathVariable Integer gid) {
		log.info("@@@@@@@@@@ bridge id = {}", gid);

		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			if(gid == null || gid.intValue() <= 0) {
				result = "bridge.id.require";
				map.put("result", result);
				return map;
			}

			Bridge bridge = bridgeService.getBridge(gid);
			map.put("bridge", bridge);

		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}

		map.put("result", result);
		return map;
	}

	@GetMapping("/{gid:[0-9]+}/sat/avg")
	@ResponseBody
	public Map<String, Object> getListSatAvg(Bridge bridge, @PathVariable Integer gid) {
		log.info("@@@@ gid = {}", gid);

		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			long satAvgCount = satService.getSatAvgTotalCount(bridge.getFacNum());
			List<Sat> satAvgList = satService.getListSatAvg(bridge.getFacNum());
			map.put("satAvgList", satAvgList);
			map.put("satAvgCount", satAvgCount);
		} catch (Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}

		map.put("result", result);
		return map;
	}

	@GetMapping("/{gid:[0-9]+}/sat/value")
	@ResponseBody
	public Map<String, Object> getListSatValue(Sat sat, @PathVariable Integer gid) {
		log.info("@@@@ gid = {}", gid);

		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			List<Sat> satValueList = satService.getListSatValueByLonLat(sat);
			map.put("satValueList", satValueList);
		} catch (Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}

		map.put("result", result);
		return map;
	}

	@GetMapping("/{gid:[0-9]+}/sensor")
	@ResponseBody
	public Map<String, Object> getListSensorId(Bridge bridge, @PathVariable Integer gid) {
		log.info("@@@@ gid = {}", gid);

		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			long sensorIDCount = sensorService.getSensorIDTotalCount(bridge.getFacNum());
			List<Sensor> sensorIDList = sensorService.getListSensorID(bridge.getFacNum());
			map.put("sensorIDList", sensorIDList);
			map.put("sensorIDCount", sensorIDCount);
		} catch (Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}

		map.put("result", result);
		return map;
	}

	@GetMapping("/{gid:[0-9]+}/sensor/{sensorType}")
	@ResponseBody
	public Map<String, Object> getListSensorIdBysensorType(HttpServletRequest request, Sensor sensor, @PathVariable Integer gid, @PathVariable String sensorType) {
		log.info("@@@@ gid = {}", gid);

		sensor.setSensorType(sensorType);
		log.info("@@@@ Sensor = {}", sensor);

		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			List<Sensor> sensorIDList = sensorService.getListSensorIDBySensorType(sensor);
			map.put("sensorIDList", sensorIDList);
		} catch (Exception e) {
			e.printStackTrace();
			result = "db.excepiton";
		}

		map.put("result", result);
		return map;
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
