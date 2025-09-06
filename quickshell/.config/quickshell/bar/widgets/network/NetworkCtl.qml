import QtQuick
import Quickshell
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Widgets
import qs.services
import qs.common

StyledPopup {
    id: root

    readonly property bool askPassword: NetworkService.askPassword
    property string connectingSSID: ""
    property string connectionError: ""
    property string failedSSID: ""

    child: wifiList

    onVisibleChanged: {
        if (visible) {
            NetworkService.triggerScan();
        } else {
            connectionError = "";
            failedSSID = "";
        }
    }

    // List of networks
    StyledSelectList {
        id: wifiList

        headerHeight: 48
        implicitWidth: 600
        model: NetworkService.availableNetworks

        delegate: StyledSelectItem {
            id: network

            required property int index
            required property int signalStrength
            required property string ssid
            required property string type

            function get_bg_color() {
                return wifiList.currentIndex === index ? get_border_color() : Theme.colors.background;
            }
            function get_border_color() {
                if (root.failedSSID === ssid) {
                    return Theme.colors.danger;
                }
                return NetworkService.connectedSSID === ssid ? Theme.colors.warning : Theme.colors.text;
            }
            function get_text_color(col = Theme.colors.text) {
                return wifiList.currentIndex === index ? Theme.colors.background : col;
            }

            border.color: get_border_color()
            color: get_bg_color()
            width: wifiList.width

            Text {
                Layout.preferredWidth: 30
                color: network.get_text_color()
                font.family: Theme.font.family.nerd
                font.pixelSize: Theme.font.size.large
                text: Utils.iconFromWlanSignalStrength(network.signalStrength)
            }
            Text {
                Layout.fillWidth: true
                color: network.get_text_color()
                elide: Text.ElideRight
                font.family: Theme.font.family.nerd
                font.pixelSize: Theme.font.size.medium
                text: network.ssid
            }
            Text {
                color: network.get_text_color(Theme.colors.danger)
                font.italic: true
                font.pixelSize: Theme.font.size.small
                text: root.connectionError
                verticalAlignment: Text.AlignVCenter
                visible: network.ssid === root.failedSSID
            }
            Text {
                color: network.get_text_color()
                font.italic: true
                font.pixelSize: Theme.font.size.small
                text: "Connecting..."
                verticalAlignment: Text.AlignVCenter
                visible: network.ssid === root.connectingSSID
            }
        }
        header: StyledListHeader {
            RowLayout {
                anchors.fill: parent
                spacing: 20

                Text {
                    color: Theme.colors.text
                    font.bold: true
                    font.pixelSize: Theme.font.size.large
                    text: "Signal"
                }
                Text {
                    Layout.fillWidth: true
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
                    text: NetworkService.scanning ? "Scanning..." : NetworkService.availableNetworks.length === 0 ? "No networks found" : ""
                }
            }
        }

        onSelected: network => {
            root.failedSSID = "";
            root.connectingSSID = network.ssid;
            NetworkService.connect(network.ssid);
        }
    }
    Connections {
        function onConnectionResult(ssid, error) {
            root.connectingSSID = "";
            if (error) {
                root.failedSSID = ssid;
            }
            root.connectionError = error;
        }

        target: NetworkService
    }
    Dialog {
        id: enterPasswordDialog

        property string inputPassword: ""

        anchors.centerIn: parent
        modal: true
        standardButtons: Dialog.Ok | Dialog.Cancel
        title: "Enter Wi-Fi Password"
        visible: root.askPassword

        onAccepted: {
            NetworkService.submitPassword(enterPasswordDialog.inputPassword);
            enterPasswordDialog.inputPassword = "";
        }
        onRejected: {
            root.connectingSSID = "";
            NetworkService.askPassword = false;
            enterPasswordDialog.inputPassword = "";
        }
        onVisibleChanged: {
            if (visible) {
                passwordField.forceActiveFocus();
            } else {
                wifiList.forceActiveFocus();
            }
        }

        Column {
            spacing: 10

            Text {
                color: Theme.colors.text
                text: "Password for: " + root.connectingSSID
                wrapMode: Text.WordWrap
            }
            TextField {
                id: passwordField

                anchors.horizontalCenter: parent.horizontalCenter
                echoMode: TextInput.Password
                placeholderText: "Wi-Fi Password"
                text: enterPasswordDialog.inputPassword
                width: 220

                Keys.onReturnPressed: {
                    enterPasswordDialog.accept();
                }
                onTextChanged: enterPasswordDialog.inputPassword = text
            }
        }
    }
}
