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

        spacing: 10

        Repeater {
            model: NotificationService.notExpired

            delegate: Noti {
            }
        }
    }
}
