import QtQuick
import QtQuick.Layouts

Rectangle {
    id: item

    default property alias data: contentRow.data
    property bool hovered: false
    property string selectedBackground: Theme.colors.text
    property string selectedColor: Theme.colors.text
    property int verticalPadding: 20

    border.color: Theme.colors.text
    border.width: 1
    color: Theme.colors.background
    implicitHeight: contentRow.implicitHeight + verticalPadding
    radius: 8

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: parent.hovered = true
        onExited: parent.hovered = false
    }
    RowLayout {
        id: contentRow

        anchors.fill: parent
        anchors.margins: 10
        spacing: 45
    }
}
