import QtQuick
import QtQuick.Layouts
import qs.common

Item {
    id: barItem
    property real radius: 8
    property real padding: 5
    property bool hovered: mouseArea.containsMouse

    implicitWidth: contentItem.implicitWidth
    implicitHeight: Config.bar.height
    default property alias content: contentItem.children

    Rectangle {
        id: bg
        anchors.fill: parent
        color: hovered ? Theme.colors.text : "transparent"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }

    RowLayout {
        id: contentItem
        anchors.fill: parent
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            right: parent.right
        }
    }
}
