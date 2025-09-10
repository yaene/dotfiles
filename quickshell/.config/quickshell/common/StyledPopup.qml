import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
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

    anchor.rect.x: anchor.window.width / 2 - width / 2
    anchor.rect.y: anchor.window.screen.height / 2 - height / 2
    anchor.window: Globals.barWindow
    color: "transparent"
    implicitHeight: container.implicitHeight
    implicitWidth: container.implicitWidth
    visible: false

    ClippingWrapperRectangle {
        id: container

        anchors.centerIn: parent
        color: Theme.colors.background
        radius: 8

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
