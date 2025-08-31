import QtQuick
import Quickshell
import qs.common
import Quickshell.Services.UPower
import QtQuick.Controls
import ".."

BarItem {
    readonly property UPowerDevice powerDevice: UPower.displayDevice

    function iconFromBatteryPercentage(percentage, battery_state) {
        const charging = battery_state === UPowerDeviceState.Charging;
        let iconstr = charging ? "󱐋" : "";
        if (percentage <= 10) {
            iconstr += charging ? "" : "";
        } else if (percentage <= 35) {
            iconstr += "";
        } else if (percentage <= 60) {
            iconstr += "";
        } else if (percentage <= 85) {
            iconstr += "";
        } else {
            iconstr += "";
        }
        return iconstr;
    }

    visible: powerDevice.isLaptopBattery

    Text {
        id: percentText
        readonly property int percentage: Math.floor(powerDevice.percentage * 100)
        color: hovered ? Theme.colors.background : Theme.colors.text
        text: `${percentage}%`
        font {
            pixelSize: Theme.font.size.smaller
        }
    }
    Text {
        text: iconFromBatteryPercentage(percentText.percentage, powerDevice.state)
        color: hovered ? Theme.colors.background : Theme.colors.text
        font {
            pixelSize: Theme.font.size.medium
            family: Theme.font.family.nerd
        }
    }
}
