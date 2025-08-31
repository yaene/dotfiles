import QtQuick
import QtQuick.Layouts
import qs.common

RowLayout {
    id: right
    spacing: 4
    layoutDirection: Qt.RightToLeft
    anchors {
        left: center.right
        right: parent.right
    }
    default property alias content: right.children
}
