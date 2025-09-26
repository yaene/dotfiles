import Quickshell.Services.Notifications
import qs.services.notification
import qs.common
import QtQuick
import Quickshell
import Quickshell.Widgets
import QtQuick.Layouts

WrapperRectangle {
    id: notification

    readonly property bool hasAppIcon: noti.appIcon.length > 0
    required property Notif modelData
    readonly property Notification noti: modelData.notification

    Layout.alignment: Qt.AlignHCenter
    Layout.preferredHeight: 100
    Layout.preferredWidth: 400
    color: Theme.colors.opaqueBackground(0.9)
    margin: 10
    radius: 8

    GridLayout {
        columnSpacing: 10
        columns: 2
        rowSpacing: 5
        rows: 3

        Loader {
            id: appIcon

            Layout.alignment: Qt.AlignTop
            Layout.column: 0
            Layout.preferredWidth: icon.width
            Layout.row: 0
            Layout.rowSpan: 3
            active: notification.hasAppIcon
            asynchronous: true
            visible: notification.hasAppIcon

            sourceComponent: ClippingRectangle {
                color: "transparent"
                implicitHeight: 40
                implicitWidth: 40

                Image {
                    id: icon

                    anchors.fill: parent
                    source: Quickshell.iconPath(notification.noti.appIcon)
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
    }
}
