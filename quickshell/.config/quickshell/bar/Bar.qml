import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs.common
import "widgets"
import "widgets/network"
import "widgets/bluetooth"

Scope {
    id: root

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: barWindow

            required property var modelData

            color: Config.bar.transparent ? "transparent" : Theme.colors.background
            implicitHeight: Config.bar.height + 2 * borderRect.border.width
            screen: modelData

            Component.onCompleted: {
                Globals.barWindow = barWindow;
            }

            anchors {
                left: true
                right: true
                top: true
            }
            Rectangle {
                id: borderRect

                anchors.centerIn: parent
                anchors.fill: parent
                color: "transparent"
                radius: 8

                border {
                    color: Theme.colors.text
                    width: Config.bar.borderWidth
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
                        }
                        Network {
                        }
                    }
                }
            }
        }
    }
}
