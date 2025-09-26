import QtQuick
import Quickshell.Services.Notifications
import qs.common

Item {
    id: notif

    property real expireTimeout
    property bool expired: false
    required property Notification notification

    Component.onCompleted: {
        if (!notification) {
            return;
        }
        expireTimeout = notification.expireTimeout;
    }

    Timer {
        interval: expireTimeout > 0 ? expireTimeout : Config.notifications.defaultExpireTimeout
        running: true

        onTriggered: {
            notification.expire();
            expired = true;
        }
    }
}
