// 대메뉴 css 적용
// 이건 다음에 하자...... 지금 구조로는 쉽지 않음
function initMenu(id) {
	$(id).siblings().removeClass('on');
	$(id).addClass("on");
}

//url 페이지로 이동
function goPage(url, _this) {

	if ($(_this).hasClass('on')) {
		return;
	} else {
		$(_this).siblings().removeClass('on');
	}

	if (url === '/bridge/list-bridge' || url === '/bridge/bridge-groups') {
		if ($("#bridgeContent").is(':visible') || $("#bridgeGroupContent").is(':visible')) {
			if ($("#bridgeContent").is(':visible')) {
				$("#bridgeContent").hide();
				$("#bridgeGroupContent").show();
				initMenu("#bridgegroupMenu");
				initBridgeGroupLayer();
			} else {
				$("#bridgeGroupContent").hide();
				$("#bridgeContent").show();
				initMenu("#bridgeMenu");
			}
		} else {
			location.href = url;
		}
	} else {
		location.href = url;
	}

	/*
	if(url === location.pathname) {
		if (url === '/bridge/list-bridge') {
			var currentUrl = location.href;
			if(currentUrl.indexOf(url) >= 0) {
				// 자기 페이지에서 자기 메뉴를 누름
				if($("#leftMenuArea").css("display") == "none") {
					$("#leftMenuArea").show();
					$(".mapWrap").css({"padding-left" : "391px"});
				} else {
					$("#leftMenuArea").hide();
					$(".mapWrap").css({"padding-left" : "50px"});
				}
				return;
			} else {
				return;
			}
		} else {
			return;
		}

	} else {
		if(url === "/bridge-groups") {
			if ($("#bridgeContent").is(':visible')) {
				$("#bridgeContent").hide();
				$("#bridgeGroupContent").show();
			} else {
				location.href = '/bridge/list-bridge';
				$("#bridgeContent").hide();
				$("#bridgeGroupContent").show();
			}
			//initBridgeGroupLayer();
		}
	}
	*/
}

// 닫기 버튼 클릭
$( "#menuCloseButton" ).on( "click", function() {
	if($("#leftMenuArea").css("display") == "none") {
		$("#leftMenuArea").show();
		$(".mapWrap").css({"padding-left" : "391px"});
	} else {
		$("#leftMenuArea").hide();
		$(".mapWrap").css({"padding-left" : "50px"});
	}
});
