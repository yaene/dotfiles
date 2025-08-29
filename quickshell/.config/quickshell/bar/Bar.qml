import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick
import qs.common

Scope {
    id: root
    Variants {
        model: Quickshell.screens
        PanelWindow {
            required property var modelData
            screen: modelData
            anchors {
                top: true
                left: true
                right: true
            }
            color: "transparent"

            implicitHeight: 30

            Clock {
                anchors.centerIn: parent
            }
        }
    }
}
