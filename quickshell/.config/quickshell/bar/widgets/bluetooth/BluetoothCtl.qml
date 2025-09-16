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

            function get_text_color() {
                return selected ? Theme.colors.background : Theme.colors.text;
            }

            active: modelData.connected
            device: modelData
            selected: btList.currentIndex === index
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
