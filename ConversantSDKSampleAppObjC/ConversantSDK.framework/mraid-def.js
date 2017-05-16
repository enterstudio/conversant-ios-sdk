var mraiddef = {
   "methods": [{
      "name": "getVersion",
      "type": "method",
      "desc": "Ad checks the version of the MRAID implementation that the host is using.",
      "supported": true,
      "test": "getVersion",
      "expect": "3.0",
		"result":""
   }, {
      "name": "addEventListener",
      "type": "method",
      "desc": "Ad registers a listener for a specified event",
      "supported": true,
      "test": "addEventListener",
      "args": [
         "ready",
         function(arg) { updateResult('addEventListener', arg, 'Callback called'); }
      ],
      "expect": true,
		"result":""
   }, {
      "name": "removeEventListener",
      "type": "method",
      "desc": "Ad removes a listener for a specified event",
      "supported": true,
      "test": "removeEventListener",
      "args": [
         "ready"
      ],
      "expect": true,
		"result":""
   }, {
      "name": "open",
      "type": "method",
      "desc": "Ad specifies a URL to be opened in a new webview",
      "supported": true,
      "test": "open",
      "expect": true,
		"result":""
   }, {
      "name": "close",
      "type": "method",
      "desc": "Ad calls to downgrade the state ad container",
      "supported": true,
      "test": "close",
      "expect": true,
		"result":""
   }, {
      "name": "useCustomClose",
      "type": "method",
      "desc": "Ad specifies a custom graphic to use in place of the host-provided default close graphic",
      "supported": true,
      "test": "useCustomClose",
      "args": [ false ],
      "expect": false,
		"result":""
   }, {
      "name": "expand",
      "type": "method",
      "desc": "Ad requests ad container expansion",
      "supported": true,
      "test": "expand",
      "expect": true,
		"result":""
   }, {
      "name": "isViewable*",
      "type": "method",
      "desc": "Ad queries the host about the on-screen result of the ad container",
      "supported": true,
      "test": "isViewable",
      "expect": cnvr.state.isViewable,
		"result":""
   }, {
      "name": "playVideo",
      "type": "method",
      "desc": "Ad requests video play in native player",
      "supported": true,
      "test": "",
      "expect": true,
		"result":""
   }, {
      "name": "resize",
      "type": "method",
      "desc": "Ad requests ad container size change to accommodate new ad size",
      "supported": true,
      "test": "",
      "expect": true,
		"result":""
   }, {
      "name": "storePicture",
      "type": "method",
      "desc": "Ad requests prompt to user about storing a picture on the device",
      "supported": false,
      "test": "",
      "expect": true,
		"result":""
   }, {
      "name": "createCalendarEvent",
      "type": "method",
      "desc": "Ad request prompt to the user for adding an event to the device calendar",
      "supported": false,
      "test": "",
      "expect": true,
		"result":""
   }],
   "properties": [{
      "name": "supports",
      "type": "property",
      "desc": "Ad requests details on features the host supports",
      "supported": true,
      "test": "",
      "expect": true,
		"result":""
   }, {
      "name": "getPlacementType",
      "type": "property",
      "desc": "Ad requests confirmation of either an inline or interstitial placement",
      "supported": true,
      "test": "",
      "expect": "inline",
		"result":""
   }, {
      "name": "setOrientationProperties",
      "type": "property",
      "desc": "Ad specifies preferences for allowing or locking orientation, if supported, for ad display",
      "supported": true,
      "test": "setOrientationProperties",
      "expect": cnvr.state.getOrientationProperties,
		"result":""
   }, {
      "name": "getOrientationProperties",
      "type": "property",
      "desc": "Ad requests details on landscape or portrait orientation",
      "supported": true,
      "test": "getOrientationProperties",
      "expect": cnvr.state.getOrientationProperties,
		"result":""
   },  {
      "name": "getCurrentAppOrientation",
      "type": "property",
      "desc": "Ad requests current orientation of the app",
      "supported": true,
      "test": "getCurrentAppOrientation",
      "expect": cnvr.state.getCurrentAppOrientation,
		"result":""
   }, {
      "name": "getCurrentPosition",
      "type": "property",
      "desc": "Ad requests current coordinates of the ad container",
      "supported": true,
      "test": "getCurrentPosition",
      "expect": cnvr.state.getCurrentPosition,
		"result":""
   }, {
      "name": "getDefaultPosition",
      "type": "property",
      "desc": "Ad requests default coordinates of the ad container",
      "supported": true,
      "test": "getDefaultPosition",
      "expect": cnvr.state.getDefaultPosition,
		"result":""
   }, {
      "name": "getState",
      "type": "property",
      "desc": "Ad requests current state of the ad container: loading, default, expanded, resized, hidden",
      "supported": true,
      "test": "getState",
      "expect": "loading",
		"result":""
   }, {
      "name": "setExpandProperties",
      "type": "property",
      "desc": "Ad specifies new expand properties",
      "supported": true,
      "test": "setExpandProperties",
      "args": [
         { 
            "width": 640,
            "height": 800,
            "useCustomClose": false,
            "isModal": false
         }
      ],
      "expect": { 
         "width": 640,
         "height": 800,
         "useCustomClose": false,
         "isModal": false
      },
		"result":""
   }, {
      "name": "getExpandProperties",
      "type": "property",
      "desc": "Ad requests current expand properties",
      "supported": true,
      "test": "getExpandProperties",
      "expect": { 
         "width": 640,
         "height": 800,
         "useCustomClose": false,
         "isModal": false
      },
		"result":""
   }, {
      "name": "getMaxSize",
      "type": "property",
      "desc": "Ad request max ad container dimensions available",
      "supported": true,
      "test": "",
      "expect": {"width":window.screen.width,"height":window.screen.height},
		"result":""
   }, {
      "name": "getScreenSize",
      "type": "property",
      "desc": "Ad requests dimensions of device screen",
      "supported": true,
      "test": "getScreenSize",
      "expect": {"width":window.screen.width,"height":window.screen.height},
		"result":""
   }, {
      "name": "setResizeProperties",
      "type": "property",
      "desc": "Ad specifies dimensions for resizing the ad container",
      "supported": true,
      "test": "",
      "expect": true,
		"result":""
   }, {
      "name": "getResizeProperties",
      "type": "property",
      "desc": "Ad requests current dimensions of the ad container in its resized state",
      "supported": true,
      "test": "",
      "expect": true,
		"result":""
   }, {
      "name": "getLocation",
      "type": "property",
      "desc": "Ad requests current coordinates of the device",
      "supported": true,
      "test": "",
      "expect": true,
		"result":""
   }],
   "events": [{
      "name": "error",
      "type": "event",
      "desc": "Host reports an error",
      "supported": true,
      "test": "addEventListener",
      "args": [
         "error",
         function(arg) { updateResult('error', arg); }
      ],
      "expect": true,
		"result":""
   }, {
      "name": "ready",
      "type": "event",
      "desc": "Host reports that MRAID libraries are loaded",
      "supported": true,
      "test": "addEventListener",
      "args": [
         "ready",
         function(arg) { updateResult('ready', arg); }
      ],
      "expect": true,
		"result":""
   }, {
      "name": "sizeChange",
      "type": "event",
      "desc": "Host reports that ad container dimensions have changed",
      "supported": true,
      "test": "addEventListener",
      "args": [
         "sizeChange",
         function(arg) { updateResult('sizeChange', arg); }
      ],
      "expect": true,
		"result":""
   }, {
      "name": "stateChange",
      "type": "event",
      "desc": "Host reports that the state of the ad container has changed",
      "supported": true,
      "test": "addEventListener",
      "args": [
         "stateChange",
         function(arg) { updateResult('stateChange', arg); }
      ],
      "expect": true,
		"result":""
   }, {
      "name": "exposureChange",
      "type": "event",
      "desc": "Host reports that the percentage of ad container exposure has changed",
      "supported": true,
      "test": "addEventListener",
      "args": [
         "exposureChange",
         function(arg) { updateResult('exposureChange', arg); }
      ],
      "expect": true,
		"result":""
   }, {
      "name": "audioVolumeChange",
      "type": "event",
      "desc": "Host reports a change in volume",
      "supported": true,
      "test": "addEventListener",
      "args": [
         "audioVolumeChange",
         function(arg) { updateResult('audioVolumeChange', arg); }
      ],
      "expect": true,
		"result":""
   }, {
      "name": "adAction",
      "type": "event",
      "desc": "Host reports a user-initiated action",
      "supported": true,
      "test": "addEventListener",
      "args": [
         "adAction",
         function(arg) { updateResult('adAction', arg); }
      ],
      "expect": true,
		"result":""
   }, {
      "name": "viewableChange",
      "type": "event",
      "desc": "Host reports a change in ad container viewability",
      "deprecated": true,
      "supported": true,
      "test": "addEventListener",
      "args": [
         "viewableChange",
         function(arg) { updateResult('viewableChange', arg); }
      ],
      "expect": mraid.events.viewableChange[mraid.events.viewableChange.length-1],
		"result":""
   }]
}
