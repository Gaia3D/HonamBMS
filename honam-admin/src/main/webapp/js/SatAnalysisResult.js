// 위성영상 결과 가시화
function getListSatAvg(gid, facNum) {
	var arrSatValue = new Array(); 
	var url = "./" + gid + "/sat/avg";
	var info = "fac_num=" + facNum;
	$.ajax({
    url: url,
    type: "GET",
    data: info,
    dataType: "json",
    success : function(msg) {
        if(msg.result === "success") {
       		var satAvgList = msg.satAvgList;
       		satValueCount = msg.satAvgCount;
       		var len = satAvgList.length;
       		if(len > 0) {
       			$('#bridgeLayer ul.listLayer > li:eq(1)').toggleClass('on');
	       		for(var i=0; i < len; i++) {
                	var satPoint = satAvgList[i];
                	this.satValue = viewBridgeSatAvg(satPoint.lon, satPoint.lat, satPoint.displacement);
                	arrSatValue.push(satPoint.displacement);
                }
	       		getClassBreaks(arrSatValue);
	       		
       		}		       		
        }
    },
    error : function(request, status, error) {
        //alert(JS_MESSAGE["ajax.error.message"]);
    	console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
        }
	});
}
	
function getListSatValue(gid, facNum, lon, lat) {	
	var url = "./" + gid + "/sat/value";
	var info = "fac_num=" + facNum + "&lon=" + lon + "&lat=" + lat;
	var arrSatValue = new Array(); 
	
	$.ajax({
    url: url,
    type: "GET",
    data: info,
    dataType: "json",
    success : function(msg) {
        if(msg.result === "success") {
       		var satValueList = msg.satValueList;
       		var len = satValueList.length;
       		for(var i=0; i < len; i++) {
				var satDisplacement = satValueList[i];
				arrSatValue.push([satDisplacement.acquire_date, satDisplacement.value]);
       		}
       		createSatValueGraph(arrSatValue);
        }
    },
    error : function(request, status, error) {
        //alert(JS_MESSAGE["ajax.error.message"]);
        console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
    }
});
}
	
