import QtQuick
import QtQuick.Layouts

RowLayout {
    id: right
    spacing: 4
    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
    default property alias content: right.children
}
