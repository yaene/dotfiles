import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick.Effects
import QtQuick.Controls
import "."

PopupWindow {
    id: root

    property alias child: container.child
    default property alias data: container.data

    function hide() {
        grab.active = false;
        root.visible = false;
    }
    function show() {
        root.visible = true;
        grab.active = true;
    }

    anchor.window: Globals.barWindow
    color: "transparent"
    implicitHeight: anchor.window.screen.height
    implicitWidth: anchor.window.screen.width
    visible: false

    RectangularShadow {
        anchors.fill: container
        blur: 24
        cached: true
        color: "#1a1a1a"
        offset: Qt.vector2d(0, 8)
        radius: 8
        spread: 15
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
        color: Theme.colors.background
        radius: 8
        z: 1

        Keys.onPressed: event => {
            if (event.key === Qt.Key_Escape) {
                root.hide();
                event.accepted = true;
            }
        }
    }
    HyprlandFocusGrab {
        id: grab

        windows: [root]

        onCleared: () => {
            root.hide();
        }
    }
}
