import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.services
import qs.common

Variants {
    model: Quickshell.screens

    Item {
        id: root

        required property ShellScreen modelData
        property BrightnessService.Monitor monitor: monitors.find(m => m.modelData === modelData)
        property var monitors: BrightnessService.monitors

        OsdPopup {
            id: osd

            leftLabel: "󰃞"
            rightLabel: "󰃠"
            screen: modelData
        }
        Connections {
            function onBrightnessChanged() {
                osd.show();
                osd.percentage = root.monitor.brightness * 100;
            }

            target: root.monitor
        }
    }
}
