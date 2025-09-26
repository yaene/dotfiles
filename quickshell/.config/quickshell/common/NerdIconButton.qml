import QtQuick

Text {
    id: root

    property alias size: root.font.pixelSize

    signal clicked

    color: Theme.colors.primaryButton

    MouseArea {
        anchors.fill: parent

        onClicked: {
            root.clicked();
        }
    }
}
