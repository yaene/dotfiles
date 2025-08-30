import QtQuick
import QtQuick.Layouts

RowLayout {
    id: left
    spacing: 4
    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
    default property alias content: left.children
}
