import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.services
import qs.common

Scope {
    id: root

    function hideBrightness() {
        osd.hide();
    }
    function showBrightness() {
        osd.show();
    }

    Connections {
        function onBrightnessChanged() {
            showBrightness();
        }

        target: BrightnessService
    }
    OsdPopup {
        id: osd

        leftLabel: "󰃞"
        percentage: BrightnessService.brightness
        rightLabel: "󰃠"
    }
    GlobalShortcut {
        description: "Shows Brightness On-Screen Display"
        name: "osdBrightnessShow"

        onPressed: showBrightness()
    }
    GlobalShortcut {
        description: "Shows Brightness On-Screen Display"
        name: "osdBrightnessHide"

        onPressed: hideBrightness()
    }
}
