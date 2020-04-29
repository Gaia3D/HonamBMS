function getListSatValue(gid, facNum, slope, lon, lat) {	
	var arrSatValue = new Array();
	
	var info = "facNum=" + facNum + "&lon=" + lon + "&lat=" + lat;
	$.ajax({
		url: "/sats/" + facNum + "/average/values",
		type: "GET",
		headers: {"X-Requested-With": "XMLHttpRequest"},
		data: info,
		dataType: "json",
		success: function(msg){
			if(msg.statusCode <= 200) {
				var satValueList = msg.satValueList;
	       		var len = satValueList.length;
	       		for(var i=0; i < len; i++) {
					var satDisplacement = satValueList[i];
					arrSatValue.push([satDisplacement.acquireDate, satDisplacement.value]);
	       		}
	       		createSatValueGraph(slope, lon, lat, arrSatValue);
			} else {
				alert(JS_MESSAGE[msg.errorCode]);
			}
		},
		error:function(request,status,error){
			alert(JS_MESSAGE["ajax.error.message"]);
		}
	});
}
	
function viewBridgeSatAvg(lon, lat, slope) {
	if(slope >= 4){
		viewer.entities.add({
			parent : satValue,
			id : lon + ',' + lat ,
			name : 'Mean velocity (mm/yr)',
		    description  : slope ,
			position : Cesium.Cartesian3.fromDegrees(lon, lat, 20),
			point : new Cesium.PointGraphics({
				pixelSize : 10,
				color : Cesium.Color.RED,
				//outlineColor : Cesium.Color.WHITE,
				outlineWidth : 1
			})
			// ellipsoid : {
			// 		radii : new Cesium.Cartesian3(1.3, 1.3, 1.3),
			// 		material : Cesium.Color.RED
			// 		}
		});
	} else if((slope >= 3) && (slope < 4)) {
		viewer.entities.add({
			parent : satValue,
			id : lon + ',' + lat ,
			name : 'Mean velocity (mm/yr)',
			description  : slope ,
			position : Cesium.Cartesian3.fromDegrees(lon, lat, 20),
			point : new Cesium.PointGraphics({
				pixelSize : 10,
				color : Cesium.Color.ORANGERED,
				//outlineColor : Cesium.Color.WHITE,
				outlineWidth : 1
			})
			// ellipsoid : {
			// 		radii : new Cesium.Cartesian3(1.3, 1.3, 1.3),
			//         material : Cesium.Color.ORANGERED
			//         }
		});
	} else if((slope >= 2) && (slope < 3)) {
		viewer.entities.add({
			parent : satValue,
			id : lon + ',' + lat ,
			name : 'Mean velocity (mm/yr)',
			description  : slope ,
			position : Cesium.Cartesian3.fromDegrees(lon, lat, 20),
			point : new Cesium.PointGraphics({
				pixelSize : 10,
				color : Cesium.Color.ORANGE,
				//outlineColor : Cesium.Color.WHITE,
				outlineWidth : 1
			})
			// ellipsoid : {
			// 		radii : new Cesium.Cartesian3(1.3, 1.3, 1.3),
			//         material : Cesium.Color.ORANGE
			//         }
		});
	} else if((slope >= 1) && (slope < 2)) {
		viewer.entities.add({
			parent : satValue,
			id : lon + ',' + lat ,
			name : 'Mean velocity (mm/yr)',
			description  : slope ,
			position : Cesium.Cartesian3.fromDegrees(lon, lat, 20),
			point : new Cesium.PointGraphics({
				pixelSize : 10,
				color : Cesium.Color.YELLOW,
				//outlineColor : Cesium.Color.WHITE,
				outlineWidth : 1
			})
			// ellipsoid : {
			// 		radii : new Cesium.Cartesian3(1.3, 1.3, 1.3),
			//         material : Cesium.Color.YELLOW
			//     }
		});
	} else if((slope >= 0) && (slope < 1)) {
		viewer.entities.add({
			parent : satValue,
			id : lon + ',' + lat ,
			name : 'Mean velocity (mm/yr)',
			description  : slope ,
			position : Cesium.Cartesian3.fromDegrees(lon, lat, 20),
			point : new Cesium.PointGraphics({
				pixelSize : 10,
				color : Cesium.Color.LIME,
				//outlineColor : Cesium.Color.WHITE,
				outlineWidth : 1
			})
			// ellipsoid : {
			// 		radii : new Cesium.Cartesian3(1.3, 1.3, 1.3),
			//         material : Cesium.Color.LIME
			//     }
		});
	} else if((slope >= -1) && (slope < 0)) {
		viewer.entities.add({
			parent : satValue,
			id : lon + ',' + lat ,
			name : 'Mean velocity (mm/yr)',
			description  : slope ,
			position : Cesium.Cartesian3.fromDegrees(lon, lat, 20),
			point : new Cesium.PointGraphics({
				pixelSize : 10,
				color : Cesium.Color.SPRINGGREEN,
				//outlineColor : Cesium.Color.WHITE,
				outlineWidth : 1
			})
			// ellipsoid : {
			// 		radii : new Cesium.Cartesian3(1.3, 1.3, 1.3),
			//         material : Cesium.Color.SPRINGGREEN
			//     }
		});
	} else if((slope >= -2) && (slope < -1)) {
		viewer.entities.add({
			parent : satValue,
			id : lon + ',' + lat ,
			name : 'Mean velocity (mm/yr)',
			description  : slope ,
			position : Cesium.Cartesian3.fromDegrees(lon,lat, 20),
			point : new Cesium.PointGraphics({
				pixelSize : 10,
				color : Cesium.Color.CYAN,
				//outlineColor : Cesium.Color.WHITE,
				outlineWidth : 1
			})
			// ellipsoid : {
			// 		radii : new Cesium.Cartesian3(1.3, 1.3, 1.3),
			//         material : Cesium.Color.CYAN
			//     }
		});
	} else if((slope >= -3) && (slope < -2)) {
		viewer.entities.add({
			parent : satValue,
			id : lon + ',' + lat ,
			name : 'Mean velocity (mm/yr)',
			description  : slope ,
			position : Cesium.Cartesian3.fromDegrees(lon,lat, 20),
			point : new Cesium.PointGraphics({
				pixelSize : 10,
				color : Cesium.Color.DEEPSKYBLUE,
				//outlineColor : Cesium.Color.WHITE,
				outlineWidth : 1
			})
			// ellipsoid : {
			// 		radii : new Cesium.Cartesian3(1.3, 1.3, 1.3),
			//         material : Cesium.Color.DEEPSKYBLUE
			//     }
		});
	} else if((slope >= -4) && (slope < -3)) {
		viewer.entities.add({
			parent : satValue,
			id : lon + ',' + lat ,
			name : 'Mean velocity (mm/yr)',
			description  : slope ,
			position : Cesium.Cartesian3.fromDegrees(lon, lat, 20),
			point : new Cesium.PointGraphics({
				pixelSize : 10,
				color : Cesium.Color.BLUE,
				//outlineColor : Cesium.Color.WHITE,
				outlineWidth : 2
			})
			// ellipsoid : {
			// 		radii : new Cesium.Cartesian3(1.3, 1.3, 1.3),
			//         material : Cesium.Color.BLUE
			//     }
		});
	} else if(slope < -4){
		viewer.entities.add({
		parent : satValue,
		id : lon + ',' + lat ,
		name : 'Mean velocity (mm/yr)',
		description  : slope ,
		position : Cesium.Cartesian3.fromDegrees(lon, lat, 20),
			point : new Cesium.PointGraphics({
				pixelSize : 10,
				color : Cesium.Color.DARKBLUE,
				//outlineColor : Cesium.Color.WHITE,
				outlineWidth : 2
			})
		// ellipsoid : {
		// 		radii : new Cesium.Cartesian3(1.3, 1.3, 1.3),
		//         material : Cesium.Color.DARKBLUE
		//     }
		});		
	}	
}

