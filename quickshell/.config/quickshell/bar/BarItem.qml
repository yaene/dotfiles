import QtQuick
import QtQuick.Layouts
import qs.common
import Quickshell.Widgets

Item {
    id: barItem

    default property alias content: contentItem.data
    property bool hovered: mouseArea.containsMouse
    property real padding: 3
    property real radius: 20

    signal pressed

    implicitHeight: Config.bar.height
    implicitWidth: bg.implicitWidth

    WrapperRectangle {
        id: bg

        bottomMargin: (Config.bar.height - Config.bar.iconSize) / 2
        color: "transparent"
        leftMargin: padding
        radius: barItem.radius
        rightMargin: padding
        topMargin: (Config.bar.height - Config.bar.iconSize) / 2

        anchors {
            centerIn: parent
            left: parent.left
            right: parent.right
        }
        Rectangle {
            color: hovered ? Theme.colors.selected : "transparent"
            implicitHeight: contentItem.height
            implicitWidth: contentItem.width + 2 * padding
            radius: 8

            RowLayout {
                id: contentItem

                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
        propagateComposedEvents: true

        onPressed: parent.pressed()
    }
}