function viewBridgeSatAvg(lon, lat, avg) {
	var entities = viewer.entities;
	
	if(avg >= 4){
		entities.add({
		parent : satValue,
		id : lon + ',' + lat ,
		name : 'Mean velocity (mm/yr)',
	    description  : '<table class="cesium-infoBox-defaultTable"><tbody>' +
        '<tr><th>Longitude</th><td>' + lon + '</td></tr>' +
        '<tr><th>Latitude</th><td>' +  lat + '</td></tr>' +
        '<tr><th>value</th><td>' +  avg + '</td></tr>' +
        '</tbody></table>',
		position : Cesium.Cartesian3.fromDegrees(lon, lat, 25),
		ellipsoid : {
				radii : new Cesium.Cartesian3(1.3, 1.3, 1.3),
				material : Cesium.Color.RED
				}
	});
	} else if((avg >= 3) && (avg < 4)) {
		entities.add({
		parent : satValue,
		id : lon + ',' + lat ,
		name : 'Mean velocity (mm/yr)',
	    description  : '<table class="cesium-infoBox-defaultTable"><tbody>' +
        '<tr><th>Longitude</th><td>' + lon + '</td></tr>' +
        '<tr><th>Latitude</th><td>' +  lat + '</td></tr>' +
        '<tr><th>value</th><td>' +  avg + '</td></tr>' +
        '</tbody></table>',
		position : Cesium.Cartesian3.fromDegrees(lon, lat, 25),
		ellipsoid : {
				radii : new Cesium.Cartesian3(1.3, 1.3, 1.3),
		        material : Cesium.Color.ORANGERED
		        }
	});
	} else if((avg >= 2) && (avg < 3)) {
		entities.add({
		parent : satValue,
		id : lon + ',' + lat ,
		name : 'Mean velocity (mm/yr)',
	    description  : '<table class="cesium-infoBox-defaultTable"><tbody>' +
        '<tr><th>Longitude</th><td>' + lon + '</td></tr>' +
        '<tr><th>Latitude</th><td>' +  lat + '</td></tr>' +
        '<tr><th>value</th><td>' +  avg + '</td></tr>' +
        '</tbody></table>',
		position : Cesium.Cartesian3.fromDegrees(lon, lat, 25),
		ellipsoid : {
				radii : new Cesium.Cartesian3(1.3, 1.3, 1.3),
		        material : Cesium.Color.ORANGE
		        }
	});
	} else if((avg >= 1) && (avg < 2)) {
		entities.add({
		parent : satValue,
		id : lon + ',' + lat ,
		name : 'Mean velocity (mm/yr)',
	    description  : '<table class="cesium-infoBox-defaultTable"><tbody>' +
        '<tr><th>Longitude</th><td>' + lon + '</td></tr>' +
        '<tr><th>Latitude</th><td>' +  lat + '</td></tr>' +
        '<tr><th>value</th><td>' +  avg + '</td></tr>' +
        '</tbody></table>',
		position : Cesium.Cartesian3.fromDegrees(lon, lat, 25),
		ellipsoid : {
				radii : new Cesium.Cartesian3(1.3, 1.3, 1.3),
		        material : Cesium.Color.YELLOW
		    }
	});
	} else if((avg >= 0) && (avg < 1)) {
		entities.add({
		parent : satValue,
		id : lon + ',' + lat ,
		name : 'Mean velocity (mm/yr)',
	    description  : '<table class="cesium-infoBox-defaultTable"><tbody>' +
        '<tr><th>Longitude</th><td>' + lon + '</td></tr>' +
        '<tr><th>Latitude</th><td>' +  lat + '</td></tr>' +
        '<tr><th>value</th><td>' +  avg + '</td></tr>' +
        '</tbody></table>',
		position : Cesium.Cartesian3.fromDegrees(lon, lat, 25),
		ellipsoid : {
				radii : new Cesium.Cartesian3(1.3, 1.3, 1.3),
		        material : Cesium.Color.LIME
		    }
	});
	} else if((avg >= -1) && (avg < 0)) {
		entities.add({
		parent : satValue,
		id : lon + ',' + lat ,
		name : 'Mean velocity (mm/yr)',
	    description  : '<table class="cesium-infoBox-defaultTable"><tbody>' +
        '<tr><th>Longitude</th><td>' + lon + '</td></tr>' +
        '<tr><th>Latitude</th><td>' +  lat + '</td></tr>' +
        '<tr><th>value</th><td>' +  avg + '</td></tr>' +
        '</tbody></table>',
		position : Cesium.Cartesian3.fromDegrees(lon, lat, 25),
		ellipsoid : {
				radii : new Cesium.Cartesian3(1.3, 1.3, 1.3),
		        material : Cesium.Color.SPRINGGREEN
		    }
	});
	} else if((avg >= -2) && (avg < -1)) {
		entities.add({
		parent : satValue,
		id : lon + ',' + lat ,
		name : 'Mean velocity (mm/yr)',
	    description  : '<table class="cesium-infoBox-defaultTable"><tbody>' +
        '<tr><th>Longitude</th><td>' + lon + '</td></tr>' +
        '<tr><th>Latitude</th><td>' +  lat + '</td></tr>' +
        '<tr><th>value</th><td>' +  avg + '</td></tr>' +
        '</tbody></table>',	    
		position : Cesium.Cartesian3.fromDegrees(lon,lat, 25),
		ellipsoid : {
				radii : new Cesium.Cartesian3(1.3, 1.3, 1.3),
		        material : Cesium.Color.CYAN 
		    }
	});
	} else if((avg >= -3) && (avg < -2)) {
		entities.add({
		parent : satValue,
		id : lon + ',' + lat ,
		name : 'Mean velocity (mm/yr)',
	    description  : '<table class="cesium-infoBox-defaultTable"><tbody>' +
        '<tr><th>Longitude</th><td>' + lon + '</td></tr>' +
        '<tr><th>Latitude</th><td>' +  lat + '</td></tr>' +
        '<tr><th>value</th><td>' +  avg + '</td></tr>' +
        '</tbody></table>',	    
		position : Cesium.Cartesian3.fromDegrees(lon,lat, 25),
		ellipsoid : {
				radii : new Cesium.Cartesian3(1.3, 1.3, 1.3),
		        material : Cesium.Color.DEEPSKYBLUE 
		    }
	});
	} else if((avg >= -4) && (avg < -3)) {
		entities.add({
		parent : satValue,
		id : lon + ',' + lat ,
		name : 'Mean velocity (mm/yr)',
	    description  : '<table class="cesium-infoBox-defaultTable"><tbody>' +
        '<tr><th>Longitude</th><td>' + lon + '</td></tr>' +
        '<tr><th>Latitude</th><td>' +  lat + '</td></tr>' +
        '<tr><th>value</th><td>' +  avg + '</td></tr>' +
        '</tbody></table>',
		position : Cesium.Cartesian3.fromDegrees(lon, lat, 25),
		ellipsoid : {
				radii : new Cesium.Cartesian3(1.3, 1.3, 1.3),
		        material : Cesium.Color.BLUE
		    }
	});
	} else if(avg >= -4){
		entities.add({
		parent : satValue,
		id : lon + ',' + lat ,
		name : 'Mean velocity (mm/yr)',
	    description  : '<table class="cesium-infoBox-defaultTable"><tbody>' +
        '<tr><th>Longitude</th><td>' + lon + '</td></tr>' +
        '<tr><th>Latitude</th><td>' +  lat + '</td></tr>' +
        '<tr><th>value</th><td>' +  avg + '</td></tr>' +
        '</tbody></table>',
		position : Cesium.Cartesian3.fromDegrees(lon, lat, 25),
		ellipsoid : {
				radii : new Cesium.Cartesian3(1.3, 1.3, 1.3),
		        material : Cesium.Color.DARKBLUE
		    }
		});		
	}	
}

