import QtQuick
import Quickshell
import Quickshell.Bluetooth
import qs.common
import qs.services
import ".."

BarItem {
    readonly property BluetoothAdapter adapter: Bluetooth.defaultAdapter

    function iconFromWlanSignalStrength(signalStrength) {
        return NetworkService.ethernet ? "" : !NetworkService.wlan ? "󰤮" : signalStrength >= -60 ? "󰤨" : signalStrength >= -67 ? "󰤥" : signalStrength >= -75 ? "󰤢" : "󰤟";
    }

    Text {
        color: hovered ? Theme.colors.background : Theme.colors.text
        text: iconFromWlanSignalStrength(NetworkService.networkStrength)

        font {
            family: Theme.font.family.nerd
            pixelSize: Theme.font.size.large
        }
    }
}
