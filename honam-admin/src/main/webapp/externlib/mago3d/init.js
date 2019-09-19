'use strict';

var Emitter = function () {
    this._events = {};
};

Emitter.prototype.on = function (event, fn) {
    if (!this._events[event]) {
        this._events[event] = [];
    }
    this._events[event].push(fn);

    return this;
};

Emitter.prototype.emit = function (event) {
    var callbacks = this._events[event];

    if (callbacks) {
        for (var _len = arguments.length, args = Array(_len > 1 ? _len - 1 : 0), _key = 1; _key < _len; _key++) {
            args[_key - 1] = arguments[_key];
        }

        for (var _iterator = callbacks, _isArray = true, _i = 0, _iterator = _isArray ? _iterator : _iterator[Symbol.iterator](); ;) {
            var _ref;

            if (_isArray) {
                if (_i >= _iterator.length) break;
                _ref = _iterator[_i++];
            } else {
                _i = _iterator.next();
                if (_i.done) break;
                _ref = _i.value;
            }

            var callback = _ref;

            callback.apply(this, args);
        }
    }

    return this;
};

Emitter.prototype.off = function (event, fn) {
    if (!this._events || arguments.length === 0) {
        this._events = {};
        return this;
    }

    // specific event
    var callbacks = this._events[event];
    if (!callbacks) {
        return this;
    }

    // remove all handlers
    if (arguments.length === 1) {
        delete this._events[event];
        return this;
    }

    // remove specific handler
    for (var i = 0; i < callbacks.length; i++) {
        var callback = callbacks[i];
        if (callback === fn) {
            callbacks.splice(i, 1);
            break;
        }
    }

    return this;
};

var MagoInit = function(container, options) {
    Emitter.call(this);
    this.version = Mago3D.VERSION;
    this.defaultOptions = {
        viewer: null,
        policyUrl: null,
        dataBaseUrl: null,
        imageBaseUrl: null,
        animation:false,
        timeline:false,
        fullscreenButton:false,
        init : function init() {}
    };
    this.container = container || "";
    this._managerFactory = null;
    this._policy = null;
    this._projectIdArray = [];
    this._projectDataArray = [];
    this._projectDataFolderArray = [];
    this.options = MagoInit.extend({}, this.defaultOptions, options != null ? options : {});
};

MagoInit.prototype = Object.create(Emitter.prototype);

MagoInit.prototype.constructor = MagoInit;

MagoInit.prototype.init = function () {
    // console.log("Mago3D Init...");

    this.on("started", function () {
        // console.log("Mago3D Started...");
    });

    this.on("finished", function () {
        // console.log("Mago3D finished...");
    });

    this.options.init.call(this);
};

MagoInit.prototype.start = function () {
    var that = this;
    this.init();
    this.emit("started");
    console.log("Mago3D Running...");
    var loadMago3DPolicy = Mago3D.loadWithXhr(this.options.policyUrl, undefined, undefined, 'json', 'GET');
    loadMago3DPolicy.then(function (_policy) {
        that.setPolicy(_policy);

        var loadData = [];
        var policy = that.getPolicy();
        var defaultProjectArray = policy.geo_data_default_projects || [];
        for(var i=0, len=defaultProjectArray.length; i<len; i++)
        {
            that._projectIdArray[i] = defaultProjectArray[i];
            loadData[i] = Mago3D.loadWithXhr(that.options.dataBaseUrl + defaultProjectArray[i], undefined, undefined, 'json', 'GET');
        }
    
        Promise.all(loadData).then(function (data) {
            // console.log(data);
            for(var i=0, len= data.length; i<len; i++)
            {
                that._projectDataArray[i] = data[i];
                that._projectDataFolderArray[i] = data[i].data_key;
            }
            var options = {};
            that._managerFactory = new Mago3D.ManagerFactory(that.options.viewer, that.container, policy, that._projectIdArray, that._projectDataArray, that._projectDataFolderArray, that.imageBaseUrl, that.options);
        }, function (err) {
            console.log(err);
        });
    });
  
    var timerId;
    var intervalCount = 0;
    var start = function () {
        return new Promise(function (resolve, reject) {
            timerId = setInterval(function () {
                intervalCount++;
                if(that._managerFactory != null && that._managerFactory.getMagoManagerState() === Mago3D.CODE.magoManagerState.READY)
                {
                    resolve();
                }
                // console.log("--------- intervalCount = " + intervalCount);
            }, 1000);
        });
    };

    start().then(function() {
        clearInterval(timerId);
        that.emit("finished");
    });
}

MagoInit.prototype.stop = function () {

};

MagoInit.prototype.getManagerFactory = function ()
{
    return this._managerFactory;
}

MagoInit.prototype.getPolicy = function () {
    return this._policy;
};

MagoInit.prototype.setPolicy = function (policy) {
    this._policy = MagoInit.extend({}, this._policy, policy != null ? policy : {});
};

MagoInit.extend = function (target) {
    for (var _len2 = arguments.length, objects = Array(_len2 > 1 ? _len2 - 1 : 0), _key2 = 1; _key2 < _len2; _key2++) {
        objects[_key2 - 1] = arguments[_key2];
    }

    for (var _iterator9 = objects, _isArray9 = true, _i9 = 0, _iterator9 = _isArray9 ? _iterator9 : _iterator9[Symbol.iterator](); ;) {
        var _ref8;

        if (_isArray9) {
            if (_i9 >= _iterator9.length) break;
            _ref8 = _iterator9[_i9++];
        } else {
            _i9 = _iterator9.next();
            if (_i9.done) break;
            _ref8 = _i9.value;
        }

        var object = _ref8;

        for (var key in object) {
            var val = object[key];
            target[key] = val;
        }
    }
    return target;
}

Mago3D['Mago3D'] = MagoInit;
