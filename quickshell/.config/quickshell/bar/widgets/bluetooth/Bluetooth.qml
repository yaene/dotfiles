import QtQuick
import Quickshell
import Quickshell.Bluetooth
import Quickshell.Hyprland
import qs.common
import "../.."

Item {
    implicitWidth: barItem.implicitWidth

    BarItem {
        id: barItem

        readonly property BluetoothAdapter adapter: Bluetooth.defaultAdapter

        function iconFromAdapterState(adapter) {
            if (!adapter.enabled) {
                return "󰂲";
            } else if (isConnected(adapter.devices.values)) {
                return "󰂱";
            } else {
                return "󰂯";
            }
        }
        function isConnected(devices) {
            for (const device of devices) {
                if (device.connected) {
                    return true;
                }
            }
            return false;
        }

        anchors.centerIn: parent

        onPressed: bluetoothCtlLoader.item.visible = !bluetoothCtlLoader.item.visible

        Text {
            color: barItem.hovered ? Theme.colors.background : Theme.colors.text
            text: barItem.iconFromAdapterState(barItem.adapter)

            font {
                family: Theme.font.family.nerd
                pixelSize: Theme.font.size.large
            }
        }
    }
    LazyLoader {
        id: bluetoothCtlLoader

        loading: true
        source: "BluetoothCtl.qml"
    }
    GlobalShortcut {
        description: "Open simple bluetooth connection widget"
        name: "openBluetoothConnection"

        onPressed: bluetoothCtlLoader.item.show()
    }
}
