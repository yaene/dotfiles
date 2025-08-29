pragma Singleton

import Quickshell

Singleton {
    function urlStripProtocol(url) {
        const parts = url.split("//");
        return parts.length > 1 ? parts[1] : parts[0];
    }
}
