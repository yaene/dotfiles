import QtQuick
import Quickshell
import Quickshell.Widgets

PanelWindow {
    id: root

    property alias child: container.child
    default property alias data: container.data

    color: "transparent"
    focusable: true

    anchors {
        bottom: true
        left: true
        right: true
        top: true
    }
    ClippingWrapperRectangle {
        id: container

        anchors.centerIn: parent
        color: Theme.colors.background
        radius: 8

        Keys.onPressed: event => {
            if (event.key === Qt.Key_Escape) {
                root.visible = false;
                event.accepted = true;
            }
        }
    }
}
