(function(win) {
    var mraid = win.mraid = {
    version: "3.0",
    getVersion: function() {
        cnvr.log("mraid.getVersion called");
        return mraid.version;
    },
    events: {},
    addEventListener: function(eventName, callback) {
        cnvr.log("mraid.addEventListener:" + eventName );
        mraid.events[eventName].push(callback);
        return true;
    },
    removeEventListener: function(eventName, listener) {
        cnvr.log("mraid.removeEventListener: " + eventName + " (args:" + JSON.stringify(listener) + ")");
        for (var i=0; i<mraid.events[eventName].length; i++) {
            if (!listener || (mraid.events[eventName][i] === listener)) {
                mraid.events[eventName].splice(i, 1);
            }
        }
        return true;
    },
    dispatchEvent: function(eventName,args) {
        cnvr.log("mraid.dispatchEvent: " + eventName + " (args:" + JSON.stringify(args)+")");
        
        var allargs = (arguments.length === 1 ? [arguments[0]] : Array.apply(null, arguments));
        evnt = allargs.shift();
        
        if ((mraid.events[eventName] && mraid.events[eventName].length>0)) {
            for (var i=0; i<mraid.events[eventName].length; i++) {
                cnvr.log("mraid.dispatchEvent: executing " + mraid.events[eventName][i].toString());
                mraid.events[eventName][i].apply(this, allargs);
            }
        }
        return true;
    },
    expand: function() {
        cnvr.log("mraid.expand called");
        cnvr.sendMessage({"function":"expand", "payload":cnvr.state.getExpandProperties});
        return true;
    },
    resize: function() {
        cnvr.log("mraid.resize called");
        if (cnvr.internalVars.didSetResizeProperties) {
            cnvr.sendMessage({"function":"resize", "payload":cnvr.state.getResizeProperties});
            return true;
        } else {
            mraid.dispatchEvent("error", "You must set resize properties before calling resize()");
            return false;
        }
    },
    open: function(url) {
        cnvr.log("mraid.open called");
        cnvr.sendMessage({"function":"open", "payload":url});
        return true;
    },
    close: function() {
        cnvr.log("mraid.close called");
        cnvr.sendMessage({"function":"close"});
        return true;
    },
        
    useCustomClose: function(state) {
        //stored in getExpand Properties!
        cnvr.log("mraid.useCustomClose set to " + state);
        if (typeof cnvr.state.getExpandProperties.useCustomClose !== "undefined") {
            cnvr.state.getExpandProperties.useCustomClose = cnvr.state.getExpandProperties.useCustomClose.constructor(state);
        }
        cnvr.sendMessage({"function":"useCustomClose","payload":cnvr.state.getExpandProperties.useCustomClose});
        return cnvr.state.getExpandProperties.useCustomClose;
    },
        
    playVideo: function(url) {
        cnvr.log("mraid.playVideo called for url: " + url);
        cnvr.sendMessage({"function":"playVideo", "payload": url});
        return true;
    },
        
    getScreenSize: function() {
        cnvr.log("mraid.getScreenSize called");
        return cnvr.state.getScreenSize;
    },
        
    getMaxSize: function() {
        cnvr.log("mraid.getMaxSize called");
        return cnvr.state.getMaxSize;
    },
        
    getState: function() {
        cnvr.log("mraid.getState called");
        
        if (!cnvr.state.getState) {
            return "loading";
        } else {
            return cnvr.state.getState;
        }
    },
        
    getPlacementType: function() {
        cnvr.log("mraid.getPlacementType called");
        return cnvr.state.getPlacementType;
    },
        
    getCurrentPosition: function() {
        cnvr.log("mraid.getCurrentPosition called.");
        console.dir(cnvr.state.getCurrentPosition);
        return cnvr.state.getCurrentPosition;
    },
        
    getDefaultPosition: function() {
        cnvr.log("mraid.getDefaultPosition called");
        return cnvr.state.getDefaultPosition;
    },
        
    getExpandProperties: function() {
        cnvr.log("mraid.getExpandProperties called");
        return cnvr.state.getExpandProperties;
    },
        
    getOrientationProperties: function() {
        cnvr.log("mraid.getOrientationProperties called");
        return cnvr.state.getOrientationProperties;
    },
        
    getCurrentAppOrientation: function() {
        cnvr.log("mraid.getCurrentAppOrientation called");
        return cnvr.state.getCurrentAppOrientation;
    },
        
    getResizeProperties: function() {
        cnvr.log("mraid.getResizeProperties called");
        return cnvr.state.getResizeProperties;
    },
        
    setExpandProperties: function(obj) {
        cnvr.log("mraid.setExpandProperties called");
        //cnvr.sendMessage({"function":"setExpandProperties","payload":obj});
        
        for (var key in obj) {
            if (typeof cnvr.state.getExpandProperties[key] !== "undefined") {
                cnvr.state.getExpandProperties[key] = cnvr.state.getExpandProperties[key].constructor(obj[key]);
            }
        }
        return cnvr.state.getExpandProperties;
    },
        
    setOrientationProperties: function(obj) {
        cnvr.log("mraid.setOrientationProperties called");
        cnvr.sendMessage({"function":"setOrientationProperties","payload":obj});
        
        for (var key in obj) {
            if (typeof cnvr.state.getOrientationProperties[key] !== "undefined") {
                cnvr.state.getOrientationProperties[key] = cnvr.state.getOrientationProperties[key].constructor(obj[key]);
            }
        }
        return cnvr.state.getOrientationProperties;
    },
        
    setResizeProperties: function(obj) {
        cnvr.log("mraid.setResizeProperties called with " + obj);
        
        if (typeof obj["allowOffscreen"] === "string" && obj["allowOffscreen"].toLowerCase() == "false") {
            obj ["allowOffscreen"] = false
        }
        var cleanedObj = {};
        //cnvr.sendMessage({"function":"setResizeProperties", "payload":obj});
        for (var key in obj) {
            if (typeof cnvr.state.getResizeProperties[key] !== "undefined") {
                cleanedObj[key] = cnvr.state.getResizeProperties[key].constructor(obj[key]);
            }
        }
        var requiredParams = ["width","height","offsetX","offsetY"];
        var arrayLength = requiredParams.length;
        for (var i = 0; i < arrayLength; i++) {
            if (typeof cleanedObj[requiredParams[i]] === "undefined") {
                mraid.dispatchEvent("error","setResizeProperties must include width,height, offsetX, and OffsetY");
                return
                break;
            }
        }
        if (typeof cleanedObj["customClosePosition"] === "string") {
            var allowedCustomClosePositions = ["top-left","top-center","top-right","bottom-left","bottom-center","bottom-right","center"];
            arrayLength = allowedCustomClosePositions.length;
            var found = false
            for (var i = 0; i < arrayLength; i++) {
                if (cleanedObj["customClosePosition"] == allowedCustomClosePositions[i]) {
                    found = true;
                    break;
                }
            }
            if (!found) {
                mraid.dispatchEvent("error","setResizeProperties customClosePosition is not an allowed value.");
                delete cleanedObj["customClosePosition"];
            }
        }
        for (var key in cleanedObj) {
            cnvr.state.getResizeProperties[key] = cleanedObj[key];
        }
        cnvr.internalVars.didSetResizeProperties = true;
        return cnvr.state.getResizeProperties;
    },
        
    isViewable: function() {
        cnvr.log("mraid.isViewable called. Returned: "+cnvr.state.isViewable);
        return cnvr.state.isViewable;
    },
        
    supports: function(item) {
        cnvr.log("mraid.supports called. Checking for support: " + item + " (" + cnvr.state.supports[item] + ")");
        return cnvr.state.supports[item];;
    },
        
    exposureChange: function(exposed) {
        cnvr.state.exposure = exposed;
        mraid.dispatchEvent("exposureChange", exposed);
        
        if ((exposed>=50) && (!cnvr.state.isViewable)) {
            cnvr.state.isViewable = true;
            mraid.dispatchEvent("viewableChange", true);
        } else if ((exposed<50) && (cnvr.state.isViewable)) {
            cnvr.state.isViewable = false;
            mraid.dispatchEvent("viewableChange", false);
        }
        return true;
    },
        
    getLocation: function() {
       /* if ("geolocation" in navigator) {
            navigator.geolocation.getCurrentPosition(function(position) {
                cnvr.state.getLocation.lat = position.coords.latitude;
                cnvr.state.getLocation.lon = position.coords.longitude;
                cnvr.state.getLocation.method = "cell";
                cnvr.state.getLocation.time = position.timestamp;
                cnvr.log("getLocation: position received: ", cnvr.state.getLocation );
            }, function(err) {
                cnvr.log("[ERROR] getLocation: unable to acquire position.", err);
            }, {"timeout": 5000, "maximumAge": 60000});
        }*/
        return cnvr.state.getLocation;
    }
    };
    
    var cnvr = window.cnvr = {
    state: {
    getDefaultPosition: {x:0, y:0, width:0, height:0},
    getCurrentPosition: {x:0, y:0, width:0, height:0},
    currentSize: {width:0,height:0},
    getMaxSize: { width: window.screen.width, height: window.screen.height },
    getScreenSize: { width: window.screen.width, height: window.screen.height },
    getCurrentAppOrientation: { orientation:"portrait", locked:false},
    getOrientationProperties: { allowOrientationChange: true, forceOrientation: "none"},
    getExpandProperties: { width:0, height:0, useCustomClose:false },
    getResizeProperties: { width:0, height:0, offsetX:0, offsetY:0, customClosePosition:"top-right", allowOffscreen:false },
    getPlacementType: "inline",
    getState: "loading",
    exposure: 0,
    isViewable: false,
    supports: {sms:false,tel:false,calendar:false,storePicture:false,inlineVideo:false,vpaid:false,location:false},
    getLocation: { lat:0, lon:0, method:"" }
    },
    internalVars: {
    didSetResizeProperties:false
    },
    sendMessage: function(msg) {
        cnvr.log("Sending msg to controller: " + JSON.stringify(msg));
        var obj = (typeof msg=="string") ? JSON.parse(msg) : msg;
        CNVRBridge.execute(obj);
    },
    receiveMessage: function(msg) {
            var obj = (typeof(msg)==="string") ? JSON.parse(msg) : msg;
            cnvr.log("Received message: " + JSON.stringify(obj.payload));
            
            if (typeof cnvr[obj.function] == 'function') {
                cnvr[obj.function](obj.payload)
            } else if (obj.function === "event") {
                mraid.dispatchEvent(obj.payload);
            } else {
                cnvr.state[msg.function] = msg.payload;
            }
        },
    events: [],
    init: function() {
        cnvr.log("init() called.");
        cnvr.sendMessage({"function":"documentLoaded","payload":""});
        
        // Create dummy MRAID events for listening and dispatching
        var eventNames = ["ready", "error", "stateChange", "viewableChange", "sizeChange", "exposureChange", "audioVolumeChange", "stateChange", "adAction"],
        events = {};
        
        eventNames.forEach(function(el, idx, arr) {
            mraid.events[el] = [];
            //            mraid.addEventListener(el, function(arg) { console.log("MRAID Event dispatched: " + el + " (args: " + JSON.stringify(arg) + ")"); });
        });
    },
    log: function(msg, obj) {
        console.log("[Client] " + msg);
        CNVRBridge.log("[Client] " + msg);
        if (obj) {
            console.dir(obj);
        }
    },
    sync: function(data) {
        this.log("Syncing mraid method values to creative");
        for (var key in data) {
            if (data.hasOwnProperty(key)) {
                this.log("set 'mraid." + key + "' to: " + data[key] + " was: " + cnvr.state[key]);
                
                cnvr.state[key] = data[key];
            }
        }
    },
    mraidReady: function(data) {
        cnvr.state.getState = "ready";
        cnvr.log("MRAID ready state set to 'ready'");
        mraid.dispatchEvent("ready");
    },
    exposureChange: function(data) {
        mraid.exposureChange(data)
    },
        
    setState: function(state) {
        cnvr.log("mraid.setState called with state");
        
        if (cnvr.state.getState != state) {
            cnvr.state.getState = state
            mraid.dispatchEvent("stateChange", state);
        }
    },
    setCurrentPosition: function(payload) {
        cnvr.log("mraid.setState called with state");
        var newSize = {"width":payload.width, "height":payload.height};
        cnvr.state.getCurrentPosition = payload;
        if (newSize != cnvr.state.currentSize)  {
            mraid.dispatchEvent("sizeChange", payload.width, payload.height);
            currentSize = newSize;
        }
    },
    hostDispatchEvent: function(payload) {
        mraid.dispatchEvent(payload.event, payload.args)
    },
    hostError: function(payload) {
        mraid.dispatchEvent("error", payload);
    },
    setCurrentAppOrientation: function(payload) {
        cnvr.state.getCurrentAppOrientation = payload;
    },
    setLocation: function(payload) {
        cnvr.log("setLocation");
        cnvr.state.getLocation = payload;
    }
    };
    
    cnvr.init();
    
    window.addEventListener("message", cnvr.receiveMessage, false);
    
    
})(window);
 
