// 관리주체 목록 로딩
function loadManageOrg() {
	var defaultMngOrg = '<option value> </option>';
	var url = "./manage";
	$.ajax({
	    url: url,
	    type: "GET",
	    dataType: "json",
	    success : function(msg) {
	        if(msg.result === "success") {
	            var bridgeList = msg.bridgeList;
	            var content = "";
	            
	            content += defaultMngOrg;
	            for(var i=0, len=bridgeList.length; i < len; i++)                    
	            {
	                var bridge = bridgeList[i];
	                content += '<option value=' + bridge.mng_org + '>' + bridge.mng_org + '</option>';
	            }
	            
	            $('#mng_org').html(content);
	        }
	    },
	    error : function(request, status, error) {
	        console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
	    }
	});
}

// 해당 교량으로 이동
function getCentroidBridge(viewer, gid, name, grade, facNum) {
	var url = "./" + gid + "/centroid"; 
	var cnt = null;
	var sensorID;
	
	// 해당 교량에 해당되는 영역을 폴리곤으로 표시
  	var now = new Date();
    var rand = ( now - now % 5000) / 5000;
  	var queryString = "brg_nam = '" + name + "'";
    var provider = new Cesium.WebMapServiceImageryProvider({
        url : "http://localhost:8080/geoserver/honambms/wms",
        layers : 'honambms:bridge',
        parameters : {
            service : 'WMS'
            ,version : '1.1.1'
            ,request : 'GetMap'
            ,transparent : 'true'
            ,format : 'image/png'
            ,time : 'P2Y/PRESENT'
            ,rand:rand
            ,maxZoom : 25
            ,maxNativeZoom : 23
            ,CQL_FILTER: queryString
        },
        enablePickFeatures : false
    });
    
    viewer.imageryLayers.addImageryProvider(provider);	
	
	//해당 교량으로 이동
	$.ajax({
	    url: url,
	    type: "GET",
	    dataType: "json",
	    success : function(msg) {
	        if(msg.result === "success") {
	      	  cameraFlyTo(msg.longitude,  msg.latitude, 500, 3);
	        }
	    },
	    error : function(request, status, error) {
	        //alert(JS_MESSAGE["ajax.error.message"]);
	        console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
	    }
	});
	
	getListSatAvg(viewer, gid, facNum);
	getListSensorID(viewer, gid, facNum);
}