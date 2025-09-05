import QtQuick
import Quickshell
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Hyprland
import Quickshell.Widgets
import qs.services
import qs.common

PanelWindow {
    id: root

    readonly property bool askPassword: NetworkService.askPassword
    property string connectingSSID: ""
    property string connectionError: ""
    property string failedSSID: ""

    color: "transparent"
    focusable: true

    onVisibleChanged: {
        if (visible) {
            NetworkService.triggerScan();
        } else {
            connectionError = "";
            failedSSID = "";
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
    anchors {
        bottom: true
        left: true
        right: true
        top: true
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
    ClippingWrapperRectangle {
        id: container

        anchors.centerIn: parent
        color: Theme.colors.background
        implicitHeight: Math.min(800, wifiList.contentHeight + 48)
        implicitWidth: 600
        radius: 8

        // List of networks
        ListView {
            id: wifiList

            anchors.fill: parent
            anchors.margins: 18
            clip: true
            focus: true
            keyNavigationWraps: true
            model: NetworkService.availableNetworks
            spacing: 10

            delegate: Rectangle {
                id: network

                property bool hovered: false
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

                border.color: get_border_color()
                border.width: 1
                color: get_bg_color()
                implicitHeight: contentRow.implicitHeight + 20
                radius: 8
                width: wifiList.width

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: parent.hovered = true
                    onExited: parent.hovered = false
                }
                RowLayout {
                    id: contentRow

                    function get_text_color(col = Theme.colors.text) {
                        return wifiList.currentIndex === index ? Theme.colors.background : col;
                    }

                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 45

                    Text {
                        Layout.preferredWidth: 30
                        color: contentRow.get_text_color()
                        font.family: Theme.font.family.nerd
                        font.pixelSize: Theme.font.size.large
                        text: Utils.iconFromWlanSignalStrength(network.signalStrength)
                    }
                    Text {
                        Layout.fillWidth: true
                        color: contentRow.get_text_color()
                        elide: Text.ElideRight
                        font.family: Theme.font.family.nerd
                        font.pixelSize: Theme.font.size.medium
                        text: network.ssid
                    }
                    Text {
                        color: contentRow.get_text_color(Theme.colors.danger)
                        font.italic: true
                        font.pixelSize: Theme.font.size.small
                        text: root.connectionError
                        verticalAlignment: Text.AlignVCenter
                        visible: network.ssid === root.failedSSID
                    }
                    Text {
                        color: contentRow.get_text_color()
                        font.italic: true
                        font.pixelSize: Theme.font.size.small
                        text: "Connecting..."
                        verticalAlignment: Text.AlignVCenter
                        visible: network.ssid === root.connectingSSID
                    }
                }
            }
            header: Rectangle {
                id: header

                color: Theme.colors.background
                height: 48
                radius: 8
                width: parent.width

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

            Keys.onPressed: event => {
                if (event.key === Qt.Key_J) {
                    wifiList.currentIndex = (wifiList.currentIndex + 1) % wifiList.count;
                    event.accepted = true;
                } else if (event.key === Qt.Key_K) {
                    wifiList.currentIndex = (wifiList.currentIndex - 1 + wifiList.count) % wifiList.count;
                    event.accepted = true;
                } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                    if (wifiList.currentIndex >= 0 && wifiList.currentIndex < wifiList.count) {
                        const net = wifiList.model[wifiList.currentIndex];
                        root.failedSSID = "";
                        root.connectingSSID = net.ssid;
                        NetworkService.connect(net.ssid);
                    }
                    event.accepted = true;
                } else if (event.key === Qt.Key_Escape) {
                    root.visible = false;
                    event.accepted = true;
                }
            }
        }
    }
}
