var CNVRBridge = {}
CNVRBridge.log = function(message) {
    window.webkit.messageHandlers.log.postMessage(message)
}
CNVRBridge.execute = function(command) {
    window.webkit.messageHandlers.execute.postMessage(command)
}

