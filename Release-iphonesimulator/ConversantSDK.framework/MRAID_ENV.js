window.MRAID_ENV = {
    Version: '3.0',
    SDK: 'Conversant Mobile SDK',
    SDKVersion: '%@',
    bundle: '%@',
    IFA: '%@',
    LimitAdTracking: %@,
    COPPA: false
};

mraid = {
    state: "loading",
    getState: function() {
        return mraid.state;
    }
};
