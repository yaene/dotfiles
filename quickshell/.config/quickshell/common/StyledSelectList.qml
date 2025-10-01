import QtQuick
import Quickshell

ListView {
    id: list

    property int headerHeight: 48

    signal selected(var item)

    anchors.fill: parent
    anchors.margins: 18
    clip: true
    focus: true
    highlightMoveDuration: 1
    implicitHeight: Math.min(list.contentHeight + (list.headerItem?.height || 0), 500)
    keyNavigationWraps: true
    spacing: 10

    Keys.onPressed: event => {
        if (event.key === Qt.Key_J) {
            list.currentIndex = (list.currentIndex + 1) % list.count;
            event.accepted = true;
        } else if (event.key === Qt.Key_K) {
            list.currentIndex = (list.currentIndex - 1 + list.count) % list.count;
            event.accepted = true;
        } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
            if (list.currentIndex >= 0 && list.currentIndex < list.count) {
                const item = list.model instanceof ObjectModel ? list.model.values[list.currentIndex] : list.model[list.currentIndex];

                list.selected(item);
            }
            event.accepted = true;
        }
    }
}