var breaks;
function getClassBreaks(features) {
		var colors  = new Array('#00008B', '#0000FF', '#00BFFF', '#00FFFF', '#00FF7F', '#00FF00' ,'#FFFF00', '#FF8C00', '#FF4500', '#FF0000');   			
	    var stat = new geostats(features);
	    
	    var ranges = new Array('-5.0','-4.0','-3.0','-2.0','-1.0','0','1.0','2.0','3.0','4.0','5.0');
	 	stat.setBounds(ranges);
	 	stat.setRanges();
	 	stat.legendSeparator = '⇔  ';
	 	stat.setPrecision(2);

		$('#bridgeLayer ul.listLayer > li:eq(1) .legend').html(
			stat.getHtmlLegend(colors, "legend", true, null, null, 'DESC')
		);
}
	
function parse(str) {
    var y = str.substr(0, 4);
    var m = str.substr(4, 2);
    var d = str.substr(6, 2);
    return new Date(y,m-1,d);
}

var satValueChart = null;
function createSatValueGraph(data) {
	var date= [];
	var displacement = [];
	var value = [];
	var label = [];
	
	for (i = 0; i < data.length-1; i++) {
		date.push(parse(String(data[i][0])));
		label.push(moment.utc(date[i]).format('YYYY/MM/DD'));
		value.push({x: date[i], y: data[i][1]});
		displacement.push(data[i][1]);
	}

	if (satValueChart != null) {
		satValueChart.destroy();
	}		
	satValueChart = new Chart(document.getElementById("analysisGraphic"), {
	    type: 'scatter',
	    data: {
	    	labels: label,
	        datasets: [{
	            data: value,
	            borderColor: [
	                'rgba(44,130,255,1)'
	            ],
				pointBackgroundColor: [
					'rgba(255,0,255,0.5)',
					'rgba(255,0,1 50,0.5)',
					'rgba(255,150,0,0.5)'
				],
				pointBackgroundColor: 'rgba(255, 255, 178, 1)',
				pointRadius: 5,
				pointHoverRadius: 10,
				pointHitRadius: 10,
				pointStyle: 'circle'
	        }]
	    },
	    options: {
			responsive: true,
			maintainAspectRatio: false,
			legend: {
				display: false,
				position: 'top',
				labels: {
					boxWidth: 80,
					fontColor: 'black'
				}
			},
			hover: {
				mode: 'index',
				intersect: true
			},
	        scales: {
				xAxes: [{
	            	type: 'time',
	                time: {
	                    millisecond: 'mm:ss',
	                    second: 'mm:ss',
	                    minute: 'HH:mm',
	                    hour: 'HH:mm',
	                    day: 'MMM DD',
	                    week: 'MMM DD',
	                    month: 'YYYY MMM',
	                    quarter: 'YYYY MMM',
	                  },
					display: true,
					scaleLabel: {
						display: true,
						labelString: 'date'
					}
				}],
	            yAxes: [{		            	
					display: true,
					scaleLabel: {
						display: true,
						labelString: 'Displacement (mm)'
					},
					ticks: {
						autoSkip: true,
						minRotation: 0,
						min: -15,
						max: 15
					}
	            }]
	        }
	    }
	});
}


