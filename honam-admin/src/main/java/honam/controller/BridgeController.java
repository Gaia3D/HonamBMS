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
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/bridge/")
@Controller
public class BridgeController {
	
	@Autowired
	private PropertiesConfig propertiesConfig;
	@Autowired
	private BridgeService bridgeService;
	@Autowired
	private BridgeService bridgeAttributeService;
	
	@RequestMapping(value = "list-bridge")
	public String listBridge(HttpServletRequest request, Bridge bridge, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		log.info("@@ bridge = {}", bridge);
		
		String cesiumIonToken = propertiesConfig.getCesiumIonToken();
		
		model.addAttribute("cesiumIonToken", cesiumIonToken);
		return "/bridge/list-bridge";
	}
	
	/**
	 * 검색 조건
	 * @param brdige
	 * @return
	 */
	private String getSearchParameters(PageType pageType, HttpServletRequest request, Bridge bridge) {
		StringBuffer buffer = new StringBuffer();
		boolean isListPage = true;
		if(pageType.equals(PageType.MODIFY) || pageType.equals(PageType.DETAIL)) {
			isListPage = false;
		}
		
		if(!isListPage) {
			buffer.append("pageNo=" + request.getParameter("pageNo"));
		}
		buffer.append("&");
		buffer.append("searchWord=" + StringUtil.getDefaultValue(isListPage ? bridge.getSearchWord() : request.getParameter("searchWord")));
		buffer.append("&");
		buffer.append("searchOption=" + StringUtil.getDefaultValue(isListPage ? bridge.getSearchOption() : request.getParameter("searchOption")));
		buffer.append("&");
		try {
			buffer.append("searchValue=" + URLEncoder.encode(StringUtil.getDefaultValue(
					isListPage ? bridge.getSearchValue() : request.getParameter("searchValue")), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			buffer.append("searchValue=");
		}
		buffer.append("&");
		buffer.append("listCounter=" + (isListPage ? bridge.getListCounter() : StringUtil.getDefaultValue(request.getParameter("listCount"))));
		return buffer.toString();
	}


}
