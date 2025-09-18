import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Effects
import qs.common

Scope {
    id: osd

    default property alias content: osd.contentComponent
    property Component contentComponent: osdContent
    property int height: 130
    property string leftLabel: ""
    property int percentage: 50
    property string rightLabel: ""
    property bool showPercentage: true
    property int width: 300

    function hide() {
        osdPopupLoader.active = false;
    }
    function show() {
        osdPopupLoader.active = true;
        hideOsdTimer.restart();
    }

    Loader {
        id: osdPopupLoader

        active: false
        sourceComponent: osdPopupWindow
    }
    Component {
        id: osdContent

        Item {
            Text {
                id: leftBarLabel

                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                color: Theme.colors.text
                font.pixelSize: Theme.font.size.larger
                text: osd.leftLabel
            }
            Text {
                id: rightBarLabel

                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                color: Theme.colors.text
                font.pixelSize: Theme.font.size.larger
                text: osd.rightLabel
            }
            // Background bar
            Rectangle {
                id: bgBar

                anchors.left: leftBarLabel.right
                anchors.margins: 20
                anchors.right: rightBarLabel.left
                anchors.verticalCenter: parent.verticalCenter
                color: "#444444bb"
                height: 16
                radius: 8
            }

            // Fill bar (progress)
            Rectangle {
                id: fillBar

                anchors.left: bgBar.left
                anchors.verticalCenter: bgBar.verticalCenter
                color: Theme.colors.text
                height: bgBar.height
                radius: 8
                width: (bgBar.width) * osd.percentage / 100

                Behavior on width {
                    NumberAnimation {
                        duration: 150
                    }
                }
            }

            // Percentage label
            Text {
                anchors.bottom: fillBar.top
                anchors.horizontalCenter: parent.horizontalCenter
                color: Theme.colors.text
                font.bold: true
                font.pixelSize: Theme.font.size.large
                text: osd.percentage + "%"
                visible: osd.showPercentage
            }
        }
    }
    Component {
        id: osdPopupWindow

        PanelWindow {

            // show on top of fullscreen (wayland only)
            WlrLayershell.layer: WlrLayer.Overlay
            color: "transparent"

            anchors {
                bottom: true
                left: true
                right: true
                top: true
            }
            RectangularShadow {
                anchors.fill: container
                cached: true
                color: Qt.rgba(0, 0, 0, 0.4)
                offset: Qt.vector2d(0, 8)
                radius: container.radius
                spread: 10
            }
            Rectangle {
                id: container

                anchors.centerIn: parent
                color: Theme.colors.opaqueBackground(0.9)
                height: osd.height
                opacity: 0.8
                radius: 18
                width: osd.width

                Loader {
                    id: contentLoader

                    anchors.fill: parent
                    sourceComponent: osd.contentComponent
                }
            }
        }
    }
    Timer {
        id: hideOsdTimer

        interval: Config.osd.hideTimeout
        repeat: false
        running: false

        onTriggered: {
            osdPopupLoader.active = false;
        }
    }
}
