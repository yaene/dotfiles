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

                readonly property bool active: {
                    return modelData.active && Hyprland.monitorFor(screen).id === modelData.monitor.id;
                }
                readonly property bool focused: {
                    return modelData.focused && Hyprland.monitorFor(screen).id === modelData.monitor.id;
                }
                required property HyprlandWorkspace modelData
                readonly property ShellScreen screen: QsWindow.window.screen

                Layout.fillHeight: true
                color: focused ? Theme.colors.warning : active ? Theme.colors.text : "transparent"
                implicitWidth: 20

                Text {
                    property HyprlandWorkspace workspace: workspaceBox.modelData

                    anchors.centerIn: parent
                    color: workspaceBox.active || hovered ? Theme.colors.background : Theme.colors.text
                    text: workspace.id

                    font {
                        pixelSize: Theme.font.size.medium
                    }
                }
            }
        }
    }
}
