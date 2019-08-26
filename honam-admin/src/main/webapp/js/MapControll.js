
function MapControll(viewer, option) {
    this._viewer = viewer;
    this._scene = viewer.scene;

    viewer.scene.globe.depthTestAgainstTerrain = true;
    viewer.cesiumWidget.screenSpaceEventHandler.removeInputAction(Cesium.ScreenSpaceEventType.LEFT_DOUBLE_CLICK);

    var that = this;
    var handler = null;

    var activeShapePoints = [];

    /**
     * 나침반 동작
     */
    viewer.scene.postRender.addEventListener(function () {
        var camera = this._viewer.camera;
        var angle = Cesium.Math.toDegrees(camera.heading);
        if (angle > 359.9 || angle < .1) {
            $("#mapCtrlCompass").addClass('on');
        }
        else {
            $("#mapCtrlCompass").removeClass('on');
            $("#mapCtrlCompass").css({
                '-webkit-transform': 'rotate(' + -angle + 'deg)',
                '-moz-transform': 'rotate(' + -angle + 'deg)',
                '-ms-transform': 'rotate(' + -angle + 'deg)',
                'transform': 'rotate(' + -angle + 'deg)'
            });
        }
    });

    $('#mapCtrlCompass').click(function () {
        console.log("맵컨트롤 : 나침반");
        $(this).addClass('on');
        var camera = viewer.scene.camera;
        camera.flyTo({
            destination: camera.position,
            orientation: {
                heading: 0,
                pitch: Cesium.Math.toRadians(-90),
                roll: 0
            }
        });
    });

  
    $('#mapCtrlReset').click(function () {
        console.log("맵컨트롤 : 초기화");
        that._scene.camera.flyHome();
    });

    $('#mapCtrlZoomIn').click(function () {
        console.log("맵컨트롤 : 확대");
        that._scene.camera.zoomIn();
    });

    $('#mapCtrlZoomOut').click(function () {
        console.log("맵컨트롤 : 축소");
        that._scene.camera.zoomOut();
    });
}
    