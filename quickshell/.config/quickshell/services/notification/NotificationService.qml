pragma Singleton

import Quickshell
import Quickshell.Services.Notifications
import QtQuick

Singleton {
    id: root

    readonly property list<Notif> notExpired: notifications.filter(notif => !notif.expired)
    property list<Notif> notifications

    NotificationServer {
        id: notificationServer

        actionsSupported: true
        keepOnReload: false

        onNotification: notification => {
            console.log(notification.summary);
            notification.tracked = true;
            const notif = notificationComp.createObject(root, {
                notification: notification
            });
            root.notifications = [notif, ...root.notifications];
        }
    }
    Component {
        id: notificationComp

        Notif {
        }
    }
}
