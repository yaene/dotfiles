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

            color: Config.bar.transparent ? "transparent" : Theme.colors.background

            implicitHeight: Config.bar.height + 2 * borderRect.border.width

            Rectangle {
                id: borderRect
                color: "transparent"
                anchors.centerIn: parent
                anchors.fill: parent
                radius: 8
                border {
                    color: Theme.colors.text
                    width: Config.bar.borderWidth
                }
                Item {
                    anchors.fill: parent
                    anchors {
                        topMargin: borderRect.border.width
                        bottomMargin: borderRect.border.width
                        leftMargin: borderRect.border.width + 8
                        rightMargin: borderRect.border.width + 8
                    }
                    BarLeft {
                        id: left
                        Workspaces {}
                    }
                    BarCenter {
                        id: center
                        Clock {}
                    }
                    BarRight {
                        id: right
                        Battery {}
                        Bluetooth {}
                    }
                }
            }
        }
    }
}
