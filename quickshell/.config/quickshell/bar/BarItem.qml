import QtQuick
import QtQuick.Layouts
import qs.common
import Quickshell.Widgets

Item {
    id: barItem

    default property alias content: contentItem.children
    property bool hovered: mouseArea.containsMouse
    property real padding: 6
    property real radius: 8

    signal pressed

    implicitHeight: Config.bar.height
    implicitWidth: bg.implicitWidth

    WrapperRectangle {
        id: bg

        color: hovered ? Theme.colors.selected : "transparent"
        implicitHeight: Config.bar.height
        leftMargin: padding
        rightMargin: padding

        anchors {
            centerIn: parent
            left: parent.left
            right: parent.right
        }
        RowLayout {
            id: contentItem

        }
    }
    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true

        onPressed: parent.pressed()
    }
}
