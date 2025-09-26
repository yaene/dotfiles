import Quickshell.Services.Notifications
import qs.services.notification
import qs.common
import QtQuick
import Quickshell
import Quickshell.Widgets
import QtQuick.Layouts

Rectangle {
    id: notification

    readonly property bool hasAppIcon: noti.appIcon.length > 0
    required property Notif modelData
    readonly property Notification noti: modelData.notification

    Layout.alignment: Qt.AlignHCenter
    Layout.preferredHeight: 100
    Layout.preferredWidth: 400
    color: Theme.colors.opaqueBackground(0.9)
    radius: 8

    RowLayout {
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        spacing: 10

        Loader {
            id: appIcon

            Layout.alignment: Qt.AlignTop
            Layout.leftMargin: 8
            Layout.topMargin: 8
            active: notification.hasAppIcon
            asynchronous: true
            visible: notification.hasAppIcon

            sourceComponent: ClippingRectangle {
                color: "transparent"
                implicitHeight: 40
                implicitWidth: 40

                Image {
                    anchors.fill: parent
                    source: Quickshell.iconPath(notification.noti.appIcon)
                }
            }
        }
        ColumnLayout {
            spacing: 5

            Text {
                id: app

                Layout.alignment: Qt.AlignTop
                color: Theme.colors.title
                font.bold: true
                font.pixelSize: Theme.font.size.smaller
                text: noti.appName
            }
            Text {
                id: summary

                color: Theme.colors.text
                font.bold: true
                text: noti.summary
            }
            Text {
                id: body

                color: Theme.colors.text
                text: noti.body
            }
        }
    }
}
