import qs.services.notification
import Quickshell.Services.Notifications
import qs.common
import QtQuick
import QtQuick.Layouts
import Quickshell

PanelWindow {
    id: root

    anchors.top: true
    color: "transparent"
    exclusiveZone: 0
    implicitHeight: notifications.implicitHeight
    implicitWidth: notifications.implicitWidth
    margins.top: 15
    visible: NotificationService.notExpired.length > 0

    ColumnLayout {
        id: notifications

        Repeater {
            delegate: notificationComp
            model: NotificationService.notExpired
        }
    }
    Component {
        id: notificationComp

        Rectangle {
            id: notification

            required property Notif modelData
            readonly property Notification noti: modelData.notification

            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: 100
            Layout.preferredWidth: 400
            color: Theme.colors.opaqueBackground(0.9)
            radius: 8

            Column {
                padding: 10
                spacing: 5

                Text {
                    id: app

                    color: Theme.colors.title
                    font.bold: true
                    text: noti.appName
                }
                Text {
                    id: summary

                    color: Theme.colors.text
                    text: noti.summary
                }
            }
        }
    }
}
