import QtQuick
import QtQuick.Layouts

RowLayout {
    id: center
    spacing: 4
    anchors {
        horizontalCenter: parent.horizontalCenter
    }
    default property alias content: center.children
}
