import QtQuick
import Quickshell
import qs.common
import ".."

BarItem {
    Text {
        color: hovered ? Theme.colors.background : Theme.colors.text
        text: {
            Qt.formatDateTime(clock.date, "hh:mm");
        }
        font {
            pixelSize: Theme.font.size.medium
        }
        SystemClock {
            id: clock
            precision: SystemClock.Minutes
        }
    }
}
