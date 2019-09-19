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
	                	viewSensorID(viewer, lonlat[0], lonlat[1], sensorID.alt, sensorID.condition);
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

function viewSensorID(viewer, lon, lat, alt, condition) {
	var entities = viewer.entities;
	var sensorID = entities.add(new Cesium.Entity());
	
	if(condition == 0) {
		entities.add({
			parent : sensorID,
			id : lon + ',' + lat ,
			name : 'Sensor',
		    description  : '<table class="cesium-infoBox-defaultTable"><tbody>' +
            '<tr><th>Longitude</th><td>' + lon + '</td></tr>' +
            '<tr><th>Latitude</th><td>' +  lat + '</td></tr>' +
            '</tbody></table>',
			position : Cesium.Cartesian3.fromDegrees(parseFloat(lon), parseFloat(lat), parseFloat(alt) + 32),
			ellipsoid : {
					radii : new Cesium.Cartesian3(1.5, 1.5, 1.5),
					material : Cesium.Color.SPRINGGREEN
					}
		});			
	} else if(condition == 1) {
		entities.add({
			parent : sensorID,
			id : lon + ',' + lat ,
			name : 'sensor',
		    description  : '<table class="cesium-infoBox-defaultTable"><tbody>' +
            '<tr><th>Longitude</th><td>' + lon + '</td></tr>' +
            '<tr><th>Latitude</th><td>' +  lat + '</td></tr>' +
            '</tbody></table>',
			position : Cesium.Cartesian3.fromDegrees(parseFloat(lon), parseFloat(lat), parseFloat(alt) + 32),
			ellipsoid : {
					radii : new Cesium.Cartesian3(1.5, 1.5, 1.5),
					material : Cesium.Color.RED
					}
		});					
	}
}