var breaks;
function getClassBreaks(features) {
		/*var colors  = new Array('#00008B', '#0000FF', '#00BFFF', '#00FFFF', '#00FF7F', '#00FF00' ,'#FFFF00', '#FF8C00', '#FF4500', '#FF0000');   			
	    var stat = new geostats(features);
	    
	    var ranges = new Array('-5.0','-4.0','-3.0','-2.0','-1.0','0','1.0','2.0','3.0','4.0','5.0');
	 	stat.setBounds(ranges);
	 	stat.setRanges();
	 	stat.legendSeparator = '⇔  ';
	 	stat.setPrecision(2);

		$('#bridgeLayer ul.listLayer > li:eq(1) .legend').html(
			stat.getHtmlLegend(colors, "legend", true, null, null, 'DESC')
		);*/
}
	
function parse(str) {
    var y = str.substr(0, 4);
    var m = str.substr(4, 2);
    var d = str.substr(6, 2);
    return new Date(y,m-1,d);
}

var satValueChart = null;
function createSatValueGraph(slope, longitude, latitude, data) {
	var date= [];
	var displacement = [];
	var value = [];
	var label = [];
	var title = "slope (mm/yr) : " + slope + ", 경도 : " + longitude + ", 위도 : " + latitude;
	
	for (i = 0; i < data.length-1; i++) {
		date.push(parse(String(data[i][0])));
		var acquireDate = (data[i][0]).toString();
		label.push(acquireDate.substring(0, 4) + "/" + acquireDate.substring(4, 6) + "/" + acquireDate.substring(6,8));
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
	    	title: {
	            display: true,
	            text: title
	        },	
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
						minRotation: 0
					}
	            }]
	        }
	    }
	});
}


