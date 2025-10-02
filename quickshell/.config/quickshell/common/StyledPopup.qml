import QtQuick
import Quickshell
import Quickshell.Widgets

PanelWindow {
    id: root

    property alias child: container.child
    default property alias data: container.data

    function hide() {
        root.visible = false;
    }
    function show() {
        root.visible = true;
    }

    color: "transparent"
    focusable: true
    visible: false

    anchors {
        bottom: true
        left: true
        right: true
        top: true
    }
    MouseArea {
        anchors.fill: parent

        onClicked: root.hide()
    }
    MouseArea {
        anchors.fill: container
    }
    ClippingWrapperRectangle {
        id: container

        anchors.centerIn: parent
        color: Theme.colors.opaqueBackground(0.9)
        radius: 12

        Keys.onPressed: event => {
            if (event.key === Qt.Key_Escape) {
                root.visible = false;
                event.accepted = true;
            }
        }
    }
}
