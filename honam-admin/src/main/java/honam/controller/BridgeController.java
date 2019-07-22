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

	
	@RequestMapping(value = "list-bridge")
	public String listBridge(HttpServletRequest request, Bridge bridge, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		log.info("@@ bridge = {}", bridge);
		
		String cesiumIonToken = propertiesConfig.getCesiumIonToken();
		
		model.addAttribute("cesoumIonToken", cesiumIonToken);
		log.info("@@ cesoumIonToken = {}", cesiumIonToken);
		
		return "/bridge/list-bridge";
	}

}
