import qs.common
import Quickshell.Bluetooth
import QtQuick
import QtQuick.Layouts
import Quickshell

StyledSelectItem {
    id: dev

    required property BluetoothDevice device
    property string textColor: Theme.colors.text

    function getBluetoothDeviceIcon(systemIcon) {
        if (systemIcon.includes("headset") || systemIcon.includes("headphones"))
            return "";
        if (systemIcon.includes("audio"))
            return "";
        if (systemIcon.includes("phone"))
            return "";
        if (systemIcon.includes("mouse"))
            return "󰍽";
        if (systemIcon.includes("keyboard"))
            return "󰌌";
        return "󰂯";
    }

    Keys.onPressed: event => {
        if (event.key === Qt.Key_F) {
            if (device.paired) {
                device.forget();
            }
        } else if (event.key === Qt.Key_P) {
            if (!device.paired) {
                device.pair();
            }
        }
    }

    Text {
        Layout.preferredWidth: 30
        color: textColor
        font.family: Theme.font.family.nerd
        font.pixelSize: Theme.font.size.large
        text: dev.getBluetoothDeviceIcon(device.icon)
    }
    Text {
        Layout.fillWidth: true
        color: textColor
        elide: Text.ElideRight
        font.family: Theme.font.family.primary
        font.pixelSize: Theme.font.size.medium
        text: device.name
    }
    Text {
        color: textColor
        font.italic: true
        font.pixelSize: Theme.font.size.small
        text: device.paired ? "" : " "
        verticalAlignment: Text.AlignVCenter
    }
    Text {
        color: textColor
        font.italic: true
        font.pixelSize: Theme.font.size.small
        text: BluetoothDeviceState.toString(device.state)
        verticalAlignment: Text.AlignVCenter
    }
}
