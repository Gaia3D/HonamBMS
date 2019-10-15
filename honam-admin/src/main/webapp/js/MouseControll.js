function MouseControll(viewer, gid, facNum) {
	var scene = viewer.scene;
    var pickPosition = { lat: null, lon: null, alt: null };
    var featurePosition = { lat: null, lon: null, alt: null };
  
    var handler = new Cesium.ScreenSpaceEventHandler(viewer.canvas);
    handler.setInputAction(function (event) {
        var newPosition = viewer.scene.pickPosition(event.endPosition);
        if (scene.pickPositionSupported && Cesium.defined(newPosition)) {
            var cartographic = Cesium.Cartographic.fromCartesian(newPosition);
            pickPosition.lon = Cesium.Math.toDegrees(cartographic.longitude);
            pickPosition.lat = Cesium.Math.toDegrees(cartographic.latitude);
            pickPosition.alt = Math.round(cartographic.height);
            showClickPosition(pickPosition);
        }      
    }, Cesium.ScreenSpaceEventType.MOUSE_MOVE);
  
    handler.setInputAction(function (movement) {
    	var pick = scene.pick(movement.position);
        if (Cesium.defined(pick)) {
		   	var featureId = pick.id._id;
		   	var featurename = pick.id._name;
	     	var jbSplit = featureId.split(',');
	     	featurePosition.lon = jbSplit[0];
	     	featurePosition.lat = jbSplit[1];
	     	if(satValueCount > 0) {
		        getListSatValue(gid, facNum, featurePosition.lon, featurePosition.lat);    		
				$('.analysisGraphic').css('display','block');
	     	}
        	if(sensorIDCount > 0) {
        		getSensorMonitoringData(gid, facNum, featurename);
//        		$('.analysisGraphic').css('display','block');
        	}
	    } else {
	    	$('.analysisGraphic').css('display','none');
	    	
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