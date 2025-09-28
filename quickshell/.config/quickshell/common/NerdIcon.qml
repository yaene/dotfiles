import QtQuick

Text {
    id: root

    property alias size: root.font.pixelSize

    font.family: Theme.font.family.nerd
}
