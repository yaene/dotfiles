import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets
import qs.services
import qs.common

Scope {
    id: root

    function hideVolume() {
        osdVolume.hide();
    }
    function muteToggle() {
        osdMute.show();
    }
    function showVolume() {
        osdVolume.show();
    }

    Connections {
        function onMutedChanged() {
            muteToggle();
        }
        function onVolumeChanged() {
            showVolume();
        }

        target: AudioService.sink.audio
    }
    OsdPopup {
        id: osdVolume

        leftLabel: ""
        percentage: AudioService.sink.audio.volume * 100
        rightLabel: ""
    }
    OsdPopup {
        id: osdMute

        Item {
            anchors.fill: parent

            Text {
                anchors.centerIn: parent
                color: Theme.colors.text
                font.pixelSize: 60
                text: AudioService.sink.audio.muted ? "󰝟" : "󰕾"
            }
        }
    }
    GlobalShortcut {
        description: "Shows Volume On-Screen Display"
        name: "osdVolumeShow"

        onPressed: showVolume()
    }
    GlobalShortcut {
        description: "Shows Volume On-Screen Display"
        name: "osdVolumeHide"

        onPressed: hideVolume()
    }
}
