import QtQuick
import QtQuick.Layouts

Rectangle {
    id: item

    property bool active: false
    property color activeColor: Theme.colors.active
    property color background: "transparent"
    default property alias data: contentRow.data
    property bool selected: false
    property color selectedColor: Theme.colors.selected
    property int verticalPadding: 20

    border.color: active ? activeColor : selected ? selectedColor : Colors.color8
    border.width: 1
    color: selected ? border.color : background
    implicitHeight: contentRow.implicitHeight + verticalPadding
    radius: 8

    RowLayout {
        id: contentRow

        anchors.fill: parent
        anchors.margins: 10
        spacing: 45
    }
}
