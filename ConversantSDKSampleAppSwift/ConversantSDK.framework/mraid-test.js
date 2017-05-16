var sendMessage = function(msg) {
    var obj = JSON.parse(msg);
    CNVRBridge.execute(obj);
}
sendMessage('{"function":"documentLoaded","payload":""}');
