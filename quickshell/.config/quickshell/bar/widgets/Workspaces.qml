import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
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

            MouseArea {
                id: container

                readonly property bool active: {
                    return workspace.active && onCurrentMonitor;
                }
                readonly property bool focused: {
                    return workspace.focused && onCurrentMonitor;
                }
                required property HyprlandWorkspace modelData
                readonly property bool onCurrentMonitor: screen.name === workspace.monitor.name
                readonly property var screen: QsWindow.window?.screen
                property HyprlandWorkspace workspace: container.modelData

                Layout.preferredHeight: Config.bar.height
                Layout.preferredWidth: workspaceBox.width
                visible: onCurrentMonitor

                onClicked: {
                    workspaceLabel.workspace.activate();
                }

                WrapperRectangle {
                    id: workspaceBox

                    color: container.focused ? Theme.colors.selected : container.active ? Theme.colors.active : "transparent"
                    leftMargin: 10
                    rightMargin: 10

                    RowLayout {
                        id: workspaceLabel

                        property HyprlandWorkspace workspace: container.modelData

                        spacing: 6

                        NerdIcon {
                            property string activeAppId: {
                                const activeToplevels = workspaceLabel.workspace.toplevels.values;
                                return activeToplevels.length > 0 ? activeToplevels[0].wayland.appId : "";
                            }

                            color: container.active || hovered ? Theme.colors.background : Theme.colors.text
                            size: 25
                            text: Utils.iconFromAppId(activeAppId)
                        }
                        Text {
                            id: text

                            color: container.active || hovered ? Theme.colors.background : Theme.colors.text
                            text: workspaceLabel.workspace.id

                            font {
                                pixelSize: Theme.font.size.medium
                            }
                        }
                    }
                }
            }
        }
    }
}
