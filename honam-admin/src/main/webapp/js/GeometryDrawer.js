function CesiumPolygonDrawer(viewer) {
    this.active = false;
    this.drawing = false;
    this.viewer = viewer;
    this.auxEntity;
    this.activeShapePoints = [];
    this.drawedEntity;
    this.callbackPositions = new Cesium.CallbackProperty(this.callbackPositionFunc.bind(this), false);
    this.setHandler();
}



CesiumPolygonDrawer.prototype.getPositionWKT = function() {
    if(!this.drawedEntity) {
        throw new Error('그려진 폴리곤이 없습니다.');
    }

    var positions = this.drawedEntity.polygon.hierarchy.getValue().positions;
    var firstLon;
    var firstLat;
    var wkt = 'MULTIPOLYGON (((';
    for(var i=0,len=positions.length;i<len;i++) {
        if(i>0) {
            wkt += ',';
        }
        var position = positions[i];
        var radCarto = Cesium.Cartographic.fromCartesian(position);
        var lon = Cesium.Math.toDegrees(radCarto.longitude);
        var lat = Cesium.Math.toDegrees(radCarto.latitude);

        wkt += lon;
        wkt += ' ';
        wkt += lat;

        if(i===0) {
            firstLon = lon;
            firstLat = lat;
        }
    }
    wkt += ',';
    wkt += firstLon;
    wkt += ' ';
    wkt += firstLat;
    wkt += ')))';

    return wkt;
}



CesiumPolygonDrawer.prototype.complete = function() {
    var auxEntity = this.auxEntity;
    if(auxEntity && auxEntity.name === 'polygon') {
        var entity = viewer.entities.add({
            name : 'created',
            polygon: {
                hierarchy: auxEntity.polygon.hierarchy.getValue().positions,
                material: new Cesium.ColorMaterialProperty(Cesium.Color.BLUE.withAlpha(0.3))
            }
        });
        if(this.drawedEntity) {
            this.viewer.entities.removeById(this.drawedEntity.id);
        }
        this.drawedEntity = entity;
    }
    this.init();
}
CesiumPolygonDrawer.prototype.init = function() {
    this.activeShapePoints = [];
    if(this.auxEntity) {
        this.viewer.entities.removeById(this.auxEntity.id);
        this.auxEntity = undefined;
    }
}
CesiumPolygonDrawer.prototype.callbackPositionFunc = function() {
    var points = this.activeShapePoints;
    if(points.length === 1) {
    	return points[0];
    } else if(points.length < 3) {
        return points;
    } else {
        return new Cesium.PolygonHierarchy(points);
    }
}



CesiumPolygonDrawer.prototype.setHandler = function() {
    var that = this;
    var viewer = that.viewer;
    var handler = new Cesium.ScreenSpaceEventHandler(viewer.canvas);
    handler.setInputAction(function (event) {
        if(!that.active) {
            return;
        }

        var drawPosition = screenToCartesianAdjustHeight(viewer, event.position, 50);
        that.activeShapePoints.push(drawPosition);
        if(that.activeShapePoints.length === 1) {
            that.drawing = true;
            that.auxEntity = viewer.entities.add({
                position : that.callbackPositions,
                name : 'point',
                point: {
                    pixelSize : 5,
                    color : Cesium.Color.YELLOW,
                    heightReference : Cesium.HeightReference.CLAMP_TO_GROUND
                }
            });
        } else if(that.activeShapePoints.length > 2) {
            if(that.auxEntity.name === 'line') {
                viewer.entities.removeById(that.auxEntity.id);

                that.auxEntity = viewer.entities.add({
                    name : 'polygon',
                    polygon: {
                        hierarchy: that.callbackPositions,
                        material: new Cesium.ColorMaterialProperty(Cesium.Color.YELLOW.withAlpha(0.1))
                    }
                });
            }
        }
    }, Cesium.ScreenSpaceEventType.LEFT_CLICK);

    handler.setInputAction(function (event) {
        if(!that.active) {
            return;
        }
        if(!that.drawing) {
            return;
        }

        if(that.activeShapePoints.length > 0) {
            var drawPosition = screenToCartesianAdjustHeight(viewer, event.endPosition, 50);
            if(that.activeShapePoints.length === 1) {
                that.activeShapePoints.push(drawPosition);
            } else if(that.activeShapePoints.length > 1) {
                that.activeShapePoints[that.activeShapePoints.length - 1] = drawPosition;
            }

            if(that.auxEntity.name === 'point') {
                viewer.entities.removeById(that.auxEntity.id);

                that.auxEntity = viewer.entities.add({
                    name : 'line',
                    polyline: {
                        positions: that.callbackPositions,
                        material: new Cesium.ColorMaterialProperty(Cesium.Color.YELLOW),
                        clampToGround : true
                    }
                });
            }
        }
    }, Cesium.ScreenSpaceEventType.MOUSE_MOVE);

    handler.setInputAction(function (event) {
        that.drawing = false;
        that.complete();
    }, Cesium.ScreenSpaceEventType.RIGHT_CLICK);

    function screenToCartesianAdjustHeight(viewer, screenCoord, height) {
        var cartesian = cesiumScreenToCartesian(viewer,screenCoord.x,screenCoord.y);
        var cartographic = Cesium.Cartographic.fromCartesian(cartesian);
        return Cesium.Cartesian3.fromDegrees(Cesium.Math.toDegrees(cartographic.longitude), Cesium.Math.toDegrees(cartographic.latitude), height);
    }
    function screenToCartesian(screenCoord) {
        return viewer.scene.pickPosition(screenCoord);
    }
}