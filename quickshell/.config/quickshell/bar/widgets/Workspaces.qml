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

            WrapperRectangle {
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
                leftMargin: 10
                rightMargin: 10
                visible: onCurrentMonitor

                Item {
                    implicitHeight: workspaceLabel.height
                    implicitWidth: workspaceLabel.width

                    MouseArea {
                        anchors.fill: workspaceLabel

                        onClicked: {
                            workspaceLabel.workspace.activate();
                            console.log("clicked");
                        }
                    }
                    RowLayout {
                        id: workspaceLabel

                        property HyprlandWorkspace workspace: workspaceBox.modelData

                        spacing: 6

                        NerdIcon {
                            property string activeAppId: {
                                const activeToplevels = workspaceLabel.workspace.toplevels.values;
                                return activeToplevels.length > 0 ? activeToplevels[0].wayland.appId : "";
                            }

                            color: workspaceBox.active || hovered ? Theme.colors.background : Theme.colors.text
                            size: 25
                            text: Utils.iconFromAppId(activeAppId)
                        }
                        Text {
                            id: text

                            color: workspaceBox.active || hovered ? Theme.colors.background : Theme.colors.text
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
