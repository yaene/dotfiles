import QtQuick
import Quickshell
import QtQuick.Layouts
import Quickshell.Bluetooth
import qs.common

StyledPopup {
    id: root

    property BluetoothAdapter adapter: Bluetooth.defaultAdapter

    child: btList

    onVisibleChanged: {
        if (visible) {
            adapter.discovering = true;
        } else {
            adapter.discovering = false;
        }
    }

    // List of networks
    StyledSelectList {
        id: btList

        headerHeight: 48
        implicitWidth: 600
        model: root.adapter.devices.values

        delegate: BluetoothDeviceItem {
            id: btDevice

            required property int index
            required property BluetoothDevice modelData

            function get_bg_color() {
                return btList.currentIndex === index ? get_border_color() : Theme.colors.background;
            }
            function get_border_color() {
                return modelData.connected ? Theme.colors.active : btList.currentIndex === index ? Theme.colors.selected : Theme.colors.text;
            }
            function get_text_color(col = Theme.colors.text) {
                return btList.currentIndex === index ? Theme.colors.background : col;
            }

            border.color: get_border_color()
            color: get_bg_color()
            device: modelData
            textColor: btDevice.get_text_color()
            width: btList.width
        }
        header: StyledListHeader {
            RowLayout {
                anchors.fill: parent
                spacing: 20

                Text {
                    Layout.fillWidth: true
                    Layout.leftMargin: 80
                    color: Theme.colors.text
                    font.bold: true
                    font.pixelSize: Theme.font.size.large
                    text: "Name"
                }
                Text {
                    Layout.alignment: Qt.AlignRight
                    color: Theme.colors.text
                    font.italic: true
                    padding: 20
                    text: root.adapter.discovering ? "Scanning..." : adapter.devices.length === 0 ? "No devices found" : ""
                }
            }
        }

        onSelected: device => {
            if (device.connected) {
                device.disconnect();
            } else {
                device.connect();
            }
        }
    }
}
