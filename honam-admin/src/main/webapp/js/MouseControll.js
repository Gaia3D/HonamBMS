function MouseControll() {
	// 위성영상(SAT), 센서(SENSOR), 드론(DRONE)
	var businessType = null;
	
	var pickPosition = { lat: null, lon: null, alt: null };
    var featurePosition = { lat: null, lon: null, alt: null };
  
    var handler = new Cesium.ScreenSpaceEventHandler(viewer.canvas);
    handler.setInputAction(function (event) {
        var newPosition = viewer.scene.pickPosition(event.endPosition);
        if (viewer.scene.pickPositionSupported && Cesium.defined(newPosition)) {
            var cartographic = Cesium.Cartographic.fromCartesian(newPosition);
            pickPosition.lon = Cesium.Math.toDegrees(cartographic.longitude);
            pickPosition.lat = Cesium.Math.toDegrees(cartographic.latitude);
            pickPosition.alt = Math.round(cartographic.height);
            showClickPosition(pickPosition);
        }      
    }, Cesium.ScreenSpaceEventType.MOUSE_MOVE);
    
    handler.setInputAction(function (movement) {
    	var pick = viewer.scene.drillPick(movement.position);
        if (Cesium.defined(pick)) {
        	$("#selectEntityList").empty();
        	for(var i=0; i < pick.length; i++) {
        		if(pick[i].id._name === "SENSOR") {
        			businessType = "SENSOR";
        			var sensorid = pick[i].id._id;
        			$("#selectEntityList").append("<li data-sensorid="+sensorid +">sensorID : " + sensorid + "</li>");
        		} else if(pick[i].id._name === "Mean velocity (mm/yr)") {
        			businessType = "SAT";
        			// pick[i].id._id
        			var location = pick[i].id._id.split(",");
        			getListSatValue(BRIDGE_GID, BRIDGE_FAC_NUM, location[0], location[1]);
        		} else if(pick[i].id._name.toLowerCase().startsWith('drone')) {
        			//드론 엔티티 클릭 시 
        			businessType = "DRONE";
        			var properties = pick[i].id.properties;
        			var filePath = properties.filePath.getValue();
        			var fileName = properties.fileName.getValue();
        			popup('http://localhost/upload/' + filePath + '/' + fileName, fileName,500,500,'yes');
        			
        		}
        	}
        	
        	if(businessType === "SENSOR") {
	        	var x;
	        	// 좌측메뉴가 display일 경우 그 만큼 x값을 더해준다.  
	        	if($("#leftMenuArea").css("display") === "block") {
	        		x = movement.position.x + 390;
	        	} else {
	        		x = movement.position.x
	        	}
	        	$("#entityPopup").css("left", x + 'px');
	        	$("#entityPopup").css("top", movement.position.y + 'px');
	        	$("#entityPopup").show();
	        	$("#selectEntityList").one("click", 'li', function(){
	                handlerSensorPopup(this);
	            });
        	}
        }
    }, Cesium.ScreenSpaceEventType.LEFT_CLICK);   
}

// display current mouse position
// click poisition call back function
function showClickPosition(position) {
    var lon = position.lon;
    var lat = position.lat;
    var alt = position.alt;

    alt = alt > 0 ? alt : 0;

    $('#positionAlt').text(alt+"m");
    $('#positionDD').text(getposition(lon, lat, positionFormatterDD));
}

//Decimal degrees 'DD' (DDD.DDDDD°)
function positionFormatterDD(pos) {
  var lon = pos.position[0];
  var lat = pos.position[1];
  var lon_neg = pos.negative[0];
  var lat_neg = pos.negative[1];
  var designator = pos.designator;

  lon = format('#0.000000', lon) + '°';
  lat = format('##0.000000', lat) + '°';

  return (!designator && lon_neg ? '-' : '') + lon + (designator ? (lon_neg ? ' W' : ' E') : '') + ", " +
    (!designator && lat_neg ? '-' : '') + lat + (designator ? (lat_neg ? ' S' : ' N') : '')
}

function getposition(_lon, _lat, _formatter) {
	  var lon = _lon;
	  var lat = _lat;
	  var formatter = _formatter;
	  var lon_neg = false;
	  var lat_neg = false;
	  // designator	Boolean	false	Show N-S and E-W
	  var designator = false;

	  if (formatter == undefined) formatter = positionFormatterDD;

	  // 180 degrees & negative
	  if (lon < 0) {
	    lon_neg = true;
	    lon = Math.abs(lon);
	  }
	  if (lat < 0) {
	    lat_neg = true;
	    lat = Math.abs(lat);
	  }
	  if (lon > 180) {
	    lon = 360 - lon;
	    lon_neg = !lon_neg;
	  }

	  var coord = {
	    position: [lon, lat],
	    negative: [lon_neg, lat_neg],
	    designator: designator
	  };

	  return formatter(coord);
}