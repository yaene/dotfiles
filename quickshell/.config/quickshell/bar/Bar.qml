import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import qs.common
import "widgets"
import "widgets/network"
import "widgets/bluetooth"

Scope {
    id: root

    Variants {
        id: bars

        model: Quickshell.screens

        PanelWindow {
            id: barWindow

            required property var modelData

            color: Config.bar.transparent ? "transparent" : Theme.colors.backgroundDarker
            implicitHeight: Config.bar.height + 2 * borderRect.border.width
            screen: modelData

            anchors {
                left: true
                right: true
                top: true
            }
            Rectangle {
                id: borderRect

                color: "transparent"
                implicitHeight: Config.bar.borderOnlyBottom ? 2 * Config.bar.borderWidth : Config.bar.height
                radius: 8

                anchors {
                    bottom: parent.bottom
                    left: parent.left
                    right: parent.right
                }
                border {
                    color: Theme.colors.text
                    width: Config.bar.borderWidth
                }
            }
            RectangularShadow {
                blur: 30
                color: "#33000000"
                height: 20
                offset: Qt.vector2d(0, 8)
                radius: borderRect.radius
                spread: 0
                z: 10

                anchors {
                    bottom: parent.bottom
                    left: parent.left
                    right: parent.right
                }
            }
            Item {
                anchors.fill: parent

                anchors {
                    bottomMargin: borderRect.border.width
                    leftMargin: borderRect.border.width + 8
                    rightMargin: borderRect.border.width + 8
                    topMargin: borderRect.border.width
                }
                BarLeft {
                    id: left

                    Workspaces {
                    }
                    Submap {
                    }
                }
                BarCenter {
                    id: center

                    Clock {
                    }
                }
                BarRight {
                    id: right

                    Battery {
                    }
                    Bluetooth {
                        barWindow: barWindow
                    }
                    Network {
                        barWindow: barWindow
                    }
                }
            }
        }
    }
}
