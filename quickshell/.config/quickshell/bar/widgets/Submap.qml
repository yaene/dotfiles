import QtQuick
import qs.common
import Quickshell
import Quickshell.Hyprland

Item {
    property string submap: ""

    id: "root"
    implicitWidth: text.implicitWidth

    Text {
        id: text

        anchors.centerIn: parent
        color: Theme.colors.text
        text: root.submap
    }
    Connections {
        function onRawEvent(event) {
            if (event.name === "submap") {
                root.submap = event.data;
            }
        }

        target: Hyprland
    }
}
