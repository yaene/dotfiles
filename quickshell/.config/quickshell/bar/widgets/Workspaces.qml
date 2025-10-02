import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs.common
import ".."

BarItem {
    hovered: false

    RowLayout {
        id: workspaceIndicator

        readonly property list<HyprlandWorkspace> workspaces: Hyprland.workspaces.values

        Repeater {
            model: workspaceIndicator.workspaces

            Rectangle {
                id: workspaceBox

                readonly property bool active: {
                    return modelData.active && onCurrentMonitor;
                }
                readonly property bool focused: {
                    return modelData.focused && onCurrentMonitor;
                }
                required property HyprlandWorkspace modelData
                readonly property bool onCurrentMonitor: screen.name === modelData.monitor.name
                readonly property var screen: QsWindow.window?.screen

                Layout.preferredHeight: Config.bar.height
                color: focused ? Theme.colors.selected : active ? Theme.colors.active : "transparent"
                implicitWidth: 20
                visible: onCurrentMonitor

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
