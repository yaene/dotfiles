import QtQuick
import Quickshell
import qs.common

Text {
    color: Theme.colors.text
    text: {
        Qt.formatDateTime(clock.date, "hh:mm");
    }
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
