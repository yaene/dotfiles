import QtQuick
import QtQuick.Layouts

RowLayout {
    id: center
    spacing: 4
    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
    default property alias content: center.children
}
