import QtQuick
import QtQuick.Layouts
import qs.common

RowLayout {
    id: right

    default property alias content: right.children

    layoutDirection: Qt.RightToLeft
    spacing: 3

    anchors {
        right: parent.right
    }
}
