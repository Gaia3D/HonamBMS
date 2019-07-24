package honam.controller;

import java.net.URLEncoder;
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

import honam.service.BridgeService;
import honam.config.PropertiesConfig;

import honam.domain.Bridge;
import honam.domain.CacheManager;
import honam.domain.PageType;
import honam.domain.Pagination;
import honam.util.DateUtil;
import honam.util.StringUtil;
import honam.domain.SkSdo;
import honam.domain.SkSgg;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/bridge/")
@Controller
public class BridgeController {
	
	@Autowired
	private PropertiesConfig propertiesConfig;
	@Autowired
	private BridgeService bridgeService;
	
	/**
	 * 시도 목록
	 * @return
	 */
	@GetMapping("sdos")
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
	 * @param sdo_code
	 * @return
	 */
	@GetMapping("sdos/{sdo_code:[0-9]+}/sggs")
	@ResponseBody
	public Map<String, Object> getListSggBySdo(@PathVariable String sdo_code) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			// TODO 여기 들어 오지 않음. PathVariable 은 불칠전해서 이렇게 하고 싶음
			if(sdo_code == null || "".equals(sdo_code)) {
				map.put("result", "sdo.code.invalid");
				log.info("validate error 발생: {} ", map.toString());
				return map;
			}
			
			List<SkSgg> sggList = bridgeService.getListSggBySdoExceptGeom(sdo_code);
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
	 * 선택 한 위치의 center point를 구함
	 * @param skEmd
	 * @return
	 */
	@GetMapping("centroids")
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

	@RequestMapping(value = "list-bridge")
	public String listBridge(HttpServletRequest request, Bridge bridge, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		log.info("@@ bridge = {}", bridge);
		
		String cesiumIonToken = propertiesConfig.getCesiumIonToken();
		
		model.addAttribute("cesoumIonToken", cesiumIonToken);
		
		return "/bridge/list-bridge";
	}
	
	/**
	 * 검색 조건
	 * @param bridge
	 * @return
	 */
//	private String getSearchParameters(PageType pageType, HttpServletRequest request, Bridge bridge) {
//		StringBuffer buffer = new StringBuffer();
//		boolean isListPage = true;
//		if(pageType.equals(PageType.MODIFY) || pageType.equals(PageType.DETAIL)) {
//			isListPage = false;
//		}
//		
//		if(!isListPage) {
//			buffer.append("pageNo=" + request.getParameter("pageNo"));
//		}
//		buffer.append("&");
//		buffer.append("searchWord=" + StringUtil.getDefaultValue(isListPage ? bridge.getSearchWord() : request.getParameter("searchWord")));
//		buffer.append("&");
//		buffer.append("searchOption=" + StringUtil.getDefaultValue(isListPage ? bridge.getSearchOption() : request.getParameter("searchOption")));
//		buffer.append("&");
//		try {
//			buffer.append("searchValue=" + URLEncoder.encode(StringUtil.getDefaultValue(
//					isListPage ? bridge.getSearchValue() : request.getParameter("searchBalue")), "UTF-8"));
//		} catch(Exception e) {
//			e.printStackTrace();
//			buffer.append("searchValue=");
//		}
//		buffer.append("&");
//		buffer.append("status=" + StringUtil.getDefaultValue(isListPage ? droneProject.getStatus() : request.getParameter("status")));
//		buffer.append("&");
//		buffer.append("&");
//		buffer.append("order_word=" + StringUtil.getDefaultValue(isListPage ? droneProject.getOrder_word() : request.getParameter("order_word")));
//		buffer.append("&");
//		buffer.append("order_value=" + StringUtil.getDefaultValue(isListPage ? droneProject.getOrder_value() : request.getParameter("order_value")));
//		buffer.append("&");
//		buffer.append("list_counter=" + (isListPage ? bridge.getListCounter() : StringUtil.getDefaultValue(request.getParameter("listCount"))));
//		return buffer.toString();
//	}

}
