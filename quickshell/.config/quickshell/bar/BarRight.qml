import QtQuick
import QtQuick.Layouts

RowLayout {
    id: right
    spacing: 4
    anchors {
        right: parent.right
        top: parent.top
        bottom: parent.bottom
    }
    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
    default property alias content: right.children
}
