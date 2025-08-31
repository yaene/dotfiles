import QtQuick
import Qt5Compat.GraphicalEffects

Item {
    id: icon
    required property string iconPath
    property string color: Theme.colors.text
    Image {
        id: svg
        anchors.fill: parent
        source: `file://${Theme.iconFont}/${iconPath}`
        visible: false
    }
    ColorOverlay {
        anchors.fill: svg
        source: svg
        color: icon.color
    }
}
