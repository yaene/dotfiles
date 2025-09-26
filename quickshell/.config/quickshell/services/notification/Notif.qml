import QtQuick
import Quickshell.Services.Notifications

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
        interval: expireTimeout
        running: true

        onTriggered: {
            notification.expire();
            expired = true;
        }
    }
}
