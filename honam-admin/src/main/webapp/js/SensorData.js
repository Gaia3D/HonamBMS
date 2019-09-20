// 센서 데이터 가시화
function getListSensorID(viewer, gid, facNum) {
	var url = "./" + gid + "/sensor";
	var info = "fac_num=" + facNum;

	$.ajax({
	    url: url,
	    type: "GET",
	    data: info,
	    dataType: "json",
	    success : function(msg) {
	    	if(msg.result === "success") {
	    		var sensorIDList = msg.sensorIDList;
	       		sensorIDCount = msg.sensorIDCount
	       		var len = sensorIDList.length;
	       		if(len > 0) {
	       			$('#bridgeLayer ul.listLayer > li:eq(2)').toggleClass('on');
		       		for(var i=0; i < len; i++) {
		       			var sensorID = sensorIDList[i];
	                	var location = sensorID.location.substring(sensorID.location.indexOf('(') + 1, sensorID.location.indexOf(')'));
	                	var lonlat = location.split(' ');
	                	viewSensorID(viewer, sensorID.sensorid, lonlat[0], lonlat[1], sensorID.alt, sensorID.condition);
	                	}
		       		}		       		
	       		}
		},
	    error : function(request, status, error) {
	        //alert(JS_MESSAGE["ajax.error.message"]);
	        console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
	    }
	});
	
}

function getListSensorType(viewer, gid, facNum, sensorType) {
	var url = "./" + gid + "/sensor/" + sensorType;
	var info = "sensorType=" + sensorType + "&fac_num=" + facNum;

	$.ajax({
	    url: url,
	    type: "GET",
	    data: info,
	    dataType: "json",
	    success : function(msg) {
	    	if(msg.result === "success") {
	    		var sensorList = msg.sensorIDList;
	       		var len = sensorList.length;
	       		if(len > 0) {
		       		for(var i=0; i < len; i++) {
		       			var sensor = sensorList[i];
	                	var location = sensor.location.substring(sensor.location.indexOf('(') + 1, sensor.location.indexOf(')'));
	                	var lonlat = location.split(' ');
	                	viewSensorID(viewer, sensor.sensorid, lonlat[0], lonlat[1], sensor.alt, sensor.condition);
	                	}
		       		}		       				
	       		}
		},
	    error : function(request, status, error) {
	        //alert(JS_MESSAGE["ajax.error.message"]);
	        console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
	    }
	});
}

function viewSensorID(viewer, sensorid, lon, lat, alt, condition) {
	var entities = viewer.entities;

	if(condition == 0) {
		entities.add({
			parent : sensorID,
			name : sensorid,
		    description  : '<table class="cesium-infoBox-defaultTable"><tbody>' +
            '<tr><th>Longitude</th><td>' + lon + '</td></tr>' +
            '<tr><th>Latitude</th><td>' +  lat + '</td></tr>' +
            '</tbody></table>',
			position : Cesium.Cartesian3.fromDegrees(parseFloat(lon), parseFloat(lat), parseFloat(alt) + 32),
			ellipsoid : {
					radii : new Cesium.Cartesian3(2, 2, 2),
					material : Cesium.Color.SPRINGGREEN
					}
		});			
	} else if(condition == 1) {
		entities.add({
			parent : sensorID,
			name : sensorid,
		    description  : '<table class="cesium-infoBox-defaultTable"><tbody>' +
            '<tr><th>Longitude</th><td>' + lon + '</td></tr>' +
            '<tr><th>Latitude</th><td>' +  lat + '</td></tr>' +
            '</tbody></table>',
			position : Cesium.Cartesian3.fromDegrees(parseFloat(lon), parseFloat(lat), parseFloat(alt) + 32),
			ellipsoid : {
					radii : new Cesium.Cartesian3(2, 2, 2),
					material : Cesium.Color.RED
					}
		});					
	}
}

$('input[name="sensor"]').change(function() {
	var sensorType;
    $('input[name="sensor"]').each(function() {
        var value = $(this).val();            
        var checked = $(this).prop('checked'); 
        var $label = $(this).next();
       
        if(checked) {
        	sensorType = value;
        	$.each(sensorID._children,function(i,obj){          
        		viewer.entities.remove(obj);
        	});
        	while (sensorID._children.length) {
        		sensorID._children.pop();
        	}
        	getListSensorType(viewer, gid, facNum, sensorType);
        }
    });
});

