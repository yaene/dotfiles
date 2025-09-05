pragma Singleton

import Quickshell

Singleton {
    function iconFromWlanSignalStrength(signalStrength) {
        return signalStrength >= -60 ? "󰤨" : signalStrength >= -67 ? "󰤥" : signalStrength >= -75 ? "󰤢" : "󰤟";
    }
    function urlStripProtocol(url) {
        const parts = url.split("//");
        return parts.length > 1 ? parts[1] : parts[0];
    }
}
