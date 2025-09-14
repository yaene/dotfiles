import QtQuick
import QtQuick.Layouts
import qs.common

RowLayout {
    id: left

    default property alias content: left.children

    spacing: 3

    anchors {
        left: parent.left
    }
}
