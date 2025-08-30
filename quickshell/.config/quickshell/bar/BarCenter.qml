import QtQuick
import QtQuick.Layouts

RowLayout {
    id: center
    spacing: 4
    anchors {
        verticalCenter: parent.verticalCenter
        horizontalCenter: parent.horizontalCenter
    }
    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
    default property alias content: center.children
}
