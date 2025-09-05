import QtQuick
import QtQuick.Layouts
import qs.common

Item {
    id: barItem

    default property alias content: contentItem.children
    property bool hovered: mouseArea.containsMouse
    property real padding: 5
    property real radius: 8

    signal pressed

    implicitHeight: Config.bar.height
    implicitWidth: contentItem.implicitWidth

    Rectangle {
        id: bg

        anchors.fill: parent
        color: hovered ? Theme.colors.text : "transparent"
    }
    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true

        onPressed: parent.pressed()
    }
    RowLayout {
        id: contentItem

        anchors.fill: parent

        anchors {
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
    }
}
