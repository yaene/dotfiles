import QtQuick
import QtQuick.Layouts
import qs.common

Item {
    id: barItem
    property real radius: 8
    property real padding: 5
    property bool hovered: mouseArea.containsMouse

    implicitWidth: contentItem.implicitWidth + 2 * padding
    implicitHeight: Config.bar.height
    default property alias content: contentItem.children

    Rectangle {
        id: bg
        anchors.fill: parent
        color: hovered ? Theme.colors.text : Theme.colors.background
        radius: barItem.radius
        border {
            color: Theme.colors.text
        }
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
            margins: barItem.padding
        }
    }
}
