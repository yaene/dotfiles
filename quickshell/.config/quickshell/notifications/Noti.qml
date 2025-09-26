import Quickshell.Services.Notifications
import qs.services.notification
import qs.common
import QtQuick
import Quickshell
import Quickshell.Widgets
import QtQuick.Layouts

WrapperRectangle {
    id: root

    readonly property bool hasAppIcon: noti.appIcon.length > 0
    required property Notif modelData
    readonly property Notification noti: modelData.notification

    Layout.alignment: Qt.AlignHCenter
    color: Theme.colors.opaqueBackground(0.9)
    margin: 10
    radius: 8

    Item {
        implicitHeight: content.height
        implicitWidth: content.width

        NerdIconButton {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: -5
            size: 20
            text: "󰅖"

            onClicked: root.noti.dismiss()
        }
        GridLayout {
            id: content

            columnSpacing: 10
            columns: 2
            rowSpacing: 5
            rows: 4
            width: 400

            Loader {
                id: appIcon

                Layout.alignment: Qt.AlignTop
                Layout.column: 0
                Layout.preferredWidth: icon.width
                Layout.row: 0
                Layout.rowSpan: 4
                active: root.hasAppIcon
                asynchronous: true
                visible: root.hasAppIcon

                sourceComponent: ClippingRectangle {
                    color: "transparent"
                    implicitHeight: 40
                    implicitWidth: 40

                    Image {
                        id: icon

                        anchors.fill: parent
                        source: Quickshell.iconPath(root.noti.appIcon)
                    }
                }
            }
            Text {
                id: app

                Layout.column: 1
                Layout.row: 0
                color: Theme.colors.title
                font.bold: true
                font.pixelSize: Theme.font.size.smaller
                text: noti.appName
            }
            Text {
                id: summary

                Layout.column: 1
                Layout.row: 1
                color: Theme.colors.text
                font.bold: true
                text: noti.summary
            }
            Text {
                id: body

                Layout.column: 1
                Layout.fillWidth: true
                Layout.row: 2
                color: Theme.colors.text
                text: noti.body
            }
            RowLayout {
                id: actions

                Layout.alignment: Qt.AlignRight
                Layout.column: 1
                Layout.row: 3

                Repeater {
                    model: noti.actions

                    delegate: Action {
                        Layout.alignment: Qt.AlignRight
                    }
                }
            }
        }
    }

    component Action: Rectangle {
        required property NotificationAction modelData

        Layout.preferredHeight: actionText.height + 2 * 5
        Layout.preferredWidth: actionText.width + 2 * 10
        color: Theme.colors.primaryButton
        radius: 15

        Text {
            id: actionText

            anchors.centerIn: parent
            color: Theme.colors.background
            text: modelData.text
        }
        MouseArea {
            id: area

            anchors.fill: parent

            onClicked: {
                modelData.invoke();
            }
        }
    }
}
