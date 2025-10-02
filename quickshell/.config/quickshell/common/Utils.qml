pragma Singleton

import Quickshell
import Quickshell.Hyprland

Singleton {
    function getActiveScreen() {
        for (let screen of Quickshell.screens) {
            if (screen.name === Hyprland.focusedMonitor?.name) {
                return screen;
            }
        }
        return null;
    }
    function iconFromWlanSignalStrength(signalStrength) {
        return signalStrength >= -60 ? "󰤨" : signalStrength >= -67 ? "󰤥" : signalStrength >= -75 ? "󰤢" : "󰤟";
    }
    function iconUrlFromTrayIcon(icon) {
        const parts = icon.split("?path=");
        if (parts.length > 1) {
            console.log(parts[1] + "/" + parts[0]);
            return Qt.resolvedUrl(parts[1] + "/" + parts[0].split("/").pop());
        }
        return Qt.resolvedUrl(icon);
    }
    function urlStripProtocol(url) {
        const parts = url.split("//");
        return parts.length > 1 ? parts[1] : parts[0];
    }
}
