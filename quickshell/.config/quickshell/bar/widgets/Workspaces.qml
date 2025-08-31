import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs.common
import ".."

BarItem {
    RowLayout {
        id: workspaceIndicator
        readonly property list<HyprlandWorkspace> workspaces: Hyprland.workspaces.values

        Repeater {
            model: workspaceIndicator.workspaces
            Rectangle {
                id: workspaceBox
                required property HyprlandWorkspace modelData
                implicitWidth: 10
                color: modelData.active ? Theme.colors.text : "transparent"
                Layout.fillHeight: true

                Text {
                    property HyprlandWorkspace workspace: workspaceBox.modelData
                    anchors.centerIn: parent
                    color: workspace.active || hovered ? Theme.colors.background : Theme.colors.text
                    text: workspace.id
                    font {
                        pixelSize: Theme.font.size.medium
                    }
                }
            }
        }
    }
}
