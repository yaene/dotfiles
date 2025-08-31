import QtQuick
import QtQuick.Layouts
import qs.common

RowLayout {
    id: right
    spacing: 15
    layoutDirection: Qt.RightToLeft
    anchors {
        right: parent.right
    }
    default property alias content: right.children
}
