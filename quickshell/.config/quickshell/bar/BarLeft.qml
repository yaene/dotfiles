import QtQuick
import QtQuick.Layouts
import qs.common

RowLayout {
    id: left
    spacing: 4
    anchors {
        left: parent.left
    }
    default property alias content: left.children
}
