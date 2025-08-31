import QtQuick
import Quickshell
import Quickshell.Bluetooth
import qs.common
import ".."

BarItem {
    readonly property BluetoothAdapter adapter: Bluetooth.defaultAdapter
    function isConnected(devices) {
        for (const device of devices) {
            if (device.connected) {
                return true;
            }
        }
        return false;
    }
    function iconFromAdapterState(adapter) {
        if (!adapter.enabled) {
            return "󰂲";
        } else if (isConnected(adapter.devices.values)) {
            return "󰂱";
        } else {
            return "󰂯";
        }
    }
    Text {
        color: hovered ? Theme.colors.background : Theme.colors.text
        text: iconFromAdapterState(adapter)
        font {
            pixelSize: Theme.font.size.large
            family: Theme.font.family.nerd
        }
    }
}
