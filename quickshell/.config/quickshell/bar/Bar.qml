import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs.common
import "widgets"

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

            implicitHeight: Config.bar.height

            BarLeft {
                Workspaces {}
            }
            BarCenter {
                Clock {}
            }
            BarRight {
                Battery {}
            }
        }
    }
}
