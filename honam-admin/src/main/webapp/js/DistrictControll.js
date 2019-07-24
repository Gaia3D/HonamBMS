var district = null;
var DISTRICT_PROVIDER = null;
function DistrictControll(viewer, option)
{
    district = new District(viewer);
}

function District(viewer)
{
    this.drawDistrict = function (name, sdo_code, sgg_code) {
	    var now = new Date();
	    var rand = ( now - now % 5000) / 5000;
	
	    this.deleteDistrict();
	    
	    // 시도(2) + 시군구(3) + 읍면동(3) + 리(2)
	    var queryString = "bjcd = " + sdo_code.toString().padStart(2, '0') + sgg_code.toString().padStart(3, '0') + '00000';
	 
	    var provider = new Cesium.WebMapServiceImageryProvider({
	        url : "http://localhost:8080/geoserver/honambms/wms",
	        layers : 'honambms:district',
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
	            //bjcd LIKE '47820253%' AND name='청도읍'
	        },
	        enablePickFeatures : false
	    });
	    
	    DISTRICT_PROVIDER = viewer.imageryLayers.addImageryProvider(provider);
    }

    this.deleteDistrict = function () {
        if(DISTRICT_PROVIDER !== null && DISTRICT_PROVIDER !== undefined) {
            viewer.imageryLayers.remove(DISTRICT_PROVIDER, true);
        }
        DISTRICT_PROVIDER = null;
    }
}
loadDistrict();

var sdo_name = "";
var sgg_name = "";
var sdo_code = "";
var sgg_code = "";
var district_map_type = 1;

var defaultSdo = '<option value>시도</option>';
var defaultSgg = '<option value>전체</option>';


/**
 * 시도 목록을 로딩
 */
function loadDistrict()
{
	district_map_type = 1;
    var url = "./sdos";
    $.ajax({
        url: url,
        type: "GET",
        dataType: "json",
        success : function(msg) {
            if(msg.result === "success") {
                var sdoList = msg.sdoList;
                var content = "";

                content += defaultSdo;
                for(var i=0, len=sdoList.length; i < len; i++)                    
                {
                    var sdo = sdoList[i];
                    if(sdo.sdo_code==='45' || sdo.sdo_code==='46') {
                    	content += '<option value=' + sdo.sdo_code + '>' + sdo.name + '</option>';
                    }
                }
                
                $('#sdoList').html(content);
            }
        },
        error : function(request, status, error) {
            console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
        }
    });
}

$('#sdoList').on("change",function() {
	sdo_code =$("#sdoList").val();
	changeSdo(sdo_code);
	var name = [sdo_name, sgg_name].join(" ").trim();
    district.drawDistrict(name, sdo_code, sgg_code);
    getCentroid(name, sdo_code, sgg_code);
});
$('#sggList').on("change",function() {
	sgg_code =$("#sggList").val();
	if(sgg_code == "") {
		district_map_type = 1;
	} else {
		district_map_type = 2;
	}
    var name = [sdo_name, sgg_name].join(" ").trim();
    district.drawDistrict(name, sdo_code, sgg_code);
    getCentroid(name, sdo_code, sgg_code);
});
// 시도가 변경되면 하위 시군구가 변경됨
function changeSdo(_sdo_code) {
    sdo_code = _sdo_code;
    sgg_code = "";
    
    district_map_type = 1;

    var url = "./sdos/" + sdo_code + "/sggs";
    $.ajax({
        url: url,
        type: "GET",
        dataType: "json",
        success : function(msg) {
            if(msg.result === "success") {
                var sggList = msg.sggList;
                var content = "";
                
                content += defaultSgg;
                for(var i=0, len=sggList.length; i < len; i++)                    
                {
                    var sgg = sggList[i];               
                    content += '<option value=' + sgg.sgg_code + '>' + sgg.name + '</option>';
                }             
                $('#sggList').html(content);

            }
        },
        error : function(request, status, error) {
            console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
        }
    });
}

function getCentroid(name, sdo_code, sgg_code) {
    var layerType = district_map_type;
    var bjcd = sdo_code.toString().padStart(2, '0') + sgg_code.toString().padStart(3, '0')+'00000';
    var time = 3;

    var info = "layer_type=" + layerType + "&name=" + name  + "&bjcd=" + bjcd;
    $.ajax({
        url: "./centroids",
        type: "GET",
        data: info,
        dataType: "json",
        success : function(msg) {
            if(msg.result === "success") {
                var altitude = 300000;
                if(layerType === 2) {
                    altitude = 50000;
                } else if(layerType === 3) {
                    altitude = 15000;
                }
                cameraFlyTo(msg.longitude, msg.latitude, altitude, time);
            } else {
                alert(msg.result);
            }
        },
        error : function(request, status, error) {
            //alert(JS_MESSAGE["ajax.error.message"]);
            console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
        }
    });		
}
