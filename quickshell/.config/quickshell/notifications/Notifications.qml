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
    visible: NotificationService.notifications.length > 0

    ColumnLayout {
        id: notifications

        spacing: 10

        Repeater {
            model: NotificationService.notifications

            delegate: Noti {
            }
        }
    }
}
