import QtQuick
import Quickshell
import Quickshell.Bluetooth
import Quickshell.Hyprland
import qs.common
import "../.."

Item {
    id: root

    property QsWindow barWindow

    implicitHeight: barItem.implicitHeight
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

        onPressed: bluetoothCtlLoader.item.show()

        Text {
            color: barItem.hovered ? Theme.colors.background : Theme.colors.text
            text: barItem.iconFromAdapterState(barItem.adapter)

            font {
                family: Theme.font.family.nerd
                pixelSize: Config.bar.iconSize
            }
        }
    }
    LazyLoader {
        id: bluetoothCtlLoader

        loading: true

        BluetoothCtl {
        }
    }
    GlobalShortcut {
        description: "Open simple bluetooth connection widget"
        name: "openBluetoothConnection"

        onPressed: {
            if (root.barWindow.screen === Utils.getActiveScreen()) {
                bluetoothCtlLoader.item.show();
            }
        }
    }
}